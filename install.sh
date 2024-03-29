#!/usr/bin/env bash

set -eux

DOT_HOME="$HOME/dotfiles"

function checkout_dotfiles {
  if [[ ! -e "$DOT_HOME" ]]; then
    git clone git@github.com:ljank/dotfiles.git "$DOT_HOME"
  fi
}

function install_packages {
  case $(uname) in
  'Linux')
    sudo apt-get install wget git bash-completion jq silversearcher-ag clang tree vagrant virtualbox
    ;;

  'Darwin')
    which wget || brew install wget
    which jq || brew install jq
    which ag || brew install ag
    which bat || brew install bat
    which cmake || brew install cmake
    brew install bash-completion
    brew install homebrew/cask-fonts/font-fira-code-nerd-font
    brew install git; brew link git
    brew install libsodium
    which docker || brew install --cask docker
    which starship || brew install starship

    if uname -m | grep --silent x86_64; then
      which VirtualBox || brew install --cask virtualbox
      which vagrant || brew install --cask vagrant
    fi
    ;;
  esac
}

function setup_sublime_text {
  case $(uname) in
    'Linux')
      SUBLIME_PATH="$HOME/.config/sublime-text-4"
      ;;
    'Darwin')
      SUBLIME_PATH="$HOME/Library/Application Support/Sublime Text"
      ;;
  esac

  if [[ ! -z "$SUBLIME_PATH" && -e "$SUBLIME_PATH" ]]; then
    echo "Configuring Sublime.."
    rm -frv "$SUBLIME_PATH/Packages/User"
    ln -sv "$DOT_HOME/sublime-text-4/" "$SUBLIME_PATH/Packages/User"

    PACKAGE_CONTROL_PKG="$SUBLIME_PATH/Installed Packages/Package Control.sublime-package"
    if [[ ! -e "$PACKAGE_CONTROL_PKG" ]]; then
      echo 'Installing Package Control..'
      wget 'https://sublime.wbond.net/Package%20Control.sublime-package' -O "$PACKAGE_CONTROL_PKG"
      echo 'Package Control installed.'
    fi

    echo 'Sublime configured.'
  else
    echo '[Warn] Sublime not installed!'
  fi
}

function setup_bash {
  echo 'Configuring Bash..'
  for bash_config in $DOT_HOME/bash/*.bash; do
    grep --silent $bash_config ~/.bashrc || echo "source \"$bash_config\"" >> ~/.bashrc
  done
  grep --silent "bashrc" ~/.bash_profile || echo "test -f ~/.bashrc && source ~/.bashrc" >> ~/.bash_profile
  echo 'Bash configured.'
}

function setup_git {
  echo 'Configuring Git..'
  rm -v "$HOME/.gitconfig"
  ln -sv "$DOT_HOME/git/config" "$HOME/.gitconfig"
  echo 'Git configured.'
}

checkout_dotfiles &&
  install_packages &&
  setup_sublime_text &&
  setup_bash &&
  setup_git &&
  echo 'Done!'
