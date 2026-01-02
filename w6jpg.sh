#!/bin/bash
####
w6jpg() { 
local IFS=$'\n\t '
wf="${HOME}/logs/w"; 
ww="$(basename -s .log $(ls -1 $wf/w|fzf||return 2))"||return 2; 
bo="bat -ppf --language"
# bat="go --theme Catppuccin\ Latte";
unalias b1 b2 b3 b4 2>/dev/null; 
function b1 () { bat -ppf --language go --theme Catppuccin\ Latte; }; 
function b2 () { bat -ppf --language d --theme TwoDark; }; 
function b3 () { bat -ppf --language js --theme zenburn; }; 
function b4 () { bat -ppf --language r --theme Nord; }; 
bb=$(shuf -en1 b1 b2 b3 b4); 
####
(printf %b "\e[38;5;236m$ww"|ansifilter -F serif -s 270 -M; 
echo "  "|ansifilter -s 24 -M; 
####
printf %b "\e[38;5;249m[\e[0m$(sed -n 2p $wf/w/$ww.log|$bb)\e[38;5;249m]" |ansifilter -MF mono -s 88
####
(printf %b "\e[38;5;24m"; sed -n 3p  "$wf/w/$ww.log"|cut -f2- -d" ")|ansifilter -F monospace -Ms 88;
echo|ansifilter -Ms 58; 
####
(printf %b "\e[38;5;244m"; sed -n 4p "$wf/w/$ww.log"|cut -f2- -d" "|tr -d "\n"|fmt -g 22)|ansifilter -F monospace -Ms 78) > $wf/log/$ww.xml; 
####
####
printf %b "\n--\n$0\n--\n"; 
cat "$wf/w/$ww.log"|bat -ppfld --theme zenburn; 
printf %b "\n----\n"; 
type $bb|bat -ppfld --line-range 4 --theme Catppuccin\ Frappe; 
printf %b "\n----\n."; 
####
convert -gravity center -background "#f5f5f5" pango:"$(cat ${wf}/log/${ww}.xml)" "${wf}/log/${ww}.jpg" 2>/dev/null; printf %b "."; 
####
me="${wf}/log/${ww}.jpg";
mw=($(mediainfo $me|grep -E 'Width'|tr -d " :A-z"));
mh=($(mediainfo $me|grep -E 'Height'|tr -d " :A-z"));
[[ mw -gt mh ]] && mx="$mw" || mx="$mh";
mz1="$((mx / 8 + 888))"; mz="$((mx + mz1))";
printf %b "."; 
####
convert -gravity center -background "#f5f5f5" "${wf}/log/${ww}.jpg" -extent ${mz}x${mz} "${wf}/img/${ww}.jpg" 2>/dev/null; 
printf %b ".\n"; 
####
rm "${wf}/log/${ww}.jpg" "${wf}/log/${ww}.xml"; 
####
chafa -f symbol "${wf}/img/${ww}.jpg"; }; 
w6jpg; 
