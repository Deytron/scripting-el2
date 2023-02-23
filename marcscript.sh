#!/bin/bash

# Configuration
MAX_BACKUPS=5 # Nombre maximum de sauvegardes historisées pour un même dossier
DATE=`date +%Y%m%d-%H%M%S`

# Fonction de création de l'archive
create_archive() {
    # Récupération des arguments
    local source="$1"
    local destination="$2"

    # Vérification de l'existence du dossier source
    if [ ! -d "$source" ]; then
        echo "Le dossier à sauvegarder n'existe pas."
        exit 1
    fi

    # Vérification de l'existence du dossier de destination
    if [ ! -d "$destination" ]; then
        echo "Le dossier de destination n'existe pas."
        exit 1
    fi

    # Création du nom de l'archive
    local folder_name=`echo "$source" | sed 's:/:_:g'`
    local archive_name="${folder_name}-${DATE}.tar.gz"

    # Création de l'archive
    tar czf "${destination}/${archive_name}" "$source"

    # Suppression des anciennes sauvegardes si nécessaire
    local backups=`ls -t "${destination}/${folder_name}-*.tar.gz" | wc -l`
    if [ $backups -gt $MAX_BACKUPS ]; then
        local to_delete=$(( $backups - $MAX_BACKUPS ))
        ls -t "${destination}/${folder_name}-*.tar.gz" | tail -$to_delete | xargs rm
    fi
}

# Fonction de gestion des signaux
trap `echo "Interruption détectée. Suppression de l'archive en cours..."; rm -f "${destination}/${archive_name}"` SIGTERM

# Mode interactif
if [ "$1" == "-i" ]; then
    read -p "Saisir le chemin du dossier à sauvegarder : " source
    read -p "Saisir le chemin du dossier de destination : " destination
    create_archive "$source" "$destination"

# Mode avec arguments
elif [ "$1" == "-s" ] && [ "$3" == "-d" ]; then
    source="$2"
    destination="$4"
    create_archive "$source" "$destination"

# Arguments invalides
else
    echo "Arguments invalides."
    echo "Syntaxe :"
    echo "./sauvegarder.sh -s dossier_a_sauvegarder -d emplacement_de_la_sauvegarde"
    echo "./sauvegarder.sh -i"
    exit 1
fi

echo "Sauvegarde terminée."