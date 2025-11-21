# Documentation:
# https://antidote.sh/

# Clone antidote if necessary.
ANTIDOTE_DIR="${ZDOTDIR:-$HOME}/.antidote"
if [[ ! -e "$ANTIDOTE_DIR" ]]; then
	echo "Antidote not found. Cloning it into ${ANTIDOTE_DIR}."
	git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_DIR"
fi

source "$ANTIDOTE_DIR/antidote.zsh"
antidote load
