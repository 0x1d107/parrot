#!/bin/bash
DOWNLOADER='ssh gondor transmission-remote -a'

sqlite3 -separator '	'  topics.db "select title,'magnet:?xt=urn:btih:' || hash 
from topics where  title match '$1';">select.txt
python selector.py select.txt selected.txt
magnet="$(cut -f2<selected.txt)"
[ -n "$magnet" ] && $DOWNLOADER "$magnet"
echo > selected.txt
