# Free Claude — Portable Claude Code Installer

> Run Anthropic's Claude Code on any PC with a single command.

---

## What is This?

This repository contains a **portable, self-contained package** of [Claude Code](https://github.com/anthropics/claude-code) — Anthropic's official CLI coding assistant — with everything you need to install and run it on any computer.

- **Source code** included (leaked build, ~512K lines of TypeScript)
- **Bun runtime** auto-installer
- **Launcher scripts** for Windows and Unix
- **One-step setup** with API key configuration

---

## Quick Start (5 Minutes)

### 1. Prerequisites

| Tool | How to Check | Install If Missing |
|---|---|---|
| **Bun** | `bun --version` | [bun.sh/install](https://bun.sh/install) |
| **Node.js** | `node --version` | [nodejs.org](https://nodejs.org) |
| **Git** | `git --version` | [git-scm.com](https://git-scm.com) |

**Install Bun:**
```bash
# macOS / Linux:
curl -fsSL https://bun.sh/install | bash

# Windows (PowerShell):
powershell -c "irm bun.sh/install.ps1 | iex"
```

### 2. Clone This Repository

```bash
git clone https://github.com/YashikaTech-25/Free-Claude.git
cd Free-Claude
```

### 3. Set Your API Key

Create a `.env` file in the repository root:

```bash
# Copy the template
cp .env.example .env

# Edit .env and add your Anthropic API key
# Get it at: https://console.anthropic.com/settings/keys
```

Your `.env` file should look like:
```
ANTHROPIC_API_KEY=sk-ant-...
NVIDIA_API_KEY=nvapi-...          # optional
```

### 4. Install Dependencies

```bash
bun install
```

This downloads ~367 packages. Takes 1–2 minutes.

### 5. Run Claude Code

```bash
# Interactive session
./claude-code.sh          # macOS / Linux / Git Bash
claude-code.bat           # Windows Command Prompt

# One-shot mode (print and exit)
./claude-code.sh -p "Write a Python script to sort a list"
```

---

## Repository Structure

```
Free-Claude/
├── claude-code/          # Full source code (~512K lines, 2,000+ files)
│   ├── src/              # TypeScript source
│   ├── plugins/          # Bun plugins
│   ├── stubs/            # Stubbed internal modules
│   ├── package.json      # Dependencies
│   ├── bunfig.toml       # Bun config
│   └── tsconfig.json     # TypeScript config
├── claude-code.sh        # Unix launcher (Git Bash, Linux, macOS)
├── claude-code.bat       # Windows launcher
├── .env.example          # API key template
├── .gitignore            # Excludes .env and node_modules
├── README.md             # This file
├── package.json          # Root package (same as claude-code/)
├── bun.lock              # Lockfile
├── bunfig.toml           # Bun config
└── tsconfig.json         # TypeScript config
```

---

## Launcher Scripts

Both scripts handle:
- **Bun path detection** — auto-finds `~/.bun/bin`
- **API key loading** — reads from `.env` or environment
- **Missing key validation** — warns and shows setup instructions
- **Argument passthrough** — forwards all CLI flags to Claude Code

### Unix (Git Bash / Linux / macOS)

```bash
./claude-code.sh [options]

# Examples:
./claude-code.sh                    # Interactive mode
./claude-code.sh -p "Hello Claude"  # Print mode
./claude-code.sh --help             # Show all options
./claude-code.sh --version          # Show version
```

### Windows (Command Prompt)

```batch
claude-code.bat [options]

REM Examples:
claude-code.bat                     :: Interactive mode
claude-code.bat -p "Hello Claude"   :: Print mode
claude-code.bat --help              :: Show all options
claude-code.bat --version           :: Show version
```

---

## Environment Variables

| Variable | Required | Description |
|---|---|---|
| `ANTHROPIC_API_KEY` | **Yes** | Your Anthropic API key ([get one](https://console.anthropic.com/settings/keys)) |
| `NVIDIA_API_KEY` | No | NVIDIA NIM / NeMo API key (for GPU-accelerated inference) |

Set them in `.env` (recommended) or export before running:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
export NVIDIA_API_KEY="nvapi-..."
```

---

## Development Commands

```bash
# Run with hot reload
bun run dev

# TypeScript type check
bun run typecheck

# Build production bundle
bun run build

# Run tests
bun test
```

---

## Troubleshooting

### "Bun not found"
Bun is not installed or not in PATH. Run the Bun installer and add `~/.bun/bin` to your PATH.

### "ANTHROPIC_API_KEY not set"
Create a `.env` file with your key, or set the environment variable before running.

### "Build fails with missing dependencies"
Some optional packages (OpenTelemetry, Azure SDK, Sharp) are dynamically loaded. Install them individually if needed:
```bash
bun add @opentelemetry/exporter-trace-otlp-http
```

### "Windows: 'bun' is not recognized"
Use Git Bash, or add `C:\Users\<YOU>\.bun\bin` to your Windows PATH.

---

## License & Disclaimer

This repository archives source code that was leaked from Anthropic's npm registry on **2026-03-31**. All original source code is the property of [Anthropic](https://www.anthropic.com).

This repository is provided for educational and research purposes only. The package includes stubbed replacements for proprietary Anthropic-internal modules (`@ant/*`, `@anthropic-ai/mcpb`, etc.) that were not part of the leak.

---

## Credits

- Original source: [Anthropic](https://www.anthropic.com) — Claude Code CLI
- Leaked & archived: [tanbiralam/claude-code](https://github.com/tanbiralam/claude-code)
- Portable installer: [YashikaTech-25/Free-Claude](https://github.com/YashikaTech-25/Free-Claude)

---

**Happy coding! 🚀**
