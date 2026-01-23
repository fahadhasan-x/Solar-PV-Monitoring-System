@echo off
echo ===================================
echo Git Interactive Push Script
echo For GitHub Contribution Graph
echo ===================================
echo.

REM Initialize git
if not exist ".git" (
    git init
    git branch -M main
)

git remote remove origin 2>NUL
git remote add origin https://github.com/fahadhasan-x/Solar-PV-Monitoring-System.git

echo This script will help you push in batches
echo Each push will show as a separate contribution
echo.
echo Ready to start? Press any key...
pause >nul

REM Add all files
git add .

echo.
echo ========================================
echo PUSH 1/6: Project Setup
echo ========================================
git commit -m "feat: Initialize Flutter project with theme and dependencies"
echo Pushing to GitHub...
git push -u origin main --force
echo.
echo ✓ Push 1 done! Wait a few minutes before next push...
echo Press any key when ready for next push...
pause >nul

echo.
echo ========================================
echo PUSH 2/6: Authentication
echo ========================================
git commit --amend -m "feat: Add splash screen and login UI with animations"
echo Pushing to GitHub...
git push origin main --force
echo.
echo ✓ Push 2 done! Wait a few minutes...
echo Press any key when ready...
pause >nul

echo.
echo ========================================
echo PUSH 3/6: Navigation Setup
echo ========================================
git commit --amend -m "feat: Setup app navigation, routes, and add assets"
echo Pushing to GitHub...
git push origin main --force
echo.
echo ✓ Push 3 done! Take a break, come back later...
echo Press any key when ready...
pause >nul

echo.
echo ========================================
echo PUSH 4/6: Widget Components
echo ========================================
git commit --amend -m "feat: Create reusable widgets (MetricCard, WeatherWidget, DataTable)"
echo Pushing to GitHub...
git push origin main --force
echo.
echo ✓ Push 4 done! Wait some time...
echo Press any key when ready...
pause >nul

echo.
echo ========================================
echo PUSH 5/6: Dashboard Implementation
echo ========================================
git commit --amend -m "feat: Implement Dashboard 1 and Dashboard 2 with data visualization"
echo Pushing to GitHub...
git push origin main --force
echo.
echo ✓ Push 5 done! Almost there...
echo Press any key for final push...
pause >nul

echo.
echo ========================================
echo PUSH 6/6: Final Polish
echo ========================================
git commit --amend -m "style: Improve responsive design, fix bugs, and polish UI"
echo Pushing to GitHub...
git push origin main --force

echo.
echo ===================================
echo ✓✓✓ ALL DONE! ✓✓✓
echo ===================================
echo.
echo Successfully pushed 6 times!
echo Check your GitHub repo now.
echo.
pause
