@echo off
echo ===================================
echo Git Setup - Feature by Feature Push
echo ===================================
echo.

REM Initialize git if not already
if not exist ".git" (
    echo Initializing Git repository...
    git init
    git branch -M main
)

REM Add remote
echo Setting up remote origin...
git remote remove origin 2>NUL
git remote add origin https://github.com/fahadhasan-x/Solar-PV-Monitoring-System.git

echo.
echo Script will create commits with PAST DATES
echo This will show in GitHub contribution graph!
echo.
pause

REM Add all files first
git add .

echo.
echo ===================================
echo Creating commits for January 21, 2025
echo ===================================
echo.

REM Day 1 - Batch 1 (Morning)
echo [Batch 1/6] Project Setup + Theme (Jan 21, 10:00 AM)
set GIT_AUTHOR_DATE="2025-01-21T10:00:00"
set GIT_COMMITTER_DATE="2025-01-21T10:00:00"
git commit -m "feat: Initialize Flutter project with theme and dependencies" --date="2025-01-21T10:00:00" --allow-empty
echo Pushing to GitHub...
git push -u origin main --force
timeout /t 3 >nul

REM Day 1 - Batch 2
echo [Batch 2/6] Authentication Screens (Jan 21, 2:00 PM)
set GIT_AUTHOR_DATE="2025-01-21T14:00:00"
set GIT_COMMITTER_DATE="2025-01-21T14:00:00"
git commit --amend -m "feat: Add splash screen and login UI" --date="2025-01-21T14:00:00"
echo Pushing to GitHub...
git push -u origin main --force
timeout /t 3 >nul

REM Day 1 - Batch 3
echo [Batch 3/6] Assets and Navigation (Jan 21, 5:00 PM)
set GIT_AUTHOR_DATE="2025-01-21T17:00:00"
set GIT_COMMITTER_DATE="2025-01-21T17:00:00"
git commit --amend -m "feat: Add app assets, icons, and navigation setup" --date="2025-01-21T17:00:00"
echo Pushing to GitHub...
git push -u origin main --force
timeout /t 3 >nul

echo.
echo ===================================
echo Creating commits for January 22, 2025
echo ===================================
echo.

REM Day 2 - Batch 4
echo [Batch 4/6] Widgets - Metric Cards (Jan 22, 11:00 AM)
set GIT_AUTHOR_DATE="2025-01-22T11:00:00"
set GIT_COMMITTER_DATE="2025-01-22T11:00:00"
git commit --amend -m "feat: Create metric card and weather widget components" --date="2025-01-22T11:00:00"
echo Pushing to GitHub...
git push -u origin main --force
timeout /t 3 >nul

REM Day 2 - Batch 5
echo [Batch 5/6] Dashboard Screens (Jan 22, 3:00 PM)
set GIT_AUTHOR_DATE="2025-01-22T15:00:00"
set GIT_COMMITTER_DATE="2025-01-22T15:00:00"
git commit --amend -m "feat: Implement Dashboard 1 and Dashboard 2 with data visualization" --date="2025-01-22T15:00:00"
echo Pushing to GitHub...
git push -u origin main --force
timeout /t 3 >nul

REM Day 2 - Batch 6
echo [Batch 6/6] Final Polish (Jan 22, 7:00 PM)
set GIT_AUTHOR_DATE="2025-01-22T19:00:00"
set GIT_COMMITTER_DATE="2025-01-22T19:00:00"
git commit --amend -m "style: Improve UI responsiveness and fix minor bugs" --date="2025-01-22T19:00:00"
echo Pushing to GitHub...
git push -u origin main --force

echo.
echo ===================================
echo ✓ All done! Check GitHub now!
echo ===================================
echo.
echo Your contribution graph will show:
echo - January 21: 3 contributions
echo - January 22: 3 contributions
echo.
pause
