# Commit 2
$env:GIT_AUTHOR_DATE = "2026-01-21T10:30:00"
$env:GIT_COMMITTER_DATE = "2026-01-21T10:30:00"
git add pubspec.lock
git commit -m "feat: Add project dependencies (fl_chart, google_fonts)" --date="2026-01-21T10:30:00"

# Commit 3
$env:GIT_AUTHOR_DATE = "2026-01-21T11:45:00"
$env:GIT_COMMITTER_DATE = "2026-01-21T11:45:00"
git add lib/theme/
git commit -m "feat: Setup app theme and color scheme" --date="2026-01-21T11:45:00"

# Commit 4
$env:GIT_AUTHOR_DATE = "2026-01-21T14:00:00"
$env:GIT_COMMITTER_DATE = "2026-01-21T14:00:00"
git add lib/screens/splash_screen.dart
git commit -m "feat: Create splash screen with slide-up animation" --date="2026-01-21T14:00:00"

# Commit 5
$env:GIT_AUTHOR_DATE = "2026-01-21T15:30:00"
$env:GIT_COMMITTER_DATE = "2026-01-21T15:30:00"
git add lib/screens/login_screen.dart
git commit -m "feat: Create login screen UI with form validation" --date="2026-01-21T15:30:00"

# Commit 6
$env:GIT_AUTHOR_DATE = "2026-01-21T16:15:00"
$env:GIT_COMMITTER_DATE = "2026-01-21T16:15:00"
git add Assets/ pubspec.yaml
git commit -m "feat: Add logo and weather icons assets" --date="2026-01-21T16:15:00"

# Commit 7
$env:GIT_AUTHOR_DATE = "2026-01-21T17:00:00"
$env:GIT_COMMITTER_DATE = "2026-01-21T17:00:00"
git add lib/main.dart
git commit -m "feat: Setup app navigation and routes" --date="2026-01-21T17:00:00"

# Commit 8
$env:GIT_AUTHOR_DATE = "2026-01-22T10:00:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T10:00:00"
git add lib/widgets/metric_card.dart
git commit -m "feat: Create reusable metric card widget" --date="2026-01-22T10:00:00"

# Commit 9
$env:GIT_AUTHOR_DATE = "2026-01-22T11:30:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T11:30:00"
git add lib/widgets/weather_widget.dart
git commit -m "feat: Implement weather widget with thermometer visualization" --date="2026-01-22T11:30:00"

# Commit 10
$env:GIT_AUTHOR_DATE = "2026-01-22T13:00:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T13:00:00"
git add lib/widgets/data_table_widget.dart
git commit -m "feat: Create data comparison table with alternating rows" --date="2026-01-22T13:00:00"

# Commit 11
$env:GIT_AUTHOR_DATE = "2026-01-22T14:30:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T14:30:00"
git add lib/screens/dashboard_1_screen.dart
git commit -m "feat: Implement Dashboard 1 with metrics and PV module info" --date="2026-01-22T14:30:00"

# Commit 12
$env:GIT_AUTHOR_DATE = "2026-01-22T16:00:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T16:00:00"
git add lib/screens/dashboard_2_screen.dart
git commit -m "feat: Implement Dashboard 2 with circular chart and data views" --date="2026-01-22T16:00:00"

# Commit 13
$env:GIT_AUTHOR_DATE = "2026-01-22T17:15:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T17:15:00"
git add lib/screens/ lib/widgets/
git commit -m "style: Improve responsive design and mobile layout" --date="2026-01-22T17:15:00"

# Commit 14
$env:GIT_AUTHOR_DATE = "2026-01-22T18:00:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T18:00:00"
git add lib/
git commit -m "fix: Remove duplicate text from splash and login screens" --date="2026-01-22T18:00:00"

# Commit 15
$env:GIT_AUTHOR_DATE = "2026-01-22T18:45:00"
$env:GIT_COMMITTER_DATE = "2026-01-22T18:45:00"
git add README.md android/ ios/ linux/ macos/ web/ windows/ test/
git commit -m "docs: Update README and add project documentation" --date="2026-01-22T18:45:00"

Write-Host "All 15 commits created with 2026 dates!"
git log --oneline --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%h %ad %s'
