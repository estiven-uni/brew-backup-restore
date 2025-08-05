#!/bin/bash

# Brew Backup & Restore Setup Script
# Configuración automática completa después de formatear macOS

set -e  # Exit on any error

echo "🍺 BREW BACKUP & RESTORE SETUP"
echo "=============================="
echo ""

# Function to print colored output
print_status() {
    echo "🔵 $1"
}

print_success() {
    echo "✅ $1"
}

print_error() {
    echo "❌ $1"
}

print_warning() {
    echo "⚠️  $1"
}

# Check if running on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    print_error "Este script solo funciona en macOS"
    exit 1
fi

print_status "Iniciando configuración del sistema..."

# Step 1: Install Command Line Tools if not present
print_status "Verificando Command Line Tools..."
if ! xcode-select -p &> /dev/null; then
    print_status "Instalando Command Line Tools..."
    xcode-select --install
    print_warning "Acepta la instalación en el diálogo que aparece"
    print_warning "Presiona ENTER cuando termine la instalación"
    read
else
    print_success "Command Line Tools ya instalado"
fi

# Step 2: Install Homebrew if not present
print_status "Verificando Homebrew..."
if ! command -v brew &> /dev/null; then
    print_status "Instalando Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_success "Homebrew instalado correctamente"
else
    print_success "Homebrew ya instalado"
fi

# Step 3: Update Homebrew
print_status "Actualizando Homebrew..."
brew update

# Step 4: Install packages from Brewfile
print_status "Instalando paquetes desde Brewfile..."
if [ -f "Brewfile" ]; then
    brew bundle install --file=Brewfile
    print_success "Todos los paquetes instalados desde Brewfile"
else
    print_error "No se encontró el archivo Brewfile"
    exit 1
fi

# Step 5: Cleanup
print_status "Limpiando instalación..."
brew cleanup
brew doctor

# Step 6: Configure Git (if not already configured)
print_status "Configurando Git..."
if ! git config --global user.name &> /dev/null; then
    echo "Configuración de Git:"
    read -p "Ingresa tu nombre: " git_name
    read -p "Ingresa tu email: " git_email
    
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    git config --global init.defaultBranch main
    
    print_success "Git configurado correctamente"
else
    print_success "Git ya configurado"
fi

# Step 7: Setup NVM and Node.js
print_status "Configurando NVM y Node.js..."
if command -v nvm &> /dev/null; then
    # Source nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    
    # Install latest LTS Node.js
    nvm install --lts
    nvm use --lts
    nvm alias default node
    
    print_success "Node.js LTS instalado y configurado"
fi

# Step 8: Create backup script for future use
print_status "Creando script de backup..."
cat > backup_brew.sh << 'EOF'
#!/bin/bash
# Backup current Homebrew packages

echo "🍺 Creando backup de paquetes Homebrew..."

# Create new Brewfile
brew bundle dump --force --describe

echo "✅ Backup creado en Brewfile"
echo "💡 No olvides hacer commit y push de los cambios"
EOF

chmod +x backup_brew.sh

print_success "Script de backup creado: backup_brew.sh"

# Step 9: Summary
echo ""
echo "=============================="
echo "🎉 CONFIGURACIÓN COMPLETADA!"
echo "=============================="
echo ""
echo "✅ Command Line Tools instalado"
echo "✅ Homebrew instalado y actualizado"
echo "✅ Todos los paquetes instalados:"
echo "   📱 $(brew list --cask | wc -l | xargs) aplicaciones"
echo "   🔧 $(brew list --formula | wc -l | xargs) herramientas de línea de comandos"
echo "✅ Git configurado"
echo "✅ Node.js LTS instalado"
echo "✅ Script de backup creado"
echo ""
echo "📝 PRÓXIMOS PASOS:"
echo "1. Reinicia tu terminal para cargar todas las configuraciones"
echo "2. Ejecuta 'brew doctor' para verificar que todo esté bien"
echo "3. Usa './backup_brew.sh' para crear backups futuros"
echo ""
echo "🚀 ¡Tu Mac está listo para usar!"
