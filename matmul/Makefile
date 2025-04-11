MUL ?= bmp
# 编译器配置
CROSS_COMPILE ?= riscv64-unknown-linux-gnu-
CXX	   = $(CROSS_COMPILE)g++
LD	    = $(CROSS_COMPILE)g++

# 目标配置
TARGET      = matrix_multiply
SRC_DIR     = .
SRCS	= $(SRC_DIR)/mul_$(MUL).cpp $(SRC_DIR)/main.cpp
OBJS	= $(patsubst $(SRC_DIR)/%.cpp,%.o,$(SRCS))

# RISC-V特定优化选项
RV_ARCH     = rv64gcv
RV_ABI      = lp64d

# 通用编译选项
OPT_LEVEL   = -O3
WARN_FLAGS  = -Wall -Wextra -Wpedantic
MATH_FLAGS  = -ffast-math -fno-math-errno
OPENMP_FLAG = -fopenmp
VECTOR_FLAGS= -march=$(RV_ARCH) -mabi=$(RV_ABI)

# 调试选项
DEBUG_FLAGS = -g -DDEBUG

# 组合编译选项
CXXFLAGS    = $(OPT_LEVEL) $(WARN_FLAGS) $(MATH_FLAGS) \
	      $(OPENMP_FLAG) $(VECTOR_FLAGS) \
	      -funroll-loops -flto

# 链接选项
LDFLAGS     = $(OPENMP_FLAG) $(VECTOR_FLAGS) -flto

# 默认构建目标
all: release

# 发布版本（全优化）
release: CXXFLAGS += -DNDEBUG
release: $(TARGET)

# 调试版本
debug: CXXFLAGS += $(DEBUG_FLAGS) -O0
debug: LDFLAGS  += $(DEBUG_FLAGS)
debug: $(TARGET)

# 构建规则
$(TARGET): $(OBJS)
	riscv64-unknown-linux-gnu-g++ -march=rv64gcv -mabi=lp64d -fopenmp -o $@ $^

%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# 交叉编译快速检查
check-cross:
	@echo "Checking cross-compiler:"
	$(CXX) --version | head -n1
	@echo "Vector support:"
	$(CXX) -dM -E - < /dev/null | grep -i riscv_v

# 清理
clean:
	rm -f $(TARGET) *.o

# 运行测试（需在RISC-V环境）
run: release
	./$(TARGET)

# 性能分析目标
perf: release
	perf stat -e cycles
