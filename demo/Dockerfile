# Utilisation de l'image de base Open Quantum Safe avec OpenSSL 3
FROM openquantumsafe/oqs-ossl3:latest

# Métadonnées
LABEL description="Image contenant un certificat PQC généré (ML-DSA-44)"
LABEL algorithm="ML-DSA-44"

# Création du répertoire de travail
WORKDIR /certs

# Génération du certificat PQC lors du build
# 1. Génération de la clé privée avec l'algorithme ML-DSA-44
# 2. Génération immédiate d'un certificat auto-signé (CA) valide 365 jours
RUN openssl genpkey -algorithm ML-DSA-44 -out ca.key && \
    openssl req -x509 -new -key ca.key -out ca.crt -days 365 -subj "/CN=PQC Docker CA/O=OpenQuantumSafe/C=US" && \
    # Vérification et affichage des permissions (sécurité de base)
    chmod 600 ca.key && \
    chmod 644 ca.crt && \
    # Affichage d'un message de confirmation dans les logs de build
    echo "Certificat PQC généré avec succès :" && \
    openssl x509 -in ca.crt -noout -subject -dates

# Commande par défaut : afficher les informations du certificat généré
#CMD ["openssl", "x509", "-in", "/certs/ca.crt", "-noout", "-text"]