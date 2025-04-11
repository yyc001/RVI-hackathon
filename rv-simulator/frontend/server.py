from flask import Flask, render_template, request, jsonify
from ctypes import *
import os
import subprocess
import re

app = Flask(__name__)

# 加载动态库，假设 libcpu.so 已经存在当前目录
lib = CDLL('./libcpu.so')

# 定义 CPU 状态结构体
class CPUState(Structure):
    _fields_ = [("gpr", c_uint32 * 32),
                ("pc", c_uint32),
                ("io", c_uint32),
                ("val", c_uint32)]

# 设置 C 接口参数类型
lib.cpu_reset.argtypes = [POINTER(c_uint8)]
lib.cpu_predo.argtypes = [c_uint32]
lib.cpu_predo.restype = c_uint32
lib.cpu_stateout.argtypes = [POINTER(CPUState)]
lib.cpu_commit.argtypes = []
lib.cpu_revert.argtypes = []
lib.cpu_setio.argtypes = [c_uint32, c_uint32]

# 初始化内存映射，内存文件 memory.bin 需与 ELF 文件匹配
MEM_SIZE = 4096
memory = (c_uint8 * MEM_SIZE)()
with open("image.bin", "rb") as f:
    mem_data = f.read()
    for i in range(len(mem_data)):
        memory[i] = mem_data[i]

lib.cpu_reset(memory)

@app.route("/")
def index():
    return render_template("index.html")

# 全局字符串，用于记录终端输出
terminal_output = ""

@app.route("/step", methods=["POST"])
def step():
    # 执行一条指令
    lib.cpu_predo(1)
    lib.cpu_commit()

    state = CPUState()
    lib.cpu_stateout(byref(state))

    # 如果 state.io 为 0xc，则把 state.val 当字符追加到 terminal_output 中
    global terminal_output
    if state.io == 0x0c:
        terminal_output += chr(state.val)
        lib.cpu_setio(0x00, 0x00)

    # 返回 CPU 状态信息
    return jsonify({
        "pc": state.pc,
        "gpr": list(state.gpr),
        "io": state.io,
        "val": state.val
    })

@app.route("/reset", methods=["POST"])
def reset():
    lib.cpu_reset(memory)
    return jsonify({"status": "reset"})

@app.route("/disasm", methods=["GET"])
def disasm():
    """
    通过调用 objdump 解析 ELF 文件 image.elf
    然后过滤出当前 CPU 状态中 PC 周围的反汇编代码。
    """
    state = CPUState()
    lib.cpu_stateout(byref(state))
    pc = state.pc

    # 这里假设 ELF 文件名为 image.elf，且加载地址为 0x80000000
    elf_file = "image.elf"

    try:
        # 调用 objdump 工具对 ELF 文件进行反汇编（请根据实际交叉编译工具链调整命令）
        disasm_output = subprocess.check_output(["riscv64-unknown-elf-objdump", "-d", elf_file],
                                                 universal_newlines=True)
    except subprocess.CalledProcessError as e:
        return jsonify({"error": str(e)})

    # 将 objdump 的输出按行分割
    disasm_lines = disasm_output.splitlines()

    # 设定过滤窗口：取 PC 前 16 字节至 PC 后 64 字节范围内的指令
    start_addr = pc - 16
    end_addr = pc + 64
    filtered_lines = []
    # 用正则解析每行开头的地址，格式通常为 " 80000000:   <bytes>   mnemonic ..."
    addr_re = re.compile(r'^\s*([0-9a-fA-F]+):')
    for line in disasm_lines:
        m = addr_re.match(line)
        if m:
            addr_str = m.group(1)
            try:
                addr = int(addr_str, 16)
                if start_addr <= addr <= end_addr:
                    filtered_lines.append(line)
            except ValueError:
                continue
    disasm_text = "\n".join(filtered_lines)
    
    return jsonify({
        "pc": pc,
        "disasm": disasm_text
    })

@app.route("/terminal", methods=["GET"])
def terminal():
    # 返回当前累积的终端输出字符串
    return jsonify({"terminal": terminal_output})

if __name__ == "__main__":
    app.run(debug=True)
