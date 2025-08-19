# Creating Your First Repo from Scratch

Git is a version control system that tracks changes to your code over time. It creates commits (think of it like a save file in a video game) of your project that you can return to at any point. Industry relies on Git for its ability to track code history and maintain a complete record of changes. It also enables team collaboration without overwriting each other's work, solving the fundamental challenge of maintaining a single source of truth. For students, Git offers two key benefits: it protects your academic work from loss or corruption, and it builds an essential professional skill that employers expect. Learning Git now means you can experiment confidently with your code and establish good practices that will serve your entire career.

Let's start with a brand new project! This is perfect for getting your hands dirty with Git basics without the complexity of existing code.

!!! quote "Discovery Time!"
    **We're going to DO first, then understand what happened.** Ready? Let's create a tiny project on GitHub and work with it locally!

## Step 1: Create a New GitHub Repository

Let's start by creating a repository on GitHub first. We'll use the GitHub CLI (`gh`) to do this:

Create a new GitHub repository
```bash
gh repo create hello-vcs --description "My first version control project"
```

By default, this creates a public repository that anyone can see.

!!! success "What Just Happened?"
    That command created a new public repository on GitHub called "hello-vcs" and added a description to it. The repository now exists on GitHub, but not yet on your local machine.

## Step 2: Clone the Repository

Now let's download (clone) the repository to your local machine using the GitHub CLI:

Clone the repository to your local machine
```bash
gh repo clone hello-vcs
```

This creates a folder called hello-vcs with a connection to GitHub already set up.

!!! success "Why Use GitHub CLI?"
    The `gh repo clone` command automatically:

    - Uses your preferred protocol (HTTPS or SSH) that you configured in the Ground Zero setup
    - Finds your repositories without needing to specify your username
    - Handles authentication seamlessly

!!! tip "Alternative: Using git clone"
    You can also use the traditional Git command to clone repositories:
    
    Clone using git directly (requires the full URL)
    ```bash
    git clone https://github.com/YOUR-USERNAME/hello-vcs.git
    ```
    
    OR if using SSH
    ```bash
    git clone git@github.com:YOUR-USERNAME/hello-vcs.git
    ```
    
    Replace `YOUR-USERNAME` with your actual GitHub username. You can find the correct URL by going to your repository on GitHub and clicking the green "Code" button.

## Step 3: Add Content to Your Repository

Now that you have a local copy of your GitHub repository, let's add some content to it:

Make sure you're in the repository directory
```bash
cd hello-vcs
```

Create a simple README file
```bash
printf "# Hello VCS\n\nWhy version control?\n\n- 🛡️ Safety: Never lose work again\n- 🤝 Collaboration: Work with others smoothly\n- 📈 History: See how your project evolved\n- 💼 Professional: Recruiters expect it\n" > README.md
```

Create a file with secrets that we DON'T want to commit
```bash
printf "MY_API_KEY=abc123\nPASSWORD=super_secret_password\n" > super-secret.env
```

See what Git thinks about your files
```bash
git status
```

!!! warning "Sensitive Data"
    The `super-secret.env` file contains sensitive information that we don't want to share on GitHub!

## Step 4: Make Your First Commit

OOPS! We don't want to add the secret file! Let's be selective and only add the README. Try leveraging tab completion to fill in the file name.
```bash
git add README.md
```

Check status again to see what changed
```bash
git status
```

Create your first commit (a snapshot in time)
```bash
git commit -m "feat: initial commit with README"
```

`-m` is short for `--message` and is used to provide a commit message. This message is what will show up in the commit history and it should be descriptive of the changes made. Avoid commit messages like `fixed bug` or `updated code` as these are not descriptive and do not provide any value to you when you are reading the commit history. If you are using VSCode's Source Control view you can leverage AI to generate commit messages by clicking the ✨ icon. 

!!! question "Pause & Think"
    What did `git status` show? Notice how we only added the README.md file, leaving the super-secret.env file untracked?

!!! tip "Adding multiple files"
    The `git add .` command stages all new and modified files in the current directory and its subdirectories, while `git add -A` stages ALL changes across the entire repository (including deletions and files outside your current directory). Both are quick ways to add multiple files at once, but use them carefully as they can easily include files you don't want to commit. We recommend always running `git status` after one of these commands to review what was actually staged (green).

## Step 5: Add a Basic .gitignore

Run `git status` again. Notice that `super-secret.env` shows up as untracked. This tells us Git _sees_ this file but it is not tracked by Git yet. Files that show up as untracked are ripe for mistakes. We could accidentally run `git add .` and commit our secret file!

You should presume that anything committed and pushed to GitHub is potentially visible to others. `.gitignore` is a special file that tells Git which files to ignore, saving us from accidentally committing sensitive information.

Let's create a `.gitignore` file to make sure we never accidentally commit our secret file:

Create a basic .gitignore file that includes our secret file
```bash
printf "# Secrets\nsuper-secret.env\n*.env\n" > .gitignore
```

Check status again
```bash
git status
```

Commit this important file
```bash
git add .gitignore
```

```bash
git commit -m "chore: add basic .gitignore with secrets protection"
```

Think of `.gitignore` as a bouncer for your repository - it keeps the riffraff out! We don't want operating system files, build artifacts, compiled code, temporary files, or secrets cluttering our project history.

Starting a new project and not sure what to include in your `.gitignore`? Check out [github.com/github/gitignore](https://github.com/github/gitignore) for a list of common patterns for popular languages and tools.

!!! info "Common .gitignore Patterns"
    `.gitignore` uses several pattern types:
    
    - **Exact match**: `super-secret.env` ignores only that specific file
    - **Glob pattern**: `*.env` ignores all files ending with .env
    - **Directory**: `logs/` ignores entire directories (note the trailing slash)
    - **Negation**: `!important.log` includes a file even if it is ignored by another pattern
    - **Double asterisk**: `**/node_modules` matches node_modules in any directory depth
    
!!! success "Protection in Place"
    Now even if you run `git add .` in the future, Git will ignore the super-secret.env file!

## Step 6: Push Your Changes to GitHub

Now that we've made changes locally, let's push them back to GitHub:

Push your commits to GitHub
```bash
git push
```

!!! success "🎉 What Just Happened?"
    The `git push` command sent your local commits to GitHub. Since we created the repository on GitHub first and then cloned it, the connection between your local repository and GitHub was already set up. This is one of the advantages of starting with GitHub first!
    
    Check it out: `gh repo view --web`

## Step 7: Verify Your Success

See your commit history
```bash
git log --oneline --graph --decorate
```

Check your connection to GitHub
```bash
git remote -v
```

View your repo in the browser
```bash
gh repo view --web
```

## Checkpoint: What Did You Just Do?

Take a moment to answer these questions with the people around you and a facilitator (this is not a test or a quiz - ask questions and take shots, no right or wrong answers):

1. **What's the advantage of creating a GitHub repository first?**
2. **What's the difference between `git add` and `git commit`?**
3. **Where are your files stored now? (Hint: there are two places)**
4. **What would happen if you deleted your local folder?**

!!! question "Think About It"
    **Git vs GitHub:** You just used both! Can you explain the difference to someone else?

## Step 8: Add More Content and Practice

Let's make another commit to practice the workflow:

Add some content to your README
```bash
echo "\n## About This Project\n\nThis is my first Git repository! I learned how to:\n- Create a GitHub repository\n- Clone it to my computer\n- Make commits locally\n- Use .gitignore to protect sensitive files\n- Push changes back to GitHub\n" >> README.md
```

Check status
```bash
git status
```

Look at the diff
```bash
git diff
```

Commit the changes
```bash
git add README.md
```

```bash
git commit -m "docs: expand README with learning notes"
```

Push to GitHub
```bash
git push
```

This time we used `git diff` to see the changes on tracked files before we committed them. This is a good practice to ensure we only commit the changes we want to commit. This will only show changes on files that are already tracked by Git.

## Mission Accomplished!

Congratulations! You've successfully created a GitHub repository, cloned it to your computer, built a meaningful commit history, added a `.gitignore` file to protect sensitive information, and gained valuable experience with the GitHub-first workflow.

Starting with GitHub first has several advantages:

- Your repository exists in the cloud from the very beginning
- The connection between local and remote is automatically set up
- You don't need to manually connect your local repo to GitHub later
- It's easier to collaborate with others from day one

Did you know with Git you can become a time traveler and go back to **ANY** commit in the history of a project? This can be really powerful for debugging or recovering from a breaking change (just like sometimes you need to load an earlier save in a game because you realized you needed to bring Orphic's Hammer with you into the House of Hope before ripping the contract - BG3 fans anyone?).

We will not go into these details here, but if you are using Git and you find yourself needing to rollback to an earlier commit, you can use `git reset <commit sha>` to do so.

Git can become much more complicated (and powerful). We are just scratching the surface here. For collaborative development, you would typically need to make use of `branches`, `merging`, `pull`, `rebase`, and many more commands.

Regularly committing and pushing to a remote repository is enough to ensure your work is always safe and should become a habit. 

**Next Adventure:** [Converting an Existing Project](./convert-project.md) or jump ahead to [GitHub Actions Setup](./github-actions.md)

---

## Quick Reference

GitHub-first workflow:

Create repo on GitHub & clone it
```bash
gh repo create <n> --<public|private> --description "..." --clone
```

Enter the repo directory
```bash
cd <n>
```

The basic Git workflow:

Check what's changed
```bash
git status
```

Stage all changes
```bash
git add .
```

See changes before committing
```bash
git diff
```

See commit history
```bash
git log --oneline
```

Create a snapshot
```bash
git commit -m "..."
```

Send to GitHub
```bash
git push
```

GitHub CLI shortcuts:

Open repo in browser
```bash
gh repo view --web
```

## Reflection Questions

- How does having your code on GitHub make you feel about your project?
- What's one way this could help you with homework or group projects?
- What would you tell a friend who says "Git is too complicated"?
