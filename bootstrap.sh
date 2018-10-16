#!/bin/bash
CURRENT_DIRECTORY=$(pwd)

if [ ! -f ~/.vimrc ]; then
    ln -s $CURRENT_DIRECTORY/.vimrc ~/.vimrc
fi

if [ ! -f ~/.tmux.conf ]; then
    ln -s $CURRENT_DIRECTORY/.tmux.conf ~/.tmux.conf
fi

if [ ! -f ~/.gvimrc ]; then
    ln -s $CURRENT_DIRECTORY/.gvimrc ~/.gvimrc
fi
