# Makefile with helpful CLI commands

PRE_COMMIT_HOOKS = .git/hooks/pre-commit
PRE_PUSH_HOOKS = .git/hooks/pre-push
COMMIT_MSG_HOOKS = .git/hooks/commit-msg

.PHONY: all
all: install-git-hooks test-update lint test

.PHONY: help
help:
	@echo "Available commands:"
	@echo "  make all              Run hooks install, tests, and lint"
	@echo "  make lint             Run all pre-commit hooks on all files"
	@echo "  make fix              Auto-fix issues where possible using pre-commit"
	@echo "  make test             Run project tests"
	@echo "  make test-update      Update test fixtures"
	@echo "  make update           Run the release update script"
	@echo "  make install-git-hooks Install all pre-commit hooks"

.PHONY: lint
lint: install-git-hooks
	@pre-commit run -a -v

.PHONY: fix
fix: install-git-hooks
	@pre-commit run -a -v --hook-stage manual

.PHONY: shell
shell:
	@./tests/run-tests.sh

.PHONY: test-update
test-update:
	@./tests/update.sh

.PHONY: update
update:
	@./scripts/update-release.sh asdf

.PHONY: install-git-hooks
install-git-hooks: $(PRE_COMMIT_HOOKS) $(PRE_PUSH_HOOKS) $(COMMIT_MSG_HOOKS)

$(PRE_COMMIT_HOOKS):
	@pre-commit install --install-hooks

$(PRE_PUSH_HOOKS):
	@pre-commit install --install-hooks -t pre-push

$(COMMIT_MSG_HOOKS):
	@pre-commit install --install-hooks -t commit-msg

ROLE_NAME = $(shell basename $(CURDIR))

.PHONY: lint test converge verify destroy clean

## Run full Molecule test (destroy, create, converge, verify, destroy)
test:
	@echo "🧪 Running full Molecule test..."
	molecule test

## Create and converge the instance
converge:
	@echo "⚙️  Creating and converging..."
	molecule converge

## Verify role after convergence
verify:
	@echo "🔍 Verifying..."
	molecule verify

## Destroy the instance
destroy:
	@echo "💣 Destroying..."
	molecule destroy

## Clean Molecule state (destroy)
clean: destroy

## Reset Molecule environment (destroy + create)
reset:
	@echo "🔄 Resetting Molecule environment..."
	molecule destroy
	molecule create

## Show role name
name:
	@echo "📦 Role: $(ROLE_NAME)"
