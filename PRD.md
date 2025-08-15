<context>
  <workshop>
    <title>Version Control that Works Today: Git & GitHub with CI</title>
    <section>Guided Exercise Path (75–90 min)</section>
    <overview>
      Students learn by doing: creating a new repo, converting an existing project to Git, adding a `.gitignore`, wiring GitHub Actions to verify "things compile" (or minimal checks), and surfacing a status badge in the README. Discovery is guided through short prompts, not long lectures.
    </overview>
  </workshop>

  <audience>
    <participants>
      <profile>College CS/SE students (freshman–junior). Have seen GitHub, may have used it for cloning or downloading code, but not actively managing their own projects with Git. Loosely familiar with git commands but unclear on Git vs. GitHub distinction and the value of version control.</profile>
      <devices>Laptops with terminal access; internet available; Git and gh installable.</devices>
      <motivation>Make coursework safer, more reliable, and resume-visible with CI.</motivation>
    </participants>
    <facilitators>
      <profile>DevOps consulting interns acting as guides, not lecturers.</profile>
      <stance>Socratic: ask leading questions; model debugging; celebrate small wins; timebox interventions.</stance>
    </facilitators>
  </audience>

  <personas>
    <participant_persona>
      <name>Jordan</name>
      <traits>Curious, short attention span, wants immediate payoff, has a half-finished project folder with no history.</traits>
      <prior_knowledge>Knows "git push" vaguely; doesn’t know branches/PRs; confuses Git and GitHub.</prior_knowledge>
    </participant_persona>
    <facilitator_persona>
      <name>Alex (Intern)</name>
      <traits>Confident with Git basics and GitHub Actions; trained to avoid taking keyboards; gives hints; demonstrates fixes live.</traits>
    </facilitator_persona>
  </personas>

\<time\_limits total\_minutes="85"> <phase name="Ground Zero Check" minutes="5"/> <phase name="New Repo from Scratch" minutes="15"/> <phase name="Convert Existing Project" minutes="20"/> <phase name="Automate Build (Actions)" minutes="25"/> <phase name="Add Badge & Polish README" minutes="10"/> <phase name="Buffer & Troubleshooting" minutes="10"/>
\</time\_limits>

  <tools>
    <required>Git, GitHub account, gh (GitHub CLI), GitHub Actions</required>
    <optional>Code editor, language toolchains (Node/Python/Java) if needed for local checks</optional>
  </tools>

\<env\_assumptions>
\<git\_default\_branch>main\</git\_default\_branch> <os>Mix of macOS/Windows/Linux with terminal access</os>
\<repo\_visibility>Public or private acceptable; CI works for both\</repo\_visibility>
\</env\_assumptions>

  <prerequisites>
    <installed>git, gh</installed>
    <authenticated>gh auth login completed during Ground Zero</authenticated>
  </prerequisites>

\<expected\_starting\_point>
Students have at least one project/homework folder **not** under Git. They may also start a tiny scratch project (e.g., one file).
\</expected\_starting\_point>

\<learning\_objectives> <knowledge>
Distinguish Git (local VCS) from GitHub (remote hosting & collaboration).
Explain why VCS matters today for students (safety, collaboration, resume). </knowledge> <skills>
Initialize a repo, commit, push to GitHub using gh; add .gitignore; wire a simple GitHub Actions workflow to validate a project; add the status badge to README; read CI feedback and fix basic failures. </skills> <artifacts>
A GitHub repository with history, .gitignore, a passing build workflow, and a README badge. </artifacts>
\</learning\_objectives>

\<non\_goals>
Deep branching strategies, PR reviews, advanced CI/CD, secrets management, deployment.
\</non\_goals>

  <assessment>
    <success_criteria>
      Repo exists on GitHub; local & remote linked; at least 2–3 meaningful commits; .gitignore present; actions workflow runs on push and passes; badge visible in README; student can articulate the Git vs GitHub difference and one personal value case.
    </success_criteria>
  </assessment>

\<constraints\_and\_risks> <connectivity>Wi-Fi may hiccup; plan for local commits then push later; Actions will run once pushed.</connectivity>
\<tooling\_variance>Students use different languages; provide multiple workflow templates.\</tooling\_variance>
\<time\_management>Strict timeboxes; facilitators use “done is better than perfect.”\</time\_management>
\</constraints\_and\_risks>

  <pedagogy>
    <method>Discovery learning: do → notice → name → reflect. Minimal lecture; frequent checks for understanding; pair checkpoints.</method>
    <feedback>Immediate, via git status/log and CI runs.</feedback>
  </pedagogy>
</context>

---

## Exercises (Participant + Facilitator Notes)

> **Format legend:**
> **Participant Steps** are copy-pasteable.
> *Facilitator Notes* include hints, common errors, and leading questions.
> **Gating Check** = what must be true to move on.
> **Artifact** = files/outputs students should produce.

---

### 0) Ground Zero Check — *5 min*

**Learning goal:** Verify tooling and identity; make success visible early.

**Participant Steps**

```bash
git --version
gh --version

# Set identity if missing (use the same email as your GitHub account):
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# Authenticate gh (choose HTTPS; use web-based login when prompted):
gh auth login
```

**Gating Check**

* `git --version` and `gh --version` show versions.
* `gh auth status` shows you’re logged in.

**Facilitator Notes (hints & gotchas)**

* If `gh auth login` fails, try `gh auth logout` then login again.
* Windows PowerShell quoting issues: prefer double quotes for names/emails.
* If corporate SSO is involved, instruct to use web login flow.

---

### 1) New Repo from Scratch — *15 min*

**Learning goal:** Experience the full init→commit→remote→push loop on a tiny project.

**Prompt:** “Start a brand-new project (one file is enough). Commit it locally, then publish to GitHub.”

**Participant Steps**

```bash
# Create and enter a new project folder
mkdir hello-vcs && cd hello-vcs

# Create a file
printf "# Hello VCS\n\nWhy version control?\n" > README.md

# Initialize repo and make first commit
git init
git add .
git commit -m "chore: initial commit with README"

# Add a basic .gitignore (edit per your stack later)
printf "# OS\n.DS_Store\nThumbs.db\n# Node\nnode_modules/\n# Python\n__pycache__/\n*.pyc\n# Java\n*.class\n" > .gitignore
git add .gitignore
git commit -m "chore: add basic .gitignore"

# Create GitHub repo and push (replace <repo> if prompted)
gh repo create hello-vcs --source=. --private --remote=origin --push
```

**Gating Check**

* Repo exists on GitHub.
* `git log --oneline` shows 2 commits.

**Facilitator Notes**

* If default branch isn’t `main`, set: `git branch -M main`.
* If remote exists: `git remote -v` (rename or remove with `git remote remove origin` then recreate).
* Leading questions: “What lives locally vs. remotely? What changed after `gh repo create … --push`?”

**Artifact**

* GitHub repo with README and `.gitignore`.

---

### 2) Convert an Existing Project to Git — *20 min*

**Learning goal:** Migrate a real, messy folder into Git with a sensible history and remote.

**Prompt:** “Take a homework/personal project not under Git. Give it a history and put it on GitHub.”

**Participant Steps**

```bash
# 1) Go to your existing project (replace path)
cd /path/to/your/existing-project

# 2) Initialize and commit
git init
git add .
git commit -m "feat: import existing project into version control"

# 3) Add a targeted .gitignore (edit for your stack)
# Option A: Start minimal and refine:
printf "# OS\n.DS_Store\nThumbs.db\n# Build outputs\nbuild/\ndist/\nout/\n# Node\nnode_modules/\n# Python\n__pycache__/\n*.pyc\n# Java\n*.class\n" >> .gitignore
git add .gitignore
git commit -m "chore: add .gitignore for common artifacts"

# 4) Create remote and push
gh repo create existing-project --source=. --private --remote=origin --push
```

**Gating Check**

* GitHub repo exists; commits visible.
* Build artifacts (e.g., `node_modules/`, `dist/`, `*.class`) are not tracked.

**Facilitator Notes**

* If GitHub blocks files >100MB, discuss Git LFS briefly or remove large binaries.
* If “updates rejected” on push: `git pull --rebase origin main` (or set upstream first: `git push -u origin main`).
* Leading question: “What belongs in history vs. what can be regenerated?”

**Artifact**

* Real project under version control with appropriate `.gitignore`.

---

### 3) Automate “Does It Compile?” with GitHub Actions — *25 min*

**Learning goal:** Add a simple CI check that runs on every push; see red/green feedback cycle.

**Prompt:** “Add a workflow file that verifies basic health of your project. Choose a template that matches your stack.”

**Participant Steps (choose ONE template below and save as** `.github/workflows/build.yml` **)**

#### Node.js Template

```yaml
name: build
on:
  push:
    branches: [ "**" ]
  pull_request:

jobs:
  node:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 'lts/*'
          cache: 'npm'
      - name: Install
        run: |
          if [ -f package-lock.json ] || [ -f npm-shrinkwrap.json ]; then
            npm ci
          elif [ -f package.json ]; then
            npm install
          else
            echo "No package.json; skipping install."
          fi
      - name: Build or Test
        run: |
          if [ -f package.json ]; then
            npm run build || npm test || echo "No build/test script defined."
          else
            echo "No Node project detected."
          fi
```

#### Python Template

```yaml
name: build
on:
  push:
    branches: [ "**" ]
  pull_request:

jobs:
  python:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with:
          python-version: '3.x'
      - name: Install deps if present
        run: |
          if [ -f requirements.txt ]; then
            python -m pip install --upgrade pip
            pip install -r requirements.txt
          else
            echo "No requirements.txt; continuing."
          fi
      - name: Compile all .py files (sanity check)
        shell: bash
        run: |
          python - <<'PY'
          import compileall, sys
          ok = compileall.compile_dir('.', force=True, quiet=1)
          sys.exit(0 if ok else 1)
          PY
```

#### Java Template (no build tool)

```yaml
name: build
on:
  push:
    branches: [ "**" ]
  pull_request:

jobs:
  java:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          distribution: 'temurin'
          java-version: '21'
      - name: Compile all .java (basic)
        run: |
          files=$(git ls-files '*.java' || true)
          if [ -z "$files" ]; then
            echo "No Java files found."; exit 0
          fi
          javac $files
```

> *Optional*: If using Maven or Gradle, replace the compile step with:
>
> ```yaml
> - name: Build with Maven
>   run: mvn -B -q -DskipTests package
> ```
>
> or
>
> ```yaml
> - name: Build with Gradle
>   run: ./gradlew build || gradle build
> ```

**After creating the file:**

```bash
git add .github/workflows/build.yml
git commit -m "ci: add build workflow"
git push
# Then open the GitHub repo → Actions tab → watch the run
```

**Gating Check**

* A workflow run appears under **Actions** and completes (pass or fail).
* If it fails, fix, commit, and push again, demonstrating red→green.

**Facilitator Notes**

* If Actions tab is disabled, ensure repo is not archived and Actions are allowed.
* For failing runs, prompt students to **read** the log—“What did the runner try? Which command failed?”
* If there’s no obvious build/test, the Python compile or Node “no-op” is acceptable to teach the feedback loop.

**Artifact**

* `.github/workflows/build.yml` committed; a visible Actions run.

---

### 4) Add a Status Badge to README — *10 min*

**Learning goal:** Surface CI status publicly; make quality visible.

**Participant Steps**

1. Go to your repo on GitHub → **Actions** → open the workflow **build** → click the **…** menu → **Create status badge** (or copy the Markdown below and replace placeholders).
2. Insert into `README.md` near the top:

```md
[![Build](https://github.com/<OWNER>/<REPO>/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/<OWNER>/<REPO>/actions/workflows/build.yml)
```

3. Commit and push:

```bash
git add README.md
git commit -m "docs: add CI status badge"
git push
```

**Gating Check**

* Badge renders on the repository homepage and reflects latest run state.

**Facilitator Notes**

* If default branch isn’t `main`, change the `branch=` query parameter.
* Reinforce the narrative: “Green badge = shareable signal on resumes/portfolios.”

**Artifact**

* README with a working status badge.

---

## Pair Checkpoints (after each major step)

* **After Step 1**: Partners confirm repo exists online and two commits exist.
* **After Step 2**: Partners run `git status` to ensure a clean working tree; confirm `.gitignore` took effect.
* **After Step 3**: Partners open each other’s Actions logs; identify the command that ran and one improvement they’d make.
* **After Step 4**: Partners view each other’s README badge and link through to a run.

---

## Reflection Prompts (5 minutes interleaved or at the end)

* In your own words, how is **Git** different from **GitHub**?
* What immediate value do **you** get from version control on coursework?
* What signal does a passing CI badge send to a recruiter or teammate?
* What’s one habit you’ll adopt this week (e.g., smaller commits, better messages, keeping generated files out of history)?

---

## Minimal `.gitignore` Starters

**Node**

```
node_modules/
npm-debug.log*
yarn-error.log*
dist/
build/
.env
```

**Python**

```
__pycache__/
*.py[cod]
*.egg-info/
.venv/
.env
build/
dist/
```

**Java (general)**

```
*.class
target/
out/
build/
*.log
```

> Encourage students to refine `.gitignore` incrementally as they notice noisy files.

---

## Troubleshooting (Fast Fixes)

| Symptom                                | Likely Cause                      | Quick Fix                                                                               |
| -------------------------------------- | --------------------------------- | --------------------------------------------------------------------------------------- |
| `gh: command not found`                | gh not installed                  | Install gh; re-run `gh --version`                                                       |
| `fatal: not a git repository`          | Forgot `git init` or wrong folder | Run `git init` in the project root; check `pwd`                                         |
| `remote origin already exists`         | Re-init on a repo with remote     | `git remote -v`; if needed: `git remote remove origin` then recreate                    |
| Push rejected: “updates were rejected” | Remote has commits you don’t have | `git pull --rebase origin main` (then push), or set upstream: `git push -u origin main` |
| GH blocks >100MB                       | Large files committed             | Remove from history or use Git LFS; add to `.gitignore`                                 |
| Actions not running                    | Workflow file name/path wrong     | Ensure path is `.github/workflows/build.yml`; check YAML syntax                         |
| Badge not rendering                    | Wrong owner/repo/branch           | Use the **Create status badge** UI to copy exact markdown                               |

---

## Quality Bar & Lightweight Rubric

* ✅ **Completeness**: Repo on GitHub, `.gitignore`, workflow file present, badge visible.
* ✅ **Process**: At least one red→green CI iteration.
* ✅ **Understanding**: Student can explain Git vs GitHub and one personal benefit.
* ✅ **Hygiene**: Commit messages are meaningful; no generated/binary junk tracked.

---

## Facilitator Coaching Cues (Socratic, timeboxed)

* “What does `git status` tell you about what Git sees right now?”
* “If we can regenerate it, should it live in history?”
* “What exactly failed in the CI log? Which command? What exit code?”
* “How would you know this repo is healthy from the outside?”

Timebox: if a student is stuck >3 minutes, give a hint or a template; keep momentum.

---

## Post-Workshop Nudge (Optional Homework)

* Add one more project to Git with a tailored `.gitignore` and the same CI.
* Create a branch, make a small change, open a PR, and watch the workflow run on the PR.

---

### Appendix: Command Cheat Sheet

```bash
# Initialize, add, commit
git init
git add .
git commit -m "message"

# Rename default branch to main (if needed)
git branch -M main

# Create GitHub repo from current folder and push
gh repo create <name> --source=. --private --remote=origin --push

# View remotes and logs
git remote -v
git log --oneline --graph --decorate

# Fix common push issue
git pull --rebase origin main
git push -u origin main
```

---

**End of file.**
