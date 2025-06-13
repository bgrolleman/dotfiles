export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

eval "$(direnv hook zsh)"

[[ -v PS1 ]] && [[ ! -v TMUX ]] && tmux
