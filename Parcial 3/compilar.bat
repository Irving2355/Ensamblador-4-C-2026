@echo off
setlocal enabledeleyedexpansion

REM comentario
:: comentario

for %%I in (.) do set "CARPETA=%%~nxI"

echo 
echo Compilando proyecto ...
echo 

for %%F in (*.asm) do (
    nasm -f win64 "%%F" -o "%%~nF.obj"
    if errorlevel 1 (
        echo Error al compilar nasm
        exit /b 1
    )
)

set "CSRC="
for %%F in (*.c) do (
    set "CSRC=!CSRC! %%F"
)

set "OBJS="
for %%F in (*.obj) do (
    set "OBJS=!OBJS! %%F"
)

gcc %CSRC% %OBJS% -o "%CARPETA%.exe"
if errorlevel 1 (
    echo Error el compilar gcc 
    exit /b 1
) 

endlocal
pause