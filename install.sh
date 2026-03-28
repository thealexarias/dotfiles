#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
backed_up=false

backup_and_link() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        if [ "$backed_up" = false ]; then
            mkdir -p "$BACKUP_DIR"
            backed_up=true
        fi
        local backup_path="$BACKUP_DIR/$(basename "$target")"
        echo "  Backing up $target -> $backup_path"
        mv "$target" "$backup_path"
    fi

    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    echo "  Linked $target -> $source"
}

echo "Installing dotfiles from $DOTFILES_DIR"
echo ""

# Symlink home/ files to ~/
echo "=== Home directory files ==="
for file in "$DOTFILES_DIR"/home/.*; do
    filename="$(basename "$file")"
    [ "$filename" = "." ] || [ "$filename" = ".." ] && continue
    backup_and_link "$file" "$HOME/$filename"
done

# Symlink config/ files to ~/.config/
echo ""
echo "=== .config files ==="
find "$DOTFILES_DIR/config" -type f | while read -r file; do
    relative="${file#$DOTFILES_DIR/config/}"
    # Ghostty config goes to a special location on macOS
    if [[ "$relative" == ghostty/* ]]; then
        target="$HOME/Library/Application Support/com.mitchellh.ghostty/${relative#ghostty/}"
    else
        target="$HOME/.config/$relative"
    fi
    backup_and_link "$file" "$target"
done

# Optionally install Homebrew packages
if [ -f "$DOTFILES_DIR/Brewfile" ]; then
    echo ""
    read -p "Install Homebrew packages from Brewfile? [y/N] " answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        brew bundle --file="$DOTFILES_DIR/Brewfile"
    fi
fi

echo ""
echo "Done! Restart your shell or run: source ~/.zshrc"
