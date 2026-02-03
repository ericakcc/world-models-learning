#!/bin/bash
# Scaffold a new research topic directory structure
#
# Usage:
#   scaffold_topic.sh <topic-slug> <phase-slug-1> [phase-slug-2] ...
#
# Example:
#   scaffold_topic.sh reinforcement-learning 01_foundations 02_policy_gradient 03_actor_critic 04_model_based
#
# Creates:
#   topics/<topic-slug>/
#   ├── papers/<phase>/        (with .gitkeep)
#   ├── notes/<phase>/         (with .gitkeep)
#   ├── experiments/<phase>/   (with src/.gitkeep, notebooks/.gitkeep)
#   ├── datasets/              (with .gitkeep)
#   ├── docs/                  (with .gitkeep)
#   ├── resources/             (empty, will be filled by Claude)
#   └── scripts/               (empty, will be filled by Claude)

set -euo pipefail

# --- Validation ---
if [ $# -lt 2 ]; then
    echo "Usage: scaffold_topic.sh <topic-slug> <phase-slug-1> [phase-slug-2] ..."
    echo ""
    echo "Example:"
    echo "  scaffold_topic.sh reinforcement-learning 01_foundations 02_policy_gradient"
    exit 1
fi

TOPIC_SLUG="$1"
shift
PHASES=("$@")

# Find project root (look for pyproject.toml)
PROJECT_ROOT=""
SEARCH_DIR="$(pwd)"
while [ "$SEARCH_DIR" != "/" ]; do
    if [ -f "$SEARCH_DIR/pyproject.toml" ]; then
        PROJECT_ROOT="$SEARCH_DIR"
        break
    fi
    SEARCH_DIR="$(dirname "$SEARCH_DIR")"
done

if [ -z "$PROJECT_ROOT" ]; then
    echo "Error: Could not find project root (no pyproject.toml found)."
    echo "Run this script from within the ai-research-notes project."
    exit 1
fi

TOPIC_DIR="$PROJECT_ROOT/topics/$TOPIC_SLUG"

# Check if topic already exists
if [ -d "$TOPIC_DIR" ]; then
    echo "Error: Topic directory already exists: $TOPIC_DIR"
    exit 1
fi

echo "Scaffolding topic: $TOPIC_SLUG"
echo "  Location: $TOPIC_DIR"
echo "  Phases: ${PHASES[*]}"
echo ""

# --- Create directories ---

# Phase-based directories
for phase in "${PHASES[@]}"; do
    mkdir -p "$TOPIC_DIR/papers/$phase"
    touch "$TOPIC_DIR/papers/$phase/.gitkeep"

    mkdir -p "$TOPIC_DIR/notes/$phase"
    touch "$TOPIC_DIR/notes/$phase/.gitkeep"

    mkdir -p "$TOPIC_DIR/experiments/$phase/src"
    touch "$TOPIC_DIR/experiments/$phase/src/.gitkeep"
    mkdir -p "$TOPIC_DIR/experiments/$phase/notebooks"
    touch "$TOPIC_DIR/experiments/$phase/notebooks/.gitkeep"
done

# Shared directories
mkdir -p "$TOPIC_DIR/datasets"
touch "$TOPIC_DIR/datasets/.gitkeep"

mkdir -p "$TOPIC_DIR/docs"
touch "$TOPIC_DIR/docs/.gitkeep"

mkdir -p "$TOPIC_DIR/resources"
mkdir -p "$TOPIC_DIR/scripts"

echo "Created directory structure:"
echo ""

# Display tree (use find if tree not available)
if command -v tree &>/dev/null; then
    tree "$TOPIC_DIR" --dirsfirst
else
    find "$TOPIC_DIR" -type f | sort | while read -r f; do
        echo "  ${f#$PROJECT_ROOT/}"
    done
fi

echo ""
echo "Scaffold complete! Next: Claude will generate CLAUDE.md, README.md, Makefile, etc."
