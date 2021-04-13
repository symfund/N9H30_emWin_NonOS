
# TWjiang@nuvoton.com
# Configuration: emWin_GUIDemo_E50A2V1_16BPP

# Make phony targets .PHONY
# There isn't really an all file created and there really isn't clean file.
# There are actually just tags that identify a target whose rules should
# always be run.
.PHONY: all clean target

# The Preprocessor Macros
DEFS = -D_PANEL_E50A2V1_16BPP_ \
	-D__GUI_NUMBYTES__=6 

INCLUDES = -I. \
	-I../../../../Driver/Include \
	-I../../../../ThirdParty/FATFS/src \
	-I../../../../ThirdParty/emWin/Include \
	-I../../../../ThirdParty/emWin/Config \
	-I../../../../SampleCode/emWin_GUIDemo/tslib \

GFLAGS = -mcpu=arm926ej-s -marm -mlittle-endian -mfloat-abi=soft -O0 -fmessage-length=0 \
	-fsigned-char -ffunction-sections -fdata-sections -g3 -ggdb

CFLAGS = $(DEFS) $(INCLUDES) -std=gnu11 

CPPFLAGS =
CXXFLAGS =

ASFLAG = -g
LINKFILE = ../../../../Driver/Source/GCC.ld
LDFLAGS = 
LIBS = -lgcc -lc -lrdimon -lNUemWin_ARM9_GCC -lm -L"../../../../ThirdParty/emWin/Lib"


# define the C source files
# Don't include paths in filenames
# Inerting and maintaining paths everywhere is tedious and error prone. Better is to use
# VPATH within the Makefile like this:
#	VPATH=../src
SRCS_C = ../../../../SampleCode/emWin_GUIDemo/tslib/SDGlue.c \
	../../../../SampleCode/emWin_GUIDemo/tslib/TouchPanel.c \
	../../../../SampleCode/emWin_GUIDemo/tslib/diskio.c \
	../../../../SampleCode/emWin_GUIDemo/tslib/fbutils.c \
	../../../../SampleCode/emWin_GUIDemo/tslib/spilib.c \
	../../../../SampleCode/emWin_GUIDemo/tslib/testutils.c \
	../../../../SampleCode/emWin_GUIDemo/tslib/ts_calibrate.c \
	../../../../SampleCode/emWin_GUIDemo/main.c \
	../../../../ThirdParty/FATFS/src/ff.c \
	../../../../Driver/Source/2d.c \
	../../../../Driver/Source/adc.c \
	../../../../Driver/Source/gpio.c \
	../../../../Driver/Source/jpegcodec.c \
	../../../../Driver/Source/lcd.c \
	../../../../Driver/Source/sdh.c \
	../../../../Driver/Source/spi.c \
	../../../../Driver/Source/sys.c \
	../../../../Driver/Source/sys_timer.c \
	../../../../Driver/Source/sys_uart.c \
	../../../../Driver/Source/system_N9H30.c \
	../../../../ThirdParty/emWin/Config/GUIConf.c \
	../../../../ThirdParty/emWin/Config/GUI_X.c \
	../../../../ThirdParty/emWin/Config/LCDConf.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_AntialiasedText.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Automotive.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_BarGraph.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Bitmap.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_ColorBar.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Conf.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Cursor.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Fading.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Graph.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_IconView.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_ImageFlow.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Intro.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Listview.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_RadialMenu.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Resource.c\
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Skinning.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Speed.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Speedometer.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Start.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_TransparentDialog.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_Treeview.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_VScreen.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_WashingMachine.c \
	../../../../SampleCode/emWin_GUIDemo/Application/GUIDEMO_ZoomAndRotate.c

# define the assembly files
SRCS_S = ../../../../Driver/Source/Startup_GCC.S


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

C_DEPS = $(OBJS:.o=.d)


MAIN = emWin_GUIDemo.elf

$(MAIN): $(OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: GNU ARM Cross C Linker'
	$(CC) $(GFLAGS) -T "$(LINKFILE)" -Xlinker --gc-sections $(LIBDIR) -Wl,-Map,"$*.map" --specs=rdimon.specs -Wl,--start-group $(LIBS) -Wl,--end-group -o "$@" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '
	

TARGET = emWin_GUIDemo.bin

$(TARGET): $(MAIN)
	@echo 'Invoking: GNU ARM Cross Create Flash Image'
	$(OBJCOPY) -O binary "$<" "$@"
	@echo 'Finished building: $@'
	@echo ' '


# This is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $< the name of the prerequisite of 
# the rule (a .c file) and $@ the name of the target of the rule (a .o file)
# (see the GNU make manual section about automatic variables)
# 
# Define an implicit rule
# 
.c.o:
	$(CC) $(GFLAGS) $(CFLAGS) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c "$<" -o "$@"


.S.o:
	$(CC) $(GFLAGS) -x assembler-with-cpp $(INCLUDES) -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"


# Define an implicit rule other than above
# The following means to build the target foo.S make should build foo.c

all: $(TARGET) finalization

finalization: $(MAIN)
	@echo 'Invoking: GNU ARM Cross Print Size'
	arm-none-eabi-size --format=berkeley "$<"
	@echo ' '
	
rebuild: all
	@echo "rebuild done"
	
clean:
	-$(RM) $(OBJS) $(SECONDARY_FLASH) $(SECONDARY_SIZE) $(ASM_DEPS) $(S_UPPER_DEPS) $(C_DEPS) emWin_GUIDemo.elf
	-@echo ' '