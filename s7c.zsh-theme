function git_prompt_info() {
  local ref
  if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(__git_prompt_git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return 0
    print -P "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ "${DISABLE_UNTRACKED_FILES_DIRTY:-}" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    case "${GIT_STATUS_IGNORE_SUBMODULES:-}" in
      git)
        # let git decide (this respects per-repo config in .gitmodules)
        ;;
      *)
        # if unset: ignore dirty submodules
        # other values are passed to --ignore-submodules
        FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"
        ;;
    esac
    STATUS=$(__git_prompt_git status ${FLAGS} 2> /dev/null | tail -n1)
  fi
  if [[ -n $STATUS ]]; then
    print -P "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    print -P "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[red]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY='[$(git_prompt_short_sha)]%{$fg[red]%} ✗%{$fg[blue]%})%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_CLEAN='[$(git_prompt_short_sha)]%{$fg[blue]%} ✔%{$fg_bold[blue]%})'

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}*%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}>%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}=%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

RPROMPT='%{$fg[red]%}[$?]%{$reset_color%}'
