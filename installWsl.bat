cls
@echo off
rem SetLocal EnableDelayedExpansion
echo ::============================================================================::
echo ::============================================================================::
echo ::===  this script for install wsl or wsl 2 and linux os in windows 10/11  ===::
echo ::===  this script cannot solve if you have problem in the installation    ===::
echo ::===  this is my first script and my first write in english in the web    ===::
echo ::===  if you need help send me by www.facebook.com/devbelmel              ===::
echo ::============================================================================::
echo ::============================================================================::
goto check_Permissions



:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) ELSE (
        echo Failure: Current permissions inadequate.
    )
echo check if Microsoft-Windows-Subsystem-Linux enable

FOR /F "usebackq delims==" %%i IN (`powershell Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux `) DO @set "EnableStatus=%%i"
if "%EnableStatus%" == "RestartNeeded : False" (
echo the  Microsoft-Windows-Subsystem-Linux  is enable restart not needed
)else (
echo the  Microsoft-Windows-Subsystem-Linux  is disable  restart not needed
powershell Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
restart
)

FOR /F "usebackq delims==" %%j IN (`dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`) DO @set "VirtualMachinePlatformEnable=%%j"
echo %VirtualMachinePlatformEnable%
FOR /F "usebackq delims==" %%k IN (`dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`) DO @set "Microsoft-Windows-Subsystem-Linux=%%k"
echo %Microsoft-Windows-Subsystem-Linux%

echo ****************************************************
echo ****************************************************
echo *** echo A-install wsl                           ***
echo ***      press 1 and enter for wsl               ***
echo ***      press 2 and enter for wsl2              ***
echo ***      press 3 and enter for chat with me      ***
echo ****************************************************
echo ****************************************************
set /p id="Enter choice: "
if %id% == 1 goto :wsl1
if  %id% == 2 goto :wsl2
if %id% == 3 goto :fb




:end
echo End of batch program.
:wsl1
wsl --set-default-version 1
goto :cont
:wsl2
wsl --set-default-version 2
goto :cont
:fb 
start "" http://www.facebook.com/devbelmel
goto :cont
:cont
wsl --list --online

set /p distro="choix your distro to install in linux write the name or copie passet from the list above it in cmd : "
wsl --install -d %distro% 
if errorlevel 1 echo Unsuccessful
if errorlevel 0 echo successful

