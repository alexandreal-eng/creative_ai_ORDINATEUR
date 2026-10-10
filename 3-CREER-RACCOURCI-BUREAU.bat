@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Creative AI - Raccourci Bureau
echo "%~dp0" | find /i ".zip" >nul && goto zip
where node >nul 2>nul
if errorlevel 1 goto nonode
if exist "node_modules\electron\dist\electron.exe" goto make
echo Installation des outils ^(premiere fois seulement, Internet requis^)...
call npm install
if errorlevel 1 goto err
:make
powershell -NoProfile -ExecutionPolicy Bypass -Command "$d=[Environment]::GetFolderPath('Desktop'); $s=(New-Object -ComObject WScript.Shell).CreateShortcut($d+'\Creative AI.lnk'); $s.TargetPath='%~dp0node_modules\electron\dist\electron.exe'; $s.Arguments='\"%~dp0.\"'; $s.WorkingDirectory='%~dp0'; $s.IconLocation='%~dp0build\icon.ico'; $s.Description='Creative AI'; $s.Save()"
if errorlevel 1 goto err
echo.
echo TERMINE : le raccourci "Creative AI" avec son icone est sur ton Bureau.
echo Ne deplace pas ce dossier, le raccourci pointe vers lui.
pause
exit /b 0
:zip
echo ERREUR : extrais d'abord le zip puis relance depuis le dossier extrait.
pause
exit /b 1
:nonode
echo ERREUR : installe Node.js LTS depuis https://nodejs.org puis relance.
pause
exit /b 1
:err
echo Une erreur est survenue. Copie le message ci-dessus.
pause
exit /b 1
