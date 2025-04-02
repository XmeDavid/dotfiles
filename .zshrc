
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

bindkey "^[b" backward-word
bindkey "^[f" forward-word

alias ll="exa -la"
alias txa="tmux attach"
alias txd="tmux detach"

# bun completions
[ -s "/Users/xmedavid/.bun/_bun" ] && source "/Users/xmedavid/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
