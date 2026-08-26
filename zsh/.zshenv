export EDITOR=vim
# https://stackoverflow.com/a/43087047
bindkey -e

export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# remove duplicate entries from $PATH
# zsh uses $path array along with $PATH 
typeset -U PATH path

# Sod off, docker inc.
# From https://github.com/docker/for-mac/issues/6904
export DOCKER_CLI_HINTS=false

# https://github.com/starship/starship/pull/3018#issuecomment-1682837773
export ITERM2_SQUELCH_MARK=1

# F: behave like `cat` if the output fits on one screen without scrolling.
# M: verbose prompt, apparently.
# R: pass through ANSI color escapes and hyperlink sequences to the terminal.
# W: highlights the first new line after a long movement. I can't seem to see this in action?
# i: case insensitive search whenever the search is lowercase.
# -j.5: when jumping, try to put the target in the middle of the screen.
export LESS="FMRWij.5"
export MANPAGER="less -n" # suppress line numbers in less when viewing man pages
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31;40'

export SSL_CERT_FILE="$HOME/workspace/CatoNetworksTrustedRootCA.pem"

# Make python projects that use request trust the VPN MITM spyware cert
# Update 2026-07-20: commenting out because aws cli broken by this
# export REQUESTS_CA_BUNDLE="$HOME/workspace/CatoNetworksTrustedRootCA.pem"
