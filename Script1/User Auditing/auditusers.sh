#!/bin/bash

# Colors
YES="[\033[0;32m ✓ \033[0m]"
NO="[\033[0;31m ✗ \033[0m]"

overwrite() { echo -e "\r\033[1A\033[0K$@"; }

if [ $EUID -ne 0 ]; then
  echo -e "${NO} Script called with non-root privileges"
  exit 1
fi
echo -e "${YES} Root user check"

if [[ -f "allusers.txt" ]]; then
  echo -e "${YES} Users file found"
else
  echo -e "${NO} Users file not found"
  exit 1
fi

if [[ -f "admins.txt" ]]; then
  echo -e "${YES} Admins file found"
else
  echo -e "${NO} Admins file not found"
  exit 1
fi

echo -e "[ i ] Adding specified users..."
while read line; do 
  useradd -m $line &> /dev/null
done < allusers.txt
overwrite "${YES} All users added"

echo -e "[ i ] Removing unauthorized users..."
IFS=':'
while read -r user pass uid gid desc home shell; do
  if (($uid >= 1000)) && !(grep -q $user "allusers.txt"); then
    userdel -r $user &> /dev/null
  fi
done < /etc/passwd
overwrite "${YES} Unauthorized users removed"

echo -e "[ i ] Updating user passwords..."
ME=$(whoami)
while read line; do
  if [ "$line" != "$ME" ]; then  # Skip ME
  echo $line'Pa\$\$w0rd1234' | chpasswd &> /dev/null
  chage -m 7 -M 90 -W 10 &> /dev/null
  fi
done < allusers.txt
overwrite "${YES} User passwords updated"

echo -e "[ i ] Disabling root account..."
passwd -l root
overwrite "${YES} Disabled root account"

echo -e "[ i ] Configuring admin privileges"
while read -r user pass uid gid desc home shell; do
  if (($uid >= 1000)); then
    if grep -q $user "admins.txt"; then
      usermod -aG sudo $user > /dev/null
    else
      gpasswd -d $user sudo &> /dev/null
    fi
  fi
done < /etc/passwd
overwrite "${YES} Admin priviliges configured"
