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
  git clone git@github.com:ljank/dotfiles.git $DOT_HOME
fi

if [[ -e $SUBLIME_PATH ]]; then
  echo "Configuring Sublime.."
  rm -frv "$SUBLIME_PATH/Packages/User"
  ln -sv "$DOT_HOME/sublime-text-3/" "$SUBLIME_PATH/Packages/User"

  PACKAGE_CONTROL_PKG="$SUBLIME_PATH/Installed Packages/Package Control.sublime-package"
  if [[ ! -e "$PACKAGE_CONTROL_PKG" ]]; then
    echo 'Installing Package Control..'
    $WGET "https://sublime.wbond.net/Package%20Control.sublime-package" -O "$PACKAGE_CONTROL_PKG"
    echo 'Package Control installed.'
  fi

  echo 'Adding `sublime` alias..'
  mkdir -pv "$HOME/bin"
  ln -sv "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" "$HOME/bin/sublime"

  echo "Enabling keyhold"
  defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

  echo "Sublime configured."
else
  echo "[Warn] Sublime not installed!"
fi

BASH_PROFILE_PATH=~/.bash_profile
BASH_CONFIGURED=`cat $BASH_PROFILE_PATH | grep '^# dotfiles'`
if [[ $? -ne 0 ]]; then
  echo 'Configuring Bash..'
  brew install bash-completion
  echo '' >> $BASH_PROFILE_PATH
  echo '# dotfiles' >> $BASH_PROFILE_PATH
  for bash_config in $DOT_HOME/bash/*.bash; do
    echo "source \"$bash_config\"" >> $BASH_PROFILE_PATH
  done
  echo 'Bash configured.'
else
  echo 'Bash already configured, skipping'
fi


echo "Configuring Git.."
rm -v "$HOME/.gitconfig"
ln -sv "$DOT_HOME/git/config" "$HOME/.gitconfig"
echo "Git configured."


echo "Done!"
