#!/bin/bash

echo "==========================================="
echo "Matching PASS from /etc/login.defs"
echo "==========================================="
sudo grep PASS /etc/login.defs

 #/etc/pam.d/common-password
echo "==========================================="
echo "Matching password from /etc/pam.d/common-password"
echo "==========================================="
sudo grep ^password /etc/pam.d/common-password

echo
echo "Done."