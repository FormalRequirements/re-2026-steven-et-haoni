#!/bin/bash

# Codes couleurs pour le terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

ERRORS=0

echo -e "${BLUE}=== DÉBUT DES TESTS DE CONFORMITÉ DYNAMIQUE ===${NC}"

# Fonction générique pour vérifier une section complète
check_section() {
    local folder="$1"
    local prefix="$2"
    
    echo -e "\n--- Vérification de la section : $folder (Préfixe: $prefix) ---"

    # 1. Vérifier si le dossier existe
    if [ ! -d "$folder" ]; then
        echo -e "[${RED}KO${NC}] Dossier introuvable : $folder"
        ERRORS=$((ERRORS+1))
        return
    else
        echo -e "[${GREEN}OK${NC}] Dossier présent : $folder"
    fi

    # 2. Trouver les fichiers correspondant au motif (ex: Project/p1-*.adoc)
    count=0
    
    # On boucle sur tous les fichiers qui matchent le pattern
    for file in "$folder"/"$prefix"[0-9]*-*.adoc; do
        if [ -e "$file" ]; then
            # Vérifier si le fichier n'est pas vide
            if [ -s "$file" ]; then
                echo -e "[${GREEN}OK${NC}] Fichier valide trouvé : $(basename "$file")"
                count=$((count+1))
            else
                echo -e "[${RED}KO${NC}] Fichier VIDE (0 octet) : $(basename "$file")"
                ERRORS=$((ERRORS+1))
            fi
        fi
    done

    # 3. Vérifier qu'on a trouvé au moins un fichier de contenu
    if [ "$count" -gt 0 ]; then
        echo -e "[${BLUE}INFO${NC}] $count fichier(s) validé(s) dans $folder."
    else
        echo -e "[${RED}KO${NC}] AUCUN fichier de type '$prefix*-*.adoc' trouvé dans $folder !"
        ERRORS=$((ERRORS+1))
    fi
    
    # 4. Vérifier le fichier "header.adoc"
    # Modification demandée : on cherche explicitement "header.adoc"
    header_file="$folder/header.adoc"
    
    if [ -s "$header_file" ]; then
         echo -e "[${GREEN}OK${NC}] Fichier Header trouvé : $header_file"
    else
         echo -e "[${RED}KO${NC}] Fichier Header MANQUANT (attendu: $header_file)"
         ERRORS=$((ERRORS+1))
    fi
}

# --- EXÉCUTION DES VÉRIFICATIONS PAR SECTION ---

# Appel de la fonction pour chaque partie du PEGS
check_section "docs/project" "p"
check_section "docs/environment" "e"
check_section "docs/goals" "g"
check_section "docs/system" "s"


# --- VÉRIFICATION DU PDF FINAL ---
echo -e "\n--- Vérification du livrable PDF ---"
PDF_COUNT=$(find . -name "*.pdf" -type f | wc -l)

if [ "$PDF_COUNT" -gt 0 ]; then
    echo -e "[${GREEN}OK${NC}] PDF généré trouvé ($PDF_COUNT fichier(s))."
    # Vérification taille minimale (1KB)
    PDF_FILE=$(find . -name "*.pdf" -type f | head -n 1)
    if [ -s "$PDF_FILE" ]; then 
        echo -e "[${GREEN}OK${NC}] Le fichier $(basename "$PDF_FILE") semble valide."
    else
        echo -e "[${RED}KO${NC}] Le fichier PDF est vide."
        ERRORS=$((ERRORS+1))
    fi
else
    echo -e "[${RED}KO${NC}] AUCUN fichier PDF trouvé !"
    ERRORS=$((ERRORS+1))
fi

# --- CONCLUSION ---
echo -e "\n====================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}SUCCÈS : Structure conforme et PDF généré.${NC}"
    exit 0
else
    echo -e "${RED}ÉCHEC : $ERRORS erreur(s) détectée(s).${NC}"
    exit 1
fi
