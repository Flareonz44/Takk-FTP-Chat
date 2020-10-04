@echo off
mode con cols=40 lines=15
:color_custom
if exist ".\cuscom\color.cuscom" set /p ccolor=<".\cuscom\color.cuscom"
if not exist ".\cuscom\color.cuscom" set ccolor="color 07"
%ccolor%
:load
title Takk - Loading... - @Flareonz44
cls
echo ---------------------------------------
echo ## Loading FTP Credentials... ##
echo ---------------------------------------
if exist "uplP32.tak" if exist "dwlP32.tak" if exist "dwlP64.tak" if exist ".\ftp-credentials\host.dat" goto w
:remake_credentials
echo Write your FTP host below.
set /p fhost=FTP-Host: 
echo Write your FTP user below.
set /p fuser=FTP-User: 
echo Write your FTP password below.
set /p fpass=FTP-Password: 
echo Write a custom FTP location below, or skip it (will use default directory in "/")
set /p fccd=FTP-Custom-CD: 
echo %fhost%>".\ftp-credentials\host.dat"
echo user %fuser%>uplP32.tak
echo %fpass%>>uplP32.tak
if not "%fccd%"=="" echo cd %fccd%>>uplP32.tak
echo bin>>uplP32.tak
echo put ".\chats\mainc.dat" "mainc.ch">>uplP32.tak
echo quit>>uplP32.tak
echo user %fuser%>dwlP32.tak
echo %fpass%>>dwlP32.tak
echo bin>>dwlP32.tak
if not "%fccd%"=="" echo cd %fccd%>>dwlP32.tak
echo get "mainc.ch" ".\chats\mainc.ch">>dwlP32.tak
echo quit>>dwlP32.tak
echo user %fuser%>dwlP64.tak
echo %fpass%>>dwlP64.tak
echo bin>>dwlP64.tak
if not "%fccd%"=="" echo cd %fccd%>>dwlP64.tak
echo get "mainc.ch" ".\chats\mainc.dat">>dwlP64.tak
echo quit>>dwlP64.tak
:w
set /p chost=<".\ftp-credentials\host.dat"

:main
title Takk - Welcome - @Flareonz44
cls
echo ---------------------------------------
echo ## Welcome to Takk chat online! ##
echo.
echo Type 'login' to login with an account
echo Type 'register' to create an account
echo [Then press enter]
echo.
echo ---------------------------------------
echo.
set /p option=^>
if "%option%"=="exit" exit
if "%option%"=="login" goto login
if "%option%"=="register" goto register
goto main

:register
title Takk - Register - @Flareonz44
cls
echo ---------------------------------------
echo ## Create an account to chat ##
echo.
echo Complete information below
echo.
echo ---------------------------------------
echo.
set /p nuname=New Username^>
if "%nuname%"=="back" goto main
if "%nuname%"=="exit" exit
set /p nupass=New Password^>
if "%nupass%"=="back" goto main
if "%nupass%"=="exit" exit
echo %nupass%>.\users\%nuname%.dat
cls
echo ---------------------------------------
echo ## Account sucessful created! ##
echo.
echo Press any key to login.
echo.
echo ---------------------------------------
echo.
timeout /t 5 >nul
goto login

:login
title Takk - Login - @Flareonz44
cls
echo ---------------------------------------
echo ## Login to start chatting ##
echo.
echo Enter credentials below
echo.
echo ---------------------------------------
echo.
set /p iuname=Username^>
if "%iuname%"=="back" goto main
if "%iuname%"=="exit" exit
set /p iupass=Password^>
if "%iupass%"=="back" goto main
if "%iupass%"=="exit" exit
if not exist ".\users\%iuname%.dat" goto invalid_uname
set /p fupass=<".\users\%iuname%.dat"
if not "%fupass%"=="%iupass%" goto invalid_upass
cls
echo ---------------------------------------
echo ## Sucessful loged in! ##
echo.
echo You will chat as %iuname%
echo.
echo ---------------------------------------
echo.
timeout /t 5 >nul
echo Loading...
ftp -n -s:dwlP64.tak %chost% >nul
start cmd /c ".\md.bat"
goto send_msg

:invalid_uname
title Takk - Error - @Flareonz44
cls
echo ---------------------------------------
echo ## Invalid Username ##
echo.
echo Try again or create an account
echo.
echo ---------------------------------------
echo.
timeout /t 5 >nul
goto login

:invalid_upass
title Takk - Error - @Flareonz44
cls
echo ---------------------------------------
echo ## Invalid Password ##
echo.
echo Try again or create an account
echo.
echo ---------------------------------------
echo.
timeout /t 5 >nul
goto login

:restore
echo Chat File [%date%]-[%time%]>.\chats\mainc.dat
echo Restoring...
ftp -n -s:uplP32.tak %chost% >nul
goto send_msg

:send_msg
title Takk - Send Mesagge - @Flareonz44
set msg=
cls
echo type '/help' for more options
echo ---------------------------------------
echo Mesagge:
set /p msg=^>
if "%msg%"=="" goto send_msg
if "%msg%"=="/help" goto help
if "%msg%"=="/clean" echo --^>Conversation cleaned by %iuname% >".\chats\mainc.dat"
if "%msg%"=="/clean" echo. >>".\chats\mainc.dat"
if "%msg%"=="/clean" echo Cleaning...
if "%msg%"=="/clean" ftp -n -s:uplP32.tak %chost% >nul
if "%msg%"=="/clean" goto send_msg
if "%msg%"=="/logout" goto main
if "%msg%"=="/restore" goto restore
echo Sending...
ftp -n -s:dwlP64.tak %chost% >nul
echo %iuname%:%msg% >>.\chats\mainc.dat
ftp -n -s:uplP32.tak %chost% >nul
goto send_msg

:help
title Takk - Help - @Flareonz44
cls
echo ---------------------------------------
echo ## Availiables Commands ##
echo.
echo /help      Show this list
echo /clean     Clean all conversation
echo /logout    Log out from current sesion
echo.
echo ---------------------------------------
timeout /t 30 >nul
goto send_msg