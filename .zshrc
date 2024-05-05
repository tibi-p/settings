# Set up the prompt
autoload -Uz promptinit
promptinit
prompt clint

setopt histignorealldups sharehistory

HISTSIZE=10000
SAVEHIST=50000
HISTFILE=~/.zsh_history

export CDPATH=".:${HOME}:${HOME}/dev"

export EDITOR=emacs
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

alias ..="cd .."
alias ...="cd ../.."

awkp() {
    awk '{print $'"$1"'}'
}
alias awkl='awk '"'"'{print $NF}'"'"

alias emod="emacs \`git st | grep -v '??' | awkl\`"
alias ediff="emacs \`git diff --name-status master | awkl\`"

alias gd="git diff ."
alias gds="git diff --staged"

alias todo="emacs --eval '(org-agenda-list)' --eval '(delete-other-windows)'"

# tmux windows set-up
tm() {
    declare -A _windows
    _windows=()
    cmd="/usr/bin/tmux new-session -s terminal -c dev -n cmd"
    for name file in "${(@kv)_windows}"; do
        cmd="${cmd} \; new-window -c ${file} -n ${name}"
    done
    cmd="${cmd} \; selectw -t 1"
    eval $cmd
}

# Access fzf project here: https://github.com/junegunn/fzf
fzfb() {
    fzf --bind 'shift-down:preview-page-down,shift-up:preview-page-up' "$@"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzfb "$@" --preview 'tree -C {} | head -200' ;;
    # alternative: fzf "$@" --preview "eval 'echo \$'{}" ;;
    export|unset) fzfb "$@" --preview "eval 'printf '\'%s\\\\n\'' \$'{}" ;;
    ssh)          fzfb "$@" --preview 'dig {}' ;;
    emacs)        fzfb "$@" --preview 'batcat --style=numbers --color=always --line-range :500 {}' ;;
    *)            fzf "$@" ;;
  esac
}

# Import fzf when installed from source code
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Import fzf when installed via apt
# source /usr/share/doc/fzf/examples/key-bindings.zsh
# source /usr/share/doc/fzf/examples/completion.zsh
# sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse"
