if [[ "$(uname)" == "Darwin" ]]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

  export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

  # MacPorts
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH

  launchctl setenv PATH $PATH

  alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
  defaults write com.sublimetext.3 ApplePressAndHoldEnabled -bool false

  ssh-add -K
fi

alias flush-dns='sudo killall -HUP mDNSResponder'
