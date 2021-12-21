#!/bin/zsh

set -e -o pipefail

DOTBOT=$(command -v dotbot)
GIT=$(command -v git)

cd ~/.dotfiles
$GIT pull origin main
$DOTBOT -c install.conf.yaml
