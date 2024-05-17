@echo off
echo Managing %1

ghdl -a regBank\mux8_16bits.vhd REM EXCEPITON: Dependency

for /r %%i in (*.vhd) do (
    echo Compiling %%i
    ghdl -a "%%i"
)

ghdl -e %1

ghdl -r %1 --wave=%1.ghw

gtkwave %1.ghw