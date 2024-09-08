#!/bin/sh
set -eu
borg create -v --stats "/data/@backups::$(date --iso-8601)" ~ --exclude-if-present '.BACKUP_IGNORE'
