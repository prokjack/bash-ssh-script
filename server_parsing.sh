function getsettings() {
    local PARAMS="$#"
    # TODO: pretty slow part with jq, need to improve
    local JSON=`jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" <<< "$1"`
    local KEYS=''

    if [ $# -gt 1 ]; then
        KEYS="$2"
    fi

    while read -r PAIR; do
        local KEY=''

        if [ -z "$PAIR" ]; then
            break
        fi

        IFS== read PAIR_KEY PAIR_VALUE <<< "$PAIR"

        if [ -z "$KEYS" ]; then
            KEY="$PAIR_KEY"
        else
            KEY="$KEYS:$PAIR_KEY"
        fi

        if jq -e . >/dev/null 2>&1 <<< "$PAIR_VALUE"; then
            getsettings "$PAIR_VALUE" "$KEY"
        else
        	SETTINGS_KEYS+=("$KEY");
            SETTINGS["$KEY"]="$PAIR_VALUE"
        fi
    done <<< "$JSON"
}

function join_by { local IFS="$1"; shift; echo "$*"; }


function _show {
    _arguments -C \
        "1: :("$(join_by ' ' '${SETTINGS_KEYS[@]}')")"
}

function show () {
    arg1="$1"
    IFS=$'\n' sorted_show_array=($(sort <<<"${SETTINGS_KEYS[*]}"))
    unset IFS
    server=localhost
    if [ -z "$1" ]; then
        # display usage if no parameters given
        echo "Usage: show <name_of_server>" 
        printf '%s\n' "${sorted_show_array[@]}"
        return 1
    else
        server=$SETTINGS["$arg1"]
    fi
    ssh -A -tt ubuntu@$server ". ~/.profile; sudo -s"
}

getsettings "$SETTINGS_JSON"