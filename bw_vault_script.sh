#!/bin/bash
#
# Set bitwarden server 
#
#   bw config server https://bitwardenrs.example.org/
#
# Login to bitwarden
#
#   bw login --raw
# 
# Enable in ansible.cfg
#
#   [defaults]
#   vault_password_file = ./bw_vault_password.sh

set -euo pipefail

if ! [ -x "$(command -v jq)" ]; then
    >&2 echo 'Error: jq is not installed, or not found in path.'
    >&2 echo 'See playbooks/install_bitwarden_cli.yml to install.'
    exit 1
fi

if ! [ -x "$(command -v bw)" ]; then
    >&2 echo 'Error: bw cli is not installed, or not found in path.'
    >&2 echo 'See playbooks/install_bitwarden_cli.yml to install.'
    exit 1
fi

case "$(bw status | grep -v '^Session key' | jq --raw-output .status)" in
    "unauthenticated")
        >&2 echo 'bw is not authenticated. For help see: bw login --help.'
        exit 1
        ;;
    "locked")
        >&2 echo 'bw vault is locked. For help see: bw unlock --help.'
        >&2 echo 'Try'
        >&2 echo '    export BW_SESSION=$( bw unlock --raw ); echo $BW_SESSION'
        exit 1
        ;;
    "unlocked")
        bw get password 'ansible vault'
        exit $?
        ;;
    *)
        >&2 echo 'bw is in an unknown state.'
        exit 1
        ;;
esac
