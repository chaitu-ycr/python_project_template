@echo off

title "creating/updating tool environment..."

pushd %~dp0
cd ..
set python_venv_path=%CD%\.venv
set python_exe=%python_venv_path%\Scripts\python.exe

:PYTHON_VENV
if exist %python_venv_path% (
    echo "using '%python_exe%' python."
    echo "upgrade python pip module, install uv, and install repo dependencies..."
    %python_exe% -m pip install pip --upgrade
    %python_exe% -m pip install uv --upgrade
    %python_exe% -m uv sync --link-mode=copy
    echo "completed installing tool dependencies."
) else (
    GOTO :VENV_ERROR
)
GOTO :eof

:VENV_ERROR
echo.
echo '%python_venv_path%' not found
echo "Creating virtual environment now..."
echo.
python -m venv %python_venv_path%
echo "completed venv creation."
GOTO :PYTHON_VENV

:ERROR
echo "failed to run extract due to error %ERRORLEVEL%."
popd
pause