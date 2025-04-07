
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey "^[b" backward-word
bindkey "^[f" forward-word

alias nv-help="source ~/.nv-help"
alias tmux-setup="~/.local-config/tmux-setup"
alias txa="tmux attach"
alias txd="tmux detach"
alias nv="nvim"
alias rf="source"

export PATH="$PATH:/Users/$USER/dev/go-tools/bin"

# Local config load
if [[ -f ~/.local-config/.zshrc ]]; then
  source ~/.local-config/.zshrc
fi
