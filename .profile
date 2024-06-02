export ENV=$HOME/.config/init.sh


TMP=$(mktemp)
ssh-agent > ${TMP}
. ${TMP}
rm ${TMP}

ssh-add ~/.ssh/signing_key
