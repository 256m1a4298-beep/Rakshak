@echo off
REM Compiles all Java files into the out folder.
cd /d "%~dp0"
dir /s /b src\*.java > sources.txt
javac -encoding UTF-8 -cp "lib\mysql-connector-j-9.1.0.jar" -d out @sources.txt
if %errorlevel%==0 (echo BUILD OK) else (echo BUILD FAILED - fix the errors above)
pause
