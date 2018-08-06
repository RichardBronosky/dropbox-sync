#!/bin/bash

local_dir="$HOME/synced"
remote_dir="$(basename $local_dir)"

function main(){
	cd $(dirname $(readlink -f $0))
	python3 updown.py -d --token $(cat oauth.token) $remote_dir $local_dir
}

# Only run the main function if executed (not sourced)
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi
