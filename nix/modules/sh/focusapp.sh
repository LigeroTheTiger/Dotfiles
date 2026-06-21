#!/bin/bash

app_name="$1"

# Ensure app_name ends with .app
[[ "$app_name" != *.app ]] && app_name="${app_name}.app"

# Search for the .app using Spotlight (first match is used)
app_path=$(mdfind "kMDItemKind == 'Application' && kMDItemDisplayName == '${app_name}'" | head -n 1)

if [[ -z "$app_path" ]]; then
  echo "App '$app_name' not found on system."
  exit 1
fi

# Look for a matching window in the focused workspace
id=$(aerospace list-windows --workspace focused | awk -F '|' -v name="${app_name%.app}" '
  $2 ~ name {
    gsub(/ /, "", $1);
    print $1;
    exit
  }')

if [[ -n "$id" ]]; then
  aerospace focus --window-id "$id"
else
  open -n "$app_path"
fi 
