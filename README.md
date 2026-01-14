# Omarchy Dotfiles

Reproducible Omarchy / Arch Linux setup.

This repository contains:
- User configuration (`.config`, shell, editor settings)
- Package lists (pacman + AUR)
- Enabled systemd services
- A bootstrap script to restore everything on a fresh install

## Usage (fresh system)

```bash
git clone git@github.com:nanguer/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
````



Reboot after completion.

## Notes

- Secrets and machine-specific state are intentionally excluded

- Configs are symlinked to keep a single source of truth
