
# TWjiang@nuvoton.com


# Make phony targets .PHONY
# There isn't really an all file created and there really isn't clean file.
# There are actually just tags that identify a target whose rules should
# always be run.
.PHONY: all clean target


# The Preprocessor Macros
DEFS = -DMACROTEST1 \
	-DMACROTEST2

INCLUDES = -I. -I../../Driver/Include

GFLAGS = -mcpu=arm926ej-s -marm -mlittle-endian -mfloat-abi=soft -O0 -fmessage-length=0 \
	-fsigned-char -ffunction-sections -fdata-sections  -g3 -ggdb

CFLAGS = -std=gnu11 $(INCLUDES) $(DEFS)

CPPFLAGS =
CXXFLAGS =

ASFLAG = -g
LINKFILE = ../../Driver/Source/GCC.ld
LDFLAGS = 
LIBS = -lgcc -lc -lc -lm -lrdimon


# define the C source files
# Don't include paths in filenames
# Inerting and maintaining paths everywhere is tedious and error prone. Better is to use
# VPATH within the Makefile like this:
#	VPATH=../src
SRCS_C = ../../SampleCode/2D/main.c	\
	../../Driver/Source/2d.c			\
	../../Driver/Source/sys_uart.c		\
	../../Driver/Source/lcd.c			\
	../../Driver/Source/system_N9H30.c \
	../../Driver/Source/sys.c


# define the assembly files
SRCS_S = ../../Driver/Source/Startup_GCC.S


# Explicitly name sources
# Lines like this one should be avoided.
# OS_C_SRCS := $(wildcard *.c)


# define the C object files
#
# This uses Suffix Replacement within a macro:
#	$(name:string1=string2)
#		For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macros SRCS_C
# with the .o suffix
OBJS = $(SRCS_C:.c=.o) $(SRCS_S:.S=.o)


MAIN = 2D.elf

$(MAIN): $(OBJS)
	@echo
	$(CC) $(GFLAGS) $(CFLAGS) -T $(LINKFILE) -Xlinker --gc-sections -Wl,-Map,"2D.map" \
	--specs=rdimon.specs -Wl,--start-group $(LIBS) -Wl,--end-group -o $(MAIN) $(OBJS) 
	
TARGET = 2D.bin
target: $(MAIN)
	@echo
	@echo Invoking: GNU ARM Cross Create Flash Image
	$(OBJCOPY) -O binary $< $(TARGET)
	@echo Finished building: $(TARGET)
	@echo
	@echo Invoking: GNU ARM Cross Print Size
	$(SIZE) --format=berkeley $<
	@echo Finished building: 2D.siz
	@echo


# This is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $< the name of the prerequisite of 
# the rule (a .c file) and $@ the name of the target of the rule (a .o file)
# (see the GNU make manual section about automatic variables)
# 
# Define an implicit rule
.c.o:
	$(CC) $(GFLAGS) $(CFLAGS) -c $< -o $@


# Define an implicit rule other than above
# The following means to build the target foo.S make should build foo.c
%.S: %.c
	$(CC) -S $@ -c $<

%.o: %.S
	$(CC) -o $@ -c $<


all: target

rebuild:
	@echo "rebuild done"
	
clean:
	@echo "clean done"
	-rm -f $(OBJS) 2D.*