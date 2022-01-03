#!/bin/bash
# Pterodactyl dockeer &  Database install

# Download Files
function gitdownload(){
    sudo git clone --quiet https://github.com/demondamz/PG-Pterodactyl-docker.git /opt/pterodactyl
    cd /opt/pterodactyl
}
# Install Panel
function installpanel(){
    sudo ansible-playbook ./pterodactyl-docker-panel.yml
    docker exec -it pterodactyl-panel php artisan p:user:make
}
# Install Node
function installnode(){
    sudo ansible-playbook ./pterodactyl-docker-node.yml
}
# Install Database
function installdb(){
    sudo ansible-playbook ./pterodactyl-docker-database.yml
}

# Database Management 
function dbmanagement(){
    sudo ansible-playbook ./pterodactyl-docker-adminer.yml
}

function maininstall(){
echo "files downloaded needed for install"
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  What would you like to do?.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
echo "You have the following options"
echo "panell is the main program"
echo "Node for each server"
echo "Database for the panell"
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
            installpanel
            tee <<-EOF
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            ⛔️  Panel Installed.
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
            ;;
        "Node")
            echo "your choice $REPLY which is $opt"
            installnode
             tee <<-EOF
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            ⛔️  Node Installed.
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
            ;;
        "Database")
            echo "your choice $REPLY which is $opt"
            installdb
             tee <<-EOF
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            ⛔️  Database Installed.
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
            ;;
        "DB-Manager")
            echo "your choice $REPLY which is $opt"
            dbmanagement
             tee <<-EOF
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
            ⛔️  Database Manager Installed.
            ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
            ;;
        "Quit")
            rm -rf /opt/pterodactyl
            cd /opt/appdata/pterodactyl
            sudo chown -cR 1000:1000 /opt/appdata/pterodactyl 1>/dev/null 2>&1
            sudo chmod -cR 755 /opt/appdata/pterodactyl 1>/dev/null 2>&1
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done


    tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  Install Complete..
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
}

# Commands 
gitdownload
maininstall
