#!/bin/bash
    # Directory for creating server data
    TARGET_DIR='../../../'
    # Directory with individual patches
    PATCH_DIR='../../../Patches'
    # Directory with additional scripts
    TOOL_DIR='../../../Tools'

    echo 'Welcome to the patching script'

    echo 'Create a temporary directory for work...'
    mkdir temp
    cd temp

    echo 'Unzip pre-request files... '
    7z x ../perpetuumserver_setup.exe
    7z x ../GAMMA_LAYERS_2021_10_17_P26.rar

    echo 'Move DB backup to MSSQL dir with SUDO...'
    sudo cp ./data/database/perpetuumsa.bak /var/opt/mssql/data/
    sudo chown mssql:mssql /var/opt/mssql/data/perpetuumsa.bak
    sudo chmod o-r,g+w /var/opt/mssql/data/perpetuumsa.bak

    echo 'Patch database restore script...'
    cp ./'$PLUGINSDIR'/installdb.sql ./
    dos2unix installdb.sql
    patch installdb.sql ../installdb.sql.patch

    echo -n 'SA password for MSSQL:'
    read -s SA_PASSWORD
    echo
    echo 'Restoring original database state...'
    sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d master -C -I -i ./installdb.sql 1>/dev/null

    for i in $(seq 0 6)
    do
        echo "Patching Pre Alpha $i"
        sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $PATCH_DIR/Pre_Alpha_$i/prealpha_patch_$i.sql 1>/dev/null
        cp -r $PATCH_DIR/Pre_Alpha_$i/Server/data . 2>/dev/null
    done

    echo "Patching Pre Alpha 7 FInal"
    sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $PATCH_DIR/Pre_Alpha_7_FInal/FIX_robottemplaterelation_pinkarkhe.sql 1>/dev/null
    sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $PATCH_DIR/Pre_Alpha_7_FInal/NPC_robottemplates_argano_GetsEcms__2018_04_12.sql 1>/dev/null

    for i in $(seq 1 30)
    do
        echo "Patching Live $i"
        sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $PATCH_DIR/Live_$i/live_patch_$i.sql 1>/dev/null
        cp -r $PATCH_DIR/Live_$i/Server/data . 2>/dev/null
    done

    echo 'Move data for Gamma zones....'
    mv -f ./GAMMA_LAYERS_NEW/*.bin ./data/layers/

    echo 'Copy the perpetuum.ini template. Update it manually!'
    cp ../perpetuum_linux.ini ./data/perpetuum.ini

    echo 'Setting up the tool admin account...'
    echo 'Username: test'
    echo 'Password: test'
    sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $TOOL_DIR/TOOL_test_account.sql 1>/dev/null

    echo 'Setup additional development environment...'
    sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $TOOL_DIR/DEV_ONLY_gamma_set.sql 1>/dev/null

    echo 'Open for registration from client...'
    sqlcmd -S '127.0.0.1' -U SA -P $SA_PASSWORD -d perpetuumsa -C -I -i $TOOL_DIR/DEV_ONLY_open.sql 1>/dev/null

    echo 'Move data to target'
    mv ./data $TARGET_DIR

    echo 'Clean...'
    cd ..
    rm -rdf ./temp
