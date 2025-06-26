# Étape 1 : utiliser une image nginx officielle légère
FROM nginx:alpine

# Étape 2 : copier tout le contenu du dossier courant dans nginx
COPY . /usr/share/nginx/html

# Étape 3 : exposer le port 80 pour accéder au site
EXPOSE 80

