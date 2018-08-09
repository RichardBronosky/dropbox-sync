# Dropbox Sync

### The fastest way to do a Dropbox selective sync with Linux (or anything with Python and Bash)

This is mainly just a wrapper around https://github.com/dropbox/dropbox-sdk-python/blob/master/example/updown.py

This is a demo of how I use it on Linux servers and Raspberry Pis. I've created this project to serve as executable documentation to make my life easier every time I need a new machine to sync a directory with Dropbox.

# Setup

1. Clone this repo
1. Get a Dropbox Access Token
    1. Head to https://www.dropbox.com/developers/apps/create
    1. Select Dropbox API
    1. Pick an option either "App folder" or "Full Dropbox" access (but note the "as is" disclaimer in the license)
    1. Give your "app" a unique name
    1. Generate an OAuth 2 token using the default settings
    1. Store the 64 characters of that token (and nothing else) in the file `oauth.token` in the repo directory
1. Execute `setup.sh`
    1. Use the `-d` argument to accept the default directory of `~\synced`.
    1. Use `-d directory/path` to change the default (or edit run.sh manually to specify specific values for `$remote_dir` and `$local_dir`.
1. Execute `~\synced\sync.sh` (or whatever directory/path you gave in the previous step.)

If you already have an OAuth 2 token, that looks like this:

    git clone https://github.com/RichardBronosky/dropbox-sync.git
    echo "token_data-token_data-token_data" > dropbox-sync/oauth.token
    $(dropbox-sync/setup.sh -d synctest)

    # That last line executes the return value of setup.sh...
    # which is the path of the created symlink in the sync directory...
    # which point to the run.sh in the cloned repo.

    # Sounds complicated, but it's really slick to be able to
    # setup dropbox sync with a single copy-paste from your notes.
