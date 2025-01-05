#!/bin/bash

# Actualizar el sistema
echo "Actualizando el sistema..."
sudo apt-get update -y

# Instalar dependencias necesarias
echo "Instalando dependencias..."
sudo apt-get install -y apt-transport-https curl

# Añadir la clave GPG de Helm
echo "Añadiendo la clave GPG de Helm..."
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null

# Añadir el repositorio de Helm
echo "Añadiendo el repositorio de Helm..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

# Actualizar los repositorios
echo "Actualizando los repositorios..."
sudo apt-get update -y

# Instalar Helm
echo "Instalando Helm..."
sudo apt-get install -y helm

# Verificar la instalación
echo "Verificando la instalación de Helm..."
helm version

echo "Helm ha sido instalado exitosamente."
