#!/bin/sh 
source "${HOME}/.scripts/shutil.sh"

deps jq pw-dump
PW_DUMP="$(pw-dump)"
DEFAULT_SINK="$(printf "%s" "$PW_DUMP" |
    jq -r '.[] |
        select(.props["metadata.name"] == "default").metadata[] |
        select(.key == "default.audio.source").value.name'
    )"
pw-dump -N | 
    jq --arg default_sink "$DEFAULT_SINK" '
        map(
            select(.info.props["media.class"] == "Audio/Sink") |
                { 
                    id: .id,
                    name: .info.props["node.name"],
                    description: .info.props["node.description"],
                    state:.info.state,
                    default: (.info.props["node.name"] == $default_sink)
                }
            )'
