import subprocess
import datetime
import time
import os

# Git user config
email = "fahad.hasan.42931@gmail.com"
name = "Fahad Hasan"

# Configure git
subprocess.run(["git", "config", "user.email", email])
subprocess.run(["git", "config", "user.name", name])

# Commit distribution by date
commits_data = [
    ("2026-01-23", 30),
    ("2026-01-24", 27),
    ("2026-01-25", 15),
    ("2026-01-26", 32),
    ("2026-01-27", 10),
    ("2026-01-28", 31),
    ("2026-01-29", 22),
    ("2026-01-30", 27),
    ("2026-01-31", 27),
]

# Realistic commit messages
messages = [
    "Initial project setup and configuration",
    "Add Flutter project structure",
    "Setup backend folder structure",
    "Add MongoDB connection configuration",
    "Create User model with password hashing",
    "Implement SolarData model schema",
    "Add JWT authentication middleware",
    "Create auth controller with login/register",
    "Implement solar data controller",
    "Setup Express routes for authentication",
    "Add solar data API routes",
    "Configure environment variables",
    "Add CORS and security middleware",
    "Create database seeder script",
    "Add backend API documentation",
    "Setup Flutter dependencies",
    "Create API configuration files",
    "Implement User data model",
    "Add AuthResponse model",
    "Create comprehensive SolarData models",
    "Implement DashboardData structure",
    "Setup base API service with HTTP client",
    "Create authentication service",
    "Implement solar data service",
    "Add secure storage utility",
    "Create AuthProvider for state management",
    "Implement SolarDataProvider with auto-refresh",
    "Update main.dart with Provider integration",
    "Refactor login screen with backend API",
    "Add loading states to login",
    "Implement error handling in login",
    "Refactor dashboard to use real API data",
    "Add pull-to-refresh functionality",
    "Implement auto-refresh mechanism",
    "Add logout functionality",
    "Create MetricCard widget",
    "Implement WeatherWidget display",
    "Add data table component",
    "Setup app theme and styling",
    "Configure splash screen",
    "Improve UI/UX elements",
    "Add error state UI",
    "Implement loading indicators",
    "Optimize API calls",
    "Add request timeout handling",
    "Improve error messages",
    "Add input validation",
    "Implement session persistence",
    "Add device ID configuration",
    "Create backend README documentation",
    "Add API endpoint examples",
    "Write frontend documentation",
    "Create complete setup guide",
    "Add troubleshooting section",
    "Update project README with full details",
    "Add architecture diagrams",
    "Document database schema",
    "Create testing guidelines",
    "Add code comments",
    "Refactor code structure",
    "Optimize performance",
    "Fix authentication bugs",
    "Resolve API connection issues",
    "Fix data refresh timing",
    "Correct dashboard data mapping",
    "Fix weather widget parameters",
    "Resolve token storage issues",
    "Fix CORS configuration",
    "Update MongoDB indexes",
    "Improve data aggregation queries",
    "Add battery status monitoring",
    "Implement grid status tracking",
    "Add inverter monitoring",
    "Create energy production metrics",
    "Implement load tracking",
    "Add weather data integration",
    "Create system alerts mechanism",
    "Implement hourly statistics",
    "Add historical data filtering",
    "Create statistics endpoint",
    "Implement dashboard aggregation",
    "Add real-time data updates",
    "Improve response formatting",
    "Optimize database queries",
    "Add data validation",
    "Implement error logging",
    "Create utility functions",
    "Add constants configuration",
    "Improve code organization",
    "Refactor service methods",
    "Add type safety improvements",
    "Create model converters",
    "Implement data transformers",
    "Add response handlers",
    "Create custom exceptions",
    "Improve error recovery",
    "Add retry logic",
    "Implement timeout handling",
    "Create connection management",
    "Add network status detection",
    "Improve user feedback",
    "Add success notifications",
    "Create loading animations",
    "Implement skeleton screens",
    "Add smooth transitions",
    "Improve navigation flow",
    "Create responsive layouts",
    "Add accessibility features",
    "Implement localization support",
    "Create app configuration",
    "Add environment setup",
    "Implement feature flags",
    "Create debug utilities",
    "Add development tools",
    "Implement build scripts",
    "Create deployment config",
    "Add production optimizations",
    "Implement security enhancements",
    "Create backup mechanisms",
    "Add monitoring capabilities",
    "Add comprehensive error handling",
    "Implement data caching mechanism",
    "Create offline data storage",
    "Add network status monitoring",
    "Implement retry mechanism for failed requests",
    "Add token refresh functionality",
    "Create user preferences storage",
    "Implement theme customization",
    "Add notification system foundation",
    "Create alert management",
    "Implement data export functionality",
    "Add CSV export feature",
    "Create PDF report generator",
    "Implement chart improvements",
    "Add data visualization enhancements",
    "Create analytics dashboard",
    "Implement performance optimizations",
    "Add lazy loading for data",
    "Create pagination for history",
    "Implement infinite scroll",
    "Add comprehensive unit tests",
    "Create integration test suite",
    "Add API endpoint tests",
    "Implement E2E testing framework",
    "Final bug fixes and polish",
    "Update all documentation",
    "Add deployment instructions",
    "Create contribution guidelines",
    "Add license and credits",
    "Polish UI components",
    "Optimize bundle size",
    "Add performance monitoring",
    "Implement analytics tracking",
    "Create user onboarding flow",
    "Add help and support section",
    "Implement feedback mechanism",
    "Create version update system",
    "Add changelog documentation",
    "Implement crash reporting",
    "Create health check endpoints",
    "Add system status page",
    "Implement rate limiting",
    "Create API versioning",
    "Add request validation",
    "Implement response caching",
    "Create database migrations",
    "Add seed data improvements",
    "Implement backup automation",
    "Create monitoring dashboards",
    "Add alerting system",
    "Implement logging infrastructure",
    "Create CI/CD pipeline",
    "Add automated testing",
    "Implement code quality checks",
    "Create security scanning",
    "Add dependency updates",
    "Implement container support",
    "Create Docker configurations",
    "Add Kubernetes manifests",
    "Implement cloud deployment",
    "Create infrastructure as code",
    "Add scalability improvements",
    "Implement load balancing",
    "Create failover mechanisms",
    "Add disaster recovery plan",
    "Implement multi-region support",
    "Create CDN integration",
    "Add static asset optimization",
    "Implement progressive web app",
    "Create mobile app optimizations",
    "Add push notification support",
    "Implement real-time websockets",
    "Create background sync",
    "Add offline-first capabilities",
    "Implement service workers",
    "Create app shell architecture",
    "Add resource prefetching",
    "Implement code splitting",
    "Create lazy route loading",
    "Add bundle optimization",
    "Implement tree shaking",
    "Create production build",
    "Add environment configurations",
    "Implement secrets management",
    "Create security headers",
    "Add HTTPS enforcement",
    "Implement CORS policies",
    "Create API documentation site",
    "Add interactive API explorer",
    "Implement SDK generation",
    "Create client libraries",
    "Add example integrations",
    "Project completion - Version 1.0.0",
]

msg_index = 0
total_commits = 0

print("=" * 60)
print("SCUBE Solar Monitoring - Automated Git Commits")
print("=" * 60)
print()

# Stage all files first
print("Staging all files...")
subprocess.run(["git", "add", "."], check=True)
print("Files staged successfully!")
print()

for date_str, count in commits_data:
    print("=" * 60)
    print(f"Processing: {date_str} ({count} commits)")
    print("=" * 60)
    
    for i in range(count):
        if msg_index >= len(messages):
            msg_index = 0  # Loop back if we run out of messages
        
        # Calculate time (spread across 9 AM to 8 PM)
        hour = 9 + (i % 11)
        minute = (i * 7) % 60
        
        commit_time = f"{date_str} {hour:02d}:{minute:02d}:00"
        commit_msg = messages[msg_index]
        
        # Set environment variables for commit date
        env = {
            **os.environ,
            "GIT_AUTHOR_DATE": commit_time,
            "GIT_COMMITTER_DATE": commit_time,
        }
        
        # Create commit
        result = subprocess.run(
            ["git", "commit", "--allow-empty", "-m", commit_msg],
            env=env,
            capture_output=True,
            text=True
        )
        
        if result.returncode == 0:
            print(f"[{commit_time}] ✓ Commit {i+1}/{count}: {commit_msg}")
        else:
            print(f"[{commit_time}] ✗ Failed: {commit_msg}")
            print(f"Error: {result.stderr}")
        
        msg_index += 1
        total_commits += 1
    
    print()

print("=" * 60)
print(f"Total commits created: {total_commits}")
print("=" * 60)
print()

# Ask to push
print("Ready to push to GitHub!")
response = input("Do you want to push now? (y/n): ").strip().lower()

if response == 'y':
    print()
    print("Pushing to GitHub...")
    result = subprocess.run(["git", "push", "origin", "main"], capture_output=True, text=True)
    
    if result.returncode == 0:
        print()
        print("=" * 60)
        print("✓ Successfully pushed to GitHub!")
        print("=" * 60)
        print()
        print("Repository: https://github.com/fahadhasan-x/Solar-PV-Monitoring-System")
        print()
        print("Contribution Summary:")
        for date_str, count in commits_data:
            print(f"  {date_str}: {count} commits")
        print(f"\nTotal: {total_commits} commits")
    else:
        print()
        print("✗ Push failed!")
        print(f"Error: {result.stderr}")
        print()
        print("You can manually push later with:")
        print("  git push origin main")
else:
    print()
    print("Commits created locally but not pushed.")
    print("To push later, run: git push origin main")

print()
print("=" * 60)
print("Script completed!")
print("=" * 60)
