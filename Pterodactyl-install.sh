#!/bin/bash
# Pterodactyl dockeer &  Database install

# Download Files
function gitdownload(){
    sudo git clone --quiet https://github.com/demondamz/PG-Pterodactyl-docker.git /opt/pterodactyl
    cd /opt/pterodactyl
}

gitdownload
echo "files downloaded needed for install"
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  What would you like to do?.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
echo "You have the following options"
echo "panel is the main program"
echo "Node for each server"
echo "Database for the panell"
echo "DB Manager to Manage MySql"
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  Cannot install the panel without a Database.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
PS3='Please enter your choice: '
options=("panel" "Node" "Database" "DB-Manager" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "panel")
            echo "your choice $REPLY which is $opt"
            sudo ansible-playbook ./pterodactyl-docker-panel.yml
            docker exec -it pterodactyl-panel php artisan p:user:make
            echo "Panel Installed"
            ;;
        "Node")
            echo "your choice $REPLY which is $opt"
            sudo ansible-playbook ./pterodactyl-docker-node.yml
            echo "Node Installed"
            ;;
        "Database")
            echo "your choice $REPLY which is $opt"
            sudo ansible-playbook ./pterodactyl-docker-database.yml
            echo "Database installed"
            ;;
        "DB-Manager")
            echo "your choice $REPLY which is $opt"
            sudo ansible-playbook ./pterodactyl-docker-adminer.yml
            echo "Database Manager Installed"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
