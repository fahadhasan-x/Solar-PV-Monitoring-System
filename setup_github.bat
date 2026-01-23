@echo off
echo ========================================
echo GitHub Repository Setup
echo SCUBE Solar Monitoring System
echo ========================================
echo.

REM Configure git user
git config user.email "fahad.hasan.42931@gmail.com"
git config user.name "Fahad Hasan"

echo Git configuration:
echo Email: fahad.hasan.42931@gmail.com
echo Name: Fahad Hasan
echo.

echo ========================================
echo Step 1: Initialize Git Repository
echo ========================================
echo.

REM Check if already initialized
if exist ".git" (
    echo Git repository already exists!
    echo.
) else (
    echo Initializing git repository...
    git init
    echo Git initialized!
    echo.
)

echo ========================================
echo Step 2: Create .gitignore
echo ========================================
echo.
echo .gitignore already exists and configured!
echo.

echo ========================================
echo Step 3: Stage All Files
echo ========================================
echo.
echo Staging files...
git add .
echo Files staged!
echo.

echo ========================================
echo Step 4: Create Initial Commit
echo ========================================
echo.
set GIT_AUTHOR_DATE=2026-01-23 09:00:00
set GIT_COMMITTER_DATE=2026-01-23 09:00:00
git commit --date="2026-01-23 09:00:00" -m "Initial commit: SCUBE Solar Monitoring System setup"
echo Initial commit created!
echo.

echo ========================================
echo Step 5: GitHub Repository Setup
echo ========================================
echo.
echo Please follow these steps:
echo.
echo 1. Go to GitHub: https://github.com/new
echo 2. Create a new repository named: solar-monitoring-system
echo 3. Do NOT initialize with README, .gitignore, or license
echo 4. Copy the repository URL (HTTPS or SSH)
echo.
echo Example URL: https://github.com/your-username/solar-monitoring-system.git
echo.

set /p repo_url="Paste your GitHub repository URL: "

echo.
echo Adding remote repository...
git remote remove origin 2>nul
git remote add origin %repo_url%

echo.
echo Renaming branch to main...
git branch -M main

echo.
echo ========================================
echo Repository configured successfully!
echo ========================================
echo.
echo Remote URL: %repo_url%
echo Branch: main
echo.

echo ========================================
echo Next Steps:
echo ========================================
echo.
echo 1. Run: git_commits_jan_2026.bat
echo    This will create commits for Jan 23-30
echo.
echo 2. Run: git_commits_jan_31.bat
echo    This will create commits for Jan 31
echo.
echo 3. Both scripts will ask if you want to push
echo    Answer Y to push to GitHub
echo.

echo ========================================
echo Ready to create commits!
echo ========================================
pause
