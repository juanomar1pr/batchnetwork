@echo off
title Network settings#  BY nun!
color f0
mode 120, 50 
CLS
ECHO.
ECHO +++++++++==========================================================+++++++++
ECHO Hola nun! + Administrador +
ECHO +++++++++==========================================================+++++++++
:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invocacion de UAC para escalamiento de privilegios
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
:inicio
echo ====================================================== 
echo                          El menu 
echo ====================================================== 
echo                       1. activar hotspot  
echo                       2. desctivar hotspot
echo                       3. mostrar interfaces 
echo                       4. network-settings 
echo                       5. GOOD-INFO
echo                       6. Informacion de network
echo                       7. Salir
set /p menu=Entra una opcion:
if "%menu%"=="1" start NETSH WLAN start hostednetwork

if "%menu%"=="2" start NETSH WLAN stop hostednetwork
if "%menu%"=="3" start cmd.exe /k "netsh interface show interface" 
if "%menu%"=="4" start cmd.exe /C "ncpa.cpl"
if "%menu%"=="5" START cmd.exe /k "SYSTEMINFO"
if "%menu%"=="6" START cmd.exe /k "netsh wlan show wlanreport"
if "%menu%"=="7" exit
cls
pause>nul
goto inicio

