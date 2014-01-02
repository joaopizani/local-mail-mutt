#!/usr/bin/env bash

DIR="$(cd -P "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")" )" && pwd)"

mkdir -p "${HOME}/bin"

# mail directories, mutt directories and mu directories
mkdir -p "${HOME}/comm/mutt"
mkdir -p "${DIR}/mu/{cache,xapian,results,log}"
ln -f -s -n "${HOME}/comm/mutt"                       "${HOME}/.mail"
ln -f -s -n "${DIR}/mu"                               "${HOME}/.mu"

mkdir -p "${HOME}/Downloads/mutt-attachments"
ln -f -s -n "${DIR}/mutt/themes/inkpot-256.theme"     "${DIR}/mutt/themes/current-theme.rc"
ln -f -s -n "${DIR}/mutt"                             "${HOME}/.mutt"

# mutt-open and urlview
ln -f -s -n "${DIR}/archival/mutt-open"               "${HOME}/bin/mutt-open"

# offlineimap
ln -f -s -n "${DIR}/offlineimap/offlineimap.rc"       "${HOME}/.offlineimaprc"
ln -f -s -n "${DIR}/offlineimap/offlineimap.py"       "${HOME}/.offlineimap.py"


"${DIR}/msmtp/install.sh"

"${DIR}/archival/install.sh"

"${DIR}/goobook/install.sh"


# Setting username and password in the system keyring
EMAIL_ADDRESS_FILE_LINK="${HOME}/.localmail-custom/username-gmail"
EMAIL_ADDRESS=$(cat "${EMAIL_ADDRESS_FILE_LINK}")

read -r -d '' PYCMD <<EOF
import keyring
keyring.set_password("localmail-gmail", "${EMAIL_ADDRESS}", raw_input("gmail-password > "))
EOF

python -c "$PYCMD"

