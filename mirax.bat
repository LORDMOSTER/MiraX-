@echo off
title MiraX OS - Stylish Shell
color 0D
:main
cls
echo ===============================
echo         Welcome to MiraX
echo ===============================
echo.
echo Type a command below:
echo (Type 'help' for commands)
echo.

set /p usercmd=mirax~$ 

if /i "%usercmd%"=="help" goto help
if /i "%usercmd%"=="clear" goto clear
if /i "%usercmd%"=="about" goto about
if /i "%usercmd%"=="exit" goto end
if /i "%usercmd%"=="theme" goto theme

echo.
echo Unknown command: %usercmd%
pause
goto main

:help
cls
echo ====== MiraX Commands ======
echo help   - Show help menu
echo clear  - Clear the screen
echo about  - Show info about MiraX
echo exit   - Exit the shell
echo theme  - Change MiraX theme color
echo.
pause
goto main

:about
cls
echo ===============================
echo        About MiraX OS
echo ===============================
echo Creator : hsri5
echo Version : v0.1
echo Style   : Anime-inspired terminal shell
echo Purpose : Mini OS Shell Project for Resume + Fun
echo Github  : https://github.com/your-github/MiraX--1
echo.
pause
goto main

:clear
cls
goto main

:theme
cls
echo ===============================
echo       Choose a Color Theme
echo ===============================
echo 1. Electric Blue (color 0B)
echo 2. Hacker Green  (color 0A)
echo 3. Vapor Purple  (color 0D)
echo 4. Cool Cyan     (color 0B)
echo.

set /p choice=Choose option (1-4): 

if "%choice%"=="1" color 0B
if "%choice%"=="2" color 0A
if "%choice%"=="3" color 0D
if "%choice%"=="4" color 0B

goto main

:end
echo Exiting MiraX...
timeout /t 2 >nul
exit
