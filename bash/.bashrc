# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

PATH=$HOME/.cargo/bin:$HOME/go/bin:$PATH
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

#bash options
shopt -s checkjobs          #If set, list bg jobs before exit and require another exit
shopt -s hostcomplete       #If set, use readline to attempt to complete host names after an @

export EDITOR="vim"
export LESS="JMRWij.5"
export MANPAGER="less -n" # suppress line numbers in less when viewing man pages
export PYTHONDONTWRITEBYTECODE=1

export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTTIMEFORMAT="%F %T  "
export PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

source ~/.bash_aliases

# Don't mess about with prompt in containers that have home area mounted
if [ "$HOSTNAME" == "discovery" ] ; then
	eval "$(starship init bash)"
fi
