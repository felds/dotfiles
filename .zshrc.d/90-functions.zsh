
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

