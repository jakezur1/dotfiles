export TERM=xterm-256color

### PATH CONFIGURATION ###
export PATH="/opt/homebrew/bin:/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:/opt/homebrew/opt/postgresql@16/bin:/opt/homebrew/opt/curl/bin:/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/go/bin:/Users/jakezur/dafny/:$PATH"
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.bun/bin:$PATH"
export PATH="$BUN_INSTALL/bin:$PATH"
export JAVA_HOME="/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Fix GPG signed commits for git
GPG_TTY=$(tty)
export GPG_TTY

### Zinit setup ###
if [[ ! -f "$HOME/.zinit/bin/zinit.zsh" ]]; then
  mkdir -p ~/.zinit
  git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin
fi

source ~/.zinit/bin/zinit.zsh

# Load plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# After plugins load, run compinit
autoload -Uz compinit && compinit

# Customize syntax highlighting
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=cyan"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"

# lfcd integration
LFCD="/path/to/lfcd.sh"
if [ -f "$LFCD" ]; then
  source "$LFCD"
fi

### History ###
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

### Keybindings ###
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
set -o vi
bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Vi mode cursor shape
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    print -Pn "\e[2 q"
  else
    print -Pn "\e[6 q"
  fi
}
zle -N zle-keymap-select
[[ $KEYMAP == vicmd ]] && print -Pn "\e[2 q" || print -Pn "\e[6 q"

### Aliases ###
alias diff=colordiff
alias fastfetch="fastfetch -c ~/.config/fastfetch/config.jsonc"
alias ls='eza $eza_params'
alias lsa='eza --all --header --long $eza_params'

### Shell integrations ###
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
alias cd='z'

export EDITOR=nvim
