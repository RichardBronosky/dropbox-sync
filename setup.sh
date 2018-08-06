#!/bin/bash -eux

rdir="$(pwd)"
pdir="$(dirname $(readlink -f $0))"

# Change the folder to be synced (from the default of 'synced')
if [[ $# -eq 2 && $1 = "-d" && -n $2 ]]; then
local_dir="$(realpath $2)"
sed -E -i "s?(local_dir=).*?\1$local_dir?" $pdir/run.sh
fi

# Get the variables, but don't execute
source $pdir/run.sh

if [[ $# -eq 0 || $# -eq 1 && $1 != "-d" ]]; then
cat << EOF

Usage: $(basename $0) -d [dirname]
  If dirname is not provided, the default of '$local_dir' is used.
  If -d is not provided, this help message is displayed.

EOF
exit 255
fi

pip3 install -r $pdir/requirements.txt > /dev/stderr
(cd $pdir; wget https://raw.githubusercontent.com/dropbox/dropbox-sdk-python/master/example/updown.py)

if ! [[ -e $pdir/oauth.token ]]; then
cat > /dev/stderr <<EOF

At this point you need to get a Dropbox Access Token and store it in oauth.token

1. Head to https://www.dropbox.com/developers/apps/create
2. Select Dropbox API
3. Pick an option either "App folder" or "Full Dropbox" access (but note the disclaimer in the license)
4. Give your app the name
5. Generate an OAuth 2 token using the default settings
6. Store the 64 characters of that token (and nothing else) in the file oauth.token in this directory

After that, you can run:
EOF
fi


mkdir -p $local_dir
[[ -L $local_dir/sync.sh ]] || ln -s $pdir/run.sh $local_dir/sync.sh
echo $local_dir/sync.sh

