@echo off
setlocal enabledelayedexpansion

:: 1. Setup path to KDE Connect (Checks both System-wide and User-level installs)
set "CLI_NAME=kdeconnect-cli.exe"
set "SYSTEM_PATH=C:\Program Files\KDE Connect\bin\%CLI_NAME%"
set "USER_PATH=%LOCALAPPDATA%\Programs\KDE Connect\bin\%CLI_NAME%"

if exist "%SYSTEM_PATH%" (
    set "FULL_CLI=%SYSTEM_PATH%"
) else if exist "%USER_PATH%" (
    set "FULL_CLI=%USER_PATH%"
) else (

    :: Find KDE Connect CLI through PATH (also supports Microsoft Store alias)
    set "FULL_CLI=kdeconnect-cli.exe"
    where kdeconnect-cli.exe >nul 2>&1
    if errorlevel 1 (
        
        echo [ERROR] KDE Connect CLI not found!
        echo Checked:
        echo 1. %SYSTEM_PATH%
        echo 2. %USER_PATH%
        echo 3. Whether KDE Connect CLI can be found in PATH Env-Variable. 
        echo.
        echo Please ensure KDE Connect is installed.
        pause
        exit /b 1

    )
)


:: 2. Check if we have files to send
if "%~1"=="" (
    echo [INFO] No files selected. 
    echo Please select files in Explorer first, then use "Send To".
    pause
    exit /b 0
)

:: 3. Get reachable devices
echo Searching for online devices...
set "TMP_LIST=%TEMP%\kde_dev_list.txt"
"%FULL_CLI%" --list-available --id-name-only > "%TMP_LIST%" 2>nul

set d_count=0
for /f "usebackq tokens=1,*" %%a in ("%TMP_LIST%") do (
    set /a d_count+=1
    set "d_id_!d_count!=%%a"
    set "d_name_!d_count!=%%b"
)
del "%TMP_LIST%"

:: 4. Error handling for no devices
if %d_count% equ 0 (
    echo.
    echo [ERROR] No online devices found.
    echo.
    echo Status of paired devices:
    "%FULL_CLI%" --list-devices
    echo.
    echo Troubleshooting:
    echo 1. Ensure phone and PC are on the same Wi-Fi.
    echo 2. Open the KDE Connect app on your phone.
    pause
    exit /b 1
)

:: 5. Select the target device
if %d_count% equ 1 (
    set "TARGET_ID=!d_id_1!"
    echo Found device: !d_name_1!
) else (
    echo.
    echo Available devices:
    for /l %%i in (1,1,%d_count%) do (
        echo   [%%i] !d_name_%%i!
    )
    echo.
    set /p choice="Enter device number (1-%d_count%): "
    
    :: Safely get the ID from the selection
    for /l %%i in (1,1,%d_count%) do (
        if "%%i"=="!choice!" set "TARGET_ID=!d_id_%%i!"
    )
)

if "!TARGET_ID!"=="" (
    echo [ERROR] Invalid selection.
    pause
    exit /b 1
)

:: 6. Send all files at once
echo.
echo Sending files...
"%FULL_CLI%" --device "!TARGET_ID!" --share %*

if %ERRORLEVEL% equ 0 (
    echo.
    echo [SUCCESS] All files sent!
) else (
    echo.
    echo [ERROR] Transfer failed.
)

pause
