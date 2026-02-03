# Templates for New Research Topic

Below are template skeletons for each file that Claude should generate when creating a new research topic. Replace all `{{PLACEHOLDER}}` values with actual content based on the user's requirements.

---

## 1. Topic CLAUDE.md

```markdown
# CLAUDE.md - {{Topic Display Name}}

This file provides guidance to Claude Code when working with the {{Topic Display Name}} topic.

## Topic Overview

{{1-2 paragraph description of the topic, its scope, and learning goals. Include the number of phases and their names.}}

## Commands

\```bash
# From this directory (topics/{{topic-slug}}/)
make papers                      # Download all papers from arXiv

# From project root
make lint                        # Run ruff check --fix + format
make test                        # Run pytest -v
\```

## Structure

{{List each experiment directory with phase number and description, e.g.:}}
- `experiments/01_foundations/` - Phase 1: {{description}}
- `experiments/02_xxx/` - Phase 2: {{description}}
- `papers/` - Research papers organized by phase (PDFs gitignored)
- `notes/` - Reading notes organized by phase
- `docs/` - Reference documents
- `datasets/` - Training data (gitignored, large files)
- `scripts/` - Utility scripts (download_papers.sh)

## Key Reference Repositories

When implementing experiments, reference these codebases:
{{List key repos per phase, e.g.:}}
- Phase 1: `org/repo` (description)
- Phase 2: `org/repo` (description)
```

---

## 2. Topic README.md

```markdown
# {{Topic Display Name}}: {{Subtitle}}

{{1-2 sentence overview of the topic and its goal.}}

## Learning Path

| Phase | Focus | Papers | Implementation |
|-------|-------|--------|----------------|
{{One row per phase, e.g.:}}
| 1. Foundations | {{focus}} | {{paper1}}, {{paper2}} | {{implementation goal}} |
| 2. XXX | {{focus}} | {{paper3}} | {{implementation goal}} |

## Structure

\```
{{topic-slug}}/
├── papers/          # Research papers (PDF)
├── notes/           # Reading notes (Markdown)
├── experiments/     # Implementation code
├── datasets/        # Training data (gitignored)
├── docs/            # Reference documents
├── resources/       # Learning resources
└── scripts/         # Utility scripts
\```

## Quick Start

\```bash
# Download all papers
make papers

# Start learning from Phase 1!
\```

## Papers

{{Numbered list of all papers with arXiv links, organized by phase, e.g.:}}

### {{Phase 1 Name}}

1. **Paper Name** - [arXiv:XXXX.XXXXX](https://arxiv.org/abs/XXXX.XXXXX) - Short description (year)

### {{Phase 2 Name}}

2. **Paper Name** - [arXiv:XXXX.XXXXX](https://arxiv.org/abs/XXXX.XXXXX) - Short description (year)

## Reference Repositories

{{List of key GitHub repos with links and descriptions}}
- [org/repo](https://github.com/org/repo) - Description
```

---

## 3. Topic Makefile

```makefile
.PHONY: papers

papers:
	@chmod +x scripts/download_papers.sh
	@./scripts/download_papers.sh
```

---

## 4. Experiment README.md

One per experiment directory (`experiments/<phase_slug>/README.md`).

```markdown
# Phase {{N}}: {{Phase Title}}

## Experiment Goal

{{1-2 sentences describing what will be built/learned in this phase.}}

## Covered Papers

| Paper | Key Contribution |
|-------|-----------------|
| **{{Paper Name}}** ({{year}}) | {{one-line summary of contribution}} |

## Implementation Steps

### {{Sub-section 1}}
1. {{Step 1}}
2. {{Step 2}}
3. {{Step 3}}

### {{Sub-section 2}}
1. {{Step 1}}
2. {{Step 2}}

## Key Learning Points

- **{{Concept 1}}**: {{Why it matters}}
- **{{Concept 2}}**: {{Why it matters}}
- **{{Concept 3}}**: {{Why it matters}}
```

---

## 5. download_papers.sh

```bash
#!/bin/bash
# Download all research papers from arXiv

set -e

echo "Downloading {{Topic Display Name}} papers..."

# Phase 1: {{Phase Name}}
curl -L "https://arxiv.org/pdf/{{arxiv_id}}.pdf" -o papers/{{phase_slug}}/{{filename}}.pdf
echo "✓ {{Paper Name}} ({{year}})"

{{Repeat for each paper...}}

# Phase N: {{Phase Name}}
curl -L "https://arxiv.org/pdf/{{arxiv_id}}.pdf" -o papers/{{phase_slug}}/{{filename}}.pdf
echo "✓ {{Paper Name}} ({{year}})"

echo ""
echo "All papers downloaded successfully! ({{count}} PDFs)"
{{If some papers have no arXiv PDF, add a note:}}
# echo "Note: {{Paper Name}} has no arXiv PDF — see notes files."
```

---

## 6. code_repos.md

```markdown
# Reference Repositories

## {{Category 1}}

| Repo | URL | Notes |
|------|-----|-------|
| {{org/repo}} | https://github.com/{{org/repo}} | {{description}} |

## {{Category 2}}

| Repo | URL | Notes |
|------|-----|-------|
| {{org/repo}} | https://github.com/{{org/repo}} | {{description}} |

## Datasets

| Dataset | URL | Size | Notes |
|---------|-----|------|-------|
| {{name}} | {{url}} | {{size}} | {{description}} |
```

---

## 7. learning_log.md

```markdown
# Learning Progress Log

## Phase 1: {{Phase Name}}

### {{Paper Name}} ({{Author}}, {{year}})

- [ ] First pass: Abstract, Conclusion, Figures
- [ ] Second pass: {{Key technical details to understand}}
- [ ] Understand: {{Core concept 1}}
- [ ] Understand: {{Core concept 2}}
- [ ] Implementation: {{What to build}}
- [ ] Checkpoint: {{Measurable completion criteria}}

{{Repeat for each paper in the phase...}}

---

## Phase 2: {{Phase Name}}

### {{Paper Name}} ({{Author}}, {{year}})

- [ ] First pass: {{focus}}
- [ ] Understand: {{concept}}
- [ ] Implementation: {{what to build}}
- [ ] Checkpoint: {{criteria}}

{{Continue for all phases...}}
```
