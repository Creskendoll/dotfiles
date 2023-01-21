# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ken/.oh-my-zsh"

ZSH_THEME="ken"

plugins=(git history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias ga='git add'
alias gcm='git commit -m'
alias gco='git checkout'
alias gst='git status'
alias gps='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull'

# Git alias for dotfiles
alias config='/usr/bin/git --git-dir=/home/ken/.cfg/ --work-tree=/home/ken'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# rbenv
if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)";
fi

# Use nvm node version
[ -f ./.nvmrc ] && nvm use

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ken/Apps/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ken/Apps/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ken/Apps/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ken/Apps/google-cloud-sdk/completion.zsh.inc'; fi

# Automatic NodeJS version switching after `cd`
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
