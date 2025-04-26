@echo off
title MiraX OS - Shell
color 0D

REM =========================
REM USER AUTHENTICATION SECTION
REM =========================
:auth
if not exist users.txt (
    echo No users found. Let's create your admin account.
    set /p newuser=Enter new username: 
    set /p newpass=Enter new password: 
    echo %newuser%:%newpass%>users.txt
    echo Admin account created! Please login.
)
:login
cls
echo ===============================
echo         MiraX OS Login
echo ===============================
set /p uname=Username: 
set /p upass=Password: 

setlocal enabledelayedexpansion
set "found="
for /f "tokens=1,2 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="!uname!" if "%%B"=="!upass!" set found=1
)
endlocal & set found=%found%
if defined found (
    echo Login successful! Welcome, %uname%.
    timeout /t 1 >nul
    goto main
) else (
    echo Invalid username or password.
    pause
    goto login
)

REM =========================
REM MAIN SECTION
REM =========================
:main
cls
echo ===============================
echo         Welcome to MiraX
echo ===============================
echo.
echo Type a command below:
echo (Type 'help' for commands)
echo.

set /p usercmd=mirax%promptSym%$ 

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
if /i "%usercmd%"=="newfile" goto newfile
if /i "%usercmd%"=="writefile" goto writefile
if /i "%usercmd%"=="readfile" goto readfile
if /i "%usercmd%"=="delfile" goto delfile
if /i "%usercmd%"=="sysinfo" goto sysinfo
if /i "%usercmd%"=="quote" goto quote
if /i "%usercmd%"=="openurl" goto openurl
if /i "%usercmd%"=="randomnum" goto randomnum
if /i "%usercmd%"=="countdown" goto countdown
if /i "%usercmd%"=="flipcoin" goto flipcoin
if /i "%usercmd%"=="uptime" goto uptime
if /i "%usercmd%"=="ls" goto ls
if /i "%usercmd%"=="cd" goto cd
if /i "%usercmd%"=="mkdir" goto mkdir
if /i "%usercmd%"=="movefile" goto movefile
if /i "%usercmd%"=="copyfile" goto copyfile
if /i "%usercmd%"=="exists" goto exists
if /i "%usercmd%"=="filesize" goto filesize
if /i "%usercmd%"=="fileinfo" goto fileinfo
if /i "%usercmd%"=="encryptfile" goto encryptfile
if /i "%usercmd%"=="decryptfile" goto decryptfile

REM === New Features ===
if /i "%usercmd%"=="todo" goto todo
if /i "%usercmd%"=="reminder" goto reminder
if /i "%usercmd%"=="calendar" goto calendar
if /i "%usercmd%"=="notes" goto notes
if /i "%usercmd%"=="timer" goto timer

REM === Theme Manager Commands ===
if /i "%usercmd:~0,9%"=="theme sav" goto themesave
if /i "%usercmd:~0,9%"=="theme loa" goto themeload
if /i "%usercmd:~0,9%"=="theme lis" goto themelist
if /i "%usercmd:~0,11%"=="theme delete" goto themedelete

REM === Banner Manager Commands ===
if /i "%usercmd:~0,10%"=="banner set" goto bannerset
if /i "%usercmd:~0,11%"=="banner show" goto bannershow
if /i "%usercmd:~0,10%"=="banner off" goto banneroff
if /i "%usercmd:~0,11%"=="banner list" goto bannerlist

REM === Prompt Customization Commands ===
if /i "%usercmd:~0,10%"=="prompt set" goto promptset
if /i "%usercmd:~0,13%"=="prompt color" goto promptcolor
if /i "%usercmd:~0,12%"=="prompt reset" goto promptreset

REM === ASCII Art Command ===
if /i "%usercmd%"=="ascii" goto asciiart
REM if /i "%usercmd%"=="ls" goto asciiart

REM === Theme Preview Command ===
if /i "%usercmd:~0,13%"=="theme preview" goto themepreview

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
echo newfile   - Create a new file
echo writefile - Append text to file
echo readfile  - Read and display a file
echo delfile   - Delete a file
echo sysinfo   - Show system information
echo quote     - Show a random quote
echo openurl   - Open a website in browser
echo randomnum - Generate a random number
echo countdown - Countdown timer
echo flipcoin  - Flip a coin
echo uptime    - Show system uptime
echo ls         - List files and folders
echo cd         - Change directory
echo mkdir      - Create a new folder
echo movefile   - Move or rename a file
echo copyfile   - Copy a file
echo exists     - Check if file/folder exists
echo filesize   - Show file size
echo fileinfo   - Show file info
echo encryptfile - Encrypt a text file
echo decryptfile - Decrypt a text file

echo theme save [name]   - Save current theme
echo theme load [name]   - Load a theme
echo theme list          - List all themes
echo theme delete [name] - Delete a theme
echo theme preview [name]- Preview a theme
echo banner set [name]   - Set welcome banner
echo banner show         - Show current banner
echo banner off          - Disable banner
echo banner list         - List available banners
echo prompt set [sym]    - Set prompt symbol
echo prompt color [col]  - Set prompt color
echo prompt reset        - Reset prompt to default
echo ascii               - Show cool ASCII art

echo.
pause
goto main

REM =========================
REM THEME MANAGER SECTION
REM =========================
:themesave
set themeName=%usercmd:~10%
REM Trim leading/trailing spaces (simple way)
for /f "tokens=* delims= " %%A in ("%themeName%") do set themeName=%%A
if "%themeName%"=="" (
    echo Usage: theme save [name]
    pause
    goto main
)
if not exist themes (
    mkdir themes
)
REM Save current color to theme file
echo %color% > themes\%themeName%.txt
echo Theme '%themeName%' saved.
pause
goto main

:themeload
set themeName=%usercmd:~10%
if "%themeName%"=="" (
    echo Usage: theme load [name]
    pause
    goto main
)
if not exist themes\%themeName%.txt (
    echo Theme not found!
    pause
    goto main
)
set /p themeColor=<themes\%themeName%.txt
color %themeColor%
echo Theme '%themeName%' loaded.
pause
goto main

:themelist
echo === Available Themes ===
if not exist themes (
    echo No themes found.
) else (
    dir /b themes\*.txt
)
pause
goto main

:themedelete
set themeName=%usercmd:~13%
if "%themeName%"=="" (
    echo Usage: theme delete [name]
    pause
    goto main
)
if exist themes\%themeName%.txt (
    del themes\%themeName%.txt
    echo Theme '%themeName%' deleted.
) else (
    echo Theme not found!
)
pause
goto main

:themepreview
set themeName=%usercmd:~14%
if "%themeName%"=="" (
    echo Usage: theme preview [name]
    pause
    goto main
)
if not exist themes\%themeName%.txt (
    echo Theme not found!
    pause
    goto main
)
set /p previewColor=<themes\%themeName%.txt
color %previewColor%
echo Previewing theme '%themeName%'. Press any key to revert.
pause
color 0D
goto main

REM =========================
REM BANNER MANAGER SECTION
REM =========================
:bannerset
set bannerName=%usercmd:~11%
if "%bannerName%"=="" (
    echo Usage: banner set [name]
    pause
    goto main
)
if not exist banners\%bannerName%.txt (
    echo Banner not found!
    pause
    goto main
)
if not exist config mkdir config
echo %bannerName% > config\banner.cfg
echo Banner '%bannerName%' set.
pause
goto main

:bannershow
if not exist config\banner.cfg (
    echo No banner set.
    pause
    goto main
)
set /p bannerName=<config\banner.cfg
if not exist banners\%bannerName%.txt (
    echo Banner file missing!
    pause
    goto main
)
type banners\%bannerName%.txt
pause
goto main

:banneroff
if exist config\banner.cfg del config\banner.cfg
echo Banner disabled.
pause
goto main

:bannerlist
echo === Available Banners ===
if not exist banners (
    echo No banners found.
) else (
    dir /b banners\*.txt
)
pause
goto main

REM =========================
REM PROMPT CUSTOMIZATION SECTION
REM =========================
:promptset
set promptSym=%usercmd:~11%
if "%promptSym%"=="" (
    echo Usage: prompt set [symbol]
    pause
    goto main
)
if not exist config mkdir config
echo %promptSym% > config\user_prompt.cfg
echo Prompt symbol set to '%promptSym%'
pause
goto main

:promptcolor
set promptCol=%usercmd:~13%
if "%promptCol%"=="" (
    echo Usage: prompt color [color]
    pause
    goto main
)
REM Save color to config
if not exist config mkdir config
echo %promptCol% > config\prompt_color.cfg
echo Prompt color set to '%promptCol%'
pause
goto main

:promptreset
if exist config\user_prompt.cfg del config\user_prompt.cfg
if exist config\prompt_color.cfg del config\prompt_color.cfg
echo Prompt reset to default.
pause
goto main

REM =========================
REM ASCII ART SECTION
REM =========================
:asciiart
cls
echo      __  __ _       _       
echo     |  \/  (_)_ __ (_)_ __  
echo     | |\/| | | '_ \| | '_ \ 
echo     | |  | | | | | | | | | |
echo     |_|  |_|_|_| |_|_|_| |_|
echo.
echo   Welcome to MiraX ASCII Art!
pause
goto main

:ls
cls
echo === Files and Folders ===
dir /b
pause
goto main

:cd
cls
echo === Change Directory ===
echo Current: %cd%
set /p newdir=Enter path to change to: 
if exist "%newdir%\" (
    cd /d "%newdir%"
    echo Changed to: %cd%
) else (
    echo Directory not found!
)
pause
goto main

:mkdir
cls
echo === Create New Folder ===
set /p foldername=Enter new folder name: 
if exist "%foldername%\" (
    echo Folder already exists!
) else (
    mkdir "%foldername%"
    echo Folder created: %foldername%
)
pause
goto main

:movefile
cls
echo === Move or Rename File ===
set /p src=Enter source file: 
if not exist "%src%" (
    echo Source file not found!
    pause
    goto main
)
set /p dest=Enter destination (new name or path): 
move "%src%" "%dest%"
echo Done.
pause
goto main

:copyfile
cls
echo === Copy File ===
set /p src=Enter source file: 
if not exist "%src%" (
    echo Source file not found!
    pause
    goto main
)
set /p dest=Enter destination file: 
copy "%src%" "%dest%"
echo Done.
pause
goto main

:exists
cls
echo === Check Existence ===
set /p target=Enter file or folder name: 
if exist "%target%" (
    echo Exists: %target%
) else (
    echo Not found: %target%
)
pause
goto main

:filesize
cls
echo === File Size ===
set /p fname=Enter file name: 
if not exist "%fname%" (
    echo File not found!
    pause
    goto main
)
for %%I in ("%fname%") do (
    set size=%%~zI
)
setlocal enabledelayedexpansion
set /a kb=!size!/1024
echo Size: !size! bytes (^~!kb! KB)
endlocal
pause
goto main

:fileinfo
cls
echo === File Info ===
set /p fname=Enter file name: 
if not exist "%fname%" (
    echo File not found!
    pause
    goto main
)
for %%I in ("%fname%") do (
    echo Name: %%~nxI
    echo Path: %%~fI
    echo Size: %%~zI bytes
    echo Modified: %%~tI
    echo Type: %%~xI
)
pause
goto main

:encryptfile
cls
echo === Encrypt File (Caesar Cipher +3) ===
set /p fname=Enter text file to encrypt: 
if not exist "%fname%" (
    echo File not found!
    pause
    goto main
)
set /p outname=Enter output encrypted file: 
(
    for /f "delims=" %%A in (%fname%) do (
        set "line=%%A"
        setlocal enabledelayedexpansion
        set "enc="
        for /l %%i in (0,1,127) do (
            set "c=!line:~%%i,1!"
            if not "!c!"=="" (
                set /a "n=0x!c!"
                set /a "n=(n+3)%%256"
                for /f %%x in ("!n!") do set "enc=!enc!!c!"
            )
        )
        echo(!enc!
        endlocal
    )
) > "%outname%"
echo Encrypted to %outname%
pause
goto main

:decryptfile
cls
echo === Decrypt File (Caesar Cipher -3) ===
set /p fname=Enter encrypted file: 
if not exist "%fname%" (
    echo File not found!
    pause
    goto main
)
set /p outname=Enter output decrypted file: 
(
    for /f "delims=" %%A in (%fname%) do (
        set "line=%%A"
        setlocal enabledelayedexpansion
        set "dec="
        for /l %%i in (0,1,127) do (
            set "c=!line:~%%i,1!"
            if not "!c!"=="" (
                set /a "n=0x!c!"
                set /a "n=(n-3)%%256"
                for /f %%x in ("!n!") do set "dec=!dec!!c!"
            )
        )
        echo(!dec!
        endlocal
    )
) > "%outname%"
echo Decrypted to %outname%
pause
goto main

:randomnum
cls
echo === Random Number Generator ===
set /p min=Enter minimum value: 
set /p max=Enter maximum value: 
set /a range=%max% - %min% + 1
set /a rand=%random% %% range + %min%
echo Random number between %min% and %max%: %rand%
pause
goto main

:countdown
cls
echo === Countdown Timer ===
set /p seconds=Enter seconds to countdown: 
:cdloop
cls
echo %seconds% seconds remaining...
set /a seconds=%seconds%-1
if %seconds% GEQ 0 (
    timeout /t 1 >nul
    goto cdloop
)
echo Time's up!
pause
goto main

:flipcoin
cls
echo === Coin Flip ===
set /a coin=%random% %% 2
if %coin%==0 (
    echo Heads
) else (
    echo Tails
)
pause
goto main

:uptime
cls
echo === System Uptime ===
net stats srv | find "Statistics since"
pause
goto main

:sysinfo
cls
echo === System Information ===
echo Username: %USERNAME%
echo Computer: %COMPUTERNAME%
ver
systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
pause
goto main

:quote
cls
setlocal enabledelayedexpansion
set /a num=%random% %% 5
if !num! EQU 0 echo "The best way to get started is to quit talking and begin doing."
if !num! EQU 1 echo "Success is not in what you have, but who you are."
if !num! EQU 2 echo "Stay hungry. Stay foolish."
if !num! EQU 3 echo "Dream big and dare to fail."
if !num! EQU 4 echo "Keep going. Everything you need will come to you."
endlocal
pause
goto main

:openurl
cls
echo Enter the URL to open (include http:// or https://):
set /p url=
start "" "%url%"
pause
goto main


:newfile
cls
echo === Create New File ===
set /p filename=Enter filename (with .txt): 
if exist "%filename%" (
    echo File already exists.
) else (
    echo.>"%filename%"
    echo File created: %filename%
)
pause
goto main

:writefile
cls
echo === Write to File ===
set /p filename=Enter filename to write to: 
if not exist "%filename%" (
    echo File does not exist.
    pause
    goto main
)
echo Type your message (type 'EOF' on new line to save):
:inputloop
set /p text=
if /i "%text%"=="EOF" goto donewrite
echo %text%>>"%filename%"
goto inputloop

:donewrite
echo Done writing to %filename%.
pause
goto main

:readfile
cls
echo === Read a File ===
set /p filename=Enter filename to read: 
if not exist "%filename%" (
    echo File not found!
) else (
    echo --- Contents of %filename% ---
    type "%filename%"
)
pause
goto main

:delfile
cls
echo === Delete a File ===
set /p filename=Enter filename to delete: 
if exist "%filename%" (
    del "%filename%"
    echo Deleted: %filename%
) else (
    echo File not found!
)
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

REM =========================
REM TODO SECTION
REM =========================
:todo
cls
echo === TODO Manager ===
echo 1. Add Task
echo 2. View Tasks
echo 3. Delete Task
echo 4. Back to Main
set /p todoopt=Choose option (1-4): 
if "%todoopt%"=="1" goto todoadd
if "%todoopt%"=="2" goto todoview
if "%todoopt%"=="3" goto tododelete
goto main

:todoadd
set /p task=Enter new task: 
echo %task%>>todo.txt
echo Task added!
pause
goto todo

:todoview
if not exist todo.txt (
    echo No tasks found.
    pause
    goto todo
)
echo --- Your Tasks ---
setlocal enabledelayedexpansion
set idx=0
for /f "delims=" %%A in (todo.txt) do (
    set /a idx+=1
    echo !idx!. %%A
)
endlocal
pause
goto todo

:tododelete
if not exist todo.txt (
    echo No tasks to delete.
    pause
    goto todo
)
echo --- Your Tasks ---
setlocal enabledelayedexpansion
set idx=0
for /f "delims=" %%A in (todo.txt) do (
    set /a idx+=1
    echo !idx!. %%A
)
endlocal
set /p delnum=Enter task number to delete: 
setlocal enabledelayedexpansion
set idx=0
(for /f "delims=" %%A in (todo.txt) do (
    set /a idx+=1
    if not "!idx!"=="%delnum%" echo %%A
)) > todo_tmp.txt
endlocal
move /y todo_tmp.txt todo.txt >nul
echo Task deleted.
pause
goto todo

REM =========================
REM REMINDER SECTION
REM =========================
:reminder
cls
echo === Reminder ===
set /p remmsg=Enter reminder message: 
set /p remtime=Remind after how many seconds?: 
echo Waiting %remtime% seconds...
timeout /t %remtime% >nul
echo REMINDER: %remmsg%
pause
goto main

REM =========================
REM CALENDAR SECTION
REM =========================
:calendar
cls
echo === Calendar ===
echo 1. Show today's date
echo 2. Open Windows Calendar
echo 3. Back to Main
set /p calopt=Choose option (1-3): 
if "%calopt%"=="1" (
    echo Today is: %date%
    pause
    goto calendar
)
if "%calopt%"=="2" (
    start outlookcal:
    echo Opened Windows Calendar (if available).
    pause
    goto calendar
)
goto main

REM =========================
REM NOTES SECTION
REM =========================
:notes
cls
echo === Notes ===
echo 1. Add Note
echo 2. View Notes
echo 3. Back to Main
set /p noteopt=Choose option (1-3): 
if "%noteopt%"=="1" goto noteadd
if "%noteopt%"=="2" goto noteview
goto main

:noteadd
set /p note=Type your note: 
if not exist notes.txt echo.>notes.txt
echo %note%>>notes.txt
echo Note saved!
pause
goto notes

:noteview
if not exist notes.txt (
    echo No notes found.
    pause
    goto notes
)
echo --- Your Notes ---
type notes.txt
pause
goto notes

REM =========================
REM TIMER SECTION
REM =========================
:timer
cls
echo === Timer ===
set /p tmin=Enter minutes for timer: 
set /a tsecs=tmin*60
echo Timer started for %tmin% minutes.
timeout /t %tsecs% >nul
echo Timer finished!
pause
goto main
