#!/bin/bash
w2jpg() { 
####
# local IFS=$'\n\t '; local FZF_DEFAULT_OPTS=; wf=$HOME/logs/w; 
# [ "$1" ] && wo="$(realpath $1)" || \
# wo="$(realpath $wf/w/*|fzf --preview 'bat -ppflc {}' --delimiter='/' --with-nth {-1}))"; 
# # realpath $wf/w/*.log
# word=$(basename -s .log $wo); 
# mkdir $wf/log -pm 775 2>/dev/null; 
# mkdir $wf/img -pm 775 2>/dev/null; 
####
####

#### up right down left
####
####
local IFS=$'\n\t '; local FZF_DEFAULT_OPTS=; wf="$HOME/logs/w";
####
[ $1 ] && wo=$(realpath $1) || \
wo=$(realpath $wf/w/*.log|fzf --preview 'bat {}' --delimiter "/" --with-nth {-1});
####
mkdir $wf/w -p -m 775 2>/dev/null; 
mkdir $wf/log $wf/img -pm 775 2>/dev/null; 
####
word=$(basename -s ".log" $ww);
####
hex1="$(pastel random -n1|pastel format hex|col -xb)";
hex2="$(pastel complement $hex1|pastel format hex|col -xb)";
####
(printf %b "  "|ansifilter -M -F "serif" -s 150; 
printf %b "    $(sed -n 1p $wo)    "|ansifilter -M -F "serif" -s 260;  
printf %b "\e[236m[\e[0m"|ansifilter -M -F "code" -s 60; 
sed -n 2p $wo|bat -ppfljs --theme Coldark-Cold|ansifilter -M -F "code" -s 60; 
printf %b "\e[236m]\e[0m"|ansifilter -M -F "code" -s 60; 
sed -n 3p $wo|ansifilter -MF "code" -s 60; 
sed -n 4,6p $wo|fmt -w 42 -g 26|gum style --margin "0 6 2 6" --padding "2"|ansifilter -c -M -s 60 -F "monospace") > ${wf}/log/${word}.xml; 
####
####
####
####
convert -border 4 -bordercolor black -gravity center pango:"$(cat ${wf}/log/${word}.xml)" "${wf}/log/${word}.jpg";
# 2>dev/null; 
####
media="$wf/log/$word.jpg";
mw=($(mediainfo $media|grep -E 'Width'|tr -d " :A-z"));
mh=($(mediainfo $media|grep -E 'Height'|tr -d " :A-z"));
[[ mw -gt mh ]] && mx="$mw" || mx="$mh";
mz1="$((mx / 4 + 44))"; mz="$((mx + mz1))";
########
########
convert -border ${mz}x${mz} -bordercolor "$hex1" "$wf/log/$word.jpg" "$wf/img/${word}.jpg" 2>/dev/null; 
########
# rm "$wf/log/$word.xml" "$wf/log/$word.jpg"; 
chafa -f symbols "$wf/img/${word}.jpg"; 
}; 
########
w2jpg; 
########

