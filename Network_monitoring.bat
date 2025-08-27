@echo off
title Network Monitoring Tool
color 0A
setlocal enabledelayedexpansion

:: ================================
:: ENTRY POINT
:: ================================
goto mainMenu

:: ================================
:: LOADING ANIMATION
:: ================================
:loadingAnimation
setlocal enabledelayedexpansion
set "spin=|/-\"
for /l %%a in (1,1,20) do (
    set /a idx=%%a %% 4
    set "char=!spin:~%idx%,1!"
    <nul set /p=" Starting Network Monitoring Tool !char!   `r"
    ping -n 1 localhost >nul
)
echo.
endlocal
exit /b

:: ================================
:: MAIN MENU
:: ================================
:mainMenu
cls
call :loadingAnimation
cls
echo =======================================
echo        NETWORK MONITORING TOOL
echo =======================================
echo.

:: Ask for logfile
set /p logfile= Set Logfile Name (default: network_monitoring.txt): 
if "%logfile%"=="" set logfile=network_monitoring.txt

:: Set IP address
set /p ip= Enter Target IP Address (e.g 8.8.8.8): 
if "%ip%"=="" set ip=127.0.0.1

:: Validate IP/hostname before continuing
echo Validating target: %ip%
ping -n 1 %ip% >nul 2>&1
if %errorlevel% neq 0 (
    echo =======================================
    echo ERROR: %ip% is not valid or unreachable.
    echo Please check and try again.
    echo =======================================
    pause
    goto mainMenu
)

:: Set port list
set /p portlist= Enter Ports To Monitor (default: 80 443 22): 
if "%portlist%"=="" set portlist=80 443 22

:: Ask for email Notification
set /p email= Enter Your Email For Alerts: 
if "%email%"=="" set email=your_email@gmail.com

:: Ask for SMTP server
set /p smtpServer= Enter Your SMTP server (default: smtp.gmail.com): 
if "%smtpServer%"=="" set smtpServer=smtp.gmail.com

:: Ask for SMTP port
set /p smtpPort= Enter SMTP port (default: 587): 
if "%smtpPort%"=="" set smtpPort=587

:: Ask for SMTP username
set /p smtpUser= Enter SMTP Username (default: same as email): 
if "%smtpUser%"=="" set smtpUser=%email%

:: Ask for SMTP Password
set /p smtpPassword= Enter your SMTP App Password (16 characters, no spaces): 
 
if "%smtpPassword%"=="" (
    echo ERROR: SMTP Password cannot be empty!
    pause
    goto mainMenu
)

:: Set delay
set /p delay= Enter Delay Between Checks (seconds, default: 60): 
if "%delay%"=="" set delay=60

:: ================================
:: SHOW CONFIGURATION
:: ================================
echo.
echo --- CONFIGURATION COMPLETE ---
echo Logfile: %logfile%
echo Target IP: %ip%
echo Ports: %portlist%
echo Email: %email%
echo SMTP: %smtpServer%:%smtpPort%
echo Delay: %delay% seconds
echo =========================================
pause

:: ================================
:: START MONITORING
:: ================================
echo NETWORK MONITORING STARTED - %date% %time% >> %logfile%
goto monitorLoop

:: ================================
:: MONITOR LOOP
:: ================================
:monitorLoop
set "report=Network Status Update - %ip% (%date% %time%)"

:: --- Check host ---
ping -n 2 %ip% >nul
if %errorlevel%==0 (
    set "statusMsg=Host: Reachable"
) else (
    set "statusMsg=Host: Unreachable"
)
echo !statusMsg! >> %logfile%
set "report=!report!`r`n!statusMsg!"

:: --- Check ports ---
for %%P in (%portlist%) do (
    powershell -Command "Test-NetConnection -ComputerName %ip% -Port %%P" | findstr /i "TcpTestSucceeded *: *True" >nul
    if !errorlevel! == 0 (
        set "portMsg=Port %%P: OPEN"
    ) else (
        set "portMsg=Port %%P: CLOSED"
    )
    echo !portMsg! >> %logfile%
    set "report=!report!`r`n!portMsg!"
)

:: --- Send summary email ---
call :sendEmail "%report%"

echo Waiting %delay% seconds before the next check...
timeout /t %delay% /nobreak >nul
goto monitorLoop


:: ================================
:: EMAIL FUNCTION
:: ================================
:sendEmail
set "body=%~1"
set "subject=Network Status Update - %ip% (%date% %time%)"
echo Sending summary email... >> %logfile%

echo %body% | powershell -Command ^
"Send-MailMessage -To '%email%' -From '%smtpUser%' -Subject '%subject%' -Body ([Console]::In.ReadToEnd()) -SmtpServer '%smtpServer%' -Port %smtpPort% -UseSsl -Credential (New-Object System.Management.Automation.PSCredential('%smtpUser%', (ConvertTo-SecureString '%smtpPassword%' -AsPlainText -Force)))"

if %errorlevel%==0 (
    echo Email sent successfully! >> %logfile%
) else (
    echo Failed to send email! >> %logfile%
)
exit /b


