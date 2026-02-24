# OnionChatF3nix

OnionChatF3nix es una app de chat P2P sobre Tor (.onion), ligera y con interfaz de escritorio simple.
<img width="1919" height="1005" alt="Captura de pantalla 2026-02-24 114152" src="https://github.com/user-attachments/assets/20e8fb2c-8361-4f8c-b34c-a622fa8ed2dc" />

## Caracteristicas
- Chat en tiempo real sobre Tor.
- Creacion de servicio onion efimero para recibir conexiones.
- Conexion a otros peers por direccion `.onion`.
- Envio de archivos hasta 5 MB.
- Deteccion automatica de SOCKS/ControlPort (9050/9150 y 9051/9151).
- Tema claro y oscuro.

## Requisitos
- Windows 10/11
- Tor activo (Tor Browser abierto o servicio Tor ejecutandose)

## Uso rapido
1. Ejecuta `OnionChatF3nix.exe`.
2. Pulsa `Detectar Tor`.
3. Para hospedar: pulsa `Crear chat onion` y comparte tu direccion.
4. Para conectar: pega una direccion `.onion` y pulsa `Conectar`.

## Versionado (SemVer)
Usa el esquema `vMAJOR.MINOR.PATCH`.

- Primera version estable: `v1.0.0`
- Cambios compatibles (nuevas funciones): sube `MINOR` (ej. `v1.1.0`)
- Correcciones/bugs: sube `PATCH` (ej. `v1.1.1`)
- Cambios incompatibles: sube `MAJOR` (ej. `v2.0.0`)

Script incluido para crear tags:

```powershell
# Crea siguiente patch (si no hay tags, crea v1.0.0)
.\scripts\release.ps1

# Crea siguiente minor
.\scripts\release.ps1 -Bump minor

# Crea siguiente major
.\scripts\release.ps1 -Bump major

# Crear version exacta y subirla
.\scripts\release.ps1 -Version v1.1.0 -Push
```

Ver releases/tags:

```powershell
git tag --list
git push origin <tag>
```

## Archivos generados
- Descargas recibidas: `Downloads/OnionChatF3nix`
- Build ejecutable: `dist/OnionChatF3nix.exe`
- Paquete para compartir: `release/OnionChatF3nix-Windows.zip`

## Aviso
Este proyecto es para fines educativos. No uses esta herramienta para actividades ilegales.
