#!/usr/bin/env bash
set -e

echo "==> Bootstrapping Omarchy system"

# Ensure we're in dotfiles
DOTFILES="$HOME/dotfiles"

# 1. Install official packages
echo "==> Installing pacman packages"
sudo pacman -S --needed - < "$DOTFILES/pkglist.txt"

# 2. Install AUR helper if missing
if ! command -v yay >/dev/null; then
  echo "==> Installing yay"
  sudo pacman -S --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si)
fi

# 3. Install AUR packages
echo "==> Installing AUR packages"
yay -S --needed - < "$DOTFILES/aurlist.txt"

# 4. Enable systemd services
echo "==> Enabling services"
while read -r svc; do
  sudo systemctl enable "$svc"
done < "$DOTFILES/services.txt"

# 5. Symlink dotfiles
echo "==> Linking dotfiles"

ln -sf "$DOTFILES/.config" "$HOME/.config"
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"

if [ -d "$DOTFILES/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  ln -sf "$DOTFILES/.ssh/config" "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
fi

# 6. Trust mise configs (if present)
if command -v mise >/dev/null; then
  mise trust "$DOTFILES"
fi

echo "==> Bootstrap complete. Reboot recommended."

