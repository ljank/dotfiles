#!/usr/bin/env bash

DOT_HOME="$HOME/dotfiles"
SUBLIME_PATH="$HOME/Library/Application Support/Sublime Text 3"

WGET=`which wget`
GIT=`which git`

if [[ ! -x $GIT ]]; then
  echo 'Error: git not found!'
  exit 1
fi

if [[ ! -x $WGET ]]; then
  echo 'Error: wget not found!'
  exit 1
fi

if [[ ! -e $DOT_HOME ]]; then
  git clone https://github.com/ljank/dotfiles/ $DOT_HOME
fi

if [[ -e $SUBLIME_PATH ]]; then
  echo "Configuring Sublime.."
  rm -frv "$SUBLIME_PATH/Packages/User"
  ln -sv ~/dotfiles/sublime-text-3/ "$SUBLIME_PATH/Packages/User"

  PACKAGE_CONTROL_PKG="$SUBLIME_PATH/Installed Packages/Package Control.sublime-package"
  if [[ ! -e "$PACKAGE_CONTROL_PKG" ]]; then
    echo 'Installing Package Control..'
    $WGET "https://sublime.wbond.net/Package%20Control.sublime-package" -O "$PACKAGE_CONTROL_PKG"
    echo 'Package Control installed.'
  fi

  echo "Enabling keyhold"
  defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

  echo "Sublime configured."
else
  echo "[Warn] Sublime not installed!"
fi

echo "Done!"
