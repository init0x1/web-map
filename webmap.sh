#!/bin/bash
########################################################
# webmap Tool For Exploring websites                   #
# Wirtten By 0xAbdoAli                                 #
# https://github.com/0xAbdoAli/web-map                 #
########################################################

###################

#Colors
ORANGE="\e[33m"
STOP="\e[0m"
BLACK="\e[90m"
RED="\e[91m"
GREEN="\e[92m"
YELLOW="\e[93m"
BLUE="\e[94m"
PURPLE="\e[95m"
CYAN="\e[96m"
WHITE="\e[97m"
#################
printf "\n\n${GREEN}
               _                             
             | |                            
__      _____| |__    _ __ ___   __ _ _ __  
\ \ /\ / / _ \ '_ \  | '_ ` _ \ / _` | '_ \ 
 \ V  V /  __/ |_) | | | | | | | (_| | |_) |
  \_/\_/ \___|_.__/  |_| |_| |_|\__,_| .__/ 
                                     | |    
                                     |_|         
                                               "
printf "\n${ORANGE}[+] webmap Tool Made By [ 0xAbdoAli  : 'Abdelrahman Ali' ] To Explore websites"
printf "\n${ORANGE}[+] github:  https://github.com/0xAbdoAli"
printf "\n${ORANGE}[+] twitter: https://twitter.com/0xAbdoAli \n"
sleep 1

if [ $# -gt 1 ]; then
	echo "Usage: ./webmap.sh <domain>"
	echo "Example: ./webmap.sh example.com"
	exit 1
fi
if [ ! -d "thirdlevels" ]; then
	mkdir thirdlevels
fi
if [ ! -d "nmap-results" ]; then
	mkdir nmap-results
fi
if [ ! -d "eyewitness" ]; then
	mkdir eyewitness
fi
if [ ! -d "${1}-recon" ]; then
	mkdir ${1}-recon
fi
pwd=$(pwd)

echo "{+} Gathering subdomains with Sublist3r"
sublist3r -d $1 -o final.txt
echo $1 >> final.txt

echo "{+} Compiling third-level domains"
cat final.txt | grep -Po "(\w+\.\w+\.\w+)$" | sort -u >> third-level.txt

echo "{+} Gathering full third-level domains with sublist3r"
for domain in $(cat third-level.txt); do sublist3r -d $domain -o thirdlevels/$domain.txt; cat thirdlevels/$domain.txt | sort -u >> final.txt;done

echo "{+} Probing for alive third-levels"
cat final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ":443" | sort -u > livehosts.txt

echo "{+} Scanning for open ports..."
nmap -iL livehosts.txt -T5 -oA nmap-results/scanned.txt

echo "{+} Running Eyewitness..."
eyewitness -f $pwd/livehosts.txt -d eyewitness/$1 --web

mv eyewitness nmap-results thirdlevels final.txt livehosts.txt third-level.txt geckodriver.log ${1}-recon
