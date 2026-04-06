@echo off
setlocal enabledelayedexpansion

:: 1. Setup path to KDE Connect
set "CLI_DIR=C:\Users\harsh\AppData\Local\Programs\KDE Connect\bin"
set "CLI_EXE=kdeconnect-cli.exe"
set "FULL_CLI=%CLI_DIR%\%CLI_EXE%"

:: 2. Check if we have files to send
if "%~1"=="" (
    echo [INFO] No files selected. 
    echo Please select files in Explorer first, then use "Send To".
    pause
    exit /b 0
)

:: 3. Verify KDE Connect installation
if not exist "%FULL_CLI%" (
    echo [ERROR] KDE Connect not found at:
    echo "%FULL_CLI%"
    pause
    exit /b 1
)

:: 4. Get reachable devices
echo Searching for online devices...
set "TMP_LIST=%TEMP%\kde_dev_list.txt"
"%FULL_CLI%" --list-available --id-name-only > "%TMP_LIST%" 2>nul

set d_count=0
for /f "tokens=1,*" %%a in (%TMP_LIST%) do (
    set /a d_count+=1
    set "d_id_!d_count!=%%a"
    set "d_name_!d_count!=%%b"
)
del "%TMP_LIST%"

:: 5. Error handling for no devices
if %d_count% equ 0 (
    echo.
    echo [ERROR] No online devices found.
    echo.
    echo Current status of paired devices:
    "%FULL_CLI%" --list-devices
    echo.
    echo Troubleshooting:
    echo 1. Ensure phone and PC are on the same Wi-Fi.
    echo 2. Open the KDE Connect app on your phone.
    echo 3. Check if your firewall allows KDE Connect.
    pause
    exit /b 1
)

:: 6. Select the target device
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
    for %%v in (!choice!) do set "TARGET_ID=!d_id_%%v!"
)

if "!TARGET_ID!"=="" (
    echo [ERROR] Invalid selection.
    pause
    exit /b 1
)

:: 7. Send all files at once
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