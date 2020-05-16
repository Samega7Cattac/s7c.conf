function get_git_status() {
  if [[ -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
    local git_status="$(git_prompt_status)"
    if [[ -n $git_status ]]; then
      git_status="($git_status%{$reset_color%}) "
    fi
    echo $git_status
  fi
}

#PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[red]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) $(get_git_status)%(!.#.$) '
PROMPT='%{$fg[red]%}%n%{$reset_color%}@%{$fg[red]%}%m%{$reset_color%} %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="[$(git_prompt_short_sha)]%{$fg[red]%} ✗%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="[$(git_prompt_short_sha)]%{$fg[blue]%} ✔%{$fg_bold[blue]%})"

#ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}*%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}>%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}=%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%}"

RPROMPT='%{$fg[red]%}[$?]%{$reset_color%}'
