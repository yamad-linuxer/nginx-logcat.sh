#!/bin/bash
logF="/var/log/nginx/access.log";linesL=15;while getopts l:f: OPT;do case $OPT in f) logF=$OPTARG;;l) linesL=$OPTARG;;\?) echo -e "\n  USAGE\n\n  -l NUM  : output lines  (default: 15)\n  -f FILE : log file path (default : /var/log/nginx/access.log)\n";exit 1;esac;done;logA=$(cat $logF|tail -n $linesL);logC(){ echo $logA|awk -F '"' "{print \$$1}";};for ((i=1; i<=$(($linesL*6)); i++)){ if (($(($i%6))==1));then dateA=$(logC $i|awk '{print $4 " " $5}');fromA=$(logC $i|awk '{print $1}');fi;if (($(($i%6))==2));then methodA=$(logC $i|awk '{print $1}');bodyA=$(logC $i|awk '{print $2}');fi;if (($(($i%6))==3));then resultA=$(logC $i|awk '{print $1}');fi;if (($(($i%6))==0));then echo -e "\e[33m$dateA\e[39m  From:\e[33m$fromA\e[39m  Method:\e[33m$methodA\e[39m  Result:\e[33m$resultA";echo -e "\e[39mUA:\e[36m$(logC $i)";echo -e "\e[35m>> \e[32m$bodyA\n";fi;}
