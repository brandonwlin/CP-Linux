# CP-Ubu (WORK IN PROGRESS)
NOTE: IGNORE ALL THE SYNTAX ERRORS; SCRIPT SHOULD STILL WORK

## Tasks Covered by the Script:
### script.sh
1. Root User Check: The script verifies if it is being run with root privileges. If not, it exits with an error message.
2. Restricting Home Directory Access: Home directory (homedir) access is restricted by setting specific permissions for users with user IDs greater than or equal to 1000.
3. Configuring Uncomplicated Firewall (UFW): The script ensures that the UFW firewall is installed, and it configures rules for loopback traffic and outbound connections while disabling unnecessary network protocols.
4. Configuring SSH: The script configures SSH by copying and updating SSH daemon configuration files and setting proper permissions for SSH keys.
5. Installing Security Utilities: Various security-related utilities such as Cracklib, Rootkit Hunter (rkhunter), AuditD, SysStat, acct, DebSums, and apt-show-versions are installed.
6. Adding Legal Banners: Warning banners are added to /etc/issue.net and /etc/issue files to display a warning message to unauthorized users.
7. Disabling Unneeded Software and Services: The script removes specified unneeded software packages and disables unnecessary services listed in the provided files (software.txt and services.txt).
8. Restricting Compiler Access: Access to the GNU Assembler (/usr/bin/x86_64-linux-gnu-as) is restricted to the root user.
9. Setting File Permissions: Various system files and directories related to accounts, groups, PAM, crontab, CUPS, core dumps, and sysctl are given appropriate permissions.
10. Purging Old Packages: Unused packages are removed from the system using apt-get autoremove.
11. Updating Resolver Configuration: The resolver configuration file (/etc/host.conf) is updated.
12. Securing Shared Memory: The /etc/fstab file is updated to secure shared memory.

## Script1 Cklist
1. READ image README
2. Solve FORENSIC QUESTIONS
3. Audit/Manage USERS and GROUPS
4. CLONE this repo (This is a PRIVATE repo, so you will need to LOGIN and DOWNLOAD the code)
5. COMMENT OUT any necessary/CRITICAL SERVICES or programs in services.txt and software.txt
6. Configure UPDATE SETTINGS (Use the Software & Updates GUI tool, or update /etc/apt/sources.list accordingly)
7. Make script EXECUTABLE (chmod +x script.sh)
8. RUN script (./script.sh)
9. Continue with any remaining items on the TEAM CKLIST ([Ubuntu/Linux Check-List-fromCadets](https://docs.google.com/document/d/1BBQ2hGnE1FpdCpkSSvZfeTynFjkIIREwgcZyv4Ld9eQ/edit))  

## Contributing to Script
* Submit Issues and Pull requests