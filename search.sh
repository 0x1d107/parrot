#!/bin/bash
DOWNLOADER='transmission-remote -a'

magnet=$(sqlite3 topics.db "select title,'magnet:?xt=urn:btih:' || hash 
from topics where  title match '$1';"| bash dialog-selector.sh)
[ -n "$magnet" ] && $DOWNLOADER "$magnet"
