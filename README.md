# re-2026-steven-et-haoni

Ce projet contient les exigences dans le cas de la Maison Intelligente.


## Structure du projet

Les dossiers sont organisés comme suit :
- `docs/`: Contient tous les fichiers d'exigences
  - `header.adoc`: header du document général
  - `project/`: exigences du projet
  - `environment/`: exigences de l'environnement
  - `goals/`: exigences des objectifs
  - `system/`: exigences du système
- `out/`: Dossier de sorti des fichiers générés
  - `final-document.adoc`: fichier .adoc contenant la totalité du texte
  - `final-document.pdf`: fichier pdf final


## Prérequis

- Un système Linux ou une WSL sur Windows
- Ruby et RubyGems installé
- Etre administrateur de son profil pour l'installation des packages


## Setup

1. Cloner le repository :
```bash
git clone https://github.com/FormalRequirements/re-2026-steven-et-haoni.git
cd re-2026-steven-et-haoni
```

2. Lancer le script d'installation des dépendances :
```bash
./initialize_project.sh
```

Ce que ce script fait :
- Installe Ruby
- Installe Asciidoctor et son extension PDF
- Installe d'autres extensions nécessaires


## Générer le document

Pour générer le document final:

1. Vérifier que tous les documents se trouvent bien dans le dossier `docs/`
2. Lancer le script de génération :
```bash
./generate_final_document.sh
```

Ce que ce script fait :
- Combine tous les fichiers de documentations dans le bon ordre
- Génère les fichiers .adoc et .pdf dans le dossier de sorti `out/`


## Organisation du développement

1. **Brainstorming et rafinement du sujet**
- Dans un premier temps nous avons réfléchi au sujet qui nous inspirait le plus, finalement : MIB
- Suite à cela nous avons commencé à écrire nos idées d'exigences pour chaque éléments PEGS
- Le sujet étant très vaste, nous avons décidé d'accentuer nos exigences principalement sur la **sécurité**

2. **IA générative**
- Nous avons utilisé une IA générative (Gemini) pour proposer des exigences
- Très pertinent pour faire des propositions auquels nous n'avions pas pensé

3. **Structure du document**
- Nous avons réfléchi à plusieures options pour organiser les documents
- Finalement nous nous sommes inspirés d'un projet réalisé l'année dernière

4. **Rédiger les fichiers d'exigences**
- Pour plus de lisibilité, nous avons fait 1 branche par élément de PEGS
- Nous avons relu et vérifié les exigences générés par IA avant de les intégrés aux fichiers

5. **Génération de fichiers et de la CI**
- Ajout des fichiers de génération .adoc et .pdf
- Ajout d'un fichier pour la CI

6. **Rendu final**
- Générer plusieurs versions du document final
- Vérifier la qualité du PDF
- Vérifier la génération par CI


## Auteurs

- Stéven LÉONARD
- Haoni WU
