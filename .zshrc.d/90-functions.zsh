
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

# download latest intranet backup
# download_pts_backup() {
#         local latest=$(ssh vz-interno-n8n "ls -t /mnt2/db/pts_financeiro_new/*.sql | head -n 1 | sed 's/ /\\\\ /g'")
#         scp vz-interno-n8n:"$LATEST" .
# }
download_pts_backup() {
	local host="vz-interno-n8n"
	local latest=$(ssh "$host" "ls -t /mnt2/db/pts_financeiro_new/*.sql | head -n 1 | sed 's/ /\\\\ /g'")
	local fixed_name=$(echo "$latest" | gsed -E 's|^.*/(.*)$|\1|g; s|\W+|_|g')

	echo "Downloading db dump: $latest"
	scp "${host}:${latest}" "$fixed_name"

	echo "Fixing it up to work with MySQL 8/9"
	gsed 	-e 's/ROW_FORMAT=COMPACT/ROW_FORMAT=DYNAMIC/g' \
		-e 's/pts_prod/main/g' \
		-e 's/NO_AUTO_CREATE_USER,//g' \
		-i "$fixed_name"

	echo "Done!"
}

# connect to an ssh host and send git info
ssh-git() {
    GIT_AUTHOR_NAME="$(git config user.name)" \
    GIT_AUTHOR_EMAIL="$(git config user.email)" \
    GIT_COMMITTER_NAME="$(git config user.name)" \
    GIT_COMMITTER_EMAIL="$(git config user.email)" \
    ssh -A -o SendEnv="GIT_*" "$@"
}
