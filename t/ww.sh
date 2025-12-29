
word=$HOME/logs/w/tycoon; # to be changed 
(sed -n 1p ${word}.log|tr -d " ")|gum style --border normal --border-foreground "#004444" --foreground "#222222" --margin "2 5 0 5" --padding "0 2" --align center \
| ansifilter -M -F monospace -s 56 > ${word}.log.xml; 
gum style --foreground "#448888" --border none --margin "0 2" --padding "0 1" --align center "$(sed -n 4p ${word}.log)" \
| ansifilter -M -F sans-serif -s 46 >> ${word}.log.xml; 
gum style --border none --margin "0 5 1 5" --padding "0 2" --align center "$(sed -n 2p ${word}.log|tr -d " ")"|bat -ppfljs --theme GitHub\
| ansifilter -M -F monospace -s 46 >> ${word}.log.xml; 
gum style --border none --margin "0 5 2 5" --padding "0 2" --align center "$(sed -n 5p ${word}.log|fmt -g 22|bat -ppflbash --theme TwoDark)" \
| ansifilter -M -F serif -s 56 >> ${word}.log.xml; 





convert -gravity center pango:"$(cat ${word}.log.xml)" $word.jpg; chafa $word.jpg






# gum style --border normal --margin "0 2" --padding "0 5" --align center "$((sed -n 2,3p $word.log|tr -d " "))" | ansifilter -M -F monospace -s 40 >> $word.log.xml; 

# sed -n 2,3p $word.log|tr -d "\n "|sed -e "s/]\[/\]\ \/\ [/g")|gum style --padding "1 2" --margin "0 2" --align center)
