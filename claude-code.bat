@echo off
REM Claude Code Launcher for Windows
REM Usage: claude-code.bat [options]
REM
REM Configuration:
REM   Set ANTHROPIC_API_KEY env var, or create a .env file in the same directory.
REM   Format: ANTHROPIC_API_KEY=sk-ant-...

setlocal EnableDelayedExpansion

REM === Bun Path ===
set "BUN_INSTALL=%USERPROFILE%\.bun"
set "PATH=%BUN_INSTALL%\bin;%PATH%"

REM === Load API Keys from .env file (if not already set in environment) ===
if not defined ANTHROPIC_API_KEY (
    if exist "%~dp0.env" (
        for /f "usebackq tokens=1,2 delims==" %%a in ("%~dp0.env") do (
            if "%%a"=="ANTHROPIC_API_KEY" (
                set "ANTHROPIC_API_KEY=%%b"
            )
        )
    )
)

REM === Claude Code Directory ===
set "CLAUDE_CODE_DIR=%~dp0claude-code"

REM === Check Bun ===
where bun >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo ERROR: Bun not found. Please ensure Bun is installed at %BUN_INSTALL%
    exit /b 1
)

REM === Check Directory ===
if not exist "%CLAUDE_CODE_DIR%\src\entrypoints\cli.tsx" (
    echo ERROR: Claude Code source not found at %CLAUDE_CODE_DIR%
    exit /b 1
)

REM === Check API Key ===
if not defined ANTHROPIC_API_KEY (
    echo WARNING: ANTHROPIC_API_KEY is not set.
    echo Claude Code requires an Anthropic API key to run.
    echo.
    echo To set it up:
    echo   1. Create a .env file in this directory with:
    echo      ANTHROPIC_API_KEY=sk-ant-...
    echo   2. Or run: setx ANTHROPIC_API_KEY "sk-ant-..." (then restart terminal)
    echo   3. Or export it before running: set ANTHROPIC_API_KEY=sk-ant-... ^&^& claude-code.bat
    echo.
    echo Get your key at: https://console.anthropic.com/settings/keys
    echo.
    pause
    exit /b 1
)

REM === Run Claude Code ===
cd /d "%CLAUDE_CODE_DIR%"
set "ANTHROPIC_API_KEY=%ANTHROPIC_API_KEY%"

REM Pass all arguments through
bun run start -- %*

endlocal
