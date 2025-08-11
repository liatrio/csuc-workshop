# csuc-workshop

[![Built with Material for MkDocs](https://img.shields.io/badge/Material_for_MkDocs-526CFE?style=for-the-badge&logo=MaterialForMkDocs&logoColor=white)](https://squidfunk.github.io/mkdocs-material/)

Workshop geared towards college students


## Local Development

### Prerequisites

The following tools will need to be installed:

> OSX users with [Homebrew](https://brew.sh/) installed can install Poetry
> by running the command `make brew`.

- [Make](https://www.gnu.org/software/make/): A build automation tool.
- [Python](https://www.python.org/downloads/): The programming language used
  for development.
- [Poetry](https://python-poetry.org/docs/#installation): A tool for dependency
  management in Python.

### Running the Site Locally

Our site is built using [mkdocs](https://www.mkdocs.org/), a static site
generator optimized for project documentation. It features hot reloading,
allowing immediate preview of changes, and can compile documentation into
static assets for deployment.

To serve the site locally:

- Use `make serve` to start a local server. Your changes can be viewed in
  real-time at http://127.0.0.1:8000.
- To build the documentation, run `make build`. This command generates static
  files and stores them in the `./site` directory.

### Install CSpell  for Code Spell Check

[CSpell]() is a utility used to ensure words in code are spelled correctly.
There are a few ways it'll be run in this repository. 

1. Through GitHub actions

When making a pull request, CSpell will automatically run as an action to
prevent merge of any "code" that has misspelled words.

2. Through Pre Commit Hooks

If you want it to run locally when writing code you can run it through a
pre-commit hook. Simply:
* [install pre-commit](https://pre-commit.com/) via `brew install pre-commit`
  or another means in the docs
* `cd` to the root of this repo
* run `pre-commit install` to install the pre-commit
* once done editing, run `git commit` and it'll run the hooks to validate

3. Through VSCode

If you're a VSCode user, you can install the [Code Spell
Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
extension.

> Note: You made need to point the VSCode extension to the cspell.json file.
> If you have a word that is spelled correctly but is being detected as
> an invalid word, simply add the word to the list of words in the
> [cspell.json](./cspell.json) file.

## Contributing

* **Images** - To add an image, place it under the `docs/img` folder. To
  reference the image use the syntax `![]()` e.g.
  `![example-name](/assets/name-of-the-image)`
* **Content** - To add content, create a new folder under `docs` e.g.
  `docs/Example`. Under `docs/example` create a new markdown file, e.g.
  `docs/example/example-content.md` . 
* **Page Titles** By default, the file name will serve as the title of the
  page. You can override with a H1 header (`#`) or by [setting
  meta-data](https://squidfunk.github.io/mkdocs-material/reference/#setting-the-page-title)
  in the file.
* **MkDocs Documentation** - [Official documentation](https://www.mkdocs.org/)
* **Material Theme Documentation** - The
  [README](https://github.com/squidfunk/mkdocs-material) in this repository
  provides comprehensive instructions on installing MkDocs, configuring the
  Material theme, and using its features and plugins.
* **[Material Theme Customization][custom]** 

[custom]: https://squidfunk.github.io/mkdocs-material/customization/
