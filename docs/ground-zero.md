# Ground Zero Check

Before we dive into the fun stuff, let's make sure your development environment is ready. This is your pre-flight checklist.

## What You'll Need

- **A terminal/command line** (Terminal on Mac, Command Prompt/PowerShell on Windows, or any terminal on Linux)
- **Internet connection** (for GitHub and package downloads)
- **A text editor** (VS Code, Vim, nano, whatever you prefer)

## Installation Check

Run these commands in your terminal. If something fails, we'll fix it together!

### 1. Check if Git is installed

In your terminal run the following.

```bash
git --version
```

**Expected output:** Something like `git version 2.49.0` (version number may vary)

!!! failure "If Git is missing"
    Go to [git-scm.com/downloads](https://git-scm.com/downloads){target="_blank"}, click on your operating system, and install using your preferred method (graphical installer or package manager).

### 2. Check if GitHub CLI is installed

**What is `gh`?**

The GitHub CLI (`gh`) is a command-line tool that lets you interact with GitHub directly from your terminal. This tools is not a replacement for `git` but a complement. Allowing you to quickly interface with GitHub to perform common tasks, opening up the possibility to easily automate tasks.

- Creating repositories (`gh repo create` both new and existing)
- Managing issues and pull requests
- Viewing repository information
- Authenticating with GitHub
- Interface with GitHub's API for nearly endless other possibilities

While `git` handles version control, `gh` handles GitHub platform features.

In your terminal run the following.

```bash
gh --version
```

**Expected output:** Something like `gh version 2.73.0` (version number may vary)

!!! failure "If GitHub CLI is missing"
    Go to [cli.github.com](https://cli.github.com){target="_blank"} and follow the installation instructions for your operating system.

### 3. Generate and Upload SSH Key (Recommended)

**Let's check if SSH is already configured:**

```bash
ssh -T git@github.com
```

If you see: `Hi <your username>! You've successfully authenticated, but GitHub does not provide shell access.` - great! You're already set up.

If this fails, consider configuring SSH for GitHub using the instructions below.

**Why use SSH instead of HTTPS?**

With HTTPS repositories, you'll need to enter your username and password (or personal access token) **every time you push code to GitHub**. This gets tedious quickly when you're working on projects regularly.

With SSH keys, you authenticate once during setup, and then Git operations just work seamlessly. No more typing credentials every time you want to push your changes!

**Setting up SSH keys:**

Rather than duplicate GitHub's excellent documentation, follow their official guide:

**[📖 GitHub's SSH Key Setup Guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent){target="_blank"}**

!!! tip "Choose Your Platform"
    Make sure to select the instructions for your operating system:
    - **[Mac](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=mac){target="_blank"}**
    - **[Windows](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=windows){target="_blank"}**
    - **[Linux](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux){target="_blank"}**

!!! warning "SSH Optional"
    If SSH setup fails or seems complicated, don't worry! You can continue with HTTPS authentication. SSH is convenient but not required for this workshop. You can always set it up later.

### 4. Authenticate with GitHub

```bash
gh auth login
```

Follow the prompts to authenticate. Choose:

- **What account do you want to log into?** → GitHub.com
- **What is your preferred protocol?** → Choose SSH if you set up keys in step 3 above; otherwise choose HTTPS.
- **Authenticate Git with your GitHub credentials?** → Yes

!!! tip "Pro Tip"
    If you don't have a GitHub account yet, create one at [github.com](https://github.com){target="_blank"} - it's free!

## Verify Everything Works

Let's make sure the tools can talk to each other:

This should show your GitHub username
```bash
gh api user | grep login
```

This should show your Git configuration
```bash
git config --global user.name
```

```bash
git config --global user.email
```

!!! warning "Missing Git Config?"
    If the git config commands return nothing, set them up:

    ```bash
    git config --global user.name "Your Name"
    ```

    ```bash
    git config --global user.email "your.email@example.com"
    ```

    Use the same email associated with your GitHub account!

## 🎉 Ready to Go!

If all the commands above worked, you're ready to start creating repositories!

**Next Step:** [Creating Your First Repo](./first-repo.md)

---

## Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| `command not found` | The tool isn't installed - follow installation links above |
| `permission denied` | Try adding `sudo` (Linux/Mac) or run as Administrator (Windows) |
| GitHub authentication fails | Make sure you have a GitHub account and stable internet |
| Git config missing | Run the config commands in the box above |

**Still stuck?** Raise your hand - that's what facilitators are for!
