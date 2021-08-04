#! /bin/bash

#DMR: my own aliases. Some of these are probably bad habits...
alias du="du -h --max-depth 1"
alias df="df -h"
alias free="free -h"
alias calc="bc -l"

# Pipe to clipboard!
alias clipboard='xsel -ib' # https://askubuntu.com/a/184398

alias ls='ls -h --color=auto'
alias grep='grep -ni --color=always'
alias fgrep='fgrep -ni --color=auto'
alias egrep='egrep -ni --color=always'

#octal dump. I've never got round to learning its arguments.
alias od='od -c -tx1'

#readlink: canonicalise recursively
alias readlink='readlink -e'

alias whereis='echo "Do you mean the \"which\" command (which searches on your PATH)?" >&2; whereis'

# From https://www.cyberciti.biz/faq/linux-which-process-is-using-swap/
# Called dirty because 
what_is_swapping () {
	for file in /proc/*/status ; do awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' $file; done | sort -k 2 -n -r | less
}

# Adapted from https://unix.stackexchange.com/a/367
highlight () { \grep --color=always -E "$1|$" "${@:2}" ; }

