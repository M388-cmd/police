@echo off
color a 
title Michael police
:: Antivirus básico con eliminación automática
setlocal enabledelayedexpansion

:: Título del programa
echo -------------------------------------
echo [Michael police]
echo -------------------------------------

:: Solicitar al usuario la ruta de la carpeta
echo Por favor, introduce la ruta de la carpeta que deseas escanear:
set /p carpeta=Ruta: 

:: Verificar si la carpeta existe
if not exist "%carpeta%" (
    echo -------------------------------------
    echo ERROR: La carpeta especificada no existe.
    echo Verifica la ruta e intenta de nuevo.
    echo -------------------------------------
    pause
    exit
)

:: Extensiones sospechosas a buscar
set extensiones=.exe .bat .vbs .cmd .js

echo -------------------------------------
echo Escaneando la carpeta: %carpeta%
echo -------------------------------------

:: Escanear y eliminar archivos sospechosos
set encontrado=0
for %%E in (%extensiones%) do (
    echo Buscando archivos con la extensión %%E...
    for /r "%carpeta%" %%F in (*%%E) do (
        echo [Sospechoso] %%F

        :: Eliminar automáticamente los archivos sospechosos
        del /f /q "%%F"
        if exist "%%F" (
            echo [Error] No se pudo eliminar: %%F
        ) else (
            echo [Eliminado] %%F
            set /a encontrado+=1
        )
    )
)

:: Mensajes finales
if %encontrado% gtr 0 (
    echo -------------------------------------
    echo Escaneo completado. Se eliminaron %encontrado% archivos sospechosos.
    echo -------------------------------------
) else (
    echo -------------------------------------
    echo Escaneo completado. No se encontraron archivos sospechosos.
    echo -------------------------------------
)

pause
exit
