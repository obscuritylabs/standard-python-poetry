# Configurable Variables

PYTHON := python3.10
VENV := .venv

# Computed Variables (Don't touch or modify!!!)

BIN := $(VENV)/bin
VPYTHON := $(BIN)/$(PYTHON)
PIP := $(BIN)/pip
PYTEST := $(BIN)/pytest
VENVTOUCHFILE := $(VENV)/touchfile
HOOKTOUCHFILE := .git/hooks/touchfile

# Primary Targets

.PHONY: all
all:| lint test

.PHONY: lint
lint: $(HOOKTOUCHFILE)
	pre-commit run --all-files

.PHONY: test
test: $(PYTEST)
	$(PYTEST)

.PHONY: clean
clean:
	git clean -dfX

# Secondary Targets

$(PYTEST): $(VENVTOUCHFILE)

$(HOOKTOUCHFILE): .pre-commit-config.yaml
	pre-commit install --install-hooks -t pre-commit -t commit-msg
	touch $@

$(PIP): $(VENV)

$(VENVTOUCHFILE): $(PIP)
	$(PIP) install -e ".[dev]"
	touch $@

$(VENV):
	$(PYTHON) -m venv $@
