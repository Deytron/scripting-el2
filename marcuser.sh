#!/bin/bash

# Variables
PASSWD_FILE=/etc/passwd

# Fonction pour chercher un utilisateur par une partie de son nom d'utilisateur
search_user() {
  read -p "Quel utilisateur cherchez-vous ? " search_term

  # Cherche les utilisateurs correspondants au terme de recherche
  users=$(grep -i "$search_term" "$PASSWD_FILE" | cut -d ':' -f 1,5)

  # Vérifie s'il y a des utilisateurs correspondants
  if [[ -z $users ]]; then
    echo "Aucun utilisateur trouvé pour la recherche : $search_term"
    exit 1
  fi

  # Affiche la liste des utilisateurs correspondants
  echo "Voici la liste des utilisateurs trouvés :"
  echo "$users"

  # Demande à l'utilisateur de choisir un utilisateur
  read -p "Choisissez l'utilisateur : " user_choice

  # Extrait les informations de l'utilisateur choisi
  user=$(echo "$users" | sed -n "${user_choice}p")

  # Vérifie si un utilisateur a été sélectionné
  if [[ -z $user ]]; then
    echo "Aucun utilisateur sélectionné."
    exit 1
  fi

  # Affiche les informations de l'utilisateur
  name=$(echo "$user" | cut -d ':' -f 2)
  login=$(echo "$user" | cut -d ':' -f 1)
  echo "Utilisateur : $name"
  echo "Login: $login"
}

# Fonction pour réinitialiser le mot de passe d'un utilisateur
reset_password() {
  read -p "Entrez le nom d'utilisateur : " username

  # Vérifie si l'utilisateur existe
  if ! grep -q "^$username:" "$PASSWD_FILE"; then
    echo "Utilisateur $username introuvable"
    exit 1
  fi

  # Génère un nouveau mot de passe
  new_password=""
  confirm_password=""

  while [[ $new_password != $confirm_password ]]; do
    read -s -p "Nouveau mot de passe : " new_password
    echo
    read -s -p "Confirmation : " confirm_password
    echo
    [[ $new_password != $confirm_password ]] && echo "Le mot de passe et sa confirmation ne correspondent pas."
  done

  # Modifie le mot de passe de l'utilisateur
  sed -i "s/^$username:[^:]*:/$(echo "$username:$new_password:" | sed 's/[\/&]/\\&/g')/" "$PASSWD_FILE"
  echo "Mot de passe modifié pour l'utilisateur $username."
}

# Fonction pour afficher l'aide
usage() {
  echo "Utilisation: $0 [--search-user] [--reset-password USERNAME] [--help]"
  echo
  echo "Gestion des utilisateurs."
  echo
  echo "Options:"
  echo "  --search-user, -s  Rechercher un utilisateur par une partie de son nom d'utilisateur."
  echo "  --reset-password, -r USERNAME  Réinitialiser le mot de passe d'un utilisateur."
  echo "  --help, -h         Afficher cette aide."
}