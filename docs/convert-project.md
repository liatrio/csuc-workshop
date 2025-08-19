# Converting an Existing Project to Git

This is where the rubber meets the road! Let's take one of your real projects (homework, side project, or that folder of random scripts) and bring it under version control.

!!! quote "Real-World Application"
    **This is the stuff that matters.** Converting existing work to Git is something you'll do constantly as a developer. Let's make it second nature!

## Choose Your Project

Pick a project folder that:

- ✅ Has code you care about
- ✅ Isn't already under Git (no `.git` folder)
- ✅ You wouldn't mind experimenting with
- ❌ Isn't your only copy of something super important (make a backup if nervous!)

To make the following exercises more predicatable and easy I would recommend picking a homework assignment.

## Step 1: Navigate and Investigate

```bash
# Go to your existing project (replace with your actual path)
cd /path/to/your/existing-project

# See what's in there
ls -la

# Check if it's already a Git repo (we hope not!)
git status
```

!!! failure "If you see 'fatal: not a git repository'"
    **Perfect!** That's exactly what we want. If it says something else, you might already have Git set up.

## Step 2: Take a Snapshot Before Starting

```bash
# Initialize Git in your existing project
git init

# See what Git thinks about all your files
git status
```

!!! question "Pause & Observe"
    How many files does Git see? Are there any you definitely DON'T want to track (secrets, build outputs, etc.)?

## Step 3: Create a .gitignore

Before we commit everything, let's be smart about what we ignore. Choose the template that matches your project from [GitHub's .gitignore templates](https://github.com/github/gitignore){target="_blank"}.

Search for your language or framework then click on "Raw" and copy the URL. Then run:

```bash
curl -o .gitignore <URL>
```

!!! tip "Customize It!"
    Open your `.gitignore` in your editor and add any project-specific files you want to ignore. In general this is any file that you can easily regenerate. Common additions:

    - `config.local.js`
    - `secrets.txt`
    - `*.tmp`
    - Large data files
    - build output (ie: `p1` from `g++ -o p1 main.o`)

## Step 4: Stage and Commit Your Project

```bash
# Check what Git sees now (after .gitignore)
git status
```

Review the list of files Git is tracking. Did you miss any files you want ignored. If so, add them to your `.gitignore` file.

```
# Add everything that should be tracked
git add .

# Check what's staged
git status

# Create your initial commit
git commit -m "feat: import existing project into version control"
```

!!! success "🎉 You Did It!"
    Your project now has Git history! But it's still only local. Let's get it on GitHub.

## Step 5: Connect to GitHub

```bash
# Create a GitHub repo (choose a good name!)
gh repo create <repo-name> --source=. --private --remote=origin --push
```

!!! tip "Private vs Public"
    If you want to keep your project private, use `--private`. If you want to make it public, use `--public`.
    If you are pushing homework to GitHub, it is recommended to keep it private.

!!! question "What's in a Name?"
    Choose a repo name that's:

    - **Descriptive**: `data-structures-homework` not `project1`
    - **Professional**: future employers might see this
    - **Unique**: avoid conflicts with existing repos

## Step 6: Verify and Celebrate

```bash
# See your project's history
git log --oneline --graph --decorate

# Open your repo in the browser
gh repo view --web

# Check the remote connection
git remote -v
```

## Add a Meaningful README

If your project doesn't have a README, or it's sparse, let's make it shine:

1. **Create or open README.md** in your editor

2. **Consider including in your README:**
    - A brief project description
    - Setup and usage instructions
    - Technologies used
    - Personal reflections or learnings

3. **Commit and push your README:**

```bash
# Check what's changed
git status

# Add your new or modified README
git add README.md

# Verify what's staged
git status

# Commit with a descriptive message
git commit -m "docs: add comprehensive project README"

# Push to GitHub
git push
```

## Checkpoint: Reflect with a Partner

Take 2 minutes to discuss:

1. **How does it feel to have your real work under version control?**
2. **What files did you choose to ignore and why?**
3. **If you broke your computer right now, how would you get your work back?**
4. **What's one thing you wish you had done differently on this project from the start?**

## Practice: Make a Small Change

Let's practice the Git workflow by adding a Next Steps section to your README:

Append Next Steps section to your README
```bash
cat >> README.md << 'EOF'

## Next Steps

- [ ] Add automated builds with GitHub Actions
- [ ] Add status badges to show build status
- [ ] Create automated releases
EOF
```

Check what changed
```bash
git status
```

See the specific changes
```bash
git diff README.md
```

Add the modified file
```bash
git add README.md
```

Check that it's staged
```bash
git status
```

Commit with a descriptive message
```bash
git commit -m "docs: add project next steps"
```

Push to GitHub
```bash
git push
```

## Mission Accomplished!

Your real project now has:

- Git version control
- A proper `.gitignore` file  
- A home on GitHub
- Professional documentation
- A clean commit history

**Next Adventure:** [GitHub Actions Setup](./github-actions.md) - Let's automate building and releases!

---

## Pro Tips for Future Projects

- **Start with Git from day one** on new projects
- **Commit early and often** - small, focused commits are better
- **Write meaningful commit messages** - your future self will thank you
- **Use branches** for experiments (we'll cover this in advanced workshops)

## Troubleshooting Common Issues

| Problem | Solution |
|---------|----------|
| Unwanted files showing in git status | Add patterns to `.gitignore` |
| Accidentally committed a large file | Use `git rm --cached filename`, add to `.gitignore`, commit |
| Want to rename the repo | Use `gh repo edit --name new-name` |
| Commit message typo | `git commit --amend -m "new message"` (if not pushed yet) |

## Reflection Questions

- How might version control change the way you approach homework assignments?
- What would you tell a classmate who's never used Git before?
- How could you use commit messages to track your learning progress?
