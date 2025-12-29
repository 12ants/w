ww() { 
wf="$HOME/logs/ww"; mkdir -p $wf 2>/dev/null; w="$@";
[ -z $w ] && printf %b "\n\n\e[Aword:" && read -rep ' ' "w"; echo;
curl -sL "https://api.dictionaryapi.dev/api/v2/entries/en/${w}" | command jq | command grep -e '"definition"' -m1 -B55 | sed -e 's/^[ \t]*//' | grep -vwE '"audio|"sourceUrl"|"url"|"name"|"license"|"meanings"|"text"|"phonetics"|"definitions"' | sed -e 's/\"\,/\n/g' -e '/[][}{]/d' -e 's/"//g' | tr -s "\n" "\n" | sed -e 's/partOfSpeech/type/' | tee ~/logs/ww/${w}.log | bat -ppflgo; echo
####
ww="$w"; (printf %b "\e[38;5;234m$(\
grep -we "word:" "$wf/$ww.log" -m1|cut -f2- -d' '|tr -d "\n")"|ansifilter -F serif -s 270 -M; 
echo|ansifilter -s 18 -M; 
grep -we "phonetic" "$wf/$ww.log" --quiet && \
(printf %b "\e[38;5;241m[\e[0m"; grep -e "phonetic" "$wf/$ww.log"|col -xb|cut -f2 -d "/"|tr -d "\n"|batcat -ppfllua --theme GitHub; printf %b "\e[38;5;241m]\n")|ansifilter -Ms 88; 
(printf %b "\e[38;5;24m"; grep -we "type:" "$wf/$ww.log"|cut -f2- -d" ")|ansifilter -F monospace -s 88 -M; 
echo|ansifilter -s 58 -M; 
(printf %b "\e[38;5;244m"; grep -we "definition:" "$wf/$ww.log"|cut -f2- -d" "|tr -d "\n"|fmt -g 22)|ansifilter -F monospace -s 78 -M) > $wf/$ww.xml; 
####
# (printf %b "["; grep -we "phonetic:" $ww.log |cut -f2 -d'/'|tr -d "\n"; printf %b "]")|bat -ppfllua --theme Nord
# (printf %b "\e[38;5;241m[ \e[0m"; grep -e "phonetic" $ww.log|col -xb|cut -f2 -d "/"|tr -d "\n"|bat -ppfll --theme Nord; printf %b "\e[38;5;241m ]\n")|ansifilter -F code -s 28 -M; 
convert -gravity center -background "#f5f5f5" -bordercolor "#f5f5f5" -border "588" pango:"$(cat $wf/$ww.xml)" $wf/${ww}.jpg; 
tmux display-popup -e ff="$wf/$w" -w 100% -h 100% -b none -E 'bash -c "chafa -f symbol $ff.jpg; printf %b '"'\e[?25l\e[2A'"'; read -n1"'; 
} 
