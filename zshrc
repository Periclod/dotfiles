# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
setopt autocd extendedglob notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' add-space true
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing: %d'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '' '+r:|[._-/]=** r:|=**'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=1
#zstyle ':completion:*' menu yes select
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 'NUMERIC == 2'
zstyle :compinstall filename '/home/peri/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#
# Fix special keys not working
#
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

#
# better history
#
HISTSIZE=5000
SAVEHIST=5000
# ignore duplicates
setopt hist_ignore_all_dups
# ignore commands with space prefix
setopt hist_ignore_space
# live history update for all shells
setopt inc_append_history
setopt share_history


# Display better prompt
# %F{color} sets the color
# %f resets the color
# %(?.success.failure) shows the previous command
# %B - %b bold
# %2~ show last 2 directory of pwd
PROMPT='%B%2~%f%b ❯ '


# cursor support for vi mode
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
KEYTIMEOUT=1



# Manually enable Ctrl+R search
# no longer needed because fzf
# bindkey "^R" history-incremental-search-backward

# fix broken backward-delete (no idea what's the intended way to use it
bindkey -v '^?' backward-delete-char

# Load color scheme from wal
(cat ~/.cache/wal/sequences &)


# plugins
# fish-like preview
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
ZSH_AUTOSUGGEST_USE_ASYNC=yes
# bindkey '^ ' autosuggest-accept
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# notify when long running jobs are done
source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
AUTO_NOTIFY_IGNORE+=("spt" "ytop" "fo" "git diff" "cat" "bat" "sudo docker")

# smarter cd
export _ZO_DATA=$HOME/.local/share/zoxide/database
eval "$(zoxide init zsh --no-define-aliases)"

# fuzzy finder
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Use fd and fzf to get the args to a command.
# Works only with zsh
# Examples:
# fr mv # To move files. You can write the destination after selecting the files.
# fr 'echo Selected:'
# fr 'echo Selected music:' --extention mp3
# f rm # To rm files in current directory
fr() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# Like f, but not recursive.
f() fr "$@" --max-depth 1

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() (
  IFS=$'\n' files=($(fzf --preview 'bat --color=always {}' --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
)

export FZF_CTRL_T_OPTS="--preview 'bat --color always {}'"

#
# ALIASES
#

# color and stuff
alias ls="exa"
alias l="exa -laF"

# highlighting in cat!
# alias cat="bat -p --pager never" # since bat is smart enough in non-interactive cases to be cat compatible
alias cat="bat"
# use bat for man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# better diff
alias diff="diff-so-fancy"

# more comfortable zoxide
alias c="z"

# kubectl stuff
alias k="kubectl"
alias ka="kubectl apply"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kg="kubectl get"

alias ki="kubectl -n istio-system"
alias kq="kubectl -n dev-querysalad"


