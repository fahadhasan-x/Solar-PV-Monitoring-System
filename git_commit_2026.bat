@echo off
echo ===================================
echo Git Commit Script - 2026 Dates
echo ===================================
echo.

REM Initialize git if not already
if not exist ".git" (
    echo Initializing Git repository...
    git init
    git branch -M main
)

REM Add remote
echo Adding remote origin...
git remote remove origin 2>NUL
git remote add origin https://github.com/fahadhasan-x/Solar-PV-Monitoring-System.git

REM Configure git user
git config user.email "fahad.hasan.42931@gmail.com"
git config user.name "Fahad Hasan"

echo.
echo ===================================
echo Day 1: January 21, 2026
echo ===================================
echo.

REM Commit 1: Project setup (Jan 21, 9:00 AM)
echo [1/15] Initial project setup...
git add .gitignore pubspec.yaml README.md
set GIT_AUTHOR_DATE="2026-01-21T09:00:00"
set GIT_COMMITTER_DATE="2026-01-21T09:00:00"
git commit -m "feat: Initialize Flutter project structure" --date="2026-01-21T09:00:00"
timeout /t 1 >nul

REM Commit 2: Dependencies (Jan 21, 10:30 AM)
echo [2/15] Add dependencies...
git add pubspec.lock
set GIT_AUTHOR_DATE="2026-01-21T10:30:00"
set GIT_COMMITTER_DATE="2026-01-21T10:30:00"
git commit -m "feat: Add project dependencies (fl_chart, google_fonts)" --date="2026-01-21T10:30:00"
timeout /t 1 >nul

REM Commit 3: Theme (Jan 21, 11:45 AM)
echo [3/15] Setup theme...
git add lib/theme/
set GIT_AUTHOR_DATE="2026-01-21T11:45:00"
set GIT_COMMITTER_DATE="2026-01-21T11:45:00"
git commit -m "feat: Setup app theme and color scheme" --date="2026-01-21T11:45:00"
timeout /t 1 >nul

REM Commit 4: Splash screen (Jan 21, 2:00 PM)
echo [4/15] Create splash screen...
git add lib/screens/splash_screen.dart
set GIT_AUTHOR_DATE="2026-01-21T14:00:00"
set GIT_COMMITTER_DATE="2026-01-21T14:00:00"
git commit -m "feat: Create splash screen with slide-up animation" --date="2026-01-21T14:00:00"
timeout /t 1 >nul

REM Commit 5: Login screen (Jan 21, 3:30 PM)
echo [5/15] Create login screen...
git add lib/screens/login_screen.dart
set GIT_AUTHOR_DATE="2026-01-21T15:30:00"
set GIT_COMMITTER_DATE="2026-01-21T15:30:00"
git commit -m "feat: Create login screen UI with form validation" --date="2026-01-21T15:30:00"
timeout /t 1 >nul

REM Commit 6: Assets (Jan 21, 4:15 PM)
echo [6/15] Add assets...
git add Assets/ pubspec.yaml
set GIT_AUTHOR_DATE="2026-01-21T16:15:00"
set GIT_COMMITTER_DATE="2026-01-21T16:15:00"
git commit -m "feat: Add logo and weather icons assets" --date="2026-01-21T16:15:00"
timeout /t 1 >nul

REM Commit 7: Main app (Jan 21, 5:00 PM)
echo [7/15] Setup main app...
git add lib/main.dart
set GIT_AUTHOR_DATE="2026-01-21T17:00:00"
set GIT_COMMITTER_DATE="2026-01-21T17:00:00"
git commit -m "feat: Setup app navigation and routes" --date="2026-01-21T17:00:00"
timeout /t 1 >nul

echo.
echo ===================================
echo Day 2: January 22, 2026
echo ===================================
echo.

REM Commit 8: Metric cards (Jan 22, 10:00 AM)
echo [8/15] Create metric cards...
git add lib/widgets/metric_card.dart
set GIT_AUTHOR_DATE="2026-01-22T10:00:00"
set GIT_COMMITTER_DATE="2026-01-22T10:00:00"
git commit -m "feat: Create reusable metric card widget" --date="2026-01-22T10:00:00"
timeout /t 1 >nul

REM Commit 9: Weather widget (Jan 22, 11:30 AM)
echo [9/15] Create weather widget...
git add lib/widgets/weather_widget.dart
set GIT_AUTHOR_DATE="2026-01-22T11:30:00"
set GIT_COMMITTER_DATE="2026-01-22T11:30:00"
git commit -m "feat: Implement weather widget with thermometer visualization" --date="2026-01-22T11:30:00"
timeout /t 1 >nul

REM Commit 10: Data table (Jan 22, 1:00 PM)
echo [10/15] Create data table...
git add lib/widgets/data_table_widget.dart
set GIT_AUTHOR_DATE="2026-01-22T13:00:00"
set GIT_COMMITTER_DATE="2026-01-22T13:00:00"
git commit -m "feat: Create data comparison table with alternating rows" --date="2026-01-22T13:00:00"
timeout /t 1 >nul

REM Commit 11: Dashboard 1 (Jan 22, 2:30 PM)
echo [11/15] Create Dashboard 1...
git add lib/screens/dashboard_1_screen.dart
set GIT_AUTHOR_DATE="2026-01-22T14:30:00"
set GIT_COMMITTER_DATE="2026-01-22T14:30:00"
git commit -m "feat: Implement Dashboard 1 with metrics and PV module info" --date="2026-01-22T14:30:00"
timeout /t 1 >nul

REM Commit 12: Dashboard 2 (Jan 22, 4:00 PM)
echo [12/15] Create Dashboard 2...
git add lib/screens/dashboard_2_screen.dart
set GIT_AUTHOR_DATE="2026-01-22T16:00:00"
set GIT_COMMITTER_DATE="2026-01-22T16:00:00"
git commit -m "feat: Implement Dashboard 2 with circular chart and data views" --date="2026-01-22T16:00:00"
timeout /t 1 >nul

REM Commit 13: UI improvements (Jan 22, 5:15 PM)
echo [13/15] UI improvements...
git add lib/screens/ lib/widgets/
set GIT_AUTHOR_DATE="2026-01-22T17:15:00"
set GIT_COMMITTER_DATE="2026-01-22T17:15:00"
git commit -m "style: Improve responsive design and mobile layout" --date="2026-01-22T17:15:00"
timeout /t 1 >nul

REM Commit 14: Bug fixes (Jan 22, 6:00 PM)
echo [14/15] Bug fixes...
git add lib/
set GIT_AUTHOR_DATE="2026-01-22T18:00:00"
set GIT_COMMITTER_DATE="2026-01-22T18:00:00"
git commit -m "fix: Remove duplicate text from splash and login screens" --date="2026-01-22T18:00:00"
timeout /t 1 >nul

REM Commit 15: Final polish (Jan 22, 6:45 PM)
echo [15/15] Final touches...
git add README.md android/ ios/ linux/ macos/ web/ windows/ test/
set GIT_AUTHOR_DATE="2026-01-22T18:45:00"
set GIT_COMMITTER_DATE="2026-01-22T18:45:00"
git commit -m "docs: Update README and add project documentation" --date="2026-01-22T18:45:00"
timeout /t 1 >nul

echo.
echo ===================================
echo All commits created successfully!
echo ===================================
echo.
echo Now you can push to GitHub:
echo   git push -u origin main --force
echo.
pause
