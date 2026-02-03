# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A multi-topic ML/AI research and learning repository. Each topic is organized as a self-contained sub-project under `topics/`.

## Topics

| Topic | Path | Status |
|-------|------|--------|
| World Models | `topics/world-models/` | Active |
| Reinforcement Learning | `topics/reinforcement-learning/` | Planned |
| LLM & Agents | `topics/llm-agents/` | Planned |
| Computer Vision | `topics/computer-vision/` | Planned |

## Commands

```bash
# Quick setup
make setup                       # Install uv + sync dependencies
make lint                        # Run ruff check --fix + format
make test                        # Run pytest -v
make clean                       # Remove .venv, __pycache__, etc.

# Direct uv commands
uv add <package>                 # Add dependency
uv add --dev <package>           # Add dev dependency
uv run pytest -k "test_name"     # Run specific test
```

## Project Structure

```
ai-research-notes/
├── topics/
│   ├── world-models/           # World Models research
│   │   ├── experiments/        # Implementation code
│   │   ├── papers/             # Research papers
│   │   ├── notes/              # Reading notes
│   │   └── ...
│   ├── reinforcement-learning/ # (planned)
│   ├── llm-agents/             # (planned)
│   └── computer-vision/        # (planned)
├── pyproject.toml              # Shared dependencies
└── Makefile                    # Top-level commands
```

## Topic-Specific Instructions

Each topic has its own `CLAUDE.md` with detailed instructions. When working on a specific topic, refer to:
- `topics/world-models/CLAUDE.md` for World Models
