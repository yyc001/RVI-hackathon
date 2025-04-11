#include "emulator.h"
#include <stdio.h>
uint8_t t_pmem[4096 * 4] = {
    // addi t0, zero, 5  (x5 = 0 + 5)
    0x93, 0x02, 0x50, 0x00,  // 0x00500293
    
    // addi t1, zero, 6  (x6 = 0 + 6)
    0x13, 0x03, 0x60, 0x00,  // 0x00600313
    
    // add s0, t0, t1    (x8 = x5 + x6)
    0x33, 0x84, 0x61, 0x00,  // 0x006282b3
    
    // ebreak            (触发调试断点)
    0x73, 0x00, 0x10, 0x00   // 0x00100073
};
int main(int argc, char *argv[]) {
    if(argc > 1) {
        FILE *fp = fopen(argv[1], "rb");
        int size = fread(t_pmem, 1, sizeof(t_pmem), fp);
        printf("Image %s size=%d\n", argv[1], size);
        fclose(fp);
    }
    CPU_State state;
    cpu_reset(t_pmem);
    while(1) {
        cpu_predo(1);
        cpu_stateout(&state);
        if(state.io == CPU_HALT) {
            printf("\nCPU HALT %d\n", state.val);
            break;
        }
        if(state.io == CPU_OUTPUT) {
            fprintf(stderr, "%c", state.val);
            cpu_setio(0, 0);
        }
        cpu_commit();
    }
    return state.val;
}
