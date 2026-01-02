#!/bin/bash
w4jpg() { 
####
#### up right down left
####
####
local IFS=$'\n\t '; wf="$HOME/logs/w"; 
[ $1 ] && ww=$(realpath $1) || \
ww=$(realpath $wf/w/*.log|FZF_DEFAULT_OPTS= fzf --preview 'bat {}' --delimiter "/" --with-nth {-1}); 
####
mkdir $wf/w -p -m 775 2>/dev/null; 
mkdir $wf/log -pm 775 2>/dev/null; 
mkdir $wf/img -pm 775 2>/dev/null; 
####
word=$(basename -s ".log" $ww); 
####
hex1="$(pastel random -n1|pastel format hex|col -xb)"; 
hex2="$(pastel complement $hex1|pastel format hex|col -xb)"; 
####
(printf %b "  "|ansifilter -M -F "serif" -s 115; 
printf %b "   $(sed -n 1p $ww)   "|ansifilter -M -F "serif" -s 240; 
printf %b "  "|ansifilter -M -F "monospace" -s 5;
printf %b "\e[38;5;250m[\e[0m$(sed -n 2p $ww|bat -ppfljs)\e[38;5;250m]"|ansifilter -M -F "serif" -s 60; 
printf %b "  "|ansifilter -c -M -F "serif" -s 5;
sed -n 3p $ww|gum style --foreground "$hex2"|ansifilter -c -M -F "monospace" -s 50; 
printf %b "  "|ansifilter -c -M -F "monospace" -s 5; 
tail -n+4 $ww|fmt -w 42 -g 26|gum style --padding "0 4 2 4" --foreground "#222222" --align left --border hidden|ansifilter -M -s 50 -F "monospace" 
printf %b "  "|ansifilter -c -M -F "monospace" -s 22) > $wf/log/$word.xml; 
####
####
printf %b "\n$word\n ."; 
convert -border 4 -bordercolor black -gravity center pango:"$(cat $wf/log/$word.xml)" $wf/log/$word.jpg 2>/dev/null; 
printf %b "."; 
####
media="$wf/log/$word.jpg"; 
mw=($(mediainfo $media|grep -E 'Width'|tr -d " :A-z")); 
mh=($(mediainfo $media|grep -E 'Height'|tr -d " :A-z")); 
[[ mw -gt mh ]] && mx="$mw" || mx="$mh"; 
mz1="$((mx / 8))"; mz="$((mx + mz1))"; 
printf %b "."; 
####
####
convert "$wf/log/$word.jpg" -gravity center -background "$hex1" -extent ${mz}x${mz} "$wf/img/${word}.jpg" 2>/dev/null; 
printf %b "."; 
####
chafa -f symbols "$wf/img/${word}.jpg"; 
}; 
########
w4jpg; 
########
