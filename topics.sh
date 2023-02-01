#!/bin/bash
SECTIONS=(1950 2200 1808 1840 1864 1810 930 209)
mkdir -p topics
cd topics
echo ${SECTIONS[*]}|tr ' ' '\n'|xargs -I '{}' curl --compressed 'https://api.rutracker.cc/v1/static/pvc/f/{}' \
|jq -r '.result|keys[]'|pr -t100 -s',' -W 9001|tr -d '\t '\
|sed 's|^|https://api.rutracker.cc/v1/get_tor_topic_data?by=topic_id\&val=|'\
| ../wario -c 16 --rename '{index}.json' -f '-' 
cd ..
cat topics/*.json |jq -r \
    '.result|select (. != null)|.[]|select(.!=null)|([.info_hash,.topic_title])|@csv'>topics.csv
sqlite3 -init topics.sql topics.db ''
rm -r topics topics.csv
