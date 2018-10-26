REM @call %~dp0run.cmd build %*
REM @exit /b %ERRORLEVEL%

@echo off
REM TODO: this environment variable is set for this machine where ref assemblies were copied by hand
if /i [%COMPUTERNAME%]==[SHAWNRW10-NOVS] set TargetFrameworkRootPath=D:\temp\refassem

set NETCOREENG_INSTALL_DIRECTORY=%~dp0artifacts\toolset\native

call eng\common\init-tools-native.cmd
powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0eng\common\Build.ps1""" -restore -build %*"
exit /b %ErrorLevel%