#!/bin/bash
#Depuracion - Activa + desactiva
if [ "$1" == "Debug" ] ; then set -x ; fi
clear
RC=0
# Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
trap ctrl_c INT
# Funciones Basicos
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
	echo -e " ||    || .|' ||    '|.|    ||   |.   ||   ||    || .|' ||  ||       .|'     ||    ||  ||    ||  .|'     ${endColour}${yellowColour}(${endColour}${grayColour}Create by ${endColour}${redColour} DBZ - ${endColour}${purpleColour} Tmux Script${endColour}${yellowColour})${endColour}${redColour}"
	sleep 0.05
	echo -e ".||...|'  '|..'|'    '|    .||.  '|..'||. .||...|'  '|..'|'  '|...' ||....| .||...|'  .||...|'  ||......| ${endColour}\n\n"
	sleep 0.05
}
banner()
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
if [ "$SESSIONEXISTS" = "" ]
then
    tiempo=0.2
    #Crea la sesion en detach, para no verla. Se le da un tiempo pq se demora un poco en subir
    tmux new-session -d -s $SESSION_TMUX && sleep $tiempo
    tmux rename-window "LinuxDBZ"&& sleep $tiempo
    #------------------------------------------------------------------------Primer panel
    tmux select-pane -t 1
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'code .' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    #------------------------------------------------------------------------Segunda
    tmux new-window -t "StartDBZ" -n "K8sDBZ Man"  && sleep $tiempo
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    tmux split-window -v -p 20 && sleep $tiempo
    #------------------------------------------------------------------------Segundo Panel
    tmux select-pane -t 2
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    tmux split-window -v -p 10 && sleep $tiempo
    #tmux select-window -t 1
    #------------------------------------------------------------------------Tercer Panel
    tmux select-pane -t 3
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    #tmux select-window -t 1
    #------------------------------------------------------------------------Tercera
    tmux new-window -t "StartDBZ" -n "K8sDBZ Work"  && sleep $tiempo
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m  && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    tmux split-window -v -p 50 && sleep $tiempo
    #------------------------------------------------------------------------Segundo Panel
    tmux select-pane -t 2
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    tmux split-window -v -p 25 && sleep $tiempo
    #tmux select-window -t 1
    #------------------------------------------------------------------------Tercer Panel
    tmux select-pane -t 3
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    tmux split-window -v -p 10 && sleep $tiempo
    #tmux select-window -t 1
    #------------------------------------------------------------------------Cuarta Panel
    tmux select-pane -t 4
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-key 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'ssh-add ~/.ssh/id_rsa' C-m && sleep $tiempo
    tmux select-window -t 1 
    tiempo=2
    tmux send-key 'clear' C-m && sleep $tiempo
    tmux send-key 'bannerDBZ' C-m && sleep $tiempo
    tiempo=1
    tmux send-key 'banner  "     -- DBZ -- David Baez -- DBZ --"' C-m && sleep $tiempo
    #tmux setw -g monitor-activity on
    tmux set -g visual-activity on
    #tmux select-layout even-horizontal
    tmux set -g mouse on
else
	echo "${redColour}[*]${endColour}${yellowColour} La sesion ya esta creada $SESSION_TMUX${endColur}\n"
fi
# Verify TMUX session
if [[ -z "$TMUX" ]]; then
  tmux attach-session -t $SESSION_TMUX
else
  tmux switch-client -t $SESSION_TMUX
fi
