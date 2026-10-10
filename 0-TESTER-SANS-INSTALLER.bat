@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Creative AI - Test sans installer
echo "%~dp0" | find /i ".zip" >nul && goto zip
where node >nul 2>nul
if errorlevel 1 goto nonode
echo Installation des outils ^(premiere fois seulement, Internet requis^)...
call npm install
if errorlevel 1 goto err
call npm start
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
echo Une erreur est survenue ^(Internet ? antivirus ?^). Copie le message ci-dessus.
pause
exit /b 1
