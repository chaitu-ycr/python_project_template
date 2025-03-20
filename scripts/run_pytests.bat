@echo off

title "running pytests"

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

:START_PYTESTS
pytest
if %ERRORLEVEL% NEQ 0 (GOTO ERROR)

:END
call %cmd_venv_deactivate%
popd
GOTO :eof

:ERROR
title "Failed to run pytests due to error %ERRORLEVEL%"
popd
pause
GOTO :eof