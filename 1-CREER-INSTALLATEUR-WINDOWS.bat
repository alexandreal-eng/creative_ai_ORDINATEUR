@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Creative AI - Creation de l'installateur Windows
echo "%~dp0" | find /i ".zip" >nul && goto zip
where node >nul 2>nul
if errorlevel 1 goto nonode
set CSC_IDENTITY_AUTO_DISCOVERY=false
echo.
echo [1/2] Installation des outils. Internet est necessaire, compte 3 a 10 minutes la premiere fois.
call npm install
if errorlevel 1 goto err
echo.
echo [2/2] Creation de l'installateur Windows...
call npm run dist:win
if not errorlevel 1 goto ok
echo.
echo Premiere tentative echouee. Nouvelle tentative en mode compatible...
call npx electron-builder --win --config.win.signAndEditExecutable=false
if errorlevel 1 goto err
echo.
echo NOTE : en mode compatible, l'icone n'est pas integree au fichier .exe lui-meme.
echo Pour avoir un raccourci Bureau avec la belle icone, lance ensuite 3-CREER-RACCOURCI-BUREAU.bat
:ok
echo.
echo ============================================================
echo  TERMINE : ton installateur est dans le dossier "dist"
echo  Double-clique sur Creative-AI-Setup-8.0.0.exe pour l'installer.
echo ============================================================
start "" "%~dp0dist"
pause
exit /b 0
:zip
echo ERREUR : tu lances ce fichier depuis l'interieur du zip.
echo Fais un clic droit sur le zip, "Extraire tout...", puis relance depuis le dossier extrait.
pause
exit /b 1
:nonode
echo ERREUR : Node.js n'est pas installe.
echo Installe la version LTS depuis https://nodejs.org puis relance ce fichier.
pause
exit /b 1
:err
echo.
echo ============================================================
echo  ECHEC. Causes les plus frequentes sous Windows :
echo  1. Active le MODE DEVELOPPEUR : Parametres - Confidentialite et securite -
echo     Pour les developpeurs - Mode developpeur : active. Puis relance ce fichier.
echo     ^(ou : clic droit sur ce fichier - Executer en tant qu'administrateur^)
echo  2. Pas d'Internet, proxy d'entreprise ou antivirus qui bloque. Desactive-le un instant.
echo  3. Dossier dans OneDrive ou chemin tres long : copie le dossier dans C:\CreativeAI
echo  Si ca echoue encore : lance 3-CREER-RACCOURCI-BUREAU.bat ^(ne demande pas de creer un .exe^)
echo  ou envoie-moi une photo du message d'erreur ci-dessus.
echo ============================================================
pause
exit /b 1
