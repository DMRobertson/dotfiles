#! /usr/bin/env zsh
# https://stevenvanbael.com/profiling-zsh-startup
# zmodload zsh/zprof
# Put "zprof" at the end of the file
# zprof

# Starship prompt
eval "$(starship init zsh)"

# ASDF, https://asdf-vm.com/guide/getting-started.html
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

# Don't write history entries that start with a space
setopt HIST_IGNORE_SPACE

## COMPLETION
# Brew completion path
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Expose custom completions
fpath=(~/.zshcompletions $fpath);

# Load completions
autoload bashcompinit && bashcompinit
# Use -u to ignore the warning that we don't own the completion scripts and they're writable.
# https://workbrew.com/docs/how-to-fix-zsh-errors-after-installing-workbrew#insecure-directories-prompt
# Thank you workbrew!!!!
autoload -Uz compinit && compinit -u

# Completion for aws, see https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux
complete -C '/usr/local/bin/aws_completer' aws

# Completion for terraform
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Case-insensitive completion
# https://superuser.com/a/1092328
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

## INPUT
#
# From https://pencilflip.medium.com/my-zshrc-file-on-mac-adapted-from-bashrc-and-inputrc-16ac09efeb95
# bindkey "\e[A" history-beginning-search-backward
# bindkey "\e[B" history-beginning-search-forward
# The above doesn't put the cursor at the end of the substring match, which is infuritating. Try this from 
# https://unix.stackexchange.com/a/691482

for direction (up down) {
  autoload $direction-line-or-beginning-search
  zle -N $direction-line-or-beginning-search
  key=$terminfo[kcu$direction[1]1]
  for key ($key ${key/O/[})
    bindkey $key $direction-line-or-beginning-search
}

# https://unix.stackexchange.com/a/522922
bindkey \^U backward-kill-line

# https://unix.stackexchange.com/a/34251
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# iTerm2 integration
source ~/.iterm2_shell_integration.zsh

## ENVIRONMENTS AND CONTEXTUAL STUFF
# Direnv
eval "$(direnv hook zsh)"
# Load 1Password plugin aliases
source ~/.config/op/plugins.sh


# Make ls use colour for its output
export CLICOLOR=1

# less is more
export PAGER=less
export LESSOPEN="|/opt/homebrew/bin/lesspipe.sh %s"

# Zsh integration, see https://github.com/junegunn/fzf#key-bindings-for-command-line
source <(fzf --zsh)


# Silly aliases for me
alias clipset=pbcopy
alias clipget=pbpaste
alias od='od -c -tx1'
alias diff='diff --color=auto'
alias finder='open -R'

# Custom functions that are too long for here
fpath=( ~/.zsh/functions "${fpath[@]}" )
autoload -Uz plsreviewme
autoload -Uz debugandlog
autoload -Uz echologs



# postgres binaries TYVM
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="/opt/homebrew/opt/ffmpeg-full/bin:$PATH"

