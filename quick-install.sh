#!/bin/bash

# Quick Brew Installation Script
# Solo instala los paquetes desde Brewfile

echo "🍺 INSTALACIÓN RÁPIDA DE PAQUETES"
echo "================================="
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew no está instalado"
    echo "💡 Ejecuta './setup.sh' para instalación completa"
    exit 1
fi

# Check if Brewfile exists
if [ ! -f "Brewfile" ]; then
    echo "❌ No se encontró el archivo Brewfile"
    exit 1
fi

echo "🔄 Actualizando Homebrew..."
brew update

echo "📦 Instalando paquetes desde Brewfile..."
brew bundle install --file=Brewfile

echo "🧹 Limpiando instalación..."
brew cleanup

echo ""
echo "✅ ¡Instalación completada!"
echo "📊 Resumen:"
echo "   📱 $(brew list --cask | wc -l | xargs) aplicaciones instaladas"
echo "   🔧 $(brew list --formula | wc -l | xargs) herramientas CLI instaladas"
