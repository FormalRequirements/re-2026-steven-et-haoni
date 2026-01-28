# re-2026-steven-et-haoni
Ce projet contient les exigences dans le cas de la Maison Intelligente.

# TXT → CSV (Qitab) Converter

## Description

Ce script permet de **convertir automatiquement une synthèse textuelle de provenant d'ELISA**
(Questions / Answers générées) en un **fichier CSV importable dans Qitab**
ou tout autre outil de gestion des exigences.

Le script :
- lit un fichier `.txt` structuré (section *Questions / Answer*),
- extrait chaque **question / réponse**,
- génère un **CSV propre**, avec échappement correct des caractères spéciaux,
- ajoute un **index de question** et le **nom du projet**.

---

## Fichiers

- `txt2qitab_csv.sh` : script principal (Bash + Python)
- `synthesis.txt` : fichier d’entrée (exemple)
- `qitab_import.csv` : fichier CSV généré (sortie)

---

## Prérequis

- Système Linux / macOS
- Bash
- **Python 3.7+** installé et accessible via `python3`

Vérification :
```bash
python3 --version
```

## Utilisation

Rendre le script exécutable :
```bash
chmod +x txt2qitab_csv.sh
```

Lancer la conversion :
```bash
./txt2qitab_csv.sh synthesis.txt qitab_import.csv
```

Résultat :

Un fichier `qitab_import.csv` est généré dans le dossier courant.

## Format du CSV généré

Le fichier CSV contient les colonnes suivantes :

| Colonne  | Description |
|----------|-------------|
| project  | Nom du projet (extrait du fichier TXT) |
| q_index  | Identifiant numérique de la question |
| question | Texte de la question |
| answer   | Texte complet de la réponse |


Exemple :
```csv
"project","q_index","question","answer"
"MIB","1","How user-friendly should the SHS be?","The SHS should be highly user-friendly..."
```

## Logique de parsing

Le script :
- détecte la section :
```
-------------------- Questions / Answer --------------------
```

- considère :

  - une ligne non vide comme une question,
  - les lignes suivantes comme la réponse,
  - une ligne vide comme fin de bloc Question/Réponse,

- ignore les lignes de séparation (-----).

⚠️ Les questions dupliquées sont conservées volontairement
afin de ne perdre aucune information.

## Compatibilité Qitab

Le CSV généré est :

- encodé en UTF-8,
- correctement quoté ("),
- compatible avec la majorité des imports CSV
(Qitab, Excel, LibreOffice, etc.).

 Si Qitab impose un format spécifique
(colonnes supplémentaires, séparateur ;,
feature, refinement level, etc.),
le script peut être facilement adapté.

## Auteurs

- Stéven LÉONARD
- Haoni WU
