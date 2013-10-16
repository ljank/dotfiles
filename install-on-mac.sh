#!/usr/bin/env bash

DOT_HOME="${HOME}/dotfiles"
SUBLIME_PATH="${HOME}/Library/Application Support/Sublime Text 3"

if [[ ! -e $DOT_HOME ]]; then
  git clone https://github.com/ljank/dotfiles/ $DOT_HOME
fi

if [[ -e $SUBLIME_PATH ]]; then
  echo "Configuring Sublime.."
  rm -frv "${SUBLIME_PATH}/Packages/User"
  ln -sv ~/dotfiles/sublime-text-3/ "${SUBLIME_PATH}/Packages/User"
  echo "Sublime configured."
else
  echo "[Warn] Sublime not installed!"
fi

echo "Done!"
