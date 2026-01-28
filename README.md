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
source initialize_project.sh
```

Ce que ce script fait :
- Installe Ruby
- Installe Asciidoctor et son extension PDF
- Installe d'autres extensions nécessaires


## Exécuter les tests

Pour exécuter les tests de structures :

1. Vérifier d'être à la racine du projet
2. Lancer le script de test :
```bash
./check_structure.sh
```


## Générer le document

Pour générer le document final:

1. Vérifier que tous les documents se trouvent bien dans le dossier `docs/`
2. Lancer le script de génération :
```bash
source generate_final_document.sh
```

Ce que ce script fait :
- Combine tous les fichiers de documentations dans le bon ordre
- Génère les fichiers .adoc et .pdf dans le dossier de sorti `out/`


## Continuous Integration

La CI se lance automatiquement à chaque commit, merge request sur la branche main.
Sinon il est possible de lancer le Workflow "Generate Final Document" dans les Actions Git :

1. Cela va faire les installations nécessaires à la génération du fichier pdf
2. Lance les tests de structure du document (check_structure.sh)
3. Génère le fichier pdf dans les Artifacts si les tests sont passés


## Lien pour télécharger le PDF final

[Télécharger le PDF du document final](https://github.com/FormalRequirements/re-2026-steven-et-haoni/actions/runs/21444260777/artifacts/5290008969)


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

4. **BIS Rédiger les fichiers d'exigences avec ELISA**
- Nous avons essayé de générer des exigences avec ELISA, mais nous n'avons pas eu le temps d'aboutir cette recherche
- Il est possible de générer un fichier CSV avec les exigences générées par ELISA, cela est expliqué dans le README de la branche ELISA

5. **Génération de fichiers, test et CI**
- Ajout d'un fichier de génération .adoc et .pdf (generate_final_document.sh)
- Ajout d'un fichier d'exécution des tests (check_structure.sh)
- Ajout d'un fichier pour la CI (generation_ci.yml)

6. **Rendu final**
- Générer plusieurs versions du document final
- Vérifier la qualité du PDF
- Vérifier la génération par CI


## Auteurs

- Stéven LÉONARD
- Haoni WU
