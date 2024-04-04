#!/bin/bash
[ -z $GENMAP_NAME ] && echo "GENMAP_NAME not set" && exit

echo "layout: {qmk_info_json: info.json}" > "map.yaml"
keymap -c config.yaml parse -c 10 -z "../config/${GENMAP_NAME}.keymap" >> "map.yaml" \
    && keymap -c config.yaml draw "map.yaml" > "map.svg"
