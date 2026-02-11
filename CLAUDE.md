# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal portfolio website for Wouter Jehee (Security Engineer) built with Hugo and TailwindCSS 4.

## Development Commands

```bash
# Enter Nix development environment (provides hugo, tailwindcss, asciidoctor)
nix develop

# Start local dev server with hot reload
just serve

# Build static site to /public
just build
```

## Technology Stack

- **Hugo** (v0.128.0+) - Static site generator
- **TailwindCSS 4** - Styling via Hugo's asset pipeline (no npm required)
- **AsciiDoc** - Content format (via asciidoctor)
- **Nix Flakes** - Reproducible development environment
- **Just** - Task runner

## Architecture

### Content Flow
- Content lives in `content/` as `.adoc` files with TOML front matter
- `content/lorem-ipsum.adoc` is a styling reference page that exercises all AsciiDoc elements (lists, admonitions, code blocks, tables, etc.) — use it to verify CSS changes
- Layouts in `layouts/` define HTML structure, with `baseof.html` as the base template
- `layouts/home.html` is the homepage template
- Partials in `layouts/_partials/` for reusable components

### Asset Pipeline
- `assets/css/main.css` - TailwindCSS entry point with custom theme (Satoshi font, dark zinc palette)
- `assets/js/path.js` - Dynamic SVG path drawing between page sections
- TailwindCSS processes through Hugo's PostCSS integration (configured in `hugo.toml`)

### Hugo Configuration
- `hugo.toml` enables build stats and cache busting for CSS rebuilds
- Security policies allow asciidoctor and tailwindcss execution
- Module mounts configured for assets directory

### Visual Design
- Dark theme with constellation-style social icons using CSS transforms
- Quadratic Bézier curves connect page sections via SVG paths
- Responsive breakpoint at 768px adjusts icon positions
