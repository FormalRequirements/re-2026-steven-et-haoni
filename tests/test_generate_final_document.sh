#!/bin/bash

# Script de validation des fichiers AsciiDoc selon le template PEGS

# Étape 0 : Génération du document final
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
GENERATION_SCRIPT_PATH="$SCRIPT_DIR/../generate_final_document.sh"

# Vérifie que le script de génération existe et est exécutable
if [[ ! -x "$GENERATION_SCRIPT_PATH" ]]; then
    echo "ERREUR : Le script de génération '$GENERATION_SCRIPT_PATH' est introuvable ou non exécutable."
    exit 1
fi

"$GENERATION_SCRIPT_PATH"
GEN_RESULT=$?

if [[ $GEN_RESULT -ne 0 ]]; then
    echo "ERREUR : Échec lors de l'exécution de generate_final_document.sh"
    exit 1
fi

# Variables
REQUIREMENTS_DIR="$SCRIPT_DIR/../docs"
TEMPLATE="requirements_template_adoc.txt"

OK_COUNT=0
ERROR_COUNT=0

echo "Vérification des fichiers requirements AsciiDoc dans '$REQUIREMENTS_DIR'"

# Structure PEGS des chapitres obligatoires par dossier
declare -A REQUIRED_FILES_BY_DIR=(
    [goals]="g1 g3 g7"
    [environment]="e1 e3"
    [system]="s1 s2"
    [project]="p3 p4"
)

# Boucle sur les dossiers à vérifier
for dir in "${!REQUIRED_FILES_BY_DIR[@]}"; do 
    echo "-----------------------------"
    echo "Répertoire : $dir"
    echo "Fichiers requis : ${REQUIRED_FILES_BY_DIR[$dir]}"
    
    dir_path="$REQUIREMENTS_DIR/$dir"
    
    if [[ ! -d "$dir_path" ]]; then
        echo "ERREUR : Le répertoire '$dir_path' n'existe pas."
        ((ERROR_COUNT++))
        continue
    fi

    IFS=' ' read -ra required_prefixes <<< "${REQUIRED_FILES_BY_DIR[$dir]}"
    for prefix in "${required_prefixes[@]}"; do
        if ! ls "$dir_path"/"$prefix"* &> /dev/null; then
            echo "ERREUR : Aucun fichier commençant par '$prefix' trouvé dans '$dir_path'"
            ((ERROR_COUNT++))
        else
            ((OK_COUNT++))
        fi
    done
done

# Résultat final
echo "-----------------------------"
echo "✅ Tests réussis : $OK_COUNT"
echo "❌ Erreurs détectées : $ERROR_COUNT"
echo "-----------------------------"

if [[ $ERROR_COUNT -gt 0 ]]; then
    echo "❌ Des erreurs ont été détectées. Veuillez corriger les problèmes ci-dessus."
    exit 1
else
    echo "✅ Tous les fichiers sont conformes."
    exit 0
fi
