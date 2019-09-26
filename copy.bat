@echo off
set origem=C:\temp\teste\device
set destino=C:\temp\teste\archive
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%b-%%a)
for /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a_%%b)

:: o script gera a hora e substitui o zero por espaço quando a hora for por exemplo 09:11
:: ficando com 9:11 com espaço a frente, ocasionando erro ao renomear o arquivo.
:: linha abaixo remove os espaços no inicio da hora
for /f "tokens=* delims= " %%a in ("%mytime%") do set mytime=%%a

dir %origem%\ /b > list
robocopy %origem% %destino%\
for /f %%f in (list) do rename %destino%\\%%f %%~nf_%mydate%#%mytime%%%~xf