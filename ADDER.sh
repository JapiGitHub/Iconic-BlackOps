#!/bin/bash

# Dynamic values
id="$1"
alias="${id} log"
extension=".$1"

# Add the new language to package.json
jq --arg id "$id" \
   --arg alias "$alias" \
   --arg extension "$extension" \
   '.contributes.languages += [{
     "id": $id,
     "aliases": [$alias],
     "extensions": [$extension],
     "configuration": "./language-configuration.json"
   }]' package.json > tmp.$$.ADDER.json && mv tmp.$$.ADDER.json package.json

# Add the new icons.json entry
jq --arg id "$id" \
   --arg alias "$alias" \
   --arg extension "$extension" \
   '.iconDefinitions += { ($id + "-icon") : {"iconPath" : ("./" + $id + "-icon.png"),}}' icons/icons.json > tmp.$$.ADDER.json && mv tmp.$$.ADDER.json icons/icons.json

# Add the new icons.json entry
jq --arg id "$id" \
   --arg alias "$alias" \
   --arg extension "$extension" \
   '.fileExtensions += { $id : ($id + "-icon")}' icons/icons.json > tmp.$$.ADDER.json && mv tmp.$$.ADDER.json icons/icons.json

#cleanup
rm tmp.*.ADDER.json || echo "no changes made"