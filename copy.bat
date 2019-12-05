@echo off

:: alterar os caminhos das pastas  de origem e destino abaixo conforme a necessidade.
:: não incluir \ no final do caminho, pois pode ocasionar erro no script.

set origem=C:\temp\teste\device
set destino=C:\temp\teste\archive
setlocal enabledelayedexpansion
for /f "tokens=1-4 delims=/-. " %%i in ('date /t') do (
        set v1=%%i& set v2=%%j& set v3=%%k
        if "%%i:~0,1%%" gtr "9" (set v1=%%j& set v2=%%k& set v3=%%l)

        for /f "skip=1 tokens=2-4 delims=(-)" %%m in ('echo.^|date') do (
            set %%m=!v1!& set %%n=!v2!& set %%o=!v3!
    )
)

set year=%yy%%aa%
set mydate=%year%%mm%%dd%
for /f "tokens=1-2 delims=/:" %%a in ("%TIME%") do (set mytime=%%a_%%b)

:: o script gera a hora e substitui o zero por espaço quando a hora for por exemplo 09:11
:: ficando com 9:11 com espaço a frente, ocasionando erro ao renomear o arquivo.
:: linha abaixo remove os espaços no inicio da hora.
for /f "tokens=* delims= " %%a in ("%mytime%") do set mytime=%%a

dir %origem%\ /b > list
robocopy %origem% "%destino%"
for /f %%f in (list) do rename "%destino%\%%f" "%%~nf_%mydate%#%mytime%%%~xf"
del list