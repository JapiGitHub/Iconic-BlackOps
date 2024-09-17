#!/bin/bash

extension_version=$(jq -r .version package.json)
#                      -r  = exclude the original double quotes from version value
#                            , otherwise -> Error: ENOENT: no such file or directory, open '/home/json/projects/CTF-notes-tools/Iconic-BlackOps/hack-theme-"0.0.5-rc2".vsix'

echo "packaging version : $extension_version"
vsce package

code --install-extension hack-theme-$extension_version.vsix --force

echo "installation success"

echo "deleting old .vsix packages"