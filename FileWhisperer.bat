@echo off

setlocal enabledelayedexpansion
title Directory_sorting
:: Ask user for folder path
set /p target=Enter the full path of the folder you want to organize: 


:: Check if path exists
if not exist "%target%" (
    echo The folder does not exist. Please try again.
    pause
)

echo Organizing files in: %target%
echo.

:: Loop through all files
for %%F in ("%target%\*.*") do (
    set "ext=%%~xF"
    if not "!ext!"=="" (
        set "ext=!ext:~1!"
        mkdir "%target%\!ext!" 2>nul
        move "%%F" "%target%\!ext!\" >nul
        echo Moved %%~nxF to folder !ext!
    )
)

 echo loading
 ping localhost -n 2 > nul
 cls
 echo loading.
 ping localhost -n 2 > nul
 cls
 echo loading..
  ping localhost -n 2 > nul
 cls
 echo loading...
 ping localhost -n 2 > nul
 cls
 echo .....VERIFICATION SUCCESSFULL!.....
 echo.
powershell -Command "Add-Type -AssemblyName System.Speech; (New-Object System.Speech.Synthesis.SpeechSynthesizer).Speak('Tada! Verification successful. Files organized successfully')"
pause