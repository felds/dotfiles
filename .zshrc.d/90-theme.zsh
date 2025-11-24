# # Custom prompt
# PROMPT='
# %{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}
# %{$fg_bold[green]%}→%{$reset_color%} '

# ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

# for color in black red green yellow blue magenta cyan white; do
#     print -P "%F{$color}$color%f"
# done


git_prompt_info() {
	# extract branch
	local ref
	ref=$(git symbolic-ref HEAD 2> /dev/null) || \
	ref=$(git rev-parse --short HEAD 2> /dev/null) || return 0
	local branch="${ref#refs/heads/}"

	# check if anything changed
	local dirty_mark=""
	if [[ -n $(git status --porcelain 2> /dev/null) ]]; then
		dirty_mark="*"
	fi

	echo " git:${branch}${dirty_mark}"
}

prompt_path() {
	local repo_root
	if repo_root=$(git rev-parse --show-toplevel 2> /dev/null); then
		local rel="${PWD#$repo_root}"
		rel=${rel#/}
		printf '%s' "${repo_root##*/}"
		[[ -n $rel ]] && printf '/%s' "$rel"
	else
		printf '%s' "%~"
	fi
}

PROMPT=""
PROMPT+=$'\n'
PROMPT+='%F{242}%n%f'  # username
PROMPT+='@'
PROMPT+='%m'  # hostname
PROMPT+=' '
# PROMPT+='%F{magenta}%3~%f'  # path from ~; max 3 parts
PROMPT+='%F{magenta}$(prompt_path)%f'
PROMPT+='$(git_prompt_info)'
PROMPT+='%(?..%F{red} [%?]%f)'  # error code, if any
PROMPT+=$'\n'
# PROMPT+='❯ '
PROMPT+='$ '


