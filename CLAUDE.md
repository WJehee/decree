# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal website for wouterjehee.com, built with Hugo, TailwindCSS v4, and AsciiDoc content.

## Commands

- `just serve` — Start dev server (serves drafts with `-D` flag)
- `just build` — Build the site with Hugo
- `nix build` — Full production build (Hugo + Tailwind + Asciidoctor, minified)
- `nix develop` — Enter dev shell with hugo, tailwindcss_4, asciidoctor

## Architecture

- **Content format**: All content is written in AsciiDoc (`.adoc`), not Markdown. Hugo renders it via asciidoctor with Rouge syntax highlighting.
- **Styling**: TailwindCSS v4 with `@import "tailwindcss"` in `assets/css/main.css`. Uses `hugo_stats.json` for class purging. The `.prose` component class in main.css provides all typography/content styling for AsciiDoc output.
- **Theme**: Light/dark mode with View Transitions API. Light uses Libre Baskerville (serif), dark uses Satoshi (sans-serif). Default is dark.
- **Layouts**: Custom Hugo layouts (no theme). `layouts/baseof.html` is the shell; `layouts/_default/` has list/single templates; `layouts/_partials/` has nav, footer, tailwind.
- **Deployment**: GitHub Actions runs `nix build`, then rsync to a remote server.

## Content conventions

- Blog posts go in `content/posts/` as `.adoc` files
- Multi-part series use separate files with a shared name prefix (e.g., `niks-to-nix.adoc`, `niks-to-nix-auth.adoc`, `niks-to-nix-deployment.adoc`)
- Front matter uses TOML (`+++` delimiters) with Hugo's standard fields
