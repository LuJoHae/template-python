
.PHONY: check lint format typecheck test all

# Run everything
all: format typecheck test

# Ruff lint + format check
lint:
	uv run ruff check .
	uv run ruff format --check .

# Auto-fix lint issues and format
format:
	uv run ruff check --fix .
	uv run ruff format .

# Type checking
typecheck:
	uv run mypy src/

# Tests with coverage
test:
	uv run pytest

# Run all checks (same as `all`)
check: lint typecheck test

# Version management
version:
	uvx hatch version

bump-patch:
	uvx hatch version patch

bump-minor:
	uvx hatch version minor

bump-major:
	uvx hatch version major

release: check
	@VERSION=$$(uvx hatch version); \
	git add src/python_package/__init__.py; \
	git commit -m "chore: bump version to $$VERSION"; \
	git tag "v$$VERSION"; \
	echo "Tagged v$$VERSION. Run 'git push origin main --tags' to release."

rename-package:
	@read -p "Enter the new package name: " NEW_NAME; \
	OLD_NAME="python_package"; \
	mv src/$$OLD_NAME src/$$NEW_NAME && \
	sed -i '' "s/$$OLD_NAME/$$NEW_NAME/g" pyproject.toml && \
	find src/ tests/ docs/ -type f -exec sed -i '' "s/$$OLD_NAME/$$NEW_NAME/g" {} + && \
	echo "Package renamed from $$OLD_NAME to $$NEW_NAME"
