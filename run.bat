@echo off

REM Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Python is not found.
    exit /b 1
)

REM Check if virtual environment exists, if not, create it
if not exist "venv" (
    python -m venv venv
)

REM Activate the virtual environment
call venv\Scripts\activate

REM Install dependencies
pip install -r requirements.txt

REM Set environment variables for PySpark
set PYSPARK_PYTHON=python

REM Check if the "model" directory exists, if not, train the model
if not exist "model" (
    python train_model.py
)

REM Run the application
wave run app

REM Deactivate the virtual environment
deactivate