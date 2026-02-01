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
# Sync Python environment
uv sync

# Run tests
uv run pytest
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
