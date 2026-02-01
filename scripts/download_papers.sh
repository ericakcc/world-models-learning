#!/bin/bash
# Download all research papers from arXiv

set -e

echo "Downloading World Models papers..."

# Phase 1: Foundations
curl -L "https://arxiv.org/pdf/1803.10122.pdf" -o papers/01_foundations/world_models_2018.pdf
echo "✓ World Models (2018)"

# Phase 2: Standard
curl -L "https://arxiv.org/pdf/2301.04104.pdf" -o papers/02_standard/dreamerv3_2023.pdf
echo "✓ DreamerV3 (2023)"

# Phase 3: High-Fidelity
curl -L "https://arxiv.org/pdf/2402.15391.pdf" -o papers/03_high_fidelity/genie_2024.pdf
echo "✓ Genie (2024)"

curl -L "https://arxiv.org/pdf/2408.14859.pdf" -o papers/03_high_fidelity/gamengen_2024.pdf
echo "✓ GameNGen (2024)"

# Phase 4: Advanced
curl -L "https://arxiv.org/pdf/2404.08471.pdf" -o papers/04_advanced/v_jepa_2024.pdf
echo "✓ V-JEPA (2024)"

curl -L "https://arxiv.org/pdf/2309.17080.pdf" -o papers/04_advanced/gaia1_2023.pdf
echo "✓ GAIA-1 (2023)"

echo ""
echo "All papers downloaded successfully!"
