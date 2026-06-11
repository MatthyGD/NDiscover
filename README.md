[![Stars](https://img.shields.io/github/stars/MatthyGD/NDiscover?style=for-the-badge&color=00e6c8&labelColor=0d1117&logo=github)](https://github.com/MatthyGD/NDiscover/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/MatthyGD/NDiscover?style=for-the-badge&color=78b4ff&labelColor=0d1117&logo=git&logoColor=white)](https://github.com/MatthyGD/NDiscover/commits)
[![Language](https://img.shields.io/badge/Shell-Bash-ff5ab4?style=for-the-badge&logo=gnubash&logoColor=white&labelColor=0d1117)](https://github.com/MatthyGD/NDiscover)
[![Platform](https://img.shields.io/badge/Platform-Kali%20Linux-557C94?style=for-the-badge&logo=linux&logoColor=white&labelColor=0d1117)](https://www.kali.org/)
[![Ethics](https://img.shields.io/badge/Use-Ethical%20Only-64f082?style=for-the-badge&labelColor=0d1117)](https://github.com/MatthyGD/NDiscover)
 
---
 
## ⚠️ Precaución
 
> 👮 Usa la herramienta **solo con autorización** o en entornos controlados.
> 👮 NDiscover está pensada únicamente para **fines éticos, educativos o de investigación**.
> 👮 No se recomienda ni se respalda su uso en redes o sistemas sin permiso explícito.
>
> NDiscover realiza escaneos de red activos (barridos de puertos agresivos). Lanzarlos contra redes ajenas puede ser intrusivo e ilegal. La responsabilidad recae por completo en quien ejecuta la herramienta.
 
---
 
<div align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0d1117,50:00e6c8,100:78b4ff&height=220&section=header&text=NDiscover&fontSize=72&fontColor=ffffff&animation=twinkling&fontAlignY=40&desc=Network%20Discovery%20Toolkit%20%E2%80%94%20by%20MatthyGD&descSize=18&descAlignY=62&descColor=a0f0e0" />
<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&size=18&duration=3000&pause=800&color=00E6C8&center=true&vCenter=true&width=700&lines=ARP+%2B+ICMP+%2B+IPv6+Host+Discovery;Nmap+TCP+%2B+UDP+%2B+SCTP+Scanning;Auto-generated+HTML+Reports;Interactive+Menu-Driven+Interface" alt="Typing SVG" />
</div>
---
 
## 🌐 ¿Qué es NDiscover?
 
**NDiscover** es una herramienta interactiva de reconocimiento de red que cubre todo el ciclo de descubrimiento: desde encontrar hosts activos hasta generar reportes HTML navegables de los escaneos Nmap, todo desde un único menú guiado. Diseñada para que un analista pueda ir de cero a resultados documentados sin salir del script.
 
⭐ Descubrimiento de hosts IPv4 e IPv6 mediante **ARP**, **ICMP** y **multicast link-local**
⭐ Detección de fabricante por OUI (VMware, VirtualBox, QEMU/KVM, Raspberry Pi…)
⭐ Detección del sistema operativo por **TTL**
⭐ Escaneo de puertos vía **TCP**, **UDP** y **SCTP** con Nmap, generando **reportes HTML** navegables
⭐ Servidor **HTTP en Python** para revisar los análisis vía web desde cualquier dispositivo
⭐ Subnetting automático Clase C a partir de la IP privada introducida
 
---
 
## ✨ Características
 
| | Feature | Descripción |
|---|---|---|
| 🎨 | Paleta truecolor | Degradado cian → magenta con fallback automático a 8 colores |
| 🧭 | Menú interactivo | 9 opciones guiadas con cabeceras degradadas e iconos |
| 🏷️ | Detección de fabricante | OUI lookup para IPv4 y correlación con vecinos IPv6 |
| 🌐 | IPv6 robusto | Ping multicast `ff02::1` + lectura de tabla `ip -6 neigh` |
| 📄 | Reportes HTML | Conversión automática XML → HTML vía `xsltproc` |
| 🛡️ | Escaneo IPv6 estable | Evita el crash NSE de Nmap usando `-sV -O --traceroute` en IPv6 |
| 🔒 | Servidor HTTP limpio | `Ctrl+C` detiene el servidor y devuelve al menú sin matar el proceso |
| ✅ | Validación de entradas | Formato de IP y opciones de menú validados antes de ejecutar |
 
---
 
## 🔎 Opciones del menú
 
| Opción | Función | Descripción |
|---|---|---|
| `1` | ❓ Ayuda y guía | Cómo usar NDiscover y flujo recomendado |
| `2` | 📦 Verificar dependencias | Comprueba e instala `nmap`, `python3` y `xsltproc` |
| `3` | 🌐 Interfaces de red | Lista todas las interfaces activas del sistema |
| `4` | 🔍 Descubrir hosts | ARP (capa 2) + ICMP echo (capa 3) + vecinos IPv6 link-local |
| `5` | 🕵️ Detección de SO | Inferencia del SO por TTL recibido en ping |
| `6` | 💻 Nmap IPv4 | TCP + UDP + SCTP completos con generación de HTML por protocolo |
| `7` | 💻 Nmap IPv6 | Igual que opción 6 pero sobre dirección IPv6 |
| `8` | 📂 Banco + HTTP | Crea estructura de directorios e inicia servidor HTTP en Python |
| `9` | ❌ Salir | Cierra NDiscover de forma limpia |
 
---
 
## 📦 Requisitos
 
| Herramienta | Función | Instalación |
|---|---|---|
| `nmap` | Motor de escaneo y descubrimiento | `apt install nmap` |
| `python3` | Servidor HTTP del banco de trabajo | Preinstalado en Kali |
| `xsltproc` | Generación de reportes HTML | `apt install xsltproc` |
| `iproute2` | Interfaces y vecinos IPv6 | Preinstalado en Kali |
| `ping` (IPv6) | Multicast link-local | Preinstalado en Kali |
 
> 💡 NDiscover puede instalar sus dependencias automáticamente desde la **opción 2** del menú.
 
> 🔑 Los escaneos SYN/UDP/SCTP, detección de SO y creación de bancos en `/opt` requieren **sudo**.
 
---
 
## 🚀 Instalación y uso
 
🔴 Clonar el repositorio
 
```bash
git clone https://github.com/MatthyGD/NDiscover.git
```
 
🔴 Entrar en el directorio
 
```bash
cd NDiscover/
```
 
🔴 Garantizar permisos de ejecución
 
```bash
chmod +x NDiscover.sh
```
 
🔴 Desplegar la herramienta
 
```bash
sudo ./NDiscover.sh
```
 
---
 
## 🧭 Recorrido por el menú
 
✅ **1 → Ayuda y guía de uso**
 
Descripción del flujo recomendado: instalar dependencias → descubrir hosts → escanear con Nmap → banco de trabajo. Incluye información del autor y créditos.
 
✅ **2 → Verificación e instalación de dependencias**
 
Comprueba `nmap`, `python3` y `xsltproc`. Si alguna falta, ofrece instalarla con `apt` automáticamente antes de continuar.
 
✅ **3 → Interfaces de red disponibles**
 
Lista todas las interfaces activas con sus IPs usando `ip -brief address` con salida en color. Útil para identificar la interfaz y red objetivo antes de lanzar el descubrimiento.
 
✅ **4 → Descubrimiento de hosts (ARP · ICMP · IPv6)**
 
Introduce tu IP privada y NDiscover deriva la subred `/24`. Lanza tres pasadas: ARP sobre capa 2, ICMP echo sobre capa 3 y detección de vecinos IPv6 link-local. Muestra IP, MAC, fabricante detectado por OUI y acumula los resultados en un caché de sesión para correlacionar IPv4 ↔ IPv6.
 
✅ **5 → Detección de SO por TTL**
 
Envía un ping a la IP indicada e infiere el sistema operativo probable: `≤64` → Linux/Unix, `≤128` → Windows, `>128` → dispositivo de red.
 
✅ **6 & 7 → Escaneo de puertos IPv4 / IPv6 (TCP · UDP · SCTP)**
 
Escaneo completo de los 65535 puertos por protocolo con Nmap a máxima velocidad (`--min-rate=5000 -T5`). Los resultados se guardan en XML y se convierten a HTML con `xsltproc` para revisar desde el navegador. En IPv6 se usa `-sV -O --traceroute` para evitar el crash del motor NSE.
 
✅ **8 → Banco de trabajo + servidor HTTP**
 
Crea en `/opt/<nombre>` una estructura de subdirectorios (`ftp`, `ssh`, `smb`, `http`, `credentials`, `exploit`…) e inicia un servidor HTTP en Python en el puerto elegido. `Ctrl+C` detiene el servidor y devuelve al menú sin interrumpir el proceso.
 
✅ **9 → Salir**
 
Cierra NDiscover de forma limpia con confirmación previa.
 
---
 
<div align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&color=0:78b4ff,100:0d1117&height=120&section=footer" />

Desarrollado por MatthyGD (https://github.com/MatthyGD)
</div>
