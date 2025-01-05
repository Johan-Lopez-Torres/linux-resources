#!/bin/bash

# Definir la versión de kind
KIND_VERSION="v0.26.0"

# Descargar el binario de kind para la arquitectura AMD64
echo "Descargando kind versión $KIND_VERSION..."
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/$KIND_VERSION/kind-linux-amd64"

# Comprobar si la descarga fue exitosa
if [[ $? -ne 0 ]]; then
    echo "Error al descargar kind. Verifica tu conexión a Internet."
    exit 1
fi

# Hacer el archivo ejecutable
echo "Haciendo el binario ejecutable..."
chmod +x ./kind

# Mover el binario al directorio /usr/local/bin
echo "Moviendo kind a /usr/local/bin..."
sudo mv ./kind /usr/local/bin/kind

# Verificar la instalación
echo "Verificando instalación de kind..."
if kind version; then
    echo "kind instalado correctamente."
else
    echo "Hubo un problema al verificar la instalación."
    exit 1
fi
