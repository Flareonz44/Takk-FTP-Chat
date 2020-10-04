@echo off
mode con cols=40
:color_custom
if exist ".\cuscom\color.cuscom" set /p ccolor=<".\cuscom\color.cuscom"
if not exist ".\cuscom\color.cuscom" set ccolor="color 07"
%ccolor%
title Takk - Mesagge Display - @Flareonz44
cls
echo Loading...
set ftphost=%chost%

:read
ftp -n -s:dwlP32.tak %ftphost% >nul
cls
echo Conversation                @Flareonz44
echo ---------------------------------------
if exist ".\chats\mainc.ch" type .\chats\mainc.ch
if not exist ".\chats\mainc.ch" echo File chat not present. Contact the Admin.
goto read