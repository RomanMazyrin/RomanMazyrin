#if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
#    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
#fi

# Created by `pipx` on 2025-09-22 15:17:51
export PATH="$PATH:/Users/romanmazyrin/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path bash)"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

export EDITOR="vim"

eval "$(fzf --bash)"

# ripgrep + fzf interactive search (like VS Code "Find in Files")
rgf() {
  local query="$*"
  local RELOAD='reload:rg --column --color=always --smart-case {q} || :'

  fzf --disabled --ansi --multi \
    --bind "start:$RELOAD" --bind "change:$RELOAD" \
    --bind 'enter:become:vim {1} +{2}' \
    --bind 'ctrl-o:execute:vim {1} +{2}' \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --delimiter ':' \
    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(up)' \
    --query "$query"
}

fdf() {
  local query="$*"

  fd --type f --color=always . | \
  fzf --ansi --multi \
    --bind 'enter:become:vim {1}' \
    --bind 'ctrl-o:execute:vim {1}' \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --delimiter ':' \
    --preview 'bat --style=full --color=always {1}' \
    --preview-window '~4,<80(up)' \
    --query "$query"
}

bind -x '"\C-f":rgf'
bind -x '"\C-t":fdf'
