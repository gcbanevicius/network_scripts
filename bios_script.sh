#!/bin/bash

# use in conjuction with facter to get bios and model info about machines

cd ~/Desktop

INFI=/path/to/workstation_list
OUTFI=~/Desktop/bios_data/bios

if [ ! -f $INFI ]; then
    echo "No input file!  Are you on the network?  Do you have the proper permissions?"
    exit 1
fi

if [ -d ./bios_data ]; then
    rm -rf ./bios_data
fi

mkdir ./bios_data

user="username"
cat $INFI | while read text; do
model=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | egrep ^productname | cut -c16-)
    case $model in
      "Precision T1600")
        data=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | grep bios)
        echo -en "$text \t" >> ${OUTFI}_T1600
        echo "$data" | tr '\n' '\t' >> ${OUTFI}_T1600
        echo -e "\n------------------------------------\n" >> ${OUTFI}_T1600
        ;;
      "Precision T1500")
        data=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | grep bios)
        echo -en "$text \t" >> ${OUTFI}_T1500
        echo "$data" | tr '\n' '\t' >> ${OUTFI}_T1500 
        echo -e "\n------------------------------------\n" >> ${OUTFI}_T1500
        ;;
      "Precision WorkStation 390")
        data=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | grep bios)
        echo -en "$text \t" >> ${OUTFI}_390
        echo "$data" | tr '\n' '\t' >> ${OUTFI}_390 
        echo -e "\n------------------------------------\n" >> ${OUTFI}_390
        ;;
      "OptiPlex 755")
        data=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | grep bios)
        echo -en "$text \t" >> ${OUTFI}_755
        echo "$data" | tr '\n' '\t' >> ${OUTFI}_755
        echo -e "\n------------------------------------\n" >> ${OUTFI}_755
        ;;
      "OptiPlex GX620")
        data=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | grep bios)
        echo -en "$text \t" >> ${OUTFI}_620
        echo "$data" | tr '\n' '\t' >> ${OUTFI}_620 
        echo -e "\n------------------------------------\n" >> ${OUTFI}_620
        ;;
      *)
        data=$(ssh -n -oBatchMode=yes $user@$text sudo facter -p | grep bios)
        echo -en "$text \t" >> ${OUTFI}_other
        echo "$data" | tr '\n' '\t' >> ${OUTFI}_other 
        echo -e "\n------------------------------------\n" >> ${OUTFI}_other
        ;;
    esac

done
    

