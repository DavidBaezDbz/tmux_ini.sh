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
	echo -e " ||   ||   ....   .... ... ...     .. ||   ||   ||   ....     ....  ......   ||   ||   ||   ||      .|'   "
	echo -e " ||    || '' .||   '|.  |   ||   .'  '||   ||'''|.  '' .||  .|...|| '  .|'   ||    ||  ||'''|.     ||     "
	echo -e " ||    || .|' ||    '|.|    ||   |.   ||   ||    || .|' ||  ||       .|'     ||    ||  ||    ||  .|'     ${endColour}${yellowColour}(${endColour}${grayColour}Create by ${endColour}${redColour} DBZ - ${endColour}${purpleColour} Tmux Script V(3.0.0)${endColour}${yellowColour})${endColour}${redColour}"
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
function desencrypt(){
    echo -en "${greenColour}Enter your secret word to protect your password for Validation:${endColour}\n" 
    read -s word
    echo -en "${greenColour}Enter your location:${endColour}\n" 
    read -s pathfile
    PASSWD=$(sudo cat $pathfile | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"$word")
    RC=$?
    if [[ ${RC} -gt 0 ]]
    then
        echo -e "\n\t${redColour}Your Word is no correct. ${endColour}Date: $(date +%x) $(date +%X) --> ${yellowColour} Try again, with the correct Word${blueColour} ${endColour} \n" 
        RC=0
        desencrypt
    fi  
}
function sshagent(){
    tmux send-keys "unset HISTFILE" C-m && sleep $tiempo
    tmux send-keys 'eval "$(ssh-agent -s)"' C-m && sleep $tiempo
    tmux send-keys '/usr/bin/expect <<EOD
        spawn ssh-add /home/dbz/.ssh/id_rsa
        match_max 1
        expect -exact "Enter passphrase for /home/dbz/.ssh/id_rsa: "
        send -- "'${PASSWD}'\r"
        expect eof
EOD' C-m && sleep $tiempo
    tmux send-keys 'fc -p' C-m && sleep $tiempo
    tmux send-keys 'export HISTFILE='$HOME'/.zsh_history' C-m && sleep $tiempo
    tmux send-keys 'clear' C-m && sleep $tiempo
}
function clearWindow(){
    tmux send-keys 'fc -p' C-m && sleep $tiempo
    tmux send-keys 'export HISTFILE='$HOME'/.zsh_history' C-m && sleep $tiempo
    tmux send-keys 'clear' C-m && sleep $tiempo
}
bannerDBZ
#banner "TMUX DBZ"
SESSION_TMUX="StartDBZ"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION_TMUX)
#Validate that the session does not exist
if [ "$SESSIONEXISTS" = "" ]
then
    unset HISTFILE
    desencrypt
    tiempo=0.2
    #Create the session in detach, so you don't see it. It takes some time because it takes a while to upload.
    tmux new-session -d -s $SESSION_TMUX && sleep $tiempo
    tmux rename-window "LinuxDBZ"&& sleep $tiempo
    #------------------------------------------------------------------------First Window Principal - Vscode
    #------------------------------------------------------------------------
    tmux select-pane -t 1
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    tmux send-keys 'code .' C-m && sleep $tiempo  && sleep $tiempo  && sleep $tiempo  
    sshagent
    #------------------------------------------------------------------------Second Window WebStatus
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "WebStatus"  && sleep $tiempo
    tmux send-keys "cd ~/Estudio/dbz/statusweb" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'bash check_sites_www.sh 300 0 0 0' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v -p 80 && sleep $tiempo
    tmux select-pane -t 2
    tmux send-keys "cd ~/Estudio/dbz/statusweb" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'tail -f logwebstatus.log | grep FAIL' C-m && sleep $tiempo
    #------------------------------------------------------------------------Third Panel
    tmux split-window -v -p 20 && sleep $tiempo
    tmux select-pane -t 3
    tmux send-keys "cd ~/Estudio/dbz/statusweb" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'tail -19 logwebstatus.log' C-m && sleep $tiempo
    #------------------------------------------------------------------------Third Window Mail Status
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "MailStatus"  && sleep $tiempo
    tmux send-keys "cd ~" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'tail -f /var/log/postfix.log' C-m && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v && sleep $tiempo
    tmux send-keys "cd ~" C-m && sleep $tiempo
    sshagent
    tmux send-keys '/usr/bin/expect <<EOD
    spawn sudo service postfix start
    match_max 100000
    expect -exact "\[sudo\] password for dbz: "
    send -- "'${PASSWD}'\r"
    expect eof
EOD' C-m && sleep $tiempo
    clearWindow
    tmux send-keys 'postqueue -p' C-m && sleep $tiempo
    #------------------------------------------------------------------------Fourth Window Work K8s
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "K8s Work-Dev"  && sleep $tiempo
    tmux send-keys "cd ~" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'ssh kw01' C-m  && sleep $tiempo
    tmux send-keys 'sudo su' C-m  && sleep $tiempo
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v -p 65 && sleep $tiempo
    tmux select-pane -t 2
    tmux send-keys "cd ~" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'ssh kdm01' C-m  && sleep $tiempo
    tmux send-keys 'cd dbz/mssql' C-m  && sleep $tiempo
    tmux send-keys 'clear' C-m  && sleep $tiempo
    tmux send-keys 'docker-compose ps' C-m  && sleep $tiempo
    #------------------------------------------------------------------------SecoThirdnd Panel
    tmux split-window -v && sleep $tiempo
    tmux select-pane -t 3
    tmux send-keys "cd ~" C-m && sleep $tiempo
    sshagent
    tmux send-keys 'sshcen ftpCafe' C-m  && sleep $tiempo
    tmux send-keys 'clear' C-m  && sleep $tiempo
    #------------------------------------------------------------------------Quinta Panel study
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "K8s Work-Dev"  && sleep $tiempo
    tmux send-keys "cd ~/Estudio" C-m && sleep $tiempo
    sshagent 
    tiempo=10
    tmux send-keys 'evince ~/Estudio/linux/asset-v1_LinuxFoundationX+LFD109x+1T2022+type@asset+block@LFD109x-labs_V2022-03-22.pdf & 2>/dev/null' C-m && sleep $tiempo
    tiempo=0.2
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v && sleep $tiempo
    tmux select-pane -t 2
    sshagent
    tmux send-keys "cd /mnt/c/DBZ/DBZ\ ESTUDIO/Selenium/Heon" C-m && sleep $tiempo
    if [ -e "/mnt/c/DBZ/DBZ\ ESTUDIO/Selenium/Heon/Almuerzo\ Heon.side" ]
    then
        tmux send-keys 'll' C-m && sleep $tiempo
    else
        tmux send-keys '7z e seleheon.7z' C-m && sleep $tiempo
    fi
    #------------------------------------------------------------------------Sixth Panel study
    #------------------------------------------------------------------------
    tmux new-window -t "StartDBZ" -n "Sql -Docker"  && sleep $tiempo
    tmux send-keys " ~/dbz/docker" C-m && sleep $tiempo
    sshagent
    #------------------------------------------------------------------------Second Panel
    tmux split-window -v && sleep $tiempo
    tmux select-pane -t 2
    tmux send-keys " ~/dbz/docker" C-m && sleep $tiempo
    sshagent
    #------------------------------------------------------------------------Me Ubico en la First Window
    tmux select-window -t 1 
    tmux select-pane -t 1
    sshagent
    clearWindow
    tmux send-keys 'bannerDBZ' C-m && sleep $tiempo && sleep $tiempo
    tmux send-keys 'dbzupg' C-m
    export HISTFILE=$HOME/.zsh_history
else
	echo -ne "${redColour}[*]${endColour}${yellowColour} La sesion ya esta creada $SESSION_TMUX${endColur}\n"
fi
#Change the value of Pasword
PASSWD=hf_hkl681000fhkGHJLlña44_ssss_654646OIUo7496sdl_lsajlñsd464646sfsdfasdfakhHUDUDFSJKBBKBCGZVHJZ__6464688hlkjkjjañj5465hla
# Verify TMUX session error
if [[ -z "$TMUX" ]]; then
    tmux attach-session -t $SESSION_TMUX
else
    tmux switch-client -t $SESSION_TMUX
fi