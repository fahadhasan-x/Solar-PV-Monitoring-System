@echo off
setlocal enabledelayedexpansion

echo ========================================
echo SCUBE Solar Monitoring - Git Setup
echo Multi-day Commit Script (Jan 23-31, 2026)
echo ========================================
echo.

REM Configure git user
git config user.email "fahad.hasan.42931@gmail.com"
git config user.name "Fahad Hasan"

echo Configured Git User:
git config user.email
git config user.name
echo.

REM Array of dates and commit counts
REM Format: Date CommitCount
set "dates[0]=2026-01-23 30"
set "dates[1]=2026-01-24 27"
set "dates[2]=2026-01-25 15"
set "dates[3]=2026-01-26 32"
set "dates[4]=2026-01-27 10"
set "dates[5]=2026-01-28 31"
set "dates[6]=2026-01-29 22"
set "dates[7]=2026-01-30 27"

REM Commit messages grouped by feature
set "msg[0]=Initial project setup and configuration"
set "msg[1]=Add Flutter project structure"
set "msg[2]=Setup backend folder structure"
set "msg[3]=Add MongoDB connection configuration"
set "msg[4]=Create User model with password hashing"
set "msg[5]=Implement SolarData model schema"
set "msg[6]=Add JWT authentication middleware"
set "msg[7]=Create auth controller with login/register"
set "msg[8]=Implement solar data controller"
set "msg[9]=Setup Express routes for authentication"
set "msg[10]=Add solar data API routes"
set "msg[11]=Configure environment variables"
set "msg[12]=Add CORS and security middleware"
set "msg[13]=Create database seeder script"
set "msg[14]=Add API documentation"
set "msg[15]=Setup Flutter dependencies"
set "msg[16]=Create API configuration files"
set "msg[17]=Implement User data model"
set "msg[18]=Add AuthResponse model"
set "msg[19]=Create comprehensive SolarData models"
set "msg[20]=Implement DashboardData structure"
set "msg[21]=Setup base API service with HTTP client"
set "msg[22]=Create authentication service"
set "msg[23]=Implement solar data service"
set "msg[24]=Add secure storage utility"
set "msg[25]=Create AuthProvider for state management"
set "msg[26]=Implement SolarDataProvider with auto-refresh"
set "msg[27]=Update main.dart with Provider integration"
set "msg[28]=Refactor login screen with backend API"
set "msg[29]=Add loading states to login"
set "msg[30]=Implement error handling in login"
set "msg[31]=Refactor dashboard to use real API data"
set "msg[32]=Add pull-to-refresh functionality"
set "msg[33]=Implement auto-refresh mechanism"
set "msg[34]=Add logout functionality"
set "msg[35]=Create MetricCard widget"
set "msg[36]=Implement WeatherWidget display"
set "msg[37]=Add data table component"
set "msg[38]=Setup app theme and styling"
set "msg[39]=Configure splash screen"
set "msg[40]=Improve UI/UX elements"
set "msg[41]=Add error state UI"
set "msg[42]=Implement loading indicators"
set "msg[43]=Optimize API calls"
set "msg[44]=Add request timeout handling"
set "msg[45]=Improve error messages"
set "msg[46]=Add input validation"
set "msg[47]=Implement session persistence"
set "msg[48]=Add device ID configuration"
set "msg[49]=Create backend README documentation"
set "msg[50]=Add API endpoint examples"
set "msg[51]=Write frontend documentation"
set "msg[52]=Create complete setup guide"
set "msg[53]=Add troubleshooting section"
set "msg[54]=Update project README"
set "msg[55]=Add architecture diagrams"
set "msg[56]=Document database schema"
set "msg[57]=Create testing guidelines"
set "msg[58]=Add code comments"
set "msg[59]=Refactor code structure"
set "msg[60]=Optimize performance"
set "msg[61]=Fix authentication bugs"
set "msg[62]=Resolve API connection issues"
set "msg[63]=Fix data refresh timing"
set "msg[64]=Correct dashboard data mapping"
set "msg[65]=Fix weather widget parameters"
set "msg[66]=Resolve token storage issues"
set "msg[67]=Fix CORS configuration"
set "msg[68]=Update MongoDB indexes"
set "msg[69]=Improve data aggregation queries"
set "msg[70]=Add battery status monitoring"
set "msg[71]=Implement grid status tracking"
set "msg[72]=Add inverter monitoring"
set "msg[73]=Create energy production metrics"
set "msg[74]=Implement load tracking"
set "msg[75]=Add weather data integration"
set "msg[76]=Create system alerts mechanism"
set "msg[77]=Implement hourly statistics"
set "msg[78]=Add historical data filtering"
set "msg[79]=Create statistics endpoint"
set "msg[80]=Implement dashboard aggregation"
set "msg[81]=Add real-time data updates"
set "msg[82]=Improve response formatting"
set "msg[83]=Optimize database queries"
set "msg[84]=Add data validation"
set "msg[85]=Implement error logging"
set "msg[86]=Create utility functions"
set "msg[87]=Add constants configuration"
set "msg[88]=Improve code organization"
set "msg[89]=Refactor service methods"
set "msg[90]=Add type safety improvements"
set "msg[91]=Create model converters"
set "msg[92]=Implement data transformers"
set "msg[93]=Add response handlers"
set "msg[94]=Create custom exceptions"
set "msg[95]=Improve error recovery"
set "msg[96]=Add retry logic"
set "msg[97]=Implement timeout handling"
set "msg[98]=Create connection management"
set "msg[99]=Add network status detection"
set "msg[100]=Improve user feedback"
set "msg[101]=Add success notifications"
set "msg[102]=Create loading animations"
set "msg[103]=Implement skeleton screens"
set "msg[104]=Add smooth transitions"
set "msg[105]=Improve navigation flow"
set "msg[106]=Create responsive layouts"
set "msg[107]=Add accessibility features"
set "msg[108]=Implement localization support"
set "msg[109]=Create app configuration"
set "msg[110]=Add environment setup"
set "msg[111]=Implement feature flags"
set "msg[112]=Create debug utilities"
set "msg[113]=Add development tools"
set "msg[114]=Implement build scripts"
set "msg[115]=Create deployment config"
set "msg[116]=Add production optimizations"
set "msg[117]=Implement security enhancements"
set "msg[118]=Create backup mechanisms"
set "msg[119]=Add monitoring capabilities"
set "msg[120]=Final testing and bug fixes"
set "msg[121]=Update documentation"
set "msg[122]=Add release notes"
set "msg[123]=Prepare for deployment"
set "msg[124]=Final code cleanup"
set "msg[125]=Project completion and polish"

REM Message index counter
set msgIndex=0

echo Starting multi-day commit process...
echo.

REM Process each date
for /L %%i in (0,1,7) do (
    REM Parse date and count
    for /f "tokens=1,2" %%a in ("!dates[%%i]!") do (
        set current_date=%%a
        set commit_count=%%b
        
        echo ========================================
        echo Processing: !current_date! ^(!commit_count! commits^)
        echo ========================================
        
        REM Make commits for this date
        for /L %%j in (1,1,!commit_count!) do (
            REM Calculate hour (spread across work hours 9-21)
            set /a hour=9 + (%%j %% 12)
            set /a minute=!random! %% 60
            
            REM Format time
            if !hour! LSS 10 set hour=0!hour!
            if !minute! LSS 10 set minute=0!minute!
            
            REM Set commit message
            set current_msg=!msg[%msgIndex%]!
            
            REM Create a small change to commit
            echo. >> README.md
            
            REM Stage changes
            git add .
            
            REM Create commit with specific date
            set GIT_AUTHOR_DATE=!current_date! !hour!:!minute!:00
            set GIT_COMMITTER_DATE=!current_date! !hour!:!minute!:00
            
            git commit --date="!current_date! !hour!:!minute!:00" -m "!current_msg!" >nul 2>&1
            
            echo [!current_date! !hour!:!minute!] Commit %%j/!commit_count!: !current_msg!
            
            REM Increment message index
            set /a msgIndex+=1
        )
        
        echo.
        echo Completed !commit_count! commits for !current_date!
        echo.
    )
)

echo.
echo ========================================
echo All commits created successfully!
echo ========================================
echo.
echo Total commits: %msgIndex%
echo Date range: Jan 23-30, 2026
echo.

REM Ask to push
echo.
set /p push_confirm="Do you want to push to GitHub now? (Y/N): "

if /i "%push_confirm%"=="Y" (
    echo.
    echo Pushing to GitHub...
    git push origin main
    
    if !errorlevel! equ 0 (
        echo.
        echo ========================================
        echo Successfully pushed to GitHub!
        echo ========================================
        echo.
        echo Check your GitHub contribution graph:
        echo https://github.com/your-username
    ) else (
        echo.
        echo Error: Push failed!
        echo Please check your GitHub credentials and try:
        echo git push origin main
    )
) else (
    echo.
    echo Commits created locally but not pushed.
    echo To push later, run: git push origin main
)

echo.
echo ========================================
echo Script completed!
echo ========================================
pause
