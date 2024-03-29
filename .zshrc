# Lines configured by zsh-newuser-install
hISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt autocd extendedglob
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

# zsh package manager:
source "$HOME/.local/share/miniplug.zsh"
miniplug plugin zsh-users/zsh-syntax-highlighting
miniplug plugin jeffreytse/zsh-vi-mode
miniplug plugin zsh-users/zsh-completions
miniplug plugin zsh-users/zsh-autosuggestions
# miniplug plugin marlonrichert/zsh-autocomplete
miniplug plugin agkozak/zsh-z
miniplug plugin wfxr/forgit
miniplug plugin Bhupesh-V/ugit
miniplug plugin peterhurford/git-it-on.zsh
miniplug plugin zdharma-continuum/fast-syntax-highlighting
miniplug plugin supercrabtree/k

# Theme
miniplug theme spaceship-prompt/spaceship-prompt

miniplug load
# end zsh package manager

# change suggestions strategy
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# bindkey '\t' autosuggest-accept

# Global ENV
# export TERM="xterm-kitty"
#export TERM="xterm-256color"
export EDITOR='nvim'
export VISUAL='nvim'

# Custom aliases
alias dash="gh dash"
alias ls="lsd"
alias ll="lsd -la"
alias gs="git status"
alias gd="git diff"
alias ggn="git checkout -b "
alias ggc="git checkout "
alias ggp="gh pr create "
alias gg="lazygit"
alias n="nvim"
alias e="nvim"
alias ff="ranger"
alias dl="lazydocker"
alias t="tmux"
alias tl="tmux list-sessions"
alias ta="tmux attach"

# vim alias shit
alias :q="exit"
alias :e="nvim"

alias ports="lsof -i -P -n | grep LISTEN"

alias get-ports="netstat -tulnp | grep LISTEN"
alias get-router="ip route | grep default"
alias get-ip="hostname -I"

# taskell
alias todo="taskell ~/Documents/taskell.md"

# Kitty aliases
alias d="kitty +kitten diff"

alias pinentry='pinentry-mac'

# # un - archive extractor
# # usage: un <file>
un ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
export GPG_TTY=$(tty)
eval "$(mcfly init zsh)"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  # gradle        # Gradle section
  # maven         # Maven section
  node          # Node.js section
  # ruby          # Ruby section
  # elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  # golang        # Go section
  # php           # PHP section
  rust          # Rust section
  # haskell       # Haskell Stack section
  # julia         # Julia section
  # aws           # Amazon Web Services section
  # gcloud        # Google Cloud Platform section
  # venv          # virtualenv section
  # conda         # conda virtualenv section
  # pyenv         # Pyenv section
  # dotnet        # .NET section
  # ember         # Ember.js section
  # kubectl       # Kubectl context section
  # terraform     # Terraform workspace section
  # ibmcloud      # IBM Cloud section
  docker        # Docker section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  # vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

function zvm_after_init() {
  zvm_bindkey viins '^R' mcfly-history-widget
}

# bun completions
[ -s "/Users/almo7aya/.bun/_bun" ] && source "/Users/almo7aya/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'
