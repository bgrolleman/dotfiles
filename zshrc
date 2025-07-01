export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

eval "$(direnv hook zsh)"

[[ -v PS1 ]] && [[ ! -v TMUX ]] && tmux

# Function to get the current Git branch and remote
git_info() {
    local branch
    local remote

    # Get the current branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    # Get the current remote
    remote=$(git config --get remote.origin.url 2>/dev/null)

    # Format the output
    if [[ -n $branch ]]; then
        #echo "[$branch] $(basename "$remote")"
        echo "[$branch]"
    fi
}
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m %F{blue}%~ %F{yellow}$(git_info)%f %# '

eval "$(zoxide init zsh)"
alias cd=z

cat <<EOF
Reminders:

  Use z
EOF
