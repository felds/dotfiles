# Load antidote and plugins
. $HOME/config/.antidoterc


# Custom prompt
PROMPT='
%{$fg[cyan]%}%~ %{$fg_bold[blue]%}$(git_prompt_info)%{$reset_color%}
%{$fg_bold[green]%}→%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"


# Set default editor
export EDITOR=vim
export VISUAL=vim


# Don't add lines starting with spaces to history
setopt HIST_IGNORE_SPACE


# Brew
# - stop brew from updating everything every time we install anything
export HOMEBREW_NO_AUTO_UPDATE=1


# HOME BIN
export PATH="$HOME/bin:$HOME/config/bin:$PATH"


# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# pip3
export PATH="$PATH:$HOME/Library/Python/3.7/bin"








# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true


# Custom functions









export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# after installing mysql-client via brew
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig"


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# asdf
# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export PATH="$PATH:$HOME/.deno/bin"

# Load completions
. $HOME/.zsh/completions/*


# export LANG=pt_BR.UTF-8
# export LC_ALL=pt_BR.UTF-8
#

WORDCHARS='*?_[]~='  # sem /-_. para que quebrem a palavra




# =============================================================================
# Functions 
# =============================================================================

# gitignore generator
gi() { curl -sLw "\\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

# download yt video as mp3
youtube-dl-mp3() { youtube-dl -x --audio-format mp3 $@ ;}

# Prints the current timestamp in an ISO-ish 
timestamp() { date +"%Y-%m-%d-%H-%M-%S" ;}

# create webfonts using fontforge
webfonts() {
  echo "Generating webfonts for font $1 with the name of $2"
  fontforge -lang=ff -c 'Open($1); Generate($2)' $1 "$2.woff"
  fontforge -lang=pe -c 'Open($1); Generate($2)' $1 "$2.woff2"
}

# fix OpenVPN recurring failure to connect
ovpn_fix() {
  echo "Restarting OpenVPN agent…"
  sudo launchctl unload -w /Library/LaunchDaemons/org.openvpn.client.plist
  sudo launchctl load  -w /Library/LaunchDaemons/org.openvpn.client.plist
  echo "Checking process:"
  pgrep -fl ovpnagent || echo "⚠️  Agent still not running!"
}

# open target into PHPStorm
pstorm() { open -na "PhpStorm.app" --args $@ ;}

# create a new folder and cd into it
m() { mkdir -p $@ && cd ${@: -1} ;}

# create a new temporary folder and cd into it
mt() { cd $(mktemp -d)  }

# redirect calls for gcloud to gctx
gcloud() { gctx "$@"; }

git_cleanup_branches() { git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d; }