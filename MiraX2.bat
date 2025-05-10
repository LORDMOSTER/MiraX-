@echo off
title MiraX OS - Shell
color 0D
set "dirhistory=%cd%"
set "dirpos=1"
REM === Load session if exists ===
if exist session.txt (
    for /f "tokens=1,* delims==" %%A in (session.txt) do (
        set "%%A=%%B"
    )
)

REM =========================
REM USER AUTHENTICATION SECTION
REM =========================
:auth
if not exist users.txt (
    echo No users found. Let's create your admin account.
    set /p newuser=Enter new username: 
    set /p newpass=Enter new password: 
    echo %newuser%:%newpass%:admin > users.txt
    echo Admin account created! Please login.
)

REM === Load settings if available ===
if exist settings.txt (
    for /f "tokens=1,* delims==" %%A in (settings.txt) do (
        set "%%A=%%B"
    )
)

goto login

:login
cls
echo ===============================
echo         MiraX OS Login
echo ===============================
set /p uname=Username: 
set /p upass=Password: 

setlocal enabledelayedexpansion
set "found="
set "userrole="
for /f "tokens=1,2,3 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="!uname!" if "%%B"=="!upass!" (
        set found=1
        set userrole=%%C
    )
)
endlocal & set found=%found% & set userrole=%userrole%

if defined found (
    echo Login successful! Welcome, %uname%.
    echo username=%uname%>session.txt
    echo role=%userrole%>>session.txt
    echo lastlogin=%date% %time%>>session.txt
    set username=%uname%
    set role=%userrole%

    REM Load user config if exists
    if exist configs\%uname%.config (
        for /f "tokens=1,* delims==" %%C in (configs\%uname%.config) do (
            set "%%C=%%D"
        )
    )
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
REM === System Logging: Log the command ===

echo ===============================
echo         MiraX OS Main Menu
echo ===============================
echo Type a command below:
echo (Type 'help' for commands)
echo.

if defined username (
    set /p usercmd=[%username%@MiraX] ^>
) else (
    set /p usercmd=MiraX^>
)

REM === Command Handlers ===
if /i "%usercmd%"=="help" goto help
if /i "%usercmd%"=="clear" goto clear
if /i "%usercmd%"=="about" goto about
if /i "%usercmd%"=="exit" goto end
if /i "%usercmd%"=="theme" goto colorMenu
if /i "%usercmd%"=="settings" goto settings
if /i "%usercmd%"=="time" goto showtime
if /i "%usercmd%"=="date" goto showdate
if /i "%usercmd%"=="notepad" goto runnotepad
if /i "%usercmd%"=="calc" goto runcalc
if /i "%usercmd%"=="dir" goto rundir
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
if /i "% usercmd%"=="fileinfo" goto fileinfo
if /i "%usercmd%"=="encryptfile" goto encryptfile
if /i "%usercmd%"=="decryptfile" goto decryptfile
REM === Pipe-like Chaining (Simulated Pipes) ===
echo %usercmd% | findstr /r /c:"^.*|.*$" >nul
if not errorlevel 1 goto pipechain

if /i "%usercmd:~0,10%"=="searchfile" goto searchfile
if /i "%usercmd:~0,8%"=="findtext" goto findtext
if /i "%usercmd%"=="history" goto history
if /i "%usercmd%"=="goback" goto goback
if /i "%usercmd%"=="viewsearchlogs" goto viewsearchlogs
if /i "%usercmd:~0,5%"=="runbg" goto runbg
if /i "%usercmd%"=="jobs" goto jobs
if /i "%usercmd:~0,7%"=="killjob" goto killjob
if /i "%usercmd%"=="clearjobs" goto clearjobs

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

REM === Theme Preview Command ===
if /i "%usercmd:~0,13%"=="theme preview" goto themepreview

if /i "%usercmd:~0,10%"=="searchfile" goto searchfile
if /i "%usercmd:~0,8%"=="findtext" goto findtext
if /i "%usercmd%"=="history" goto history
if /i "%usercmd%"=="goback" goto goback

REM === Command Handlers ===
if /i "%usercmd%"=="help" goto help
if /i "%usercmd%"=="clear" goto clear
if /i "%usercmd%"=="about" goto about
if /i "%usercmd%"=="exit" goto end
if /i "%usercmd%"=="theme" goto colorMenu
if /i "%usercmd%"=="settings" goto settings
if /i "%usercmd%"=="syshealth" goto syshealth
if /i "%usercmd%"=="battery" goto battery
if /i "%usercmd%"=="netstatus" goto netstatus
if /i "%usercmd%"=="cpuload" goto cpuload
if /i "%usercmd%"=="ramload" goto ramload
if /i "%usercmd%"=="diskinfo" goto diskinfo
if /i "%usercmd%"=="speedtest" goto speedtest
if /i "%usercmd%"=="pingtest" goto pingtest
if /i "%usercmd%"=="ipinfo" goto ipinfo
if /i "%usercmd%"=="openweb" goto openweb
if /i "%usercmd%"=="register" goto register
if /i "%usercmd%"=="login" goto login
if /i "%usercmd%"=="listusers" goto listusers
if /i "%usercmd:~0,10%"=="deleteuser" goto deleteuser
if /i "%usercmd:~0,11%"=="promoteuser" goto promoteuser

REM === User Theme/Prompt Commands ===
if /i "%usercmd:~0,7%"=="settheme" goto settheme
if /i "%usercmd:~0,12%"=="settextcolor" goto settextcolor
if /i "%usercmd%"=="listthemes" goto listthemes
if /i "%usercmd%"=="previewtheme" goto previewtheme
if /i "%usercmd%"=="resettheme" goto resettheme

if /i "%usercmd%"=="tasklist" goto tasklist
if /i "%usercmd:~0,8%"=="killtask" goto killtask
if /i "%usercmd%"=="sysload" goto sysload
if /i "%usercmd%"=="processinfo" goto processinfo
if /i "%usercmd%"=="memstat" goto memstat
if /i "%usercmd%"=="netstat" goto netstat
if /i "%usercmd:~0,8%"=="starttask" goto starttask
if /i "%usercmd%"=="tasklist" goto tasklist
if /i "%usercmd:~0,8%"=="killtask" goto killtask
if /i "%usercmd:~0,8%"=="taskinfo" goto taskinfo
if /i "%usercmd:~0,6%"=="uptask" goto uptask
if /i "%usercmd%"=="helpdesk" goto helpdesk
if /i "%usercmd:~0,4%"=="man " goto manpage
if /i "%usercmd%"=="viewlogs" goto viewlogs

if /i "%role%"=="guest" (
    echo Guests cannot delete files.
    pause
    goto main
)

if /i "%usercmd:~0,6%"=="setperm" goto setperm
if /i "%usercmd%"=="guest" goto guest
if /i "%usercmd%"=="whoami" goto whoami
if /i "%usercmd%"=="logout" goto logout

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

echo searchfile [name]    - Search for a file by name
echo findtext [text]      - Search for text inside .txt files
echo history              - Show directory navigation history
echo goback               - Return to previous directory
echo viewsearchlogs       - View search command logs

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

:guest
set username=guest
set role=guest
set lastlogin=%date% %time%
echo Guest mode enabled. Limited access.
timeout /t 1 >nul
goto main

:setperm
set args=%usercmd:~8%
for /f "tokens=1,2,3" %%a in ("%args%") do (
    set fname=%%a
    set permuser=%%b
    set perm=%%c
)
if "%fname%"=="" (
    set /p fname=Enter filename: 
)
if "%permuser%"=="" (
    set /p permuser=Enter username (or 'all'): 
)
if "%perm%"=="" (
    set /p perm=Enter permission (readonly/edit/restricted): 
)
REM Remove old permission for this file/user
if exist permissions.txt (
    findstr /v /i "^%fname%:%permuser%:" permissions.txt > permissions_tmp.txt
    move /y permissions_tmp.txt permissions.txt >nul
)
echo %fname%:%permuser%:%perm%>>permissions.txt
echo Permission set: %fname% for %permuser% as %perm%
pause
goto main

REM Example for :writefile
:writefile
cls
echo === Write to File ===
set /p filename=Enter filename to write to: 
REM Permission check
set allowed=1
if exist permissions.txt (
    for /f "tokens=1,2,3 delims=:" %%a in (permissions.txt) do (
        if /i "%%a"=="%filename%" if /i "%%b"=="%username%" (
            if /i "%%c"=="readonly" set allowed=0
            if /i "%%c"=="restricted" set allowed=0
        )
        if /i "%%a"=="%filename%" if /i "%%b"=="all" (
            if /i "%%c"=="readonly" set allowed=0
            if /i "%%c"=="restricted" set allowed=0
        )
    )
)
if "%allowed%"=="0" (
    echo You do not have permission to write to this file.
    pause goto main
)
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

:listusers
if /i not "%role%"=="admin" (
    echo Admin access required!
    pause
    goto main
)
cls
echo === Registered Users ===
for /f "tokens=1,3 delims=:" %%A in (users.txt) do (
    echo Username: %%A   Role: %%C
)
pause
goto main

:deleteuser
if /i not "%role%"=="admin" (
    echo Admin access required!
    pause
    goto main
)
set usertodel=%usercmd:~11%
if "%usertodel%"=="" (
    set /p usertodel=Enter username to delete: 
)
findstr /i /v "^%usertodel%:" users.txt > users_tmp.txt
move /y users_tmp.txt users.txt >nul
echo User '%usertodel%' deleted (if existed).
pause
goto main

:promoteuser
if /i not "%role%"=="admin" (
    echo Admin access required!
    pause
    goto main
)
set usertopromote=%usercmd:~12%
if "%usertopromote%"=="" (
    set /p usertopromote=Enter username to promote: 
)
(for /f "tokens=1,2,3 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="%usertopromote%" (
        echo %%A:%%B:admin
    ) else (
        echo %%A:%%B:%%C
    )
)) > users_tmp.txt
move /y users_tmp.txt users.txt >nul
echo User '%usertopromote%' promoted to admin (if existed).
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

:prompt set promptSym=%usercmd:~11%
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
    set "prevdir=%cd%"
    cd /d "%newdir%"
    set /a dirpos+=1
    set "dirhistory=%dirhistory%|%cd%"
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
set /p choice="Enter option (1-6 ): "

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
: calendar
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

:register
cls
echo === User Registration ===
set /p reguser=Enter new username: 
set /p regpass=Enter new password: 
REM Default role is 'user', unless first user (then admin)
set role=user
if not exist users.txt (
    set role=admin
)
REM Simple base64 obfuscation (not secure, but better than plain)
echo %reguser%:%regpass%:%role%>>users.txt
echo User '%reguser%' registered as %role%.
pause
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

REM =========================
REM SETTINGS SECTION
REM =========================
:settings
cls
echo === MiraX Settings ===
echo 1. Change Username
echo 2. Change Password
echo 3. Set Default Color Theme
echo 4. Set Welcome Message
echo 5. Reset Settings (Factory Defaults)
echo 6. Back to Main
set /p setopt=Choose option (1-6): 
if "%setopt%"=="1" goto set_username
if "%setopt%"=="2" goto set_password
if "%setopt%"=="3" goto set_theme
if "%setopt%"=="4" goto set_welcome
if "%setopt%"=="5" goto reset_settings
goto main

:set_username
set /p newuser=Enter new username: 
REM Update users.txt (replace old username with new one for current user)
setlocal enabledelayedexpansion
set "updated="
(for /f "tokens=1,2 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="%uname%" (
        echo %newuser%:%%B
        set "updated=1"
    ) else (
        echo %%A:%%B
    )
)) > users_tmp.txt
endlocal
move /y users_tmp.txt users.txt >nul
set uname=%newuser%
echo Username changed!
pause
goto settings

:set_password
set /p newpass=Enter new password: 
setlocal enabledelayedexpansion
(for /f "tokens=1,2 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="%uname%" (
        echo %%A:%newpass%
    ) else (
        echo %%A:%%B
    )
)) > users_tmp.txt
endlocal
move /y users_tmp.txt users.txt >nul
echo Password changed!
pause
goto settings

:set_theme
echo Choose a color code (e.g., 0D for purple, 0F for white, 3F for aqua, etc.)
set /p newtheme=Enter color code: 
set theme=%newtheme%
REM Save to settings.txt
call :save_settings
echo Theme set to %theme%.
pause
goto settings

:set_welcome
set /p welcome=Enter your welcome message: 
REM Save to settings.txt
call :save_settings
echo Welcome message updated!
pause
goto settings

:reset_settings
del settings.txt >nul 2>&1
set theme=
set welcome=
echo Settings reset to factory defaults.
pause
goto settings

:save_settings
REM Save current settings to settings.txt
(
    if defined theme echo theme=%theme%
    if defined welcome echo welcome=%welcome%
) > settings.txt
exit /b

REM =========================
REM SYSTEM HEALTH SECTION
REM =========================
:syshealth
cls
echo === System Health ===
REM CPU Usage (simulated)
for /f "skip=1 tokens=3" %%a in ('wmic cpu get loadpercentage') do (
    if not "%%a"=="" (
        set cpu=%%a
        goto :syshealth_ram
    )
)
:syshealth_ram
REM RAM Usage
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /value') do (
    set FreeMem=%%a
)
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /value') do (
    set TotalMem=%%a
)
set /a UsedMem=%TotalMem% - %FreeMem%
set /a UsedPerc=(%UsedMem%*100)/%TotalMem%
REM Disk Usage (C:)
for /f "skip=1 tokens=3" %%a in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace') do (
    set FreeDisk=%%a
    goto :syshealth_disk
)
:syshealth_disk
for /f "skip=1 tokens=3" %%a in ('wmic logicaldisk where "DeviceID='C:'" get Size') do (
    set TotalDisk=%%a
    goto :syshealth_show
)
:syshealth_show
set /a UsedDisk=%TotalDisk% - %FreeDisk%
set /a DiskPerc=(%UsedDisk%*100)/%TotalDisk%
echo CPU Usage: %cpu%%%
echo RAM Usage: %UsedPerc%%% (%UsedMem% KB used of %TotalMem% KB)
echo Disk Usage (C:): %DiskPerc%%% (%UsedDisk% bytes used of %TotalDisk% bytes)
echo.
pause
goto main

:battery
cls
echo === Battery Status ===
wmic path Win32_Battery get EstimatedChargeRemaining,BatteryStatus /format:list 2>nul
if errorlevel 1 (
    echo Battery info not available (desktop or unsupported device).
) else (
    for /f "tokens=1,2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining,BatteryStatus /value') do (
        if "%%a"=="EstimatedChargeRemaining" set charge=%%b
        if "%%a"=="BatteryStatus" set status=%%b
    )
    if defined charge (
        echo Battery: %charge%%%
        if "%status%"=="2" (
            echo Status: Charging
        ) else (
            echo Status: Discharging
        )
    )
)
echo.
pause
goto main

:netstatus
cls
echo === Network Status ===
ping -n 1 8.8.8.8 | find "TTL=" >nul
if %errorlevel%==0 (
    echo Internet: Connected
) else (
    echo Internet: Not Connected
)
echo.
pause
goto main

:cpuload
cls
echo === CPU Load (Simulated) ===
for /f "skip=1 tokens=3" %%a in ('wmic cpu get loadpercentage') do (
    if not "%%a"=="" (
        echo Current CPU Load: %%a%%
        goto cpuload_done
    )
)
:cpuload_done
pause
goto main

:ramload
cls
echo === RAM Load (Simulated) ===
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /value') do (
    set FreeMem=%%a
)
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /value') do (
    set TotalMem=%%a
)
set /a UsedMem=%TotalMem% - %FreeMem%
set /a UsedPerc=(%UsedMem%*100)/%TotalMem%
echo RAM Usage: %UsedPerc%%% (%UsedMem% KB used of %TotalMem% KB)
pause
goto main

:pingtest
cls
echo === Ping Test ===
set /p target=Enter website or domain to ping: 
ping -n 3 %target%
if %errorlevel%==0 (
    echo %target% is reachable!
) else (
    echo %target% is NOT reachable.
)
pause
goto main

:ipinfo
cls
echo === Public IP Information ===
where curl >nul 2>nul
if errorlevel 1 (
    echo curl is not installed. Please install curl to use this feature.
) else (
    echo Fetching public IP and location...
    curl -s ipinfo.io
)
pause
goto main

:openweb
cls
echo === Open Website === 
set /p weburl=Enter website URL (include http:// or https://): 
start "" "%weburl%"
echo Opened %weburl% in your browser.
pause
goto main

:tasklist
cls
echo === Task List (Simulated) ===
echo ID   Name         Status      CPU   Mem
echo 1    explorer.exe Running     02%%  50MB
echo 2    chrome.exe   Running     10%%  200MB
echo 3    notepad.exe  Sleeping    00%%  10MB
echo 4    python.exe   Running     15%%  120MB
echo 5    svchost.exe  Running     01%%  30MB
echo.
pause
goto main

:killtask
set taskid=%usercmd:~9%
if "%taskid%"=="" (
    set /p taskid=Enter Task ID to kill: 
)
REM Simulate killing the task
echo Attempting to terminate task ID %taskid%...
REM (In real, use taskkill /PID %taskid% /F)
echo Task ID %taskid% terminated (simulated).
pause
goto main

:sysload
cls
echo === System Load (Simulated) ===
set /a cpu=%random% %% 100
set /a mem=%random% %% 100
set barcpu=
set barmem=
for /l %%i in (1,1,%cpu%) do set barcpu=!barcpu!#
for /l %%i in (1,1,%mem%) do set barmem=!barmem!#
echo CPU: [%cpu%%%] !barcpu!
echo MEM: [%mem%%%] !barmem!
pause
goto main

:processinfo
set pname=%usercmd:~12%
if "%pname%"=="" (
    set /p pname=Enter process name: 
)
REM Simulate process info
if /i "%pname%"=="explorer.exe" (
    echo Name: explorer.exe
    echo Status: Running
    echo ID: 1
    echo CPU: 02%%
    echo Mem: 50MB
) else if /i "%pname%"=="chrome.exe" (
    echo Name: chrome.exe
    echo Status: Running
    echo ID: 2
    echo CPU: 10%%
    echo Mem: 200MB
) else (
    echo Process '%pname%' not found (simulated).
)
pause
goto main

:memstat
cls
echo === Memory Status (Simulated) ===
set total=4096
set used=%random%
set /a used=used %% 4096
set /a avail=total-used
echo Total: %total% MB
echo Used : %used% MB
echo Free : %avail% MB
pause
goto main

:netstat
cls
echo === Network Status ===
ping -n 1 8.8.8.8 | find "TTL=" >nul
if %errorlevel%==0 (
    echo Internet: Connected
) else (
    echo Internet: Not Connected
)
for /f "tokens=2 delims:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    echo IP Address:%%a
)
pause
goto main

:diskinfo
cls
echo === Disk Info ===
for /f "skip=1 tokens=1,3" %%a in ('wmic logicaldisk get DeviceID,FreeSpace') do (
    if not "%%a"=="" (
        set drive=%%a
        set free=%%b
        echo Drive %%a: Free Space = %%b bytes
    )
)
echo.
pause
goto main

:speedtest
cls
echo === Internet Speed Test ===
echo This feature requires 'speedtest.exe' in the MiraX folder.
if exist speedtest.exe (
    speedtest.exe
) else (
    echo Please download speedtest.exe from https://www.speedtest.net/apps/cli and place it here.
)
pause
goto main

:settheme
set themeName=%usercmd:~8%
if "%themeName%"=="" (
    echo Usage: settheme [light|dark|matrix|default|neon|retro|hacker]
    pause
    goto main
)
set theme=%themeName%
REM Simulate theme with color codes
if /i "%themeName%"=="light" set textcolor=0F
if /i "%themeName%"=="dark" set textcolor=07
if /i "%themeName%"=="matrix" set textcolor=0A
if /i "%themeName%"=="default" set textcolor=0F
if /i "%themeName%"=="neon" set textcolor=0B
if /i "%themeName %"=="retro" set textcolor=2E
if /i "%themeName%"=="hacker" set textcolor=0A
REM Save to user config
if not exist configs mkdir configs
(
    echo theme=%theme%
    echo textcolor=%textcolor%
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Theme set to %theme%. Enjoy your new look!
pause
goto main

:settextcolor
set colorval=%usercmd:~13%
if "%colorval%"=="" (
    echo Usage: settextcolor [color code, e.g., 0A for green]
    pause
    goto main
)
set textcolor=%colorval%
if not exist configs mkdir configs
(
    if defined theme echo theme=%theme%
    echo textcolor=%textcolor%
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Text color set to %textcolor%.
pause
goto main

:listthemes
echo === Available Themes ===
echo default
echo dark
echo neon
echo retro
echo hacker
pause
goto main

:previewtheme
set themeName=%usercmd:~13%
if "%themeName%"=="" (
    echo Usage: previewtheme [theme]
    pause
    goto main
)
if /i "%themeName%"=="default" color 0F
if /i "%themeName%"=="dark" color 07
if /i "%themeName%"=="neon" color 0B
if /i "%themeName%"=="retro" color 2E
if /i "%themeName%"=="hacker" color 0A
echo Previewing theme '%themeName%'. Press any key to revert.
pause
color 0D
goto main

:resettheme
set theme=default
set textcolor=0F
if not exist configs mkdir configs
(
    echo theme=default
    echo textcolor=0F
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Theme reset to default.
pause
goto main

:setbanner
echo Enter your custom welcome banner (type 'EOF' on a new line to finish):
if not exist banners mkdir banners
set bannerfile=banners\%username%.banner
break > "%bannerfile%"
:bannerinput
set /p bline=
if /i "%bline%"=="EOF" goto bannerdone
echo %bline%>>"%bannerfile%"
goto bannerinput

:bannerdone
set banner=%bannerfile%
REM Save banner path to user config
if not exist configs mkdir configs
(
    echo theme=%theme%
    echo textcolor=%textcolor%
    echo banner=%banner%
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Banner saved!
pause
goto main ```batch
:main
cls
echo ===============================
echo         MiraX OS Main Menu
echo ===============================
echo Type a command below:
echo (Type 'help' for commands)
echo.

if defined username (
    set /p usercmd=[%username%@MiraX] ^>
) else (
    set /p usercmd=MiraX^>
)

REM === Command Handlers ===
if /i "%usercmd%"=="help" goto help
if /i "%usercmd%"=="clear" goto clear
if /i "%usercmd%"=="about" goto about
if /i "%usercmd%"=="exit" goto end
if /i "%usercmd%"=="theme" goto colorMenu
if /i "%usercmd%"=="settings" goto settings
if /i "%usercmd%"=="time" goto showtime
if /i "%usercmd%"=="date" goto showdate
if /i "%usercmd%"=="notepad" goto runnotepad
if /i "%usercmd%"=="calc" goto runcalc
if /i "%usercmd%"=="dir" goto rundir
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

REM === Theme Preview Command ===
if /i "%usercmd:~0,13%"=="theme preview" goto themepreview

REM === Command Handlers ===
if /i "%usercmd%"=="help" goto help
if /i "%usercmd%"=="clear" goto clear
if /i "%usercmd%"=="about" goto about
if /i "%usercmd%"=="exit" goto end
if /i "%usercmd%"=="theme" goto colorMenu
if /i "%usercmd%"=="settings" goto settings
if /i "%usercmd%"=="syshealth" goto syshealth
if /i "%usercmd%"=="battery" goto battery
if /i "%usercmd%"==" netstatus" goto netstatus
if /i "%usercmd%"=="cpuload" goto cpuload
if /i "%usercmd%"=="ramload" goto ramload
if /i "%usercmd%"=="diskinfo" goto diskinfo
if /i "%usercmd%"=="speedtest" goto speedtest
if /i "%usercmd%"=="pingtest" goto pingtest
if /i "%usercmd%"=="ipinfo" goto ipinfo
if /i "%usercmd%"=="openweb" goto openweb
if /i "%usercmd%"=="register" goto register
if /i "%usercmd%"=="login" goto login
if /i "%usercmd%"=="listusers" goto listusers
if /i "%usercmd:~0,10%"=="deleteuser" goto deleteuser
if /i "%usercmd:~0,11%"=="promoteuser" goto promoteuser

REM === User Theme/Prompt Commands ===
if /i "%usercmd:~0,7%"=="settheme" goto settheme
if /i "%usercmd:~0,12%"=="settextcolor" goto settextcolor
if /i "%usercmd%"=="listthemes" goto listthemes
if /i "%usercmd%"=="previewtheme" goto previewtheme
if /i "%usercmd%"=="resettheme" goto resettheme

if /i "%usercmd%"=="tasklist" goto tasklist
if /i "%usercmd:~0,8%"=="killtask" goto killtask
if /i "%usercmd%"=="sysload" goto sysload
if /i "%usercmd%"=="processinfo" goto processinfo
if /i "%usercmd%"=="memstat" goto memstat
if /i "%usercmd%"=="netstat" goto netstat

if /i "%role%"=="guest" (
    echo Guests cannot delete files.
    pause
    goto main
)

if /i "%usercmd:~0,6%"=="setperm" goto setperm
if /i "%usercmd%"=="guest" goto guest
if /i "%usercmd%"=="whoami" goto whoami
if /i "%usercmd%"=="logout" goto logout

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
echo newfile  - Create a new file
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
echo ls        - List files and folders
echo cd        - Change directory
echo mkdir     - Create a new folder
echo movefile  - Move or rename a file
echo copyfile  - Copy a file
echo exists    - Check if file/folder exists
echo filesize  - Show file size
echo fileinfo  - Show file info
echo encryptfile - Encrypt a text file
echo decryptfile - Decrypt a text file

echo theme save [name]   - Save current theme
echo theme load [name]   - Load a theme
echo theme list          - List all themes
echo theme delete [name] - Delete a theme
echo theme preview [name] - Preview a theme
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

:guest
set username=guest
set role=guest
set lastlogin=%date% %time%
echo Guest mode enabled. Limited access.
timeout /t 1 >nul
goto main

:setperm
set args=%usercmd:~8%
for /f "tokens=1,2,3" %%a in ("%args%") do (
    set fname=%%a
    set permuser=%%b
    set perm=%%c
)
if "%fname%"=="" (
    set /p fname=Enter filename: 
)
if "%permuser%"=="" (
    set /p permuser=Enter username (or 'all'): 
)
if "%perm%"=="" (
    set /p perm=Enter permission (readonly/edit/restricted): 
)
REM Remove old permission for this file/user
if exist permissions.txt (
    findstr /v /i "^%fname%:%permuser%:" permissions.txt > permissions_tmp.txt
    move /y permissions_tmp.txt permissions.txt >nul
)
echo %fname%:%permuser%:%perm%>>permissions.txt
echo Permission set: %fname% for %permuser% as %perm%
pause
goto main

:writefile
cls
echo === Write to File ===
set /p filename=Enter filename to write to: 
REM Permission check
set allowed=1
if exist permissions.txt (
    for /f "tokens=1,2,3 delims=:" %%a in (permissions.txt) do (
        if /i "%%a"=="%filename%" if /i "%%b"=="%username%" (
            if /i "%%c"=="readonly" set allowed=0
            if /i "%%c"=="restricted" set allowed=0
        )
        if /i "%%a"=="%filename%" if /i "%%b"=="all" (
            if /i "%%c"=="readonly" set allowed=0
            if /i "%%c"=="restricted" set allowed=0
        )
    )
)
if "%allowed%"=="0" (
    echo You do not have permission to write to this file.
    pause
    goto main
)
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

:listusers
if /i not "%role%"=="admin" (
    echo Admin access required!
    pause
    goto main
)
cls
echo === Registered Users ===
for /f "tokens=1,3 delims=:" %%A in (users.txt) do (
    echo Username: %%A   Role: %%C
)
pause
goto main

:deleteuser
if /i not "%role%"=="admin" (
    echo Admin access required!
    pause
    goto main
)
set usertodel=%usercmd:~11%
if "%usertodel%"=="" (
    set /p usertodel=Enter username to delete: 
)
findstr /i /v "^%usertodel%:" users.txt > users_tmp.txt
move /y users_tmp.txt users.txt >nul
echo User '%usertodel%' deleted (if existed).
pause
goto main

:promoteuser
if /i not "%role%"=="admin" (
    echo Admin access required!
    pause
    goto main
)
set usertopromote=%usercmd:~12%
if "%usertopromote%"=="" (
    set /p usertopromote=Enter username to promote: 
)
(for /f "tokens=1,2,3 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="%usertopromote%" (
        echo %%A:%%B:admin
    ) else (
        echo %%A:%%B:%%C
    )
)) > users_tmp.txt
move /y users_tmp.txt users.txt >nul
echo User '%usertopromote%' promoted to admin (if existed).
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

: quote
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

 ```batch
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

:register
cls
echo === User Registration ===
set /p reguser=Enter new username: 
set /p regpass=Enter new password: 
REM Default role is 'user', unless first user (then admin)
set role=user
if not exist users.txt (
    set role=admin
)
REM Simple base64 obfuscation (not secure, but better than plain)
echo %reguser%:%regpass%:%role%>>users.txt
echo User '%reguser%' registered as %role%.
pause
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

REM =========================
REM SETTINGS SECTION
REM =========================
:settings
cls
echo === MiraX Settings ===
echo 1. Change Username
echo 2. Change Password
echo 3. Set Default Color Theme
echo 4. Set Welcome Message
echo 5. Reset Settings (Factory Defaults)
echo 6. Back to Main
set /p setopt=Choose option (1-6): 
if "%setopt%"=="1" goto set_username
if "%setopt%"=="2" goto set_password
if "%setopt%"=="3" goto set_theme
if "%setopt%"=="4" goto set_welcome
if "%setopt%"=="5" goto reset_settings
goto main

:set_username
set /p newuser=Enter new username: 
REM Update users.txt (replace old username with new one for current user)
setlocal enabledelayedexpansion
set "updated="
(for /f "tokens=1,2 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="%uname%" (
        echo %newuser%:%%B
        set "updated=1"
    ) else (
        echo %%A:%%B
    )
)) > users_tmp.txt
endlocal
move /y users_tmp.txt users.txt >nul
set uname=%newuser%
echo Username changed!
pause
goto settings

:set_password
set /p newpass=Enter new password: 
setlocal enabledelayedexpansion
(for /f "tokens=1,2 delims=:" %%A in (users.txt) do (
    if /i "%%A"=="%uname%" (
        echo %%A:%newpass%
    ) else (
        echo %%A:%%B
    )
)) > users_tmp.txt
endlocal
move /y users_tmp.txt users.txt >nul
echo Password changed!
pause
goto settings

:set_theme
echo Choose a color code (e.g., 0D for purple, 0F for white, 3F for aqua, etc.)
set /p newtheme=Enter color code: 
set theme=%newtheme%
REM Save to settings.txt
call :save_settings
echo Theme set to %theme%.
pause
goto settings

:set_welcome
set /p welcome=Enter your welcome message: 
REM Save to settings.txt
call :save_settings
echo Welcome message updated!
pause
goto settings

:reset_settings
del settings.txt >nul 2>&1
set theme=
set welcome=
echo Settings reset to factory defaults.
pause
goto settings

:save_settings
REM Save current settings to settings.txt
(
    if defined theme echo theme=%theme%
    if defined welcome echo welcome=%welcome%
) > settings.txt
exit /b

REM =========================
REM SYSTEM HEALTH SECTION
REM =========================
:syshealth
cls
echo === System Health ===
REM CPU Usage (simulated)
for /f "skip=1 tokens=3" %%a in ('wmic cpu get loadpercentage') do (
    if not "%%a"=="" (
        set cpu=%%a
        goto :syshealth_ram
    )
)
:syshealth_ram
REM RAM Usage
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /value') do (
    set FreeMem=%%a
)
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /value') do (
    set TotalMem=%%a
)
set /a UsedMem=%TotalMem% - %FreeMem%
set /a UsedPerc=(%UsedMem%*100)/%TotalMem%
REM Disk Usage (C:)
for /f "skip=1 tokens=3" %%a in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace') do (
    set FreeDisk=%%a
    goto :syshealth_disk
)
:syshealth_disk
for /f "skip=1 tokens=3" %%a in ('wmic logicaldisk where "DeviceID='C:'" get Size') do (
    set TotalDisk=%%a
    goto :syshealth_show
)
:syshealth_show
set /a UsedDisk=%TotalDisk% - %FreeDisk%
set /a DiskPerc=(%UsedDisk%*100)/%TotalDisk%
echo CPU Usage: %cpu%%%
echo RAM Usage: %UsedPerc%%% (%UsedMem% KB used of %TotalMem% KB)
echo Disk Usage (C:): %DiskPerc%%% (%UsedDisk% bytes used of %TotalDisk% bytes)
echo.
pause
goto main

:battery
cls
echo === Battery Status ===
wmic path Win32_Battery get EstimatedChargeRemaining,BatteryStatus /format:list 2>nul
if errorlevel 1 (
    echo Battery info not available (desktop or unsupported device).
) else (
    for /f "tokens=1,2 delims==" %%a in ('wmic path Win32_Battery get EstimatedChargeRemaining,BatteryStatus /value') do (
        if "%%a"=="EstimatedChargeRemaining" set charge=%%b
        if "%%a"=="BatteryStatus" set status= %%b
    )
    if defined charge (
        echo Battery: %charge%%%
        if "%status%"=="2" (
            echo Status: Charging
        ) else (
            echo Status: Discharging
        )
    )
)
echo.
pause
goto main

:netstatus
cls
echo === Network Status ===
ping -n 1 8.8.8.8 | find "TTL=" >nul
if %errorlevel%==0 (
    echo Internet: Connected
) else (
    echo Internet: Not Connected
)
echo.
pause
goto main

:cpuload
cls
echo === CPU Load (Simulated) ===
for /f "skip=1 tokens=3" %%a in ('wmic cpu get loadpercentage') do (
    if not "%%a"=="" (
        echo Current CPU Load: %%a%%
        goto cpuload_done
    )
)
:cpuload_done
pause
goto main

:ramload
cls
echo === RAM Load (Simulated) ===
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /value') do (
    set FreeMem=%%a
)
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /value') do (
    set TotalMem=%%a
)
set /a UsedMem=%TotalMem% - %FreeMem%
set /a UsedPerc=(%UsedMem%*100)/%TotalMem%
echo RAM Usage: %UsedPerc%%% (%UsedMem% KB used of %TotalMem% KB)
pause
goto main

:pingtest
cls
echo === Ping Test ===
set /p target=Enter website or domain to ping: 
ping -n 3 %target%
if %errorlevel%==0 (
    echo %target% is reachable!
) else (
    echo %target% is NOT reachable.
)
pause
goto main

:ipinfo
cls
echo === Public IP Information ===
where curl >nul 2>nul
if errorlevel 1 (
    echo curl is not installed. Please install curl to use this feature.
) else (
    echo Fetching public IP and location...
    curl -s ipinfo.io
)
pause
goto main

:openweb
cls
echo === Open Website === 
set /p weburl=Enter website URL (include http:// or https://): 
start "" "%weburl%"
echo Opened %weburl% in your browser.
pause
goto main

:tasklist
cls
echo === Task List (Simulated) ===
echo ID   Name         Status      CPU   Mem
echo 1    explorer.exe Running     02%%  50MB
echo 2    chrome.exe   Running     10%%  200MB
echo 3    notepad.exe  Sleeping    00%%  10MB
echo 4    python.exe   Running     15%%  120MB
echo 5    svchost.exe  Running     01%%  30MB
echo.
pause
goto main

:killtask
set taskid=%usercmd:~9%
if "%taskid%"=="" (
    set /p taskid=Enter Task ID to kill: 
)
REM Simulate killing the task
echo Attempting to terminate task ID %taskid%...
REM (In real, use taskkill /PID %taskid% /F)
echo Task ID %taskid% terminated (simulated).
pause
goto main

:sysload
cls
echo === System Load (Simulated) ===
set /a cpu=%random% %% 100
set /a mem=%random% %% 100
set barcpu=
set barmem=
for /l %%i in (1,1,%cpu%) do set barcpu=!barcpu!#
for /l %%i in (1,1,%mem%) do set barmem=!barmem!#
echo CPU: [%cpu%%%] !barcpu!
echo MEM: [%mem%%%] !barmem!
pause
goto main

:processinfo
set pname=%usercmd:~12%
if "%pname%"=="" (
    set /p pname=Enter process name: 
)
REM Simulate process info
if /i "%pname%"=="explorer.exe" (
    echo Name: explorer.exe
    echo Status: Running
    echo ID: 1
    echo CPU: 02%%
    echo Mem: 50MB
) else if /i "%pname%"=="chrome.exe" (
    echo Name: chrome.exe
    echo Status: Running
    echo ID: 2
    echo CPU: 10%%
    echo Mem: 200MB
) else (
    echo Process '%pname%' not found (simulated).
)
pause
goto main

 ```batch
:memstat
cls
echo === Memory Status (Simulated) ===
set total=4096
set used=%random%
set /a used=used %% 4096
set /a avail=total-used
echo Total: %total% MB
echo Used : %used% MB
echo Free : %avail% MB
pause
goto main

:netstat
cls
echo === Network Status ===
ping -n 1 8.8.8.8 | find "TTL=" >nul
if %errorlevel%==0 (
    echo Internet: Connected
) else (
    echo Internet: Not Connected
)
for /f "tokens=2 delims:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    echo IP Address:%%a
)
pause
goto main

:diskinfo
cls
echo === Disk Info ===
for /f "skip=1 tokens=1,3" %%a in ('wmic logicaldisk get DeviceID,FreeSpace') do (
    if not "%%a"=="" (
        set drive=%%a
        set free=%%b
        echo Drive %%a: Free Space = %%b bytes
    )
)
echo.
pause
goto main

:speedtest
cls
echo === Internet Speed Test ===
echo This feature requires 'speedtest.exe' in the MiraX folder.
if exist speedtest.exe (
    speedtest.exe
) else (
    echo Please download speedtest.exe from https://www.speedtest.net/apps/cli and place it here.
)
pause
goto main

:settheme
set themeName=%usercmd:~8%
if "%themeName%"=="" (
    echo Usage: settheme [light|dark|matrix|default|neon|retro|hacker]
    pause
    goto main
)
set theme=%themeName%
REM Simulate theme with color codes
if /i "%themeName%"=="light" set textcolor=0F
if /i "%themeName%"=="dark" set textcolor=07
if /i "%themeName%"=="matrix" set textcolor=0A
if /i "%themeName%"=="default" set textcolor=0F
if /i "%themeName%"=="neon" set textcolor=0B
if /i "%themeName%"=="retro" set textcolor=2E
if /i "%themeName%"=="hacker" set textcolor=0A
REM Save to user config
if not exist configs mkdir configs
(
    echo theme=%theme%
    echo textcolor=%textcolor%
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Theme set to %theme%. Enjoy your new look!
pause
goto main

:settextcolor
set colorval=%usercmd:~13%
if "%colorval%"=="" (
    echo Usage: settextcolor [color code, e.g., 0A for green]
    pause
    goto main
)
set textcolor=%colorval%
if not exist configs mkdir configs
(
    if defined theme echo theme=%theme%
    echo textcolor=%textcolor%
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Text color set to %textcolor%.
pause
goto main

:listthemes
echo === Available Themes ===
echo default
echo dark
echo neon
echo retro
echo hacker
pause
goto main

:previewtheme
set themeName=%usercmd:~13%
if "%themeName%"=="" (
    echo Usage: previewtheme [theme]
    pause
    goto main
)
if /i "%themeName%"=="default" color 0F
if /i "%themeName%"=="dark" color 07
if /i "%themeName%"=="neon" color 0B
if /i "%themeName%"=="retro" color 2E
if /i "%themeName%"=="hacker" color 0A
echo Previewing theme '%themeName%'. Press any key to revert.
pause
color 0D
goto main
:starttask
set taskname=%usercmd:~9%
if "%taskname%"=="" (
    set /p taskname=Enter task name: 
)
REM Generate a random PID (1000-9999)
set /a pid=%random% %% 9000 + 1000
set status=Running
set /a cpu=%random% %% 100
set /a mem=%random% %% 200 + 20
set starttime=%time%
REM Save: PID:TaskName:Status:CPU:MEM:StartTime
echo %pid%:%taskname%:%status%:%cpu%:%mem%:%starttime%>>processes.txt
echo Started task '%taskname%' with PID %pid%.
pause
goto main

:tasklist
cls
echo === Active Tasks ===
if not exist processes.txt (
    echo No running tasks.
    pause
    goto main
)
echo PID   Name             Status     CPU   MEM   StartTime
for /f "tokens=1-6 delims=:" %%a in (processes.txt) do (
    echo %%a   %%b   %%c   %%d%%   %%e MB   %%f
)
pause
goto main

:killtask
set pid=%usercmd:~9%
if "%pid%"=="" (
    set /p pid=Enter PID to kill: 
)
if not exist processes.txt (
    echo No running tasks.
    pause
    goto main
)
findstr /v /b "%pid%:" processes.txt > processes_tmp.txt
move /y processes_tmp.txt processes.txt >nul
echo Task with PID %pid% terminated (simulated).
pause
goto main

:taskinfo
set pid=%usercmd:~9%
if "%pid%"=="" (
    set /p pid=Enter PID to view info: 
)
set found=0
for /f "tokens=1-6 delims=:" %%a in (processes.txt) do (
    if "%%a"=="%pid%" (
        echo === Task Info ===
        echo PID      : %%a
        echo Name     : %%b
        echo Status   : %%c
        echo CPU      : %%d%%
        echo Memory   : %%e MB
        echo Started  : %%f
        set found=1
    )
)
if "%found%"=="0" (
    echo No such process with PID %pid%.
)
pause
goto main

:uptask
set pid=%usercmd:~7%
if "%pid%"=="" (
    set /p pid=Enter PID to check uptime: 
)
set found=0
for /f "tokens=1-6 delims=:" %%a in (processes.txt) do (
    if "%%a"=="%pid%" (
        echo PID: %%a
        echo Name: %%b
        echo Started at: %%f
        REM Simulate uptime (not real, just for demo)
        echo Uptime: [Simulated: %random% seconds]
        set found=1
    )
)
if "%found%"=="0" (
    echo No such process with PID %pid%.
)
pause
goto main
:resettheme
set theme=default
set textcolor=0F
if not exist configs mkdir configs
(
    echo theme=default
    echo textcolor=0F
    echo lastlogin=%date% %time%
    echo role=%role%
) > configs\%username%.config
echo Theme reset to default.
pause
goto main
:helpdesk
cls
echo ===============================
echo         MiraX HelpDesk
echo ===============================
echo.
echo [File Operations]
echo   newfile, writefile, readfile, delfile, movefile, copyfile, exists, filesize, fileinfo
echo.
echo [System Tools]
echo   sysinfo, syshealth, battery, netstatus, cpuload, ramload, diskinfo, speedtest, pingtest, ipinfo, openweb, uptime, processinfo, memstat, netstat
echo.
echo [Productivity]
echo   todo, notes, reminder, timer, calendar, notepad, calc
echo.
echo [Advanced / Experimental]
echo   setperm, encryptfile, decryptfile, theme save/load/list/delete/preview, banner set/show/off/list, prompt set/color/reset, ascii, guest, register, login, listusers, deleteuser, promoteuser, starttask, tasklist, killtask, taskinfo, uptask
echo.
echo [Quick Tips]
echo   Type 'man <command>' for details on any command.
echo   Example: man tasklist
echo.
pause
goto main
:manpage
set mancmd=%usercmd:~4%
cls
if /i "%mancmd%"=="tasklist" (
    echo === Manual: tasklist ===
    echo Description: Lists all active simulated tasks/processes.
    echo Syntax:      tasklist
    echo Example:     tasklist
    echo.
    echo Shows PID, name, status, CPU, MEM, and start time for each task.
    pause
    goto main
)
if /i "%mancmd%"=="starttask" (
    echo === Manual: starttask ===
    echo Description: Starts a new simulated process/task.
    echo Syntax:      starttask ^<taskname^>
    echo Example:     starttask backup_script
    echo.
    echo Adds a new entry to the process list with a unique PID.
    pause
    goto main
)
if /i "%mancmd%"=="killtask" (
    echo === Manual: killtask ===
    echo Description: Terminates a simulated process by PID.
    echo Syntax:      killtask ^<pid^>
    echo Example:     killtask 1234
    echo.
    echo Removes the process from the process list.
    pause
    goto main
)
if /i "%mancmd%"=="taskinfo" (
    echo === Manual: taskinfo ===
    echo Description: Shows details for a simulated process by PID.
    echo Syntax:      taskinfo ^<pid^>
    echo Example:     taskinfo 1234
    echo.
    echo Displays all info for the given PID.
    pause
    goto main
)
if /i "%mancmd%"=="uptask" (
    echo === Manual: uptask ===
    echo Description: Shows simulated uptime for a process by PID.
    echo Syntax:      uptask ^<pid^>
    echo Example:     uptask 1234
    echo.
    echo Displays the start time and a simulated uptime.
    pause
    goto main
)
REM Add more man pages as needed
echo No manual entry for '%mancmd%'.
pause
goto main
:viewlogs
cls
echo ===============================
echo         MiraX System Logs
echo ===============================
if not exist system_logs.txt (
    echo No logs found.
    pause
    goto main
)
for /f "tokens=1,2,3* delims=|" %%a in (system_logs.txt) do (
    setlocal enabledelayedexpansion
    set "result=%%d"
    if /i "!result!"==" Success" (
        echo [SUCCESS] %%a |%%b|%%c
    ) else (
        echo [ERROR]   %%a |%%b|%%c
    )
    endlocal
)
echo.
pause
goto main

:history
cls
echo === Directory History ===
setlocal enabledelayedexpansion
set idx=1
for %%D in (%dirhistory::= % ) do (
    echo !idx!. %%D
    set /a idx+=1
)
endlocal
pause
goto main

:goback
setlocal enabledelayedexpansion
REM Split dirhistory by | and go to previous
set "hist=%dirhistory%"
set "lastdir="
for %%D in (!hist:^|= !) do (
    set "lastdir=!currdir!"
    set "currdir=%%D"
)
if defined lastdir (
    cd /d "!lastdir!"
    REM Remove last entry
    set "dirhistory="
    set idx=1
    for %%D in (!hist:^|= !) do (
        if !idx! lss %dirpos% (
            set "dirhistory=!dirhistory!!sep!%%D"
            set sep=|
        )
        set /a idx+=1
    )
    set /a dirpos-=1
    echo Returned to: !lastdir!
) else (
    echo No previous directory in history.
)
endlocal
pause
goto main

:searchfile
set searchname=%usercmd:~11%
if "%searchname%"=="" (
    set /p searchname=Enter filename to search: 
)
cls
echo === Searching for "%searchname%" ===
set found=0
for /f "delims=" %%F in ('dir /b /s "%searchname%" 2^>nul') do (
    echo Found: %%F
    set found=1
)
if "%found%"=="0" (
    echo File not found.
)
REM Log the search
echo [%date% %time%] SEARCHFILE "%searchname%" Result: %found%>>search_logs.txt
pause
goto main

:findtext
set searchtext=%usercmd:~9%
if "%searchtext%"=="" (
    set /p searchtext=Enter text to search for: 
)
cls
echo === Searching for "%searchtext%" in files ===
set found=0
for /f "delims=" %%F in ('dir /b /s *.txt 2^>nul') do (
    for /f "delims=" %%L in ('findstr /n /i /c:"%searchtext%" "%%F" 2^>nul') do (
        echo File: %%F
        echo   %%L
        set found=1
    )
)
if "%found%"=="0" (
    echo No matches found.
)
REM Log the search
echo [%date% %time%] FINDTEXT "%searchtext%" Result: %found%>>search_logs.txt
pause
goto main

:viewsearchlogs
cls
echo === Search Logs ===
if not exist search_logs.txt (
    echo No search logs found.
    pause
    goto main
)
type search_logs.txt
pause
goto main

:pipechain
REM Simulate pipes: command1 | command2
for /f "tokens=1,* delims=|" %%a in ("%usercmd%") do (
    set "cmd1=%%a"
    set "cmd2=%%b"
)
REM Trim spaces
for /f "tokens=* delims= " %%a in ("%cmd1%") do set "cmd1=%%a"
for /f "tokens=* delims= " %%a in ("%cmd2%") do set "cmd2=%%a"
REM Run first command, save output to temp file
call :runpipecmd "%cmd1%" > pipe_tmp.txt
REM Set input for second command
set "PIPE_INPUT=pipe_tmp.txt"
call :runpipecmd "%cmd2%"
set "PIPE_INPUT="
del pipe_tmp.txt >nul 2>&1
goto main

:runpipecmd
REM Handles a single command for piping
setlocal
set "cmd=%~1"
REM Special handling for savefile
echo %cmd% | findstr /i /c:"savefile " >nul
if not errorlevel 1 (
    for /f "tokens=2 delims= " %%f in ("%cmd%") do (
        copy "%PIPE_INPUT%" "%%f" >nul
        echo Output saved to %%f
    )
    endlocal & exit /b
)
REM For findtext, searchfile, etc.
if /i "%cmd:~0,8%"=="findtext" (
    set searchtext=%cmd:~9%
    if "%searchtext%"=="" set /p searchtext=Enter text to search for: 
    for /f "delims=" %%F in ('dir /b /s *.txt 2^>nul') do (
        for /f "delims=" %%L in ('findstr /n /i /c:"%searchtext%" "%%F" 2^>nul') do (
            echo File: %%F
            echo   %%L
        )
    )
    endlocal & exit /b
)
if /i "%cmd:~0,10%"=="searchfile" (
    set searchname=%cmd:~11%
    if "%searchname%"=="" set /p searchname=Enter filename to search: 
    for /f "delims=" %%F in ('dir /b /s "%searchname%" 2^>nul') do (
        echo Found: %%F
    )
    endlocal & exit /b
)
REM Default: try to call as a batch label
call :%cmd%
endlocal & exit /b

:runbg
set bgcmd=%usercmd:~6%
if "%bgcmd%"=="" (
    set /p bgcmd=Enter command to run in background: 
)
set /a bgpid=%random%+1000
start "" /B cmd /c "%bgcmd% > bgjob_%bgpid%.log 2>&1 & echo [%%date%% %%time%%] %bgcmd% (PID %bgpid%) >> bgjobs.log"
echo Started background job [%bgpid%]: %bgcmd%
echo %bgpid%|%bgcmd%|Running|%date% %time%>>bgjobs.txt
pause
goto main

:jobs
cls
echo === Background Jobs ===
if not exist bgjobs.txt (
    echo No background jobs found.
    pause
    goto main
)
echo PID     Command                Status      Started
for /f "tokens=1-4 delims=|" %%a in (bgjobs.txt) do (
    echo %%a     %%b     %%c     %%d
)
pause
goto main

:killjob
set jobid=%usercmd:~8%
if "%jobid%"=="" (
    set /p jobid=Enter PID to kill: 
)
REM Try to kill by PID
taskkill /PID %jobid% /F >nul 2>&1
REM Mark as killed in bgjobs.txt
(for /f "tokens=1-4 delims=|" %%a in (bgjobs.txt) do (
    if "%%a"=="%jobid%" (
        echo %%a|%%b|Killed|%%d
    ) else (
        echo %%a|%%b|%%c|%%d
    )
)) > bgjobs_tmp.txt
move /y bgjobs_tmp.txt bgjobs.txt >nul
echo Job %jobid% killed (if running).
pause
goto main

:clearjobs
if exist bgjobs.txt del bgjobs.txt
if exist bgjobs.log del bgjobs.log
for %%f in (bgjob_*.log) do del "%%f"
echo All background job logs cleared.
pause
goto main
