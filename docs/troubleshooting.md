# Troubleshooting & Quick Fixes

*Because even the best developers hit snags!*

Every developer encounters Git and GitHub issues - it's part of the learning process! This guide helps you diagnose and fix the most common problems quickly so you can get back to building things.

!!! tip "Golden Rule of Troubleshooting"
    **Read the error message carefully!** Git usually tells you exactly what's wrong and often suggests how to fix it.

---

## Installation & Setup Issues

### `git: command not found`

**What it means:** Git isn't installed or isn't in your system PATH.

**Quick fixes:**
```bash
# Check if Git is really missing
which git
git --version

# Install Git
# Mac:
brew install git
# Or download from: https://git-scm.com

# Windows:
winget install Git.Git
# Or download from: https://git-scm.com

# Linux (Ubuntu/Debian):
sudo apt update && sudo apt install git

# Linux (CentOS/RHEL):
sudo yum install git
```

### `gh: command not found`

**What it means:** GitHub CLI isn't installed.

**Quick fixes:**
```bash
# Install GitHub CLI
# Mac:
brew install gh

# Windows:
winget install GitHub.cli

# Linux:
# See instructions at: https://cli.github.com
```

### `fatal: unable to access 'https://github.com/...': Could not resolve host`

**What it means:** Network connectivity issues.

**Quick fixes:**
```bash
# Check internet connection
ping github.com

# Check if you're behind a corporate firewall
git config --global http.proxy http://proxy.company.com:8080

# Try HTTPS instead of SSH
git remote set-url origin https://github.com/username/repo.git
```

---

## Authentication Issues

### `Permission denied (publickey)`

**What it means:** SSH key authentication is failing.

**Quick fixes:**
```bash
# Switch to HTTPS authentication (easier)
git remote set-url origin https://github.com/username/repo.git

# Or set up SSH keys (more secure)
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
# Copy the output and add it to GitHub → Settings → SSH Keys
```

### `fatal: Authentication failed`

**What it means:** Your GitHub credentials are wrong or expired.

**Quick fixes:**
```bash
# Re-authenticate with GitHub CLI
gh auth logout
gh auth login

# Update your Git credentials
git config --global user.email "your.email@example.com"
git config --global user.name "Your Name"

# Clear stored credentials (Mac)
git config --global --unset credential.helper
```

---

## Repository Issues

### `fatal: not a git repository`

**What it means:** You're not in a Git repository directory.

**Quick fixes:**
```bash
# Check if you're in the right directory
pwd
ls -la

# Initialize Git if needed
git init

# Navigate to your project directory
cd /path/to/your/project
```

### `fatal: remote origin already exists`

**What it means:** You're trying to add a remote that already exists.

**Quick fixes:**
```bash
# See current remotes
git remote -v

# Remove existing remote and add new one
git remote remove origin
git remote add origin https://github.com/username/repo.git

# Or update existing remote
git remote set-url origin https://github.com/username/repo.git
```

### `error: failed to push some refs`

**What it means:** The remote repository has changes you don't have locally.

**Quick fixes:**
```bash
# Pull changes first (recommended)
git pull origin main

# Or force push (careful! this overwrites remote changes)
git push --force-with-lease origin main

# If you're sure and it's your personal repo
git push --force origin main
```

---

## Commit & Push Issues

### `nothing to commit, working tree clean`

**What it means:** No changes to commit (this is actually good!).

**Quick fixes:**
```bash
# Check status to confirm
git status

# See what files are tracked
git ls-files

# If you made changes but don't see them
git add .
git status
```

### `Please tell me who you are`

**What it means:** Git doesn't know your identity for commits.

**Quick fixes:**
```bash
# Set your identity (required once)
git config --global user.email "you@example.com"
git config --global user.name "Your Name"

# Verify it worked
git config --global user.email
git config --global user.name
```

### Files you don't want are being tracked

**What it means:** You forgot to add files to `.gitignore` before committing them.

**Quick fixes:**
```bash
# Remove from Git but keep locally
git rm --cached filename
git rm -r --cached foldername/

# Add to .gitignore
echo "filename" >> .gitignore
echo "foldername/" >> .gitignore

# Commit the changes
git add .gitignore
git commit -m "chore: remove tracked files and update .gitignore"
```

---

## GitHub Actions Issues

### Workflow not running

**What it means:** Your workflow file has issues or is in the wrong location.

**Quick fixes:**
```bash
# Check file location (must be exact)
ls -la .github/workflows/

# Workflow file must be named *.yml or *.yaml
mv .github/workflows/build.yaml .github/workflows/build.yml

# Check YAML syntax
cat .github/workflows/build.yml
# Look for indentation issues, missing colons, etc.
```

### Build failing immediately

**What it means:** Syntax error in your workflow file.

**Quick fixes:**
```bash
# Check the Actions tab on GitHub for error details
gh repo view --web
# Click Actions → Click the failed run → Read the error

# Common YAML issues:
# - Wrong indentation (use spaces, not tabs)
# - Missing colons after keys
# - Inconsistent indentation levels
```

### Tests failing but code works locally

**What it means:** Environment differences between local and CI.

**Quick fixes:**
```bash
# Check what's different in CI
# Look at the Actions logs to see:
# - What commands are running
# - What the error message says
# - What files are missing

# Common issues:
# - Missing dependencies in CI
# - Case-sensitive file paths (CI is usually Linux)
# - Environment variables not set
```

---

## Status Badge Issues

### Badge shows "no status"

**What it means:** Badge URL is wrong or workflow hasn't run yet.

**Quick fixes:**
```bash
# Check your badge URL format
echo "![build](https://github.com/$(gh repo view --json owner,name -q '.owner.login + "/" + .name')/actions/workflows/build.yml/badge.svg)"

# Make sure workflow file is named exactly 'build.yml'
ls .github/workflows/

# Trigger a new run
git commit --allow-empty -m "trigger CI"
git push
```

### Badge shows wrong status

**What it means:** Badge is pointing to wrong branch or workflow.

**Quick fixes:**
```bash
# Update badge URL with correct branch
![build](https://github.com/username/repo/actions/workflows/build.yml/badge.svg?branch=main)

# Or use GitHub's badge generator:
# Go to repo → Actions → Select workflow → Click "Create status badge"
```

---

## File Size & Performance Issues

### `remote: error: File exceeds GitHub's size limit`

**What it means:** You're trying to commit a file larger than 100MB.

**Quick fixes:**
```bash
# Find large files
find . -size +50M -type f

# Remove large file from Git history
git rm --cached large-file.zip
echo "large-file.zip" >> .gitignore

# For files you need to track, use Git LFS
git lfs track "*.zip"
git add .gitattributes
git add large-file.zip
git commit -m "chore: track large files with LFS"
```

### Repository clone is very slow

**What it means:** Repository has large files or long history.

**Quick fixes:**
```bash
# Shallow clone (recent commits only)
git clone --depth 1 https://github.com/username/repo.git

# Clone specific branch only
git clone -b main --single-branch https://github.com/username/repo.git
```

---

## Emergency Recovery

### "I accidentally deleted my local repository!"

**Don't panic!** If you've pushed to GitHub, your code is safe.

```bash
# Clone it back from GitHub
git clone https://github.com/username/repo.git
cd repo

# You're back in business!
```

### "I committed something I shouldn't have!"

**Quick fixes:**
```bash
# If you haven't pushed yet (safest)
git reset --soft HEAD~1    # Undo last commit, keep changes
git reset --hard HEAD~1    # Undo last commit, lose changes

# If you already pushed (more complex)
git revert HEAD            # Create a new commit that undoes the last one

# For sensitive data (passwords, keys)
# Contact your facilitator immediately!
```

### "My commits have the wrong author!"

**Quick fixes:**
```bash
# Fix future commits
git config --global user.email "correct@email.com"
git config --global user.name "Correct Name"

# Fix the last commit (if not pushed)
git commit --amend --reset-author --no-edit
```

---

## Getting Help

### Command Quick Reference

```bash
# Status and information
git status              # What's changed?
git log --oneline       # Commit history
git remote -v           # Where am I connected?
git branch             # What branch am I on?

# GitHub CLI helpers
gh repo view --web     # Open repo in browser
gh issue list          # See issues
gh run list           # See recent Actions runs
gh run view --log     # See detailed run logs

# When in doubt
git --help
git status
```

### Where to Get More Help

1. **Read the error message carefully** - Git usually tells you what's wrong
2. **Check the GitHub Actions logs** - Click on the failed run for details
3. **Ask your facilitator** - That's what they're here for!
4. **Search Stack Overflow** - Add "git" to your search
5. **GitHub Docs** - [docs.github.com](https://docs.github.com)

---

## Prevention Tips

!!! success "Avoid Issues Before They Happen"
    - **Commit often** - smaller commits are easier to debug
    - **Write clear commit messages** - your future self will thank you
    - **Use `.gitignore` from the start** - prevent tracking unwanted files
    - **Test locally before pushing** - catch issues early
    - **Keep your tools updated** - `brew upgrade git gh` (Mac)

## Reflection Questions

- What's the most common type of error you've encountered today?
- How has your confidence with Git troubleshooting changed?
- What would you do differently on your next project to avoid these issues?
- How would you help a teammate who's stuck on a Git problem?

---

*Remember: Every expert was once a beginner who didn't give up!*
