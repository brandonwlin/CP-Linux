#!/bin/bash

MY_INSTALLED_APPS=$(apt list --installed | cut -d/ -f1 | sort | uniq)
KNOWN_APPS_FILE="known_default_packages_debian.txt"

if [ ! -f "$KNOWN_APPS_FILE" ] ;then
  echo "ERROR: file $KNOWN_APPS_FILE not found"
  exit 1
fi

echo "Displaying all installed apps not found in a default debain 11 clean install"
for APP in $MY_INSTALLED_APPS; do
  if ! grep -q "^${APP}$" $KNOWN_APPS_FILE ; then
    echo $APP
  fi
done
