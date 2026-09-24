TARGET = patches.elf

CC      ?= clang
LD      ?= ld.lld

GBI_DEFINE := -DF3D_OLD
CFLAGS   := -target mips -mips2 -mabi=32 -O2 -G0 -mno-abicalls -mno-odd-spreg -mno-check-zero-division \
			-fomit-frame-pointer -ffast-math -fno-unsafe-math-optimizations -fno-builtin-memset -funsigned-char -fno-builtin-sinf -fno-builtin-cosf \
			-Wall -Wextra -Wno-incompatible-library-redeclaration -Wno-unused-parameter -Wno-unknown-pragmas -Wno-unused-variable -Wno-missing-braces -Wno-unsupported-floating-point-opt -Wno-error=incompatible-pointer-types -Werror=pointer-bool-conversion
ASFLAGS   := -target mips -mips2 -mabi=32 -O2 -G0 -mno-abicalls -mno-odd-spreg -mno-check-zero-division
CPPFLAGS := -nostdinc -D_LANGUAGE_C -DMIPS -I ../include -I ../lib/blastcorps/include -I ../lib/blastcorps/include/2.0D -I ../lib/blastcorps/game/src -I../lib/rt64/include -I../lib/N64ModernRuntime/ultramodern/include $(GBI_DEFINE)
LDFLAGS  := -nostdlib -T patches.ld -T syms.ld -Map patches.map --unresolved-symbols=ignore-all --emit-relocs

C_SRCS := $(wildcard *.c)
C_OBJS := $(C_SRCS:.c=.o)
C_DEPS := $(C_SRCS:.c=.d)

S_SRCS := $(wildcard *.s)
S_OBJS := $(S_SRCS:.s=.o)
S_DEPS := $(S_SRCS:.s=.d)

$(TARGET): $(C_OBJS) $(S_OBJS) patches.ld syms.ld
	$(LD) $(C_OBJS) $(S_OBJS) $(LDFLAGS) -o $@

$(C_OBJS): %.o : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $< -MMD -MF $(@:.o=.d) -c -o $@

$(S_OBJS): %.o : %.s
	$(CC) $(ASFLAGS) $(CPPFLAGS) -x assembler-with-cpp $< -MMD -MF $(@:.o=.d) -c -o $@

clean:
	rm -rf $(C_OBJS) $(S_OBJS) $(TARGET) $(C_DEPS) $(S_DEPS)

-include $(C_DEPS)
-include $(S_DEPS)

# Debug variable print target
print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true

.PHONY: clean
