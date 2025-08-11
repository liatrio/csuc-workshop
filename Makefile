TEMP_PATH :=  $(CURDIR)/tmp


.PHONY: poetry-install
poetry-install:
	poetry install --no-root

.PHONY: build
build: poetry-install
	poetry run mkdocs build

.PHONY: serve
serve: poetry-install
	poetry run mkdocs serve

.PHONY: brew
brew:
	brew bundle --force

# TODO: The techdocs cli spins up a container which will need any Python
# plugins installed in it in order to serve this site. Currently does not work.
# Replace this with our backstage container for local integration checking.
.PHONY: backstage
backstage:
	npx @techdocs/cli serve -v
