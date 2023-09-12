#!/bin/bash
# Install zsh                                                                      
sudo pacman -S zsh zsh-completions grml-zsh-config zsh-syntax-highlighting zsh-autosuggestions
sudo cp /etc/zsh/zshrc $HOME/.zshrc                                                
$(cp $HOME/xmonad_eww_dotfiles/zshenv $HOME/.zshenv)                               
$(cp $HOME/xmonad_eww_dotfiles/zshrc.local $HOME/.zshrc.local) 
exec zsh
