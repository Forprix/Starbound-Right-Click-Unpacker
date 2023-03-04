@echo off
for /F "skip=2 tokens=2,*" %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Valve\Steam" /v "InstallPath"') do set "steamdir=%%B"
echo Looking for asset_packer.exe and asset_unpacker.exe...
if defined steamdir (if exist "%steamdir%\steamapps\common\Starbound\" (echo Yay! Steam version of Starbound found && set "sbdir=%steamdir%\steamapps\common\Starbound") else (echo Steam version of Starbound was NOT found && set /p sbdir="Enter the Starbound directory manually: ")) else (echo Steam was not found wtf && set /p sbdir="Enter the Starbound directory manually: ")
echo Sooo your Starbound is: %sbdir%
echo Using %sbdir%\win32\asset_packer.exe
echo Using %sbdir%\win32\asset_unpacker.exe
mkdir "C:\Program Files\Packbound" 2> NUL
(echo set "a=%%~1" & echo "%sbdir%\win32\asset_packer.exe" "%%a%%" "%%a%%.pak") > "C:\Program Files\Packbound\pack.bat"
(echo set "a=%%~1" & echo "%sbdir%\win32\asset_unpacker.exe" "%%a%%" "%%a:~0,-4%%") > "C:\Program Files\Packbound\unpack.bat"
(echo Windows Registry Editor Version 5.00 & echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\Packbound] & echo  @="Packbound" & echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\Packbound\command] & echo  @="\"C:\\Program Files\\Packbound\\pack.bat\" \"%%1\"" & echo [HKEY_CLASSES_ROOT\.pak] & echo  @="sbpak" & echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\sbpak] & echo  @="Starbound Packed Assets File" & echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\sbpak\shell\Unpackbound] & echo  @="Unpackbound" & echo [HKEY_LOCAL_MACHINE\SOFTWARE\Classes\sbpak\shell\Unpackbound\command] & echo  @="\"C:\\Program Files\\Packbound\\unpack.bat\" \"%%1\"") > "C:\Program Files\Packbound\registry_changes.reg"
echo C:\Program Files\Packbound created
regedit.exe /S "C:\Program Files\Packbound\registry_changes.reg"
echo Registry changes done
pause
