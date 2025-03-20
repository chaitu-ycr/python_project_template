@echo off

title "build python wheel using setuptools and uv"

pushd %~dp0
cd ..
set cmd_venv_activate=%CD%\.venv\Scripts\activate.bat
set cmd_venv_deactivate=%CD%\.venv\Scripts\deactivate.bat

:ACTIVATE_VENV
call %cmd_venv_activate%
if %ERRORLEVEL% NEQ 0 (GOTO ERROR)

:UV_SETUP
uv sync --link-mode=copy
if %ERRORLEVEL% NEQ 0 (GOTO ERROR)

:BUILD_PACKAGE
uv build
if %ERRORLEVEL% NEQ 0 (GOTO ERROR)

:END
call %cmd_venv_deactivate%
popd
GOTO :eof

:ERROR
title "Failed to build package due to error %ERRORLEVEL%"
popd
pause
GOTO :eof