#!/bin/bash
set -euo pipefail

SOURCE="/Volumes/Alex SSD/"
DEST="/Volumes/Crucial X9/"

if [ ! -d "$SOURCE" ] || [ ! -d "$DEST" ]; then
  echo "One or both drives not mounted. Plug them in and retry."
  exit 1
fi

# Exclude ._* sidecars: macOS auto-generates them during every exFAT write,
# so syncing them churns without any data benefit.
rsync -avh --progress --delete \
  --exclude='._*' \
  --exclude='.DS_Store' \
  --exclude='.Spotlight-V100' \
  --exclude='.Trashes' \
  --exclude='.fseventsd' \
  --exclude='$RECYCLE.BIN' \
  --exclude='System Volume Information' \
  "$SOURCE" "$DEST"

echo "Backup complete: $(date)"
