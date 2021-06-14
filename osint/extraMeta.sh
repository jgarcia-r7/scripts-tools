#!/bin/bash
# Title: extraMeta.sh
# Author: Jessi
# Usage: ./extraMeta.sh -i <office_doc_urls> -o <output_file>
# Requires exiftool to be installed (apt install libimage-exiftool-perl)
# Downloads all documents from a list of URLs, extracts metadata from each doc using exiftool, and outputs discovered metadata into a file.


# Colors
RED='\033[0;31m' # Orange in R7 Color Scheme
GREEN='\033[0;32m' # Green
YELLOW='\033[1;33m' # Yellow
LCYAN='\033[1;36m' # Light Cyan
WHITE='\033[1;37m' # White
NC='\033[0m' # No Color


# Create temp directory
mkdir -p emtemp


# Get options
while getopts i:o: flag
do
	case "${flag}" in
		i) input=${OPTARG};;
		o) output=${OPTARG};;
	esac
done


# Download files
num_urls=$(wc -l $input | sed 's/[^0-9]*//g')
echo -e ${YELLOW}[!] ${LCYAN}Downloading Documents From ${WHITE}$num_urls ${RED}URLs
for url in $(cat $input);
do
	wget $url -P emtemp >/dev/null 2>&1
done
echo -e ${GREEN}[+] ${LCYAN}Done


# Extract metadata
ls emtemp > dlfiles.txt
files=$(cat dlfiles.txt)
num_files=$(wc -l dlfiles.txt | sed 's/[^0-9]*//g')
echo -e ${GREEN}[+] ${LCYAN}Donwloaded ${WHITE}$num_files ${RED}Files
echo -e ${YELLOW}[!] ${LCYAN}Extracting Metadata From ${WHITE}$num_files ${RED}Files
echo
for file in $files;
do
	echo -e ${YELLOW}[*] ${LCYAN}Extracted Metadata From: ${RED}$file >> $output
	echo >> $output 
	echo -e ${LCYAN}================================================ >> $output
	echo -e ${GREEN} >> $output
	exiftool emtemp/$file -Author -Creator -LastModifiedBy -S | grep 'Author\|Creator' >> $output
	echo >> $output
done
echo


# Finish
echo -e ${GREEN}[+] ${LCYAN}Finished Extracting Metadata From ${WHITE}$num_files ${RED}Files
echo -e ${YELLOW}[!] ${LCYAN}Cleaning Up Temp Directory And Zipping Up Files To emeta_files.zip
rm dlfiles.txt
zip -r emeta_filez.zip emtemp/ >/dev/null 2>&1 
rm -rf emtemp/
echo -e ${GREEN}[+] ${LCYAN}Done
