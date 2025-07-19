@echo off
title RDR2 - Respaldando partida...

set "PARTIDA=SRDR30015"
set /a INTERVALO=60
set NUMERO=0

:: Verificar si RDR2 esta en ejecucion
tasklist /FI "IMAGENAME eq RDR2.exe" | find /I "RDR2.exe" >nul
if errorlevel 1 (
    echo [%TIME%] RDR2 no esta en ejecucion. Cerrando script.
    exit /b
)

:: Prueba de permisos
echo prueba > "permiso_test.txt"
if exist "permiso_test.txt" (
    del "permiso_test.txt"
    echo [%TIME%] Permisos de escritura confirmados.
) else (
    echo [%TIME%] No se puede escribir en el directorio. Abortando respaldo.
    exit /b
)

echo [%TIME%] Iniciando respaldos cada %INTERVALO% segundos...

:CICLO
:: Verificar si RDR2 sigue activo
tasklist /FI "IMAGENAME eq RDR2.exe" | find /I "RDR2.exe" >nul
if errorlevel 1 (
    echo [%TIME%] RDR2 ya no esta activo. Cerrando script.
    exit /b
)

:: Esperar que el archivo se desbloquee
>nul 2>nul (copy /b "%PARTIDA%" nul) || (
    echo [%TIME%] Archivo bloqueado. Reintentando en 10 segundos...
    timeout /t 10 >nul
    goto CICLO
)

:: Crear copia inicial si no existen copias
if not exist "%PARTIDA%_copy-1m" (
    if not exist "%PARTIDA%_copy-2m" (
        if not exist "%PARTIDA%_copy-3m" (
            copy /Y "%PARTIDA%" "%PARTIDA%_copy-1m" >nul
            echo [%TIME%] No existen copias previas. Creando copia-1m inicial...
            set NUMERO=1
            goto CICLO_FINAL
        )
    )
)

:: Rotacion de respaldo numerado 1 al 3
set /a NUMERO+=1
if %NUMERO% GTR 3 set NUMERO=1
set "DESTINO=%PARTIDA%_copy-%NUMERO%m"

:: Logica de limpieza personalizada
:: Si vamos a crear la copia 1m, eliminamos la copia 3m (si existe)
if "%DESTINO%"=="%PARTIDA%_copy-1m" (
    if exist "%PARTIDA%_copy-2m" (
        del "%PARTIDA%_copy-2m" >nul
        echo [%TIME%] Copia-2m eliminada antes de crear copia-1m.
    )
)

:: Si vamos a crear la copia 2m, eliminamos la vieja copia 2m
if "%DESTINO%"=="%PARTIDA%_copy-2m" (
    if exist "%PARTIDA%_copy-3m" (
        del "%PARTIDA%_copy-3m" >nul
        echo [%TIME%] Copia-3m eliminada antes de crear nueva copia-2m.
    )
)

:: Si vamos a crear la copia 3m, eliminamos la copia 1m
if "%DESTINO%"=="%PARTIDA%_copy-3m" (
    if exist "%PARTIDA%_copy-1m" (
        del "%PARTIDA%_copy-1m" >nul
        echo [%TIME%] Copia-1m eliminada antes de crear copia-3m.
    )
)

:: Crear respaldo
copy /Y "%PARTIDA%" "%DESTINO%" >nul
echo [%TIME%] Respaldo creado: %DESTINO%

:CICLO_FINAL
:: Verificar nuevamente si RDR2 sigue activo antes de contar
tasklist /FI "IMAGENAME eq RDR2.exe" | find /I "RDR2.exe" >nul
if errorlevel 1 (
    echo [%TIME%] RDR2 ya no esta activo. Cerrando script.
    exit /b
)

:: Cuenta regresiva visible
set /a CONTADOR=%INTERVALO%
:CUENTA_REGRESIVA
if %CONTADOR% LEQ 0 (
    cls
    goto CICLO
)
echo [%TIME%] Siguiente respaldo en %CONTADOR% segundos...
set /a CONTADOR-=1
timeout /t 1 >nul
goto CUENTA_REGRESIVA


:: Mod created by TyrRakzort – Save Sentinel RDR2 – July 2025. This project is protected by copyright







