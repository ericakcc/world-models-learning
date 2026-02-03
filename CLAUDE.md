# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A structured learning project for World Models research, progressing through 4 phases:
1. **Foundations** - VMC architecture (VAE + RNN) with CarRacing
2. **Standard** - DreamerV3 RSSM framework with Atari 100k
3. **High-Fidelity** - Diffusion models (DIAMOND) for neural simulation
4. **Advanced** - V-JEPA and driving world models with OpenDV

## Commands

```bash
# Quick setup
make setup                       # Install uv + sync dependencies
make papers                      # Download all 6 papers from arXiv

# Code quality
make lint                        # Run ruff check --fix + format
make test                        # Run pytest -v
make clean                       # Remove .venv, __pycache__, etc.

# Direct uv commands
uv add <package>                 # Add dependency
uv add --dev <package>           # Add dev dependency
uv run pytest -k "test_name"     # Run specific test
```

## Project Structure

- `experiments/01_car_racing/` - Phase 1: VAE + RNN implementation
- `experiments/02_dreamerv3_atari/` - Phase 2: DreamerV3 on Atari
- `experiments/03_diamond_diffusion/` - Phase 3: Diffusion world model
- `experiments/04_opendv_driving/` - Phase 4: Driving world model
- `papers/` - Research papers organized by phase (PDFs gitignored)
- `notes/` - Reading notes organized by phase
- `docs/` - Reference documents (Chinese)
- `datasets/` - Training data (gitignored, large files)
- `scripts/` - Utility scripts (download_papers.sh)

## Key Reference Repositories

When implementing experiments, reference these codebases:
- Phase 1: `world-models-jax` (JAX/Equinox)
- Phase 2: `danijar/dreamerv3` (official JAX) or `NM512/dreamerv3-torch`
- Phase 3: `eloialonso/diamond` (Diffusion world model)
- Phase 4: `facebookresearch/jepa`, `wayveai/mile`
