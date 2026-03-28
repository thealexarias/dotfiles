# dotfiles

My macOS configuration files.

## What's Included

| File | Purpose |
|------|---------|
| `.zshrc` | Zsh config (Oh My Zsh, aliases, fastfetch) |
| `.zprofile` | PATH setup (Python, NVM, Homebrew) |
| `.gitconfig` | Git user identity and editor |
| `.aerospace.toml` | AeroSpace tiling window manager |
| `.config/gh/config.yml` | GitHub CLI preferences |
| `.config/neofetch/config.conf` | Neofetch display config |
| `.config/ghostty/config` | Ghostty terminal config |
| `Brewfile` | Homebrew packages and Cursor extensions |

## Prerequisites

- macOS
- [Homebrew](https://brew.sh)
- [Oh My Zsh](https://ohmyz.sh)

## Installation

```bash
git clone https://github.com/thealexarias/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./install.sh
```

## Brewfile

Install all packages:

```bash
brew bundle --file=Brewfile
```
