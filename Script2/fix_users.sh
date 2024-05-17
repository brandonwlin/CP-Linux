#!/bin/bash

# Create myusers.sh and mypass.txt - Set password to Pa$$w0rd1234
echo "echo \"Pa\$\$w0rd1234\" >> mypass.txt" > myusers.sh
echo "echo \"Pa\$\$w0rd1234\" >> mypass.txt" >> myusers.sh
echo "" >> myusers.sh

# Run the awk command and append the sorted output to myusers.sh
awk -F: '$3 >= 1000 && $3 < 6000 {print "#passwd " $1 " < mypass.txt"}' /etc/passwd | sort >> myusers.sh

# Open myusers.sh in a text editor
editor myusers.sh

# Make myusers.sh executable and run
chmod +x myusers.sh
./myusers.sh
