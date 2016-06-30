REM http://stackoverflow.com/questions/22928358/bat-script-for-clear-firefox-cookies-and-cache

@echo off
taskkill /im "firefox.exe"
set DataDir=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles
del /q /s /f "%DataDir%"
rd /s /q "%DataDir%"
for /d %%x in (C:\Users\%USERNAME%\AppData\Roaming\Mozilla\Firefox\Profiles\*) do del /q /s /f %%x\*sqlite
