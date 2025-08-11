# .gitignore Templates: Keep the Junk Out

*Reference guide for keeping your repositories clean*

Think of `.gitignore` as a gatekeeper for your repository. It decides what gets in and what stays out!

!!! tip "Golden Rule"
    **If you can regenerate it, don't track it!** This includes build outputs, dependencies, IDE files, and temporary files.

## Quick Setup

The easiest way to get a proper `.gitignore` file is to use the community-maintained templates from GitHub:

### Option 1: Use GitHub's Official Templates

```bash
# Choose the template that matches your project
curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore     # Node.js
curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore   # Python
curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/Java.gitignore     # Java
curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/main/C++.gitignore      # C++

# Then commit it
git add .gitignore
git commit -m "chore: add .gitignore for [language]"
```

### Option 2: Browse All Available Templates

Visit **[github.com/github/gitignore](https://github.com/github/gitignore)** to see templates for:

- **Languages**: Python, Java, C++, Go, Rust, Swift, etc.
- **Frameworks**: React, Django, Spring, Laravel, etc.
- **Tools**: Vim, Emacs, VS Code, IntelliJ, etc.
- **Operating Systems**: macOS, Windows, Linux

### Option 3: Use gitignore.io

For more customization, try **[gitignore.io](https://gitignore.io)**:

1. Enter your tech stack (e.g., "python,django,vscode,macos")
2. Generate a custom `.gitignore` file
3. Copy and paste into your project

```bash
# Example: Generate for Python + VS Code + macOS
curl -L -s https://www.gitignore.io/api/python,visualstudiocode,macos > .gitignore
```

## Common Patterns to Always Include

Regardless of your tech stack, these patterns are almost always useful:

```gitignore
# Operating System Files
.DS_Store
Thumbs.db
*~

# IDE and Editor files
.vscode/
.idea/
*.swp
*.swo

# Environment and secrets
.env
.env.local
config.local.*
secrets.*

# Logs
*.log
logs/

# Temporary files
*.tmp
*.temp
tmp/
temp/
```

## Customizing Your .gitignore

After getting a base template:

1. **Review what's included** - understand each pattern
2. **Add project-specific patterns** - custom build outputs, data files, etc.
3. **Test it** - run `git status` to see what's still being tracked
4. **Clean up existing tracked files** if needed:

```bash
# Remove files that should now be ignored
git rm --cached filename
git rm -r --cached foldername/

# Commit the cleanup
git add .gitignore
git commit -m "chore: update .gitignore and remove tracked files"
```

## Best Practices

!!! success "Do Include"
    - **Source code** (`.js`, `.py`, `.java`, `.cpp`)
    - **Configuration templates** (`config.example.js`)
    - **Documentation** (`README.md`, docs)
    - **Build scripts** (`Makefile`, `package.json`)
    - **Tests** (`test/`, `spec/`)

!!! danger "Don't Include"
    - **Dependencies** (`node_modules/`, `__pycache__/`)
    - **Build outputs** (`dist/`, `build/`, `*.exe`)
    - **IDE files** (`.vscode/`, `.idea/`)
    - **OS files** (`.DS_Store`, `Thumbs.db`)
    - **Secrets** (`.env`, `config.local.js`)
    - **Large binaries** (unless using Git LFS)

## Troubleshooting

| Problem | Solution |
|---------|----------|
| File still tracked after adding to `.gitignore` | `git rm --cached filename` then commit |
| Too many files to ignore | Use directory patterns like `build/` |
| Want to track a usually-ignored file | Add `!filename` to force inclusion |
| Accidentally ignored important file | Check `.gitignore` patterns, use `!pattern` |

## Useful Resources

- **[github.com/github/gitignore](https://github.com/github/gitignore)** - Official GitHub templates
- **[gitignore.io](https://gitignore.io)** - Custom generator
- **[Git documentation](https://git-scm.com/docs/gitignore)** - Complete `.gitignore` syntax reference

## Reflection Questions

- What types of files does your current project generate that shouldn't be tracked?
- How would a messy repository (with build files, etc.) affect a teammate?
- When might you want to modify these templates for your specific needs?
