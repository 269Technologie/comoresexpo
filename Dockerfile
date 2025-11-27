# Étape 1: Builder
FROM node:20-bullseye-slim AS builder

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install --legacy-peer-deps

# Copier tout le code source
COPY . .

# Étape 2: Production
FROM node:20-bullseye-slim

WORKDIR /app

# Copier node_modules et le code depuis builder
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app ./

# Installer serve pour servir l'application web
RUN npm install -g serve

# Exposer le port 3000
EXPOSE 3000

# Démarrer l'application
# Option 1: Si vous voulez servir le fichier HTML statique
CMD ["serve", "-s", ".", "-l", "3000"]

# Option 2: Si vous préférez utiliser expo (décommentez la ligne ci-dessous et commentez celle du dessus)
# CMD ["npx", "expo", "start", "--web", "--port", "3000"]