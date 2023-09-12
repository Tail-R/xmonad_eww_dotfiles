#!/bin/bash

cd $HOME

# Init directory tree
mkdir -p $HOME/Documents
mkdir -p $HOME/Pictures
mkdir -p $HOME/Downloads
mkdir -p $HOME/Music
mkdir -p $HOME/Videos

mkdir -p $HOME/Documents/scripts
mkdir -p $HOME/Documents/pkgs
mkdir -p $HOME/Pictures/screenshots
mkdir -p $HOME/Pictures/wallpapers

# Packman update
sudo pacman -Syu --noconfirm

# Install AUR
if [ "$(which yay)" == "" ]; then
    cd $HOME/Documents/pkgs

    $(git clone https://aur.archlinux.org/yay.git)
    cd yay
    echo "Y" | makepkg -si

    cd $HOME
fi

# Index of necessary packages
pacmanPackages="
        vim

        kitty
        ranger 
        highlight
        imagemagick

        thunar
        thunar-archive-plugin
        file-roller
        gvfs

        breeze
        breeze-gtk
        breeze-icons
        lxappearance

        firefox
        gimp
        obs-studio
        vlc
        
        rofi
        picom
        maim
        feh
        neofetch
        
        pulseaudio
        pulseaudio-alsa
        pulseaudio-bluetooth
        alsa-utils
        alsa-firmware
        pamixer
        pavucontrol
        bluez
        bluez-utils
        pavucontrol

        ttf-jetbrains-mono
        nerd-fonts
        ipa-fonts
         
        wmctrl
        xdotool
        playerctl
        acpi
        brightnessctl
        
        fcitx5
        fcitx5-im
        fcitx5-mozc

        gtk3
        pango
        gdk-pixbuf2
        cairo
        glib2
        gcc-libs
        glibc
    "

aurPackages="
        spotify
        visual-studio-code-bin
        libre-office
        discord_arch_electron

        xcursor-breeze
        pfetch
    "

# Main

# Install packages
sudo pacman -Rs pipewire-pulse --noconfirm
sudo pacman -S $pacmanPackages --noconfirm
# yay -S $aurPackages --noconfirm

# Install XMonad
if [ ! -d $HOME/.config/xmonad ]; then
    mkdir $HOME/.config/xmonad
    cp $HOME/xmonad_eww_dotfiles/xmonad/xmonad.hs $HOME/.config/xmonad/xmonad.hs
    
    cd $HOME/.config/xmonad

    $(git clone https://github.com/xmonad/xmonad)
    $(git clone https://github.com/xmonad/xmonad-contrib)

    sudo pacman -S stack --noconfirm
    stack upgrade
    stack init
    stack install

    cd $HOME

    cp $HOME/xmonad_eww_dotfiles/zshenv $HOME/.zshenv 
fi

# Enable bluetooth service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# ***** Copy some dotfiles *****

# Ranger
ranger --copy-config=all
cp $HOME/xmonad_eww_dotfiles/dotconfig/ranger/rc.conf $HOME/.config/ranger/rc.conf

# Xinit
if [ ! -f $HOME/.xinitrc ]; then
    cp $HOME/xmonad_eww_dotfiles/xinitrc $HOME/.xinitrc
fi

startx

# Kitty
if [ ! -d $HOME/.config/kitty ]; then
    mkdir $HOME/.config/kitty
    cp $HOME/xmonad_eww_dotfiles/dotconfig/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
fi

# Picom
if [ ! -d $HOME/.config/picom ]; then
    mkdir $HOME/.config/picom
    cp $HOME/xmonad_eww_dotfiles/dotconfig/picom/picom.conf $HOME/.config/picom/picom.conf
fi

# Rofi
if [ ! -d $HOME/.config/rofi ]; then
    mkdir $HOME/.config/rofi
    cp $HOME/xmonad_eww_dotfiles/dotconfig/rofi/config.rasi $HOME/.config/rofi/config.rasi
fi

# Eww
if [ ! -d $HOME/.config/eww ]; then
    mkdir $HOME/.config/eww
    cp -r $HOME/xmonad_eww_dotfiles/dotconfig/eww/ $HOME/.config/eww/
    sudo chmod -R +x $HOME/.config/eww/
    
    cd $HOME/.config/eww/popup
    
    ln -s $HOME/.config/eww/bar/images
    ln -s $HOME/.config/eww/bar/scripts
    ln -s $HOME/.config/eww/bar/eww_variables.yuck
    
    cd $HOME

    cd $HOME/Documents/pkgs
    
    $(git clone https://github.com/elkowar/eww)
    cd eww
    cargo build --release --no-default-features --features x11
    cd target/release
    chmod +x ./eww
    ./eww daemon
    
    $HOME/.config/eww/bar/launch.sh --open-all

    cd $HOME     
fi

# Vim
if [ ! -d $HOME/.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    cp $HOME/xmonad_eww_dotfiles/vimrc $HOME/.vimrc
    vim -c PlugInstall
fi





