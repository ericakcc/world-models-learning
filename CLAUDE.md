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
# Environment
uv sync                          # Sync dependencies
uv add <package>                 # Add dependency
uv add --dev <package>           # Add dev dependency

# Code quality
uv run ruff check . --fix        # Lint and fix
uv run ruff format .             # Format code

# Testing
uv run pytest                    # Run all tests
uv run pytest tests/ -v          # Verbose
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

## Key Reference Repositories

When implementing experiments, reference these codebases:
- Phase 1: `world-models-jax` (JAX/Equinox)
- Phase 2: `danijar/dreamerv3` (official JAX) or `NM512/dreamerv3-torch`
- Phase 3: `eloialonso/diamond` (Diffusion world model)
- Phase 4: `facebookresearch/jepa`, `wayveai/mile`
