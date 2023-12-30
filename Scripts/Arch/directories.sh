#!/bin/sh
git clone https://github.com/slimtux/dotfiles
mv dotfiles/ArchCurrent_2023-2024/.config/shell/  ~/$HOME/.config
mv dotfiles/ArchCurrent_2023-2024/.config/zsh/  ~/$HOME/.config
cd
ln -svr ~/$HOME/.config/zsh/.zshrc .zshrc
