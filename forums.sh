curl -L --compressed https://api.rutracker.cc/v1/static/cat_forum_tree|jq|grep -i "$*"
