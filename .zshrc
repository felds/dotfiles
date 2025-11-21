# Load antidote and plugins
. $HOME/config/.antidoterc

autoload -Uz compinit
compinit -C  # Usa cache

# Custom prompt
PROMPT='
%{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}
%{$fg_bold[green]%}→%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


# Don't add lines starting with spaces to history
setopt HIST_IGNORE_SPACE

# Set default editor
export EDITOR=vim
export VISUAL=vim

# export LANG=pt_BR.UTF-8
# export LC_ALL=pt_BR.UTF-8




# # HOME BIN
# export PATH="$HOME/bin:$HOME/config/bin:$PATH"

# # after installing mysql-client via brew
# export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# # export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
# # export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
# # export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"

# # bun completions
# [ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# export PATH="$PATH:$HOME/.deno/bin"

# # Load completions
# . $HOME/.zsh/completions/*


WORDCHARS='*?_[]~='  # sem /-_. para que quebrem a palavra


# =============================================================================
# =============================================================================
# =============================================================================


# cache completitions for 24hs
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
	compinit
else
	compinit -C
fi


# load additional zsh configs
if [[ -d ~/.zshrc.d ]]; then
	for file in ~/.zshrc.d/*.zsh; do
		source "$file"
  	done
fi


# local overrides
if [[ -f ~/.zshrc.local ]]; then
	source ~/.zshrc.local
fi
