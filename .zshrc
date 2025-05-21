if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice lucid wait'0'
zinit light joshskidmore/zsh-fzf-history-search
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim', 'nvim', 'zk')
zinit light "lukechilds/zsh-nvm"

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::asdf

bindkey '^Y' autosuggest-accept
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# zsh by default does not pass i/o capabilities to widgets, thus we have to do that manually
# mingle_connect() {
#     (
#         exec </dev/tty
#         exec <&1
#         ~/Projects/mingle/mingle connect $(~/Projects/mingle/mingle list | fzf --border --margin=20%,20%)
#     )
# }
# zle -N mingle_connect
#
# bindkey '^F' mingle_connect

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ls='eza'
alias vim='nvim'
alias c='clear'

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
export PATH="$HOME/.local/bin/:$HOME/nvim/bin:$PATH"
export EDITOR='nvim'

# Shell integrations
source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init --cmd cd zsh)"
