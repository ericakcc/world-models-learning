.PHONY: setup papers lint test clean

# First-time setup
setup:
	@command -v uv >/dev/null 2>&1 || { echo "Installing uv..."; curl -LsSf https://astral.sh/uv/install.sh | sh; }
	uv sync
	@echo "✓ Environment ready"

# Download all papers
papers:
	@chmod +x scripts/download_papers.sh
	@./scripts/download_papers.sh

# Code quality
lint:
	uv run ruff check . --fix
	uv run ruff format .

# Run tests
test:
	uv run pytest -v

# Clean generated files
clean:
	rm -rf .venv __pycache__ .pytest_cache .ruff_cache
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
