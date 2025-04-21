@echo off
title MiraX OS - Shell
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

REM === Command Handlers ===
if /i "%usercmd%"=="help" goto help
if /i "%usercmd%"=="clear" goto clear
if /i "%usercmd%"=="about" goto about
if /i "%usercmd%"=="exit" goto end
if /i "%usercmd%"=="theme" goto colorMenu
if /i "%usercmd%"=="time" goto showtime
if /i "%usercmd%"=="date" goto showdate
if /i "%usercmd%"=="notepad" goto runnotepad
if /i "%usercmd%"=="calc" goto runcalc
if /i "%usercmd%"=="dir" goto rundir
if /i "%usercmd%"=="changecolor" goto theme

echo.
echo Unknown command: %usercmd%
pause
goto main

:help
cls
echo ====== MiraX Commands ======
echo help     - Show help menu
echo clear    - Clear the screen
echo about    - Show info about MiraX
echo exit     - Exit the shell
echo theme    - Change MiraX theme color
echo time     - Show current system time
echo date     - Show today’s date
echo notepad  - Open Windows Notepad
echo calc     - Launch Calculator
echo dir      - List current directory files
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
echo GitHub  : https://github.com/your-github/MiraX--1
echo.
pause
goto main

:clear
cls
goto main

:colorMenu
echo --------------------------
echo Choose a Color Theme:
echo 1 - Aqua
echo 2 - Green
echo 3 - Red
echo 4 - Purple
echo 5 - Yellow
echo 6 - Default (White)
set /p choice="Enter option (1-6): "

if "%choice%"=="1" color 3F
if "%choice%"=="2" color 2F
if "%choice%"=="3" color 4F
if "%choice%"=="4" color 5F
if "%choice%"=="5" color 6F
if "%choice%"=="6" color 0F
goto main

:theme
cls
echo ===============================
echo       Choose a Color Text
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

:showtime
cls
for /f "tokens=1-2 delims=:" %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
)

:: Convert 24-hour to 12-hour format
set /a hour12=hour
if %hour% GEQ 12 (
    set period=PM
    if %hour% GTR 12 set /a hour12=hour - 12
) else (
    set period=AM
    if %hour% EQU 0 set hour12=12
)

cls
echo ===============================
echo         Current Time
echo ===============================
echo.
echo          %hour12%:%minute% %period% IST
echo.
pause
goto main


:showdate
cls
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set day=%%a
    set month=%%b
    set year=%%c
)

cls
echo ===============================
echo         Today Date
echo ===============================
echo.
echo         %day%-%month%-%year%
echo.
pause
goto main


:runnotepad
cls
echo Opening Notepad...
start notepad
pause
goto main

:runcalc
cls
echo Launching Calculator...
start calc
pause
goto main

:rundir
cls
echo Listing files in current directory:
dir
echo.
pause
goto main

:end
cls
echo Shutting down MiraX...
timeout /t 1 >nul
exit
