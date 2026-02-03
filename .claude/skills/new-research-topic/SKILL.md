---
name: new-research-topic
description: Scaffold and populate a new research topic under topics/ in the ai-research-notes repository. Use when the user asks to add a new research area, learning topic, or study project (e.g. "help me add a reinforcement learning topic").
---

# New Research Topic

## Overview

This skill standardizes the process of adding a new research topic to the `ai-research-notes` repository. It creates the full directory structure, generates all documentation files (CLAUDE.md, README.md, Makefile, experiment READMEs, download script, resources), and updates the root CLAUDE.md to register the new topic.

## Workflow

Follow these 7 steps in order. Each step builds on the previous one.

### Step 1: Gather Requirements

Ask the user for the following information. Use `AskUserQuestion` or conversational clarification as needed.

**Required:**
- **Topic name** — display name (e.g. "Reinforcement Learning") and slug (e.g. `reinforcement-learning`)
- **Phases** — numbered learning phases with slugs (e.g. `01_foundations`, `02_policy_gradient`, `03_actor_critic`, `04_model_based`)
- **Papers** — list of key papers per phase (title, arXiv ID if available, year)
- **Learning goal** — what the user wants to achieve (interview prep, research, project, etc.)

**Optional (can be inferred):**
- Key reference repositories
- Datasets
- Specific implementation goals per phase

### Step 2: Run Scaffold Script

Execute the scaffold script to create the directory structure:

```bash
.claude/skills/new-research-topic/scripts/scaffold_topic.sh <topic-slug> <phase1> <phase2> ...
```

Example:
```bash
.claude/skills/new-research-topic/scripts/scaffold_topic.sh reinforcement-learning 01_foundations 02_policy_gradient 03_actor_critic 04_model_based
```

This creates the full directory tree under `topics/<topic-slug>/` with all phase-based subdirectories and `.gitkeep` files.

**Verify** the output shows the expected directory structure before proceeding.

### Step 3: Write CLAUDE.md + README.md + Makefile

Read `references/templates.md` from this skill for the template skeletons, then generate three files:

1. **`topics/<topic-slug>/CLAUDE.md`** — Claude Code guidance for the topic
2. **`topics/<topic-slug>/README.md`** — Human-readable overview with learning path table and paper list
3. **`topics/<topic-slug>/Makefile`** — `make papers` target

Fill in all `{{PLACEHOLDER}}` values from the templates with the actual topic content gathered in Step 1.

**Key points:**
- CLAUDE.md should list all experiment directories with descriptions
- README.md should include the full paper list with arXiv links
- Makefile only needs the `papers` target (same pattern as other topics)

### Step 4: Write Experiment READMEs

For each phase/experiment directory, create `experiments/<phase_slug>/README.md` using the Experiment README template.

Each README should include:
- Experiment goal (what will be built/learned)
- Covered papers table
- Implementation steps (specific, actionable)
- Key learning points

**Make the content specific** — don't just copy the template. Tailor implementation steps and learning points to the actual papers and goals for that phase.

### Step 5: Write download_papers.sh

Create `topics/<topic-slug>/scripts/download_papers.sh` using the template.

- One `curl` command per paper that has an arXiv PDF
- Output path matches the phase directory structure: `papers/<phase_slug>/<filename>.pdf`
- Add notes for papers without arXiv PDFs (e.g. GitHub-only releases)
- Make the script executable (`chmod +x`)

### Step 6: Write Resources + Notes Skeleton

Create two files in `topics/<topic-slug>/resources/`:

1. **`code_repos.md`** — Reference repositories organized by category, with datasets table
2. **`learning_log.md`** — Checkbox-based progress tracker for every paper and implementation task

**learning_log.md checklist pattern per paper:**
- First pass: Abstract, Conclusion, Figures
- Second pass: Key technical details
- Understand: Core concepts (2-3 items)
- Implementation: What to build
- Checkpoint: Measurable completion criteria

### Step 7: Update Root CLAUDE.md

Add the new topic to the Topics table in the project root `CLAUDE.md`:

```markdown
| {{Topic Display Name}} | `topics/{{topic-slug}}/` | Active |
```

Also add a reference to the topic's CLAUDE.md in the "Topic-Specific Instructions" section:

```markdown
- `topics/{{topic-slug}}/CLAUDE.md` for {{Topic Display Name}}
```

## Resources

### scripts/

- **`scaffold_topic.sh`** — Creates the full directory tree for a new topic. Accepts topic slug and phase slugs as arguments. Run this in Step 2.

### references/

- **`templates.md`** — Template skeletons for all files that need to be generated (CLAUDE.md, README.md, Makefile, experiment README, download_papers.sh, code_repos.md, learning_log.md). Read this in Step 3 to fill in content.
