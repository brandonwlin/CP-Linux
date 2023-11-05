#!/bin/bash

echo "==========================================="
echo "Displaying a summary of /etc/sudoers"
echo "==========================================="
sudo sudo cat /etc/sudoers | grep -Ev ^#| grep -Ev '^$'
echo

echo "==========================================="
echo "Displaying and 'include' statements"
echo "==========================================="
sudo grep -i include /etc/sudoers

echo "==========================================="
echo "Displaying any files in /etc/sudoers.d"
echo "==========================================="
find /etc/sudoers.d -type f
echo

echo "all done"