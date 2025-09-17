# PS Antitank - Anti-Tank Headshot System

Un script realista para FiveM/ESX que implementa un sistema de headshots con consecuencias variables, eliminando la posibilidad de tanquear disparos a la cabeza.

## 📋 Características

- **Sistema de headshots realista**: Los disparos a la cabeza tienen consecuencias inmediatas
- **Probabilidad 50/50**: 
  - 50% de probabilidad de muerte instantánea
  - 50% de probabilidad de ragdoll con efectos de aturdimiento
- **Efectos visuales**: Efecto de cámara borracha durante el ragdoll
- **Anti-spam**: Sistema de cooldown para evitar activaciones múltiples
- **Logging opcional**: Registro de headshots en el servidor
- **Compatible con ESX**: Totalmente integrado con el framework ESX

## 🎯 Funcionamiento

Cuando un jugador recibe daño en la cabeza (bone ID: 31086), el script determina aleatoriamente una de estas dos consecuencias:

### Muerte Instantánea (50%)
- El jugador muere al instante
- No hay posibilidad de reanimación

### Ragdoll + Aturdimiento (50%)
- El jugador entra en ragdoll durante 2.5 segundos
- Efecto de cámara "borracha" 
- El jugador mantiene vida suficiente para sobrevivir
- Después del ragdoll, el jugador puede levantarse normalmente

## 📁 Estructura de Archivos

```
ps_antitank/
├── fxmanifest.lua
├── client.lua
├── server.lua
└── README.md
```

## 🔧 Instalación

1. Descarga o clona este repositorio
2. Coloca la carpeta `ps_antitank` en tu directorio `resources`
3. Añade `ensure ps_antitank` a tu `server.cfg`
4. Reinicia el servidor

### Dependencias

- **ESX Framework**: El script requiere ESX para funcionar correctamente

## ⚙️ Configuración

### Modificar Probabilidades

Para cambiar las probabilidades de muerte vs ragdoll, edita esta línea en `client.lua`:

```lua
local chance = math.random(1,2) -- 1 = muerte, 2 = ragdoll
```

Opciones:
- `math.random(1,2)` - 50% muerte, 50% ragdoll
- `math.random(1,3)` - 33% muerte, 67% ragdoll  
- `math.random(1,4)` - 25% muerte, 75% ragdoll

### Ajustar Duración del Ragdoll

Modifica estos valores para cambiar la duración del ragdoll:

```lua
SetPedToRagdoll(player, 2500, 2500, 0, false, false, false) -- 2500ms = 2.5 segundos
```

### Cooldown entre Activaciones

Para cambiar el tiempo de cooldown entre headshots:

```lua
if currentTime - lastDamageTime > 500 then -- 500ms de cooldown
```

## 🚨 Características Técnicas

- **Detección de bone**: Utiliza el bone ID 31086 (cabeza) para detectar headshots
- **Anti-muerte durante ragdoll**: Sistema de protección que mantiene al jugador vivo durante el ragdoll
- **Limpieza de estados**: Previene detecciones múltiples del mismo daño
- **Threading optimizado**: Uso eficiente de hilos para no afectar el rendimiento

## 🐛 Solución de Problemas

### El jugador sigue muriendo durante el ragdoll
- Asegúrate de estar usando la versión actualizada del script
- Verifica que no haya otros scripts de daño interfiriendo

### El efecto no se activa
- Confirma que ESX esté funcionando correctamente
- Revisa la consola por errores
- Verifica que el bone ID 31086 sea correcto para tu servidor

### Múltiples activaciones del mismo golpe
- El script incluye un sistema de cooldown de 500ms
- Si persiste el problema, aumenta el valor del cooldown

## 📝 Logging

El script incluye un sistema opcional de logging que registra los headshots en el servidor. Para activarlo, descomenta o modifica el archivo `server.lua`.

## 🤝 Contribución

Si encuentras bugs o tienes sugerencias de mejora:

1. Abre un issue describiendo el problema
2. Proporciona información detallada sobre tu configuración
3. Incluye logs de errores si los hay

## 📄 Licencia

Este proyecto está bajo licencia MIT. Puedes usarlo, modificarlo y distribuirlo libremente.

## 👤 Autor

**Pausiar**
- Versión: 1.1.0
- Framework: ESX
- Plataforma: FiveM

---

⚠️ **Advertencia**: Este script modifica el comportamiento de daño del juego. Úsalo bajo tu propia responsabilidad y asegúrate de probarlo en un entorno de desarrollo antes de implementarlo en producción.