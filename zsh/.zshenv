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
# J: show status column, when searching or marking
# --use-color: Enables colored text in various places.
export LESS="FMRWij.5J--use-color"
export MANPAGER="less -n" # suppress line numbers in less when viewing man pages
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31;40'

# Make python projects that use requests trust an exported copy of the system
# root store, which includes the VPN MITM spyware cert
# See
# * https://knowledge.catonetworks.com/docs/configuring-cli-tools-and-dev-frameworks-to-work-with-cato-tls-inspection
# * https://github.com/aws/aws-cli/issues/6193
# * feels like there should be a similar issue in requests? But
#   https://github.com/psf/requests/issues/2966 is closed
export REQUESTS_CA_BUNDLE="$HOME/workspace/ca_bundle_for_requests.pem"

export NODE_USE_SYSTEM_CA=1
