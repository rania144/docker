# Documentation du déploiement Ansible

## Introduction

Cette documentation décrit le processus d'automatisation . Elle détaille les fichiers de configuration nécessaires, leur fonctionnement, et les étapes de déploiement.

## Prérequis

- **Infrastructure fonctionnelle** comme présenté dans le README.md
- **Ansible** : Installer Ansible sur votre machine bastion. [Documentation Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

  ##  Playbook Ansible : Sécurité et Monitoring

Ce playbook automatise l’installation et la configuration des outils de sécurité sur un serveur Linux :

-  **fail2ban** : protection contre les tentatives de connexion SSH malveillantes
- **auditd** : surveillance des activités système
-  **UFW** : pare-feu pour filtrer les ports
-  **Désactivation du SSH root** : meilleure sécurité d’accès
-  **Mises à jour automatiques** : maintenir le système à jour



  

