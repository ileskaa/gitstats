#!/bin/bash

chmod +x gitstats.sh

if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]];then
    echo "Directory ~/.local/bin/ is in PATH.";
else
    mkdir -p "$HOME/.local/bin/"

    path_export='export PATH=$HOME/.local/bin:$PATH'

    if [[ "$SHELL" == */zsh ]];then
        echo '' >> "$HOME/.zshrc"
        echo "$path_export" >> "$HOME/.zshrc"
        echo ".zshrc was updated."
        echo -e 'Run \033[32msource ~/.zshrc\033[0m to update your path.'
    elif [[ "$SHELL" == */bash ]];then
        echo '' >> "$HOME/.bashrc"
        echo "$path_export" >> "$HOME/.bashrc"
        source "$HOME/.bashrc"
        echo ".bashrc was updated."
    fi
fi

cp gitstats.sh "$HOME"/.local/bin/gitstats
echo "gitstats was installed."
echo -e "Use it by running \033[1mgitstats\033[0m within a project directory."
