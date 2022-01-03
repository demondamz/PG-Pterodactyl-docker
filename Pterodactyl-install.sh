#!/bin/bash
# Pterodactyl docker &  Database install

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  What would you like to do?.
        1. To install the panel you need to have a database installed with the following information 
            Use the Database Manager to create the database & User.
                Database Name : pterodactyl
                Database User : pterodactyl
                Database Pass : pterodactyl
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
echo "You have the following options"
echo "panel is the main program"
echo "Node for each server"
echo "Database for the panell"
echo "DB Manager to Manage MySql"

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
