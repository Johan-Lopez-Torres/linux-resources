#!/bin/bash

# 1. Descargar la última versión estable de kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# 2. (Opcional) Validar la descarga del binario con el checksum
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# 3. Instalar kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 4. Verificar la versión de kubectl
kubectl version --client

# 5. (Opcional) Configurar el autocompletado en bash
echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc

# 6. Eliminar los archivos descargados
rm kubectl kubectl.sha256

echo "kubectl ha sido instalado correctamente."
