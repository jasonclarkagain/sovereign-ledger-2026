#!/bin/bash
# SIMPLE GITHUB BACKUP - NO BULLSHIT

echo "🔄 Backing up to GitHub..."

# Check if we're in the right place
if [ ! -f "requirements-quantum.txt" ] && [ ! -f "README.md" ]; then
    echo "❌ Wrong directory. Go to: ~/tool_library/quantum_security_toolkit"
    exit 1
fi

# Initialize git if needed
if [ ! -d ".git" ]; then
    echo "Initializing git..."
    git init
    git remote add origin https://github.com/jasonclarkagain/sovereign-ledger-2026.git
fi

# Add everything
git add -A

# Check for changes
if git status | grep -q "nothing to commit"; then
    echo "✅ No changes to backup"
    exit 0
fi

# Commit
git commit -m "Backup $(date '+%Y-%m-%d %H:%M:%S')"

# Push
if git push -u origin main --force; then
    echo "✅ Backup successful!"
    echo "🔗 View at: https://github.com/jasonclarkagain/sovereign-ledger-2026"
else
    # Try with master branch
    git branch -M master
    git push -u origin master --force && echo "✅ Backup to master successful!" || echo "❌ Backup failed"
fi

# Also create local backup
tar -czf ~/tool_backup_$(date +%Y%m%d_%H%M%S).tar.gz .
echo "📦 Local backup created"
