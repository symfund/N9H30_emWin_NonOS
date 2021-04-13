
REM make tool path
set make_tool_provided_by=C:\Program Files (x86)\GNU ARM Eclipse\Build Tools\2.8-201611221915\bin
REM set make_tool_provided_by=C:\msys64\usr\bin
set MAKE_PATH=%make_tool_provided_by%

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
SET RM=rm -rf

echo ----------------------------------------------------------------------
echo Current directory is %~dp0
echo ----------------------------------------------------------------------
echo Change directory to %2
REM 'make -C' will change to directory %2
echo ----------------------------------------------------------------------

make -C %2 -f ..\..\Makefile.mak %1
