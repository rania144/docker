# Explication du fichier Docker Compose pour Arcdata

Ce fichier `docker-compose.yml` définit plusieurs services essentiels pour le projet Arcdata :

- **arcdata-site** :  
  C’est le service principal qui construit l’image Docker à partir du dossier `arcdata-site` et expose le port 80 du conteneur sur le port 8080 de la machine hôte.

- **prometheus** :  
  Utilise l’image officielle Prometheus pour la collecte et le stockage des métriques.  
  Il monte deux fichiers de configuration (`prometheus.yml` et `alert_rules.yml`) depuis le chemin `/home/ubuntu/docker/arcdata-project/` sur la machine hôte vers le conteneur.  
  Prometheus est exposé sur le port 9091.

- **grafana** :  
  Utilise l’image officielle Grafana pour la visualisation des métriques.  
  Il expose le port 3000 et stocke les données persistantes dans un volume Docker nommé `grafana-storage`.

- **blackbox_exporter** :  
  Service qui permet de tester la disponibilité des services HTTP via Prometheus.  
  Expose le port 9115.

---

## Configuration Prometheus (extrait)

- `global.scrape_interval` : Définit l’intervalle de collecte des métriques à 15 secondes.
- `rule_files` : Charge les règles d’alerte définies dans `alert_rules.yml`.
- `scrape_configs` : Configure la manière dont Prometheus récupère les métriques. Ici, il teste via `blackbox_exporter` la disponibilité du service `arcdata-site` sur le port 80.
- Une alerte est définie pour signaler si le service HTTP n’est pas joignable pendant plus de 30 secondes.

---
# Explication des règles d’alerte Prometheus

Cette section définit un **groupe de règles d’alerte** nommé `instance-down`.  

Elle contient une alerte appelée **HTTP_Service_Down** qui se déclenche si le service web `arcdata-site` n’est pas joignable :  

- `expr`: La condition est que `probe_success` (le succès du test HTTP fait par blackbox_exporter) soit égal à 0,  
  ce qui signifie que la requête HTTP a échoué.  
- `for: 30s`: Cette condition doit être vraie pendant au moins 30 secondes pour déclencher l’alerte.  
- `labels.severity`: L’alerte est de gravité critique (`critical`).  
- `annotations.summary`: Résumé rapide de l’alerte ("Service HTTP injoignable").  
- `annotations.description`: Description détaillée indiquant que l’URL `http://arcdata-site:80` ne répond plus depuis plus de 30 secondes.

Cette règle permet à Prometheus d’envoyer des notifications ou de déclencher des actions quand le site web Arcdata est inaccessible.

 ---

## Contexte important

Avant de lancer cette stack Docker avec `docker-compose.yml`, Docker doit être installé sur les serveurs.  
Dans ce projet Arcdata, Docker a été installé et configuré automatiquement grâce au playbook Ansible `docker.yml`.  
Ce playbook installe Docker, copie les fichiers nécessaires, ajoute l’utilisateur `ubuntu` au groupe Docker, et lance la stack Docker en mode détaché.

---
Ansible automatise l'installation et la configuration de l'infrastructure pour le projet Arcdata, incluant la mise en place de Docker et des services de monitoring comme Prometheus et Grafana via des playbooks. Le fichier `docker-compose.yml` lance plusieurs conteneurs essentiels : le site Arcdata, Prometheus pour collecter les métriques, Grafana pour les visualiser, et Blackbox Exporter pour vérifier la disponibilité du site. Prometheus utilise des règles d’alerte, notamment pour détecter quand le site est inaccessible depuis plus de 30 secondes, ce qui permet de recevoir des notifications critiques et d'assurer la surveillance continue du service.





  



  

