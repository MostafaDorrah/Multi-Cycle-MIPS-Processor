@echo off
set xv_path=C:\\xlinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 6a1668f15efa4f7d93e353a479de35ea -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot Test_behav xil_defaultlib.Test xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
