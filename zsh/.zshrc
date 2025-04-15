# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/opt/homebrew/bin:$PATH"

# --- Begin Oh-My-Zsh Setup ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Load Oh-My-Zsh.
source "$ZSH/oh-my-zsh.sh"

# Enable plugins.
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)

# Initialize completions.
autoload -Uz compinit && compinit

# Ensure ZSH_HIGHLIGHT_STYLES is declared as an associative array before setting values.
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]="fg=cyan"
# --- End Oh-My-Zsh Setup ---

# Custom settings below:

# Keybindings
bindkey '^y' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History configuration
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
alias diff=colordiff
alias fastfetch="fastfetch -c ~/.config/fastfetch/config.jsonc"

# Fix gpg signed commits for git
GPG_TTY=$(tty)
export GPG_TTY

# Get pyenv python in path
export PATH="$HOME/.pyenv/shims:$PATH"

# Add to $PATH (OpenJDK, PostgreSQL, Go, curl, llvm)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Add dafny to PATH
export PATH="/Users/jakezur/dafny/:$PATH"

# Set vi mode keybindings
set -o vi
bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# Configure cursor shape depending on keymap (vi mode)
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    print -Pn "\e[2 q"
  else
    print -Pn "\e[6 q"
  fi
}
zle -N zle-keymap-select

if [[ $KEYMAP == vicmd ]]; then
  print -Pn "\e[2 q"
else
  print -Pn "\e[6 q"
fi

# Shell integrations
eval "$(fzf --zsh)"

# (Oh-My-Zsh with Powerlevel10k already handles the prompt, so no need to separately source ~/.p10k.zsh)

# bun completions
[ -s "/Users/jakezur/.bun/_bun" ] && source "/Users/jakezur/.bun/_bun"

# bun configuration
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# lfcd integration
# NOTE: There are two assignments here. Remove or comment out the one you do not use.
# Option 1: Source version from GOPATH (if applicable)
# LFCD="$GOPATH/src/github.com/gokcehan/lf/etc/lfcd.sh"
# Option 2: Pre-built binary version (use the absolute path)
LFCD="/path/to/lfcd.sh"
if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

export EDITOR=nvim

# BEGIN opam configuration
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Initialize zoxide.
eval "$(zoxide init zsh)"
alias cd='z'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
