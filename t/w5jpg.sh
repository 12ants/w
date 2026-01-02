#!/bin/bash
####
# [ $1 ] && ww="$1"||
w22jpg() { 
wf=${HOME}/logs/w; 
w=$(basename $(ls -1 $wf/w|fzf||return 2))||return 2; ww=${w/.*/}; 
####
(printf %b "\e[38;5;234m$ww"|ansifilter -F serif -s 270 -M; echo|ansifilter -s 18 -M; 
####
(printf %b "\e[38;5;241m[\e[0m"; sed -n 2p "$wf/w/$ww.log"|col -xb|cut -f2 -d "/"|tr -d "\n\/"|batcat -ppfllua --theme GitHub; printf %b "\e[38;5;241m]\n")|ansifilter -Ms 88; 
####
(printf %b "\e[38;5;24m"; sed -n 3p  "$wf/w/$ww.log"|cut -f2- -d" ")|ansifilter -F monospace -s 88 -M;
echo|ansifilter -s 58 -M; 
####
(printf %b "\e[38;5;244m"; sed -n 4p "$wf/w/$ww.log"|cut -f2- -d" "|tr -d "\n"|fmt -g 22)|ansifilter -F monospace -s 78 -M) > $wf/log/$ww.xml; 
####
printf %b "\n${i}\n"; 
####

convert -gravity center -background "#f5f5f5" -bordercolor "#f5f5f5" -border "588" pango:"$(cat ${wf}/log/${ww}.xml)" ${wf}/img/${ww}.jpg 2>/dev/null; 
####
tmux display-popup -e ff="$wf/img/$ww.jpg" -w 100% -h 100% -b none -E 'bash -c "chafa -f symbol $ff; printf %b '"'\e[?25l\e[2A'"'; read -n1"'; 
printf %b "\n${0}\n$i\n"; 
}; 
w22jpg; 
