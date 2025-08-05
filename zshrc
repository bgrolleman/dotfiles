# ~~~ Minh Config
# Optimized .zshrc for improved startup time
# Enable profiling when needed: zmodload zsh/zprof

# ~~~~~~~~~~~~~~~~~~~~~~ Environment Setup ~~~~~~~~~~~~~~~~~~~~~~
# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Language and compilation
export LANG=en_US.UTF-8

# ~~~~~~~~~~~~~~~~~~~~~~ Homebrew Setup ~~~~~~~~~~~~~~~~~~~~~~
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ~~~~~~~~~~~~~~~~~~~~~~ Core Zsh Configuration ~~~~~~~~~~~~~~~~~~~~~~
# Enable completion system (call compinit only once)
autoload -Uz compinit

# Check if compinit needs to be run (once per day for performance)
for dump in ~/.zcompdump(N.mh+24); do
  compinit
  break
done
[[ -z "$dump" ]] && compinit -C

# Enhanced completion styling for better UX
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ensure cache directory exists
[[ ! -d ~/.zsh/cache ]] && mkdir -p ~/.zsh/cache

# Group completions by category
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'

# Process completion improvements
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# ~~~~~~~~~~~~~~~~~~~~~~ Plugin Loading (Conditional) ~~~~~~~~~~~~~~~~~~~~~~
# Function to load plugins if they exist
load_plugin() {
  [[ -f "$1" ]] && source "$1"
}

# Load zsh plugins
load_plugin "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
load_plugin "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
load_plugin "$HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
load_plugin "$XDG_CONFIG_HOME/zsh-z/zsh-z.plugin.zsh"

# ~~~~~~~~~~~~~~~~~~~~~~ Zsh-Autosuggestions Configuration ~~~~~~~~~~~~~~~~~~~~~~
# Configure autosuggestions for seamless history integration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555,bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# History-based suggestions prioritization
ZSH_AUTOSUGGEST_HISTORY_IGNORE="(ls|cd|pwd|exit|clear)"

# ~~~~~~~~~~~~~~~~~~~~~~ Completion Setup ~~~~~~~~~~~~~~~~~~~~~~
# Add homebrew completions if available
if command -v brew &>/dev/null; then
  fpath+="$HOMEBREW_PREFIX/share/zsh-completions"
  fpath+="$HOMEBREW_PREFIX/share/zsh/site-functions"
fi

# ~~~~~~~~~~~~~~~~~~~~~~ Editor & Shell Configuration ~~~~~~~~~~~~~~~~~~~~~~
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ~~~~~~~~~~~~~~~~~~~~~ History Configuration ~~~~~~~~~~~~~~~~~~~~~~
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# Enhanced history options for better autosuggestions
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ~~~ Bas Config


export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="${HOME}/bin:${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

eval "$(direnv hook zsh)"

# Disable auto tmux for now, my tiling window manager is enough
#[[ -v PS1 ]] && [[ ! -v TMUX ]] && tmux

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
export OPENAI_API_KEY=$(cat ~/.openai.key)
export KAGI_API_KEY=$(cat ~/.kagi.key)

eval "$(zoxide init zsh)"
alias cd=z

cat <<EOF
Reminders:

  Use z
EOF

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
source ~/.zsh/zsh-vim-mode/zsh-vim-mode.plugin.zsh
