# GitHub Actions: Automate Build Checks

Time to add some automation to your project! GitHub Actions is a CI/CD tool built into GitHub that can be used to automate tasks such as building, testing, releasing, and more.

## What Are GitHub Actions?

GitHub Actions are workflow automation tools that can:

- Automatically run tasks when specific events happen in your repository (pushes, pull requests, schedules, etc.)
- Execute any command or script you could run on your own computer
- Connect with other services and APIs across the internet
- Process data and generate reports
- Deploy your code to various environments
- Perform custom actions based on conditions you define
- Save you time by automating repetitive tasks

Really you can do almost anything you want with GitHub Actions. If you can run it on a computer you can run it in an Action.

Additional context:

- Run on short-lived, clean virtual machines. Each run GitHub Action run starts from scratch.
- You configure tools each run (e.g., check out code, set up your language/toolchain).
- Usage is included up to a limit for most accounts. See GitHub's documentation on limits and included minutes: [Included storage and minutes](https://docs.github.com/en/billing/concepts/product-billing/github-actions#included-storage-and-minutes){target="_blank"}. It is unlikely you will hit these limits even on the free tier.

## Step 1: Add a Starter Workflow

We'll begin with a minimal, language-agnostic workflow that triggers on pushes to the `main` branch and runs a simple job.

Example workflow (`.github/workflows/build.yml`):

```yaml
name: ci
on:
  push:
    branches: [ "main" ] # Update this to whatever your default branch is

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Say hello
        run: echo "Hello, GitHub Actions!"
```

Quick create via terminal:

```bash
mkdir -p .github/workflows
cat > .github/workflows/build.yml << 'EOF'
name: ci
on:
  push:
    branches: [ "main" ] # Update this to whatever your default branch is

jobs:
  hello:
    runs-on: ubuntu-latest
    steps:
      - name: Say hello
        run: echo "Hello, GitHub Actions!"
EOF
```

## Step 2: Commit and Push Your Workflow

Add the workflow file to Git
```bash
git add .github/workflows/build.yml
```

Commit it
```bash
git commit -m "ci: add automated build workflow"
```

Push to GitHub (this triggers the first run!)
```bash
git push
```

!!! success "🤖 Robot Activated!"
    You just created your first automation! GitHub is now running your workflow.

## Step 3: Watch Your First Build

Open your repo and go to the Actions tab
```bash
gh repo view --web
```

Click on the **Actions** tab to see your workflow running in real-time!

!!! warning "No workflow runs found?"
    If you do not see any workflow runs, check your branch trigger. Is your default branch named `main`? If not, update the `branches` field in your workflow file.

!!! question "What Do You See?"
    - Is there a yellow circle (running), green checkmark (passed), or red X (failed)?
    - Click on the workflow run to see the detailed logs
    - What commands did the robot run for you? See if you can find the echo command in the logs.

## Step 4: Make It Build Your Project
Great you have automated saying 'Hello, GitHub Actions!'. This is about as useful as that box of spare cables you keep _just in case_.
But seriously this was useful. You now have **code** that runs everytime you push something to GitHub automatically. From here you can do almost anything you want.

To make this useful to you, let's modify this to build your project and later publish a release.

Remember your workflow runs on a fresh, short‑lived VM each time. That machine needs:

- **Your code** (use `actions/checkout`)
- **Build dependencies/tools** (install or set up each run)
- **A build command** to produce outputs

Edit `.github/workflows/build.yml` to add these basics. Example scaffold:

```yaml
name: ci
on:
  push:
    branches: [ "main" ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository
        uses: actions/checkout@v4

      # Optionally set up your language/toolchain
      # - uses: actions/setup-node@v4
      #   with:
      #     node-version: 'lts/*'
      # - uses: actions/setup-python@v5
      #   with:
      #     python-version: '3.x'

      - name: Install dependencies
        run: |
          echo "Install your deps here"
          # e.g., npm ci / pip install -r requirements.txt / mvn -B -q -DskipTests package

      - name: Build
        run: |
          echo "Run your build here"
          # e.g., npm run build / python -m pytest / ./gradlew build
```

### Action componenets

If you are new to GitHub Actions this file looks simple but there are a lot of moving parts. Let's break it down:

```yaml
name: ci
```

This is the name of the workflow. It is used to identify the workflow in the GitHub Actions tab.

```yaml
on:
  push:
    branches: [ "main" ]
```

This is the trigger for the workflow. Think of this as the rules that determin _when_ your action will be triggered. In this case it will run on every push to the branch named `main`.

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
```
This is a job. Jobs are collections of steps that are run together in an isolated VM. You can have multiple jobs in a workflow and they will run in parallel but remember each job runs in its own VM.

```yaml
    steps:
      - name: Check out repository
        uses: actions/checkout@v4
        
      - name: Say hello
        run: echo "Hello, GitHub Actions!"
```
This is a step. Steps are the individual tasks that are run in a job. Each step (each section that starts with a dash) is run in sequence and generally will only move to the next step if the previous step was successful.

In this example we have the two _flavors_ of steps. `uses` and `run`.

`uses` is a shortcut for using an action that is already defined in the GitHub Actions marketplace or in your own repository. Think of this like calling a function.

`run` is a shortcut for running a command in the VM. This is really just running a command in a terminal

With this context modify the scaffold workflow steps "Install dependencies" and "Build" to match your projects. Requirements (ie: if this is a c++ project you will need to install a compiler like `g++` or `clang++` and your build command will be whatever you use to build on your local machine)

Commit and push your changes.

```bash
gh repo view --web 
```

Click on the **Actions** tab to see your workflow running in real-time!

## Step 5: Fix Any Issues (Discovery Learning!)

If your build failed (❌), don't panic! This is where the learning happens:

### Viewing Logs

View workflow runs in terminal
```bash
# List recent runs
gh run list
```

Get details of the most recent run
```bash
# View the latest workflow run status
gh run view
```

View logs of the most recent run
```bash
# See detailed logs of the most recent run
gh run view --log
```

If you do not like looking at logs in your terminal you can also view them in the GitHub Actions tab.

**Common first-run issues and fixes:**

| Issue | What to do |
|-------|------------|
| "Repository not found" or "fatal: not a git repository" | You forgot to include the `actions/checkout@v4` step - this is required to access your code |
| "Build command failed" | Check the error message for specifics - you might need to adjust your build command to match what works on your local machine |
| "Cannot find module" or "Command not found" | You tried to build without installing dependencies first - make sure your workflow installs all required packages before building |

!!! tip "Embrace the ❌"
    **Red builds are learning opportunities!** Every developer deals with failed CI runs. The skill is reading the logs and fixing issues.

## Step 6: Add the Status Badge

Now for the fun part - let's add a shiny badge to your README that shows build status:

1. Navigate to your repo in the GitHub Actions tab

2. On the left hand side click on your workflow (in this case it should be named `ci` but in general it will be the `name` field in your workflow file)

3. On the top right by the search bar click on the `...` icon and select "Create status badge"

4. Copy the markdown and paste it into your README.md

5. Commit and push your changes

!!! success "🏆 Badge of Honor!"
    You now have a professional status badge! Green = healthy project, Red = needs attention.

Check it out! 

```bash
gh repo view --web
```

## Step 7: Test the Workflow

Let's make a small change and watch the automation work:

Make a trivial change
```bash
echo "# Last updated: $(date)" >> README.md
```

Commit and push
```bash
git add README.md
```

```bash
git commit -m "docs: add timestamp to README"
```

```bash
git push
```

Watch the new build
```bash
gh run watch
```

## Checkpoint: Celebrate and Reflect

Take a moment with a partner to discuss:

1. **How does it feel to have automated building?**
2. **What would happen if you accidentally broke your code now?**
3. **How might this help with group projects?**
4. **What signal does a green badge send to someone viewing your repo?**

## Automated Releases

So far you have added automation that verifies your code can compile. This is a great start. But often we need to do something with the result of our build. So let's generate a release.

Add the following to your workflow file under the last step.

```yaml
# Add to your workflow file under the last step
- name: create tag on build id
  run: git tag ${{ github.run_id }}

- name: push tag
  run: git push origin ${{ github.run_id }}

- name: create release
  run: gh release create ${{ github.run_id }} <name of your executable>
  env:
      GH_TOKEN: ${{ github.token }}
```

Let's break down _what_ this is doing:

```yaml
- name: create tag on build id
  run: git tag ${{ github.run_id }}
```

This creates a tag, think of this like a bookmark. Tags must be unique so we will leverage the build id as it is always unique.

```yaml
- name: push tag
  run: git push origin ${{ github.run_id }}
```

This pushes the tag to the remote repository (GitHub). Previously our tag ONLY existed in the VM that was running our workflow.

```yaml
- name: create release
  run: gh release create ${{ github.run_id }} <name of your executable>
  env:
      GH_TOKEN: ${{ github.token }}
```

This creates a release on GitHub. The `<name of your executable>` parameter is the name of the file(s) to include in the release. The `env` parameter is used to pass the GitHub token to the release command. This is needed so the `gh` command running in the temporary VM can authenticate to YOUR repo.

!!! warning "Build ID as Version"
    This is a very simple way to version and generate releases. Typically you would have a more complex versioning strategy like semantic versioning. Using build id as a version is not recommended for production use but we did it here to keep it simple.

### Verify the release

Go to your repo on GitHub and click on the **Releases** tab. You should see your release there.

If you do not see it make sure your workflow is running and completed successfully.

!!! tip "What is a release?"
    A release is a version of your project that is ready to be used. It is a snapshot of your project at a specific point in time. It is a way to share your project with others and to make it available for download. It by default includes a zip and a tarball of your project source code. 

## Mission Accomplished!

Your project now has:

- Automated build checks on every push
- A professional status badge
- Real-time feedback on code quality
- Protection against accidental breakage
- Industry-standard CI/CD practices

**Next Adventure:** [Troubleshooting & Polish](./troubleshooting.md)

---

## Quick Reference

Workflow management:

See recent runs
```bash
gh run list
```

See detailed logs
```bash
gh run view --log
```

Watch current run live
```bash
gh run watch
```

Badge markdown template
```
![build](https://github.com/USERNAME/REPO/actions/workflows/build.yml/badge.svg)
```

## Reflection Questions

- How does automated builds change your confidence in making changes?
- What other tasks could you automate in your development workflow?
- How would you explain the value of CI/CD to a non-technical person?
- What's the first thing you'd check if someone else's project had a red badge?
