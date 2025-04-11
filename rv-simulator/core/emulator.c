#include <string.h>
#include <stdio.h>

#include "emulator.h"

#define RESET_VECTOR 0x80000000

CPU_State state;
uint8_t pmem[4096 * 4]; // TODO align 4096

CPU_State state_l;
uint8_t pmem_l[4096 * 4]; // TODO align 4096

void inst_exec_once(uint32_t inst);

void cpu_reset(const uint8_t *mem) {
    memset(&state, 0, sizeof(state));
    state.pc = RESET_VECTOR;
    if(mem) {
        memcpy(pmem, mem, sizeof(pmem));
    } else {
        memset(pmem, 0, sizeof(pmem));
    }
    cpu_commit();
}

uint32_t cpu_predo(uint32_t n) {
    uint32_t i;
    for(i = 0; i < n; i++) {
        uint32_t inst = *(uint32_t*)&pmem[state.pc-RESET_VECTOR];
        // fprintf(stderr, "pc=%08x, inst=%08x\n", state.pc, inst);
        inst_exec_once(inst);
        if(state.io != 0) break;
    }
    return i;
}

void cpu_stateout(CPU_State *cstate) {
    *cstate = state;
}

void cpu_commit() {
    state_l = state;
    memcpy(pmem_l, pmem, sizeof(pmem));
}

void cpu_revert() {
    state = state_l;
    memcpy(pmem, pmem_l, sizeof(pmem));
}

void cpu_setio(uint32_t io, uint32_t val) {
    state.io = io;
    state.io = val;
}
