#!/bin/zsh

set -e -o pipefail

GIT=$(command -v git)

cd ~/.dotfiles
$GIT add .
$GIT commit -m "$1"
$GIT push origin main
