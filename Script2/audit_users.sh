#!/bin/bash

# Script to do some of the tedious work of a user audit

LOGFILE="./logfile.txt"
VALID_USERS="valid_users.txt"      # populate manually from README
VALID_ADMINS="valid_admins.txt"    # populate manually from README
KNOWN_UBUNTU_USERS="known_default_ubuntu_users.txt"
SUDO_GROUPS="admin sudo"           # space delimited, must set this manually
HOME_DIR="$HOME"
BACKUP_DIR="$HOME/BACKUP_DIR"

# PULLED FROM grep UID /etc/adduser.conf
FIRST_UID=1000
LAST_UID=59999

# Function log()
log() {
  DATE=$(date "+%D %T")
  echo "$DATE: $*"
  echo "$DATE: $*" >> $LOGFILE
}

# Function log_error()
log_error() {
  DATE=$(date "+%D %T")
  echo "$DATE: WEIRD: $*"
  echo "$DATE: WEIRD: $*" >> $LOGFILE
}

# MAIN PROGRAM

if [[ ! -f "$VALID_USERS" || ! -f "$VALID_ADMINS" ]] ; then
  echo "Required files not found."
  echo "Creating: $VALID_USERS"
  echo "Creating: $VALID_ADMINS"
  touch "$VALID_USERS" "$VALID_ADMINS"
  echo 
  echo "Please put data into these files and run again"
  echo "COPY/PASTE: gedit $VALID_USERS $VALID_ADMINS"
  exit
fi

VALID_USERS="valid_users.txt"      # populate manually from README
VALID_ADMINS="valid_admins.txt"    # populate manually from README

rm "$LOGFILE"
log "Displaying all users in /etc/passwd where UID >= $FIRST_UID"
cat /etc/passwd | awk -v MIN_ID="$FIRST_UID" -v MAX_ID="$LAST_UID" -F: '$3 >= MIN_ID && $3 <= MAX_ID {print}' | sort | cat -n | tee -a $LOGFILE


log
log "Checking if all vaild users per file '$VALID_USERS' exist in /etc/passwd"
if [ -f "$VALID_USERS" ] ;then

  for USER in $(cat "$VALID_USERS") ; do
    if grep -q "^${USER}:" /etc/passwd ; then
      log "found valid user $USER" 
    else 
      log_error "missing valid $USER" 
    fi
  done
else 
 log_error "file missing: $VALID_USERS" 
fi 


log
log "Checking if all vaild admins per file '$VALID_ADMINS' exist in /etc/passwd"
if [ -f "$VALID_ADMINS" ] ;then

  for USER in $(cat "$VALID_ADMINS") ; do
    if grep -q "^${USER}:" /etc/passwd ; then
      log "found valid admin $USER" 
    else 
      log_error "missing valid admin $USER" 
    fi
  done
else 
 log_error "file missing: $VALID_ADMINS" 
fi 

log
log "Checking if all users on the system are vaild"
 
for USER in $(cat /etc/passwd | awk -v MIN_ID="$FIRST_UID" -v MAX_ID="$LAST_UID" -F: '$3 >= MIN_ID && $3 <= MAX_ID {print $1}'| sort ); do
  if grep -q $USER "$VALID_USERS" ; then
    log "User $USER is a vaild user per $VALID_USERS"
  elif grep -q $USER "$VALID_ADMINS" ; then
    log "User $USER is a vaild admin per $VALID_ADMINS"
  else
    log_error "$USER is not a valid user or admin and was found in /etc/passwd"
  fi
done

log
log "Displaying all users in sudo groups"
SUDO_USERS=" "
for SUDO_GROUP in $SUDO_GROUPS; do
  USERS=$(grep "^${SUDO_GROUP}:" /etc/group | cut -d: -f4 )
  log "SUDO_GROUP='$SUDO_GROUP'  USERS_IN_GROUP='$USERS'"
  # create a space delimited list of SUDO_USERS, with leading and trailing space
  for USER in $(echo $USERS | sed 's/,/ /g') ; do
   SUDO_USERS="$SUDO_USERS $USER "
  done
done
log "DEBUG: SUDO_USERS='$SUDO_USERS'"

log
log "Checking if all admins found are supposed to be admins per $VALID_ADMINS"
  for USER in $SUDO_USERS ; do
    if grep -q "^$USER$" "$VALID_ADMINS" ; then
      log "$USER is a VALID ADMIN"
    else
      log_error "$USER has admin privileges, but is not but is not a VALID ADMIN per $VALID_ADMINS"
    fi
  done

log
log "Checking if all vaild_admins are actually setup as admins"
for USER in $(cat "$VALID_ADMINS") ; do
  # echo "checking $USER "
  if echo "'$SUDO_USERS'" | grep -q " $USER " ; then
    log "$USER is in $VALID_ADMINS and was found with admin privileges"
  else
    log_error "$USER is in $VALID_ADMINS, but does not have admin privileges"
  fi
done

log
log "Checking if ALL users are known by $KNOWN_UBUNTU_USERS"
for USER in $(cat /etc/passwd | awk -v MIN_ID="$FIRST_UID" -v MAX_ID="$LAST_UID" -F: '$3 < MIN_ID || $3 > MAX_ID {print $1}'| sort | cut -d: -f1 ); do
  if grep -q "^$USER," $KNOWN_UBUNTU_USERS; then
    log "found $USER in KNOWN_UBUNTU_USERS $KNOWN_UBUNTU_USERS"
  else
    log_error "Unable to find $USER in KNOWN_UBUNTU_USERS $KNOWN_UBUNTU_USERS"
  fi
done


log "Creating backup of key files"
if [ ! -d "$BACKUP_DIR" ] ; then
  mkdir -v "$BACKUP_DIR"
fi

BACKUP_DATE=$(date +%Y.%m.%d-%H.%M.%S)
for FULL_FILENAME in /etc/passwd /etc/group ; do
  NEW_FILENAME=$(echo $FULL_FILENAME | sed 's^/^_^g')
  cp -vp "$FULL_FILENAME" "${BACKUP_DIR}/$NEW_FILENAME.${BACKUP_DATE}"
done

echo "Displaying weird stuff"
grep WEIRD $LOGFILE
