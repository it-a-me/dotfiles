#!/bin/sh 
source "${HOME}/.scripts/shutil.sh"

deps jq pw-dump
PW_DUMP="$(pw-dump)"
DEFAULT_SOURCE="$(printf "%s" "$PW_DUMP" |
    jq -r '.[] |
        select(.props["metadata.name"] == "default").metadata[] |
        select(.key == "default.audio.source").value.name'
    )"
pw-dump -N | 
    jq --arg default_source "$DEFAULT_SOURCE" '
        map(
            select(.info.props["media.class"] == "Audio/Source") |
                { 
                    id: .id,
                    name: .info.props["node.name"],
                    description: .info.props["node.description"],
                    state:.info.state,
                    mute: .info.params.Props[0].mute,
                    default: (.info.props["node.name"] == $default_source)
                }
            )'
