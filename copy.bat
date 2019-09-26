@echo off
set origem=C:\temp\teste\device
set destino=C:\temp\teste\archive
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
echo Data: %mydate%
for /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a_%%b)
echo Hora: %mytime%
for /f "tokens=* delims= " %%a in ("%mytime%") do set mytime=%%a
echo Hora: %mytime%
pause
dir %origem%\ /b > list
robocopy %origem% %destino%\
for /f %%f in (list) do rename %destino%\\%%f %%~nf_%mydate%#%mytime%%%~xf