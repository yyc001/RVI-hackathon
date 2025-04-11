
#include <stdint.h>

typedef struct {
    uint32_t gpr[32], pc;
    uint32_t io, val;
} CPU_State;

extern CPU_State state;

#define CPU_HALT    0xf
#define CPU_INPUT   0xd
#define CPU_OUTPUT  0xc
#define CPU_READ    0xa
#define CPU_WRITE   0xb

void cpu_reset(const uint8_t *mem);

uint32_t cpu_predo(uint32_t n);

void cpu_commit();

void cpu_revert();

void cpu_stateout(CPU_State *cstate);

void cpu_setio(uint32_t io, uint32_t val);
