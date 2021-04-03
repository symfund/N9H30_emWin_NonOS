
REM make tool path
set MAKE_PATH=C:\msys64\usr\bin

REM gcc tool path
set GNU_TOOLS_ARM_EMBEDDED_PATH=C:\Program Files (x86)\GNU Tools ARM Embedded\6 2017-q1-update\bin

set PATH=%MAKE_PATH%;%GNU_TOOLS_ARM_EMBEDDED_PATH%;%PATH%
echo %PATH%

REM Cross Compiler
SET CROSS_COMPILE=arm-none-eabi-

SET CC=arm-none-eabi-gcc
SET LD=arm-none-eabi-ld
SET AS=arm-none-eabi-as
SET OBJCOPY=arm-none-eabi-objcopy
SET SIZE=arm-none-eabi-size

SET CXX=
SET RM=rm -f

echo ----------------------------------------------------------------------
echo Current directory is %~dp0
echo ----------------------------------------------------------------------
echo Change directory to %2
cd %2
echo ----------------------------------------------------------------------

make -f ..\..\NuDemo\Makefile.mak %1
