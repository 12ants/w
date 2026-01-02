#!/bin/bash
ww2jpg() { 
####
#" up right down left
local IFS=$'\n\t '; 
ww=$(realpath $1); 
wordfolder=$PWD/logs/w; 
wo=$wordfolder/w; 
mkdir -p -m 775 $wo 2>/dev/null; 
[ $1 ]||ww=$(realpath $wo/*.log|fzf --preview 'bat {}'); word=$(basename -s .log $ww); 
mkdir $wordfolder/log -pm 775 2>/dev/null; 
mkdir $wordfolder/img -pm 775 2>/dev/null; hexx="$(pastel random -n1|pastel format hex|col -xb)"; h2="$(pastel complement $hexx|pastel format hex|col -xb)"; 
####
printf %b "  "|ansifilter -M -F "serif" -s 115 > $wordfolder/log/$word.xml; 

printf %b "   $(sed -n 1p $ww)   "|ansifilter -M -F "serif" -s 240 >> $wordfolder/log/$word.xml; 

printf %b "  "|ansifilter -M -F "monospace" -s 5 >> $wordfolder/log/$word.xml; 

printf %b "\e[38;5;250m[\e[38;5;242m$(sed -n 2p $ww)\e[38;5;250m]"|ansifilter -M -F "serif" -s 60 >> $wordfolder/log/$word.xml; 

printf %b "  "|ansifilter -c -M -F "serif" -s 5 >> $wordfolder/log/$word.xml; 

sed -n 3p $ww|gum style --foreground "$h2"|ansifilter -c -M -F "monospace" -s 50 >> $wordfolder/log/$word.xml; 

printf %b "  "|ansifilter -c -M -F "monospace" -s 5 >> $wordfolder/log/$word.xml; 

tail -n+4 $ww|fmt -w 42 -g 26|gum style --padding "0 4 2 4" --foreground "#222222" --align left --border hidden|ansifilter -M -s 50 -F "monospace" >> $wordfolder/log/$word.xml; 

printf %b "  "|ansifilter -c -M -F "monospace" -s 22 >> $wordfolder/log/$word.xml; 
####
####
convert -border 4 -bordercolor black -gravity center pango:"$(cat $wordfolder/log/$word.xml)" $wordfolder/log/$word.jpg; 
####
media="$wordfolder/log/$word.jpg"; 
mw=($(mediainfo $media|grep -E 'Width'|tr -d " :A-z")); 
mh=($(mediainfo $media|grep -E 'Height'|tr -d " :A-z")); 
[[ mw -gt mh ]] && mx="$mw" || mx="$mh"; 
mz1="$((mx / 4 + 44))"; mz="$((mx + mz1))"; 
####
####
convert "$wordfolder/log/$word.jpg" -gravity center -background "$hexx" -extent ${mz}x${mz} "$wordfolder/img/${word}.jpg"; 
####
# wordw="$(mediainfo --INFORM="Image;%Width%" "$wordfolder/log/$word.jpg")"; 
# wordh="$(mediainfo --INFORM="Image;%Height%" "$wordfolder/log/$word.jpg")"; 
# wordzp="$(((2999 - wordw) / 2))x$(((2999 - wordh) / 2))"; 
# wordzs="$(((2999 - wordw) / 2))x$(((4600 - wordh) / 2))"; 
########
########
# convert -border ${wordzp} -bordercolor "$hexx" "$wordfolder/log/$word.jpg" "$wordfolder/img/${word}.jpg"; 
####
# hexx="$(pastel random -n1|pastel format hex|col -xb)"; 
# convert -border ${wordzs} -bordercolor "$hexx" "$wordlog/$word.jpg" "$wordfolder/img/${word}_story.jpg"; 
########
# printf %b "\n----\nhttps://aa.aeniks.com/wordimg/${word}.jpg \nhttps://aa.aeniks.com/wordimg/${word}_story.jpg \n----\n"; 
########
# rm "$wordfolder/log/$word.htm" "$wordfolder/log/$word.jpg"; 
chafa -f symbols "$wordfolder/img/${word}.jpg"; 
}; 
########
ww2jpg; 
########

# convert -background "#220055" pango:"$(printf %b "$(sed -n 2p w/feral.log|batcat --color never --show-all -pp|sed -e 's/{/0/g' -e 's/25b/25c/g' -e 's/[}␊/]//g')"|ansifilter -M -F serif)" kk.jpg

# wordfolder="$HOME/logs/words"; wordlog="$wordfolder/wordlog"; latest="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; ww="$wordlog/$latest"; word="${latest/.*/}"; 
####
# mkdir -m 775 -p "$wordfolder/wordlog" "$wordfolder/tmp" "$wordfolder/wordimg/story" "$wordfolder/wordimg/post" "$wordfolder/up" 2>/dev/null; 
####
#### create file and spacing on top
####
# latest="$(command ls -t1 $wordlog|grep -e '.log$'|head -n1)"; ww="$wordlog/$latest"; 
# read -rp 'wlog: ' "ww"; 
