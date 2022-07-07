#!/bin/bash
#Debug - On + Off
if [ "$1" == "Debug" ] ; then set -x ; fi
clear
RC=0
# Colors
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
trap ctrl_c INT
# Basic Functions
function ctrl_c(){
	echo -e "\n\n${yellowColour}[*]${endColour}${grayColour} Saliendo ${greenColour}${0}${grayColour} ...\n${endColour}"
	exit 0
}
function bannerDBZ(){
	echo -e "\n${redColour}'||''|.                     ||       '||  '||''|.                           '||''|.   '||''|.   |'''''||  "
	sleep 0.05
	echo -e " ||   ||   ....   .... ... ...     .. ||   ||   ||   ....     ....  ......   ||   ||   ||   ||      .|'   "
	sleep 0.05
	echo -e " ||    || '' .||   '|.  |   ||   .'  '||   ||'''|.  '' .||  .|...|| '  .|'   ||    ||  ||'''|.     ||     "
	sleep 0.05
	echo -e " ||    || .|' ||    '|.|    ||   |.   ||   ||    || .|' ||  ||       .|'     ||    ||  ||    ||  .|'     ${endColour}${yellowColour}(${endColour}${grayColour}Create by ${endColour}${redColour} DBZ - ${endColour}${purpleColour} Tmux Script V(2.1.0)${endColour}${yellowColour})${endColour}${redColour}"
	sleep 0.05
	echo -e ".||...|'  '|..'|'    '|    .||.  '|..'||. .||...|'  '|..'|'  '|...' ||....| .||...|'  .||...|'  ||......| ${endColour}\n\n"
	sleep 0.05
}
function banner()
{
	echo "+------------------------------------------+"
	printf "| %-40s |\n" "`date`"
	echo "|                                          |"
	printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
	echo -e "+------------------------------------------+\n\n"
}
bannerDBZ
banner "TMUX DBZ"
SESSION_TMUX="StartDBZ"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION_TMUX)
#Validate that the session does not exist
if [ "$SESSIONEXISTS" = "" ]
then
    tiempo=0.5
    #Create the session in detach, so you don't see it. It takes some time because it takes a while to upload.
    tmux new-session -d -s $SESSION_TMUX && sleep $tiempo
    tmux rename-window "LinuxDBZ"&& sleep $tiempo
    #------------------------------------------------------------------------First Window Principal - Vscode
    #------------------------------------------------------------------------
    tmux select-pane -t 1
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'code .' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Window WebStatus
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "WebStatus"  && sleep $tiempo
    tmux send-keys "cd ~/Estudio/dbz/statusweb" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'bash webstatus.sh 20 0 0' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v -p 80 && sleep $tiempo
    tmux select-pane -t 2
    tmux send-keys "cd ~/Estudio/dbz/statusweb" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m  && sleep $tiempo
    tmux send-key 'tail -f logwebstatus.log | grep FAIL' C-m && sleep $tiempo
    #------------------------------------------------------------------------Third Panel
    tmux split-window -v -p 20 && sleep $tiempo
    tmux select-pane -t 3
    tmux send-keys "cd ~/Estudio/dbz/statusweb" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'tail -19 logwebstatus.log' C-m && sleep $tiempo
    #------------------------------------------------------------------------Third Window Mail Status
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "MailStatus"  && sleep $tiempo
    tmux send-keys "cd ~" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'tail -f /var/log/postfix.log' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v && sleep $tiempo
    tmux send-keys "cd ~" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m  && sleep $tiempo
    tmux send-key 'mailq' C-m && sleep $tiempo
    #------------------------------------------------------------------------Fourth Window Work K8s
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "K8s Work-Dev"  && sleep $tiempo
    tmux send-keys "cd ~" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m  && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v -p 65 && sleep $tiempo
    tmux select-pane -t 2
    tmux send-keys "cd ~" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m  && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    #------------------------------------------------------------------------SecoThirdnd Panel
    tmux split-window -v && sleep $tiempo
    tmux select-pane -t 3
    tmux send-keys "cd ~" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m  && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    #------------------------------------------------------------------------Quinta Panel study
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "K8s Work-Dev"  && sleep $tiempo
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'evince ~/Estudio/linux/asset-v1_LinuxFoundationX+LFD109x+1T2022+type@asset+block@LFD109x-labs_V2022-03-22.pdf &' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v && sleep $tiempo
    tmux select-pane -t 2
    tmux send-keys "cd /mnt/c/DBZ/DBZ\ ESTUDIO/Selenium/Heon" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'll' C-m && sleep $tiempo
    #------------------------------------------------------------------------Me Ubico en la First Window
    tmux select-window -t 1 
    tiempo=2
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'bannerDBZ' C-m && sleep $tiempo
    tmux send-key 'banner  "     -- DBZ -- David Baez -- DBZ --"' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    # Notified when something happens inside other windows
    tmux setw -g monitor-activity on
    tmux set -g visual-activity on
    #tmux select-layout even-horizontal
    tmux set -g mouse on
    tmux set-option -g mouse-select-pane on
else
	  echo "${redColour}[*]${endColour}${yellowColour} La sesion ya esta creada $SESSION_TMUX${endColur}\n"
fi
# Verify TMUX session error
if [[ -z "$TMUX" ]]; then
    tmux attach-session -t $SESSION_TMUX
else
    tmux switch-client -t $SESSION_TMUX
fi
