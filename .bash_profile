SETTINGS_FILE="$HOME/Developer/scripts/servermap.txt"
SETTINGS_JSON=`cat "$SETTINGS_FILE"`
typeset -A SETTINGS
declare SETTINGS_KEYS=()

$HOME/Developer/scripts/server_parsing.sh getsettings "$SETTINGS_JSON"

compdef _show show