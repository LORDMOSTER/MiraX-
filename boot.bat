@echo off
cls
echo.
echo           WELCOME TO
echo   __  __ _             __  __          
echo  |  \/  (_)           |  \/  |         
echo  | \  / |_ _ __   __ _| \  / | ___ _ __
echo  | |\/| | | '_ \ / _` | |\/| |/ _ \ '__|
echo  | |  | | | | | | (_| | |  | |  __/ |   
echo  |_|  |_|_|_| |_|\__, |_|  |_|\___|_|   
echo                   __/ |                
echo                  |___/                 
echo.
timeout /t 1 >nul
echo [■□□□□□□□□□] Booting...
timeout /t 1 >nul
echo [■■■□□□□□□□] Loading Files...
timeout /t 1 >nul
echo [■■■■■■□□□□] Initializing...
timeout /t 1 >nul
echo [■■■■■■■■■□] Finalizing...
timeout /t 1 >nul
echo [■■■■■■■■■■] Ready to Launch!
timeout /t 1 >nul

:: Play sound (works on most Windows)
powershell -c (New-Object Media.SoundPlayer "startup.wav").PlaySync();

exit