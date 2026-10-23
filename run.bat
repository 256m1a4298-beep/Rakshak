@echo off
REM Starts RAKSHAK. Run build.bat first (or after changing any .java file).
cd /d "%~dp0"
java -cp "out;lib\mysql-connector-j-9.1.0.jar" rakshak.Main
pause
