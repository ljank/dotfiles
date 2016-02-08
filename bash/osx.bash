export CDPATH=.:~:~/workspace
export PATH=node_modules/.bin:~/bin:/usr/local/bin:$PATH

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"

# MacPorts
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

launchctl setenv PATH $PATH
