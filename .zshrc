export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


bindkey "^[b" backward-word
bindkey "^[f" forward-word


alias nv-help="source ~/.nv-help"
alias nv="nvim"
alias rf="source"

############ TMUX CREATION FOR PROJECT
function tx() {
  local target_dir=${1:-$PWD}
  local script="$target_dir/.tmux"
  local session_name

  if [[ -f "$script" ]]; then
    # Try to extract custom session name from the .tmux file
    session_name=$(grep '^SESSION=' "$script" | cut -d'"' -f2)
    [[ -z "$session_name" ]] && session_name=${target_dir:t}
  else
    session_name=${target_dir:t}
    # Create new .tmux script
    cat > "$script" <<EOF
#!/usr/bin/env zsh

SESSION="$session_name"
DIR="$target_dir"

if ! tmux has-session -t "\$SESSION" 2>/dev/null; then
  tmux new-session -d -s "\$SESSION" -n term -c "\$DIR"
  tmux send-keys -t "\$SESSION":0 "cd \"\$DIR\"" C-m
  tmux send-keys -t "\$SESSION":0 "clear" C-m
  tmux new-window -t "\$SESSION":1 -n nvim -c "\$DIR"
  tmux send-keys -t "\$SESSION":1 'nvim .' C-m
fi

tmux select-window -t "\$SESSION":0
EOF
    chmod +x "$script"
    echo "Created .tmux script for session '$session_name'"
  fi

  zsh "$script"

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session_name"
  else
    exec tmux attach-session -t "$session_name"
  fi
}
#######################

export PATH="$PATH:/Users/$USER/dev/go-tools/bin"

# Local config load
if [[ -f ~/.local-config/.zshrc ]]; then
  source ~/.local-config/.zshrc
fi

if [[ -z "$TMUX" ]]; then
	tx
fi
