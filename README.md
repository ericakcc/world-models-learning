# AI Research Notes

A multi-topic ML/AI research and learning repository.

## Topics

| Topic | Path | Status | Description |
|-------|------|--------|-------------|
| World Models | [`topics/world-models/`](topics/world-models/) | Active | VMC, DreamerV3, DIAMOND, V-JEPA |
| Reinforcement Learning | `topics/reinforcement-learning/` | Planned | PPO, SAC, Model-based RL |
| LLM & Agents | `topics/llm-agents/` | Planned | LLM architectures, tool use |
| Computer Vision | `topics/computer-vision/` | Planned | ViT, Detection, Segmentation |

## Quick Start

```bash
# 1. Setup environment (installs uv if needed)
make setup

# 2. Navigate to a topic and start learning
cd topics/world-models
```

## Project Structure

```
ai-research-notes/
├── topics/
│   ├── world-models/           # World Models research
│   ├── reinforcement-learning/ # (planned)
│   ├── llm-agents/             # (planned)
│   └── computer-vision/        # (planned)
├── pyproject.toml              # Shared Python dependencies
├── Makefile                    # Top-level commands
└── CLAUDE.md                   # Claude Code instructions
```

## Commands

```bash
make setup    # Install uv and sync dependencies
make lint     # Run ruff linter and formatter
make test     # Run pytest
make clean    # Remove generated files
```
