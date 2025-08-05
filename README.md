# 🍺 Brew Backup & Restore

Una solución completa para respaldar y restaurar automáticamente todas tus aplicaciones y herramientas instaladas con Homebrew en macOS. Perfecto para cuando formateas tu Mac o migras a una nueva máquina.

## 🚀 Características

- **Backup Completo**: Respaldo de todas las aplicaciones y herramientas CLI
- **Restauración Automática**: Instalación con un solo comando
- **Configuración Completa**: Incluye Homebrew, Git, Node.js y más
- **Scripts Inteligentes**: Detecta qué ya está instalado y solo instala lo necesario
- **Fácil Mantenimiento**: Script para crear nuevos backups

## 📦 Paquetes Incluidos

### 🔧 Herramientas CLI (19 paquetes)
- **gh** - GitHub CLI
- **git** - Control de versiones
- **nmap** - Network scanner
- **nvm** - Node.js version manager
- **postgresql@14** - Base de datos PostgreSQL
- **ripgrep** - Búsqueda ultrarrápida en archivos
- Y muchas más...

### 📱 Aplicaciones (32 apps)
- **Google Chrome** - Navegador web
- **Firefox** - Navegador web alternativo
- **Visual Studio Code** - Editor de código
- **Slack** - Comunicación empresarial
- **Postman** - Testing de APIs
- **Claude** - AI Assistant
- **Spotify** - Música streaming
- **WhatsApp** - Mensajería
- **Telegram** - Mensajería alternativa
- Y muchas más...

## 🛠️ Instalación

### Opción 1: Configuración Completa (Recomendada)
Para una Mac recién formateada o nueva:

```bash
git clone https://github.com/estiven-uni/brew-backup-restore.git
cd brew-backup-restore
chmod +x setup.sh
./setup.sh
```

Este script hará:
- ✅ Instalar Command Line Tools
- ✅ Instalar Homebrew
- ✅ Instalar todos los paquetes
- ✅ Configurar Git
- ✅ Instalar Node.js LTS
- ✅ Crear script de backup

### Opción 2: Solo Instalar Paquetes
Si ya tienes Homebrew instalado:

```bash
git clone https://github.com/estiven-uni/brew-backup-restore.git
cd brew-backup-restore
chmod +x quick-install.sh
./quick-install.sh
```

### Opción 3: Manual con Brewfile
Si prefieres usar solo el Brewfile:

```bash
brew bundle install --file=Brewfile
```

## 🔄 Crear Nuevo Backup

Para actualizar el backup con tus paquetes actuales:

```bash
./backup_brew.sh
git add Brewfile
git commit -m "Update Brewfile with current packages"
git push
```

## 📋 Comandos Útiles

```bash
# Ver paquetes instalados
brew list --formula  # Herramientas CLI
brew list --cask     # Aplicaciones

# Actualizar todo
brew update && brew upgrade

# Limpiar archivos antiguos
brew cleanup

# Verificar salud de Homebrew
brew doctor

# Crear backup manual
brew bundle dump --force --describe
```

## 🏗️ Estructura del Repositorio

```
brew-backup-restore/
├── Brewfile              # Lista de todos los paquetes
├── setup.sh             # Configuración completa
├── quick-install.sh     # Solo instalación de paquetes
├── backup_brew.sh       # Script para crear backups
└── README.md           # Esta documentación
```

## ⚡ Casos de Uso

### 🔄 Formatear Mac
1. Haz backup del Brewfile actual
2. Formatea tu Mac
3. Clona este repo
4. Ejecuta `./setup.sh`
5. ¡Listo! Todo instalado automáticamente

### 🆕 Mac Nueva
1. Clona este repo
2. Ejecuta `./setup.sh`
3. Todos tus programas favoritos estarán instalados

### 👥 Compartir Setup
1. Comparte este repo con colegas
2. Ellos ejecutan `./setup.sh`
3. Tendrán el mismo entorno de desarrollo

## 🧪 Testing

Para probar que todo funciona correctamente:

```bash
# Verificar Homebrew
brew doctor

# Verificar aplicaciones principales
which git gh code node npm

# Ver aplicaciones instaladas
ls /Applications/ | grep -E "(Chrome|Slack|Code)"
```

## 🔧 Personalización

Para personalizar las aplicaciones instaladas:

1. Edita el archivo `Brewfile`
2. Agrega o quita paquetes usando:
   ```
   brew "nombre-del-paquete"        # Para CLI tools
   cask "nombre-de-la-aplicacion"   # Para aplicaciones
   ```
3. Guarda y haz commit de los cambios

## 📝 Notas Importantes

- **Tiempo de instalación**: ~30-60 minutos dependiendo de tu conexión
- **Espacio requerido**: ~15-20GB para todas las aplicaciones
- **Compatibilidad**: macOS Big Sur 11.0+ (Intel y Apple Silicon)
- **Permisos**: Algunos paquetes pueden requerir contraseña de administrador

## 🚨 Solución de Problemas

### Homebrew no se instala
```bash
xcode-select --install
# Después ejecuta setup.sh nuevamente
```

### Error de permisos
```bash
sudo chown -R $(whoami) $(brew --prefix)/*
```

### Paquete específico falla
```bash
brew install nombre-del-paquete --verbose
```

## 🤝 Contribuciones

¿Tienes sugerencias de aplicaciones útiles? ¡Abre un issue o pull request!

### Aplicaciones Sugeridas para Agregar:
- [ ] Docker Desktop
- [ ] Discord
- [ ] Notion
- [ ] 1Password
- [ ] Figma

## 📄 Licencia

Este proyecto es de uso libre. Perfecto para desarrolladores, diseñadores y usuarios avanzados de macOS.

---

⭐ Si te resulta útil, ¡dale una estrella al repo!
