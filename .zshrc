autoload compinit
compinit


# Don't add lines starting with spaces to history
setopt HIST_IGNORE_SPACE

# Set default editor
export EDITOR=vim
export VISUAL=vim

# export LANG=pt_BR.UTF-8
# export LC_ALL=pt_BR.UTF-8


# HOME BIN
export PATH="$HOME/bin:$HOME/config/bin:$PATH"


# Load completions
. $HOME/.zsh/completions/*


# configure how the shell break words, for ctrl+w and opt+direction commands
# it should be paired with .inputrc 
WORDCHARS='*?_[]~='  


# =============================================================================
# =============================================================================
# =============================================================================


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
