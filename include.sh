#!/usr/bin/env bash

MOD_NPCITEM_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/" && pwd )"

source "$MOD_NPCITEM_ROOT/conf/conf.sh.dist"

if [ -f "$MOD_NPCITEM_ROOT/conf/conf.sh" ]; then
    source "$MOD_NPCITEM_ROOT/conf/conf.sh"
fi 