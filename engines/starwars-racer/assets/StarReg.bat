@echo off
setlocal EnableExtensions

set "INSTALLDIR=%~dp0"
if "%INSTALLDIR:~-1%"=="\" set "INSTALLDIR=%INSTALLDIR:~0,-1%"

set "K=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\lucasarts entertainment company llc\Star Wars: Episode I Racer\v1.0"

reg.exe add "%K%" /f

reg.exe add "%K%" /v "3D Device"    /t REG_SZ    /d "Direct3D HAL" /f
reg.exe add "%K%" /v "Analyze Path" /t REG_SZ    /d ".\SysCheck.exe" /f
reg.exe add "%K%" /v "CD Path"      /t REG_SZ    /d "." /f
reg.exe add "%K%" /v "executable"   /t REG_SZ    /d "%INSTALLDIR%\SWEP1RCR.EXE" /f
reg.exe add "%K%" /v "GUID"         /t REG_SZ    /d "{00000000-0000-0000-0000-000000000000}" /f
reg.exe add "%K%" /v "Install Path" /t REG_SZ    /d "%INSTALLDIR%" /f
reg.exe add "%K%" /v "JoystickID"   /t REG_SZ    /d "1" /f
reg.exe add "%K%" /v "Source Dir"   /t REG_SZ    /d "%INSTALLDIR%" /f
reg.exe add "%K%" /v "Source Path"  /t REG_SZ    /d "%INSTALLDIR%" /f

reg.exe add "%K%" /v "DevMode"      /t REG_DWORD /d 0 /f
reg.exe add "%K%" /v "InstallType"  /t REG_DWORD /d 9 /f
reg.exe add "%K%" /v "UseFett"      /t REG_DWORD /d 0 /f
