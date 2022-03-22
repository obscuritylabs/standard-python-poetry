# Configurable Variables

VENV := .venv

# Computed Variables (Don't touch or modify!!!)

VENVTOUCHFILE := $(VENV)/touchfile
HOOKTOUCHFILE := .git/hooks/touchfile

# Primary Targets

.PHONY: all
all:| lint test

.PHONY: lint
lint: $(HOOKTOUCHFILE)
	pre-commit run --all-files

.PHONY: test
test: $(VENVTOUCHFILE)
	poetry run pytest

.PHONY: clean
clean:
	git clean -dfX

# Secondary Targets

$(HOOKTOUCHFILE): $(VENVTOUCHFILE) .pre-commit-config.yaml
	poetry run pre-commit install --install-hooks -t pre-commit -t commit-msg
	touch $@

poetry.lock: pyproject.toml
	poetry lock --no-update --no-interaction && touch poetry.lock

$(VENVTOUCHFILE): poetry.lock
	poetry install --no-interaction
	touch $@
