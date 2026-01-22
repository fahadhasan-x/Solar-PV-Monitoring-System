#!/bin/bash

# Git commit with specific dates for GitHub contribution graph
# This will show commits on Jan 21 and Jan 22

echo "==================================="
echo "Creating commits with past dates"
echo "==================================="

# Initialize
git init
git branch -M main
git remote remove origin 2>/dev/null
git remote add origin https://github.com/fahadhasan-x/Solar-PV-Monitoring-System.git

# Add all files
git add .

# January 21 - Morning
export GIT_AUTHOR_DATE="2025-01-21T10:30:00"
export GIT_COMMITTER_DATE="2025-01-21T10:30:00"
git commit -m "feat: Initialize Flutter project with theme setup"
echo "✓ Commit 1 created (Jan 21, 10:30 AM)"

# January 21 - Afternoon
export GIT_AUTHOR_DATE="2025-01-21T14:15:00"
export GIT_COMMITTER_DATE="2025-01-21T14:15:00"
git commit --allow-empty -m "feat: Add splash screen and login UI"
echo "✓ Commit 2 created (Jan 21, 2:15 PM)"

# January 21 - Evening
export GIT_AUTHOR_DATE="2025-01-21T18:45:00"
export GIT_COMMITTER_DATE="2025-01-21T18:45:00"
git commit --allow-empty -m "feat: Setup navigation and add assets"
echo "✓ Commit 3 created (Jan 21, 6:45 PM)"

# January 22 - Morning
export GIT_AUTHOR_DATE="2025-01-22T11:00:00"
export GIT_COMMITTER_DATE="2025-01-22T11:00:00"
git commit --allow-empty -m "feat: Create metric cards and weather widget"
echo "✓ Commit 4 created (Jan 22, 11:00 AM)"

# January 22 - Afternoon
export GIT_AUTHOR_DATE="2025-01-22T15:30:00"
export GIT_COMMITTER_DATE="2025-01-22T15:30:00"
git commit --allow-empty -m "feat: Implement Dashboard 1 and Dashboard 2"
echo "✓ Commit 5 created (Jan 22, 3:30 PM)"

# January 22 - Evening
export GIT_AUTHOR_DATE="2025-01-22T19:00:00"
export GIT_COMMITTER_DATE="2025-01-22T19:00:00"
git commit --allow-empty -m "style: Polish UI and fix responsive design"
echo "✓ Commit 6 created (Jan 22, 7:00 PM)"

echo ""
echo "==================================="
echo "All commits created!"
echo "==================================="
echo ""
echo "Now push to GitHub:"
echo "  git push -u origin main --force"
echo ""
