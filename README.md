# purgeme
Purgeme is a log purger for rhel/centos and debian based OSes. This script will wipe all the logs located in `/var/log` using the wipe method.

## Clone the repository
```
git clone https://github.com/joeneldeasis/purgeme/
```

## Change permission

```
chmod +x purgeme/purgeme.sh
```

## Run as root in order to delete the logs in `/var/log`

```
sudo ./purgeme.sh
```
