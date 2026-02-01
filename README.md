# World Models Learning

A structured learning project for studying and implementing World Models research.

## Learning Path

| Phase | Focus | Paper | Implementation |
|-------|-------|-------|----------------|
| 1. Foundations | VMC Architecture | World Models (2018) | CarRacing VAE+RNN |
| 2. Standard | RSSM Framework | DreamerV3 (2023) | Atari 100k |
| 3. High-Fidelity | Neural Simulators | Genie + GameNGen | DIAMOND |
| 4. Advanced | JEPA & Pre-training | V-JEPA + GAIA-1 | OpenDV Driving |

## Project Structure

```
papers/          # Research papers (PDF)
notes/           # Reading notes (Markdown)
experiments/     # Implementation code
datasets/        # Training data (gitignored)
docs/            # Reference documents
resources/       # Learning resources
```

## Quick Start

```bash
# 1. Setup environment (installs uv if needed)
make setup

# 2. Download all papers (~90MB)
make papers

# 3. Start learning from Phase 1!
```

### Manual Setup

If you prefer not to use Make:

```bash
# Install uv (if not installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Sync dependencies
uv sync

# Download papers
./scripts/download_papers.sh
```

### Other Commands

```bash
make lint    # Run ruff linter and formatter
make test    # Run pytest
make clean   # Remove generated files
```

## Papers

1. **World Models** - [arXiv:1803.10122](https://arxiv.org/abs/1803.10122)
2. **DreamerV3** - [arXiv:2301.04104](https://arxiv.org/abs/2301.04104)
3. **Genie** - [arXiv:2402.15391](https://arxiv.org/abs/2402.15391)
4. **GameNGen** - [arXiv:2408.14859](https://arxiv.org/abs/2408.14859)
5. **V-JEPA** - [arXiv:2404.08471](https://arxiv.org/abs/2404.08471)
6. **GAIA-1** - [arXiv:2309.17080](https://arxiv.org/abs/2309.17080)

## Reference Repositories

- [world-models-jax](https://github.com/Sha01in/world-models-jax)
- [dreamerv3](https://github.com/danijar/dreamerv3)
- [diamond](https://github.com/eloialonso/diamond)
- [DriveAGI](https://github.com/OpenDriveLab/DriveAGI)
