# Backup-and-rsync-PostgreSQL
Bash script which backups PostgreSQL DB with archive rotation and rsync to remote location

## Getting Started

### Steps for deploying backup:

1. clone the project

2. edit crontab -

```
crontab -e
```
3. add our script as follow to run it twice a day

```
1 */12 * * * ##script-directory full path##/script.sh
```
