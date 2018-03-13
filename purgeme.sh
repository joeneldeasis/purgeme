#!/bin/bash
RED="\033[0;31m"
GREEN="\033[0;32m"
NC="\033[0m"
USER=$(whoami)

if [ $USER != "root" ]; then
	echo "You must run this script as root!"
	exit 1;
fi

printf "${RED}[WARNING]${NC}RUN THIS SCRIPT AT YOUR OWN RISK${RED}[WARNING]${NC}\\n"
sleep 2

rm -f /tmp/pmlogs.txt
find /var/log -name \*.log >> /tmp/pmlogs.txt

if [ $(which wipe) = "" ]; then
	if [[ "$(uname -a | grep -i ubuntu)" = *"ubuntu"* ]]; then
    	sudo apt-get update && sudo apt-get install wipe -y
	elif [[ "$(uname -a | grep -i debian)" = *"debian"* ]]; then
    	sudo apt-get update && sudo apt-get install wipe -y
    elif [[ "$(uname -a | grep -i centos)" = *"centos"* ]]; then
    	yum install wipe -y
	fi  
fi

printf "Logs to be purged in ${RED}/var/log${NC} DIRECTORY\\n"
printf "==================================================\\n"
cat /tmp/pmlogs.txt
printf "==================================================\\n"
read -rp "Delete these logs now? (Y/n): " choice

if [ $choice = "Y" ] || [ $choice = "y" ] || [ $choice = "" ]; then
	printf "==================================================\\n"
	printf "Cleaning up logs found under the /var/log directory\\n"
	while read -r var; do
  		wipe -f $var
		printf "${GREEN}[DONE]${NC} Wiping %s ...\\n" "$var"
	done </tmp/pmlogs.txt
	printf "===============${GREEN}[OPERATION COMPLETED]${NC}===============\\n"
elif [ $choice = "N" ] || [ $choice = "n" ]; then
	printf "Operation Aborted. No log files were harmed.\\n"
else 
	printf "Operation Aborted. Unknown choice.\\n"
fi
