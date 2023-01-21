# ZSH Theme emulating the Fish shell's default prompt.

_fishy_collapsed_wd() {
  local i pwd
  pwd=("${(s:/:)PWD/#$HOME/~}")
  if (( $#pwd > 1 )); then
    for i in {1..$(($#pwd-1))}; do
      if [[ "$pwd[$i]" = .* ]]; then
        pwd[$i]="${${pwd[$i]}[1,2]}"
      else
        pwd[$i]="${${pwd[$i]}[1]}"
      fi
    done
  fi
  echo "${(j:/:)pwd}"
}

local user_color='green'; [ $UID -eq 0 ] && user_color='red'
PROMPT='%n %{$fg[$user_color]%}$(_fishy_collapsed_wd)%{$reset_color%} $(git_prompt_info)%(!.#.>) '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status="%{$fg_bold[red]%}%(?..%?)%{$reset_color%}"
RPROMPT="${RPROMPT}"'${return_status}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*"
