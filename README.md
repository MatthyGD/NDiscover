# ⚠️ Precaución
 
![WARNING-12-12-2024 (1)](https://github.com/user-attachments/assets/148e670a-8284-47b0-9080-e8fbd738d85b)
 
> 👮 **Usa la herramienta solo con autorización o en entornos controlados.**
> 👮 **NDiscover está pensada únicamente para fines éticos, educativos o de investigación.**
> 👮 **No se recomienda ni se respalda su uso en redes o sistemas sin permiso explícito.**
 
NDiscover realiza **escaneos de red activos** (incluyendo barridos de puertos agresivos). Lanzarlos contra redes ajenas puede ser intrusivo e ilegal. La responsabilidad recae por completo en quien ejecuta la herramienta.
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
# 🔍️ Comienza a Auditar con NDiscover
 
![NDISCOVER-12-12-2024 (2)](https://github.com/user-attachments/assets/28071e81-e50b-4595-b2dc-394d6518b119)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
### 🌐 ¿Qué es NDiscover? 🌐
 
**NDiscover** (NetDiscover) es una herramienta interactiva que automatiza el reconocimiento de red de principio a fin, desde un menú claro y guiado:
 
#### ⭐ Descubrimiento de interfaces de red
#### ⭐ Descubrimiento de hosts IPv4 e IPv6 mediante ARP, ICMP y multicast link-local, con **detección de fabricante** y subnetting automático (Clase C)
#### ⭐ Detección del sistema operativo por TTL
#### ⭐ Escaneo automático de puertos IPv4 e IPv6 vía TCP, UDP y SCTP, con **reportes HTML** navegables
#### ⭐ Creación de bancos de trabajo y servidor HTTP en Python para revisar los análisis vía web
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## ✨ Características
 
- 🎨 **Banner con degradado truecolor** (cian → magenta) y *fallback* automático a 8 colores en terminales sin soporte de 24 bits.
- 🧭 **Menú interactivo** con cabeceras de sección degradadas, iconos y mensajes de estado uniformes (`✔ ✖ ⚠ ➜`).
- 🏷️ **Detección de fabricante por OUI** (VMware, VirtualBox, QEMU/KVM, Raspberry Pi…) tanto en hosts IPv4 como correlacionando los vecinos **IPv6** descubiertos.
- 🌐 **Descubrimiento IPv6 robusto**: detecta la interfaz por defecto, hace *ping* multicast a `ff02::1` y lee la tabla de vecinos (`ip -6 neigh`), en lugar de depender de *scripts* NSE frágiles.
- 📄 **Reportes HTML automáticos** de cada escaneo (vía `xsltproc`). Si la conversión falla, **se conserva el XML** para no perder resultados.
- 🛡️ **Escaneo IPv6 estable**: en TCP por IPv6 se usa `-sV -O --traceroute` en lugar de `-A`, evitando el *crash* del motor NSE de Nmap (`assertion 'lua_status(L) == LUA_YIELD'`) que aparece en varias versiones.
- 🔒 **Servidor HTTP que no rompe el flujo**: `Ctrl+C` detiene el servidor y te devuelve a la herramienta, sin matar el proceso.
- ✅ **Validación de entradas** (formato de IP, opciones del menú) y comprobación/instalación de dependencias.
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## 📦 Requisitos
 
NDiscover puede comprobar e instalar sus dependencias desde el propio menú (opción 2). Las principales son:
 
- `nmap` — motor de escaneo y descubrimiento
- `python3` — servidor HTTP del banco de trabajo
- `xsltproc` — generación de los reportes HTML
- `iproute2` (`ip`) y `ping` con soporte IPv6 — descubrimiento de interfaces y vecinos
> 💡 Para ver el banner con degradado a todo color usa una terminal con soporte **truecolor**. Si no, NDiscover cae automáticamente a colores básicos.
>
> 🔑 Muchos escaneos (SYN/UDP/SCTP, detección de SO) y la creación de bancos en `/opt` requieren privilegios: ejecuta la herramienta con **sudo**.
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## 🚀 Instalación y uso
 
🔴 Clonamos el repositorio
 
```bash
git clone https://github.com/MatthyGD/NDiscover.git
```
 
🔴 Entramos dentro del repositorio
 
```bash
cd NDiscover/
```
 
🔴 Garantizamos permisos de ejecución
 
```bash
chmod +x NDiscover.sh
```
 
🔴 Desplegamos la herramienta como usuario privilegiado
 
```bash
sudo ./NDiscover.sh
```
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## 🧭 Recorrido por el menú
 
✅ **1 → Menú de ayuda y guía de uso de la herramienta:**
 
![Ayuda](https://github.com/user-attachments/assets/4fe40482-ea04-4284-89f0-d2c40f6e66f8)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **2 → Verificación e instalación automática de dependencias** (`nmap`, `python3`, `xsltproc`)**:**
 
![Herramientas2](https://github.com/user-attachments/assets/f7240853-3197-4703-947f-393e472af7b2)
 
![Requisitos](https://github.com/user-attachments/assets/8c2e3d37-63e0-4e02-8a10-3f6724efefa3)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **3 → Interfaces de red disponibles:**
 
![Interfaces](https://github.com/user-attachments/assets/93c5e3bf-7cc8-4cfc-85d5-4c08b4d943eb)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **4 → Descubrimiento de hosts vía ARP, ICMP e IPv6 con subnetting automático (Clase C) y detección de fabricante:**
 
![Hosts](https://github.com/user-attachments/assets/a3614eef-81e3-4f4d-b843-89a6a64fa3c3)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **5 → Detección del sistema operativo por TTL:**
 
> Envía un *ping* a la IP indicada e infiere el sistema operativo probable a partir del TTL recibido (≤64 → Linux/Unix, ≤128 → Windows, en otro caso → dispositivo de red).
>
> _(Captura pendiente — añádela aquí cuando quieras.)_
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **6 & 7 → Escaneo de puertos (IPv4 e IPv6) vía TCP, UDP y SCTP, con reportes HTML:**
 
![Puertos 1](https://github.com/user-attachments/assets/cd44eac4-4084-4a58-9d40-360d149e5175)
 
![Puertos 2](https://github.com/user-attachments/assets/92bdc3e1-a313-4105-a0ac-5a6909dc136e)
 
![Puertos 3](https://github.com/user-attachments/assets/dd7ffec6-99b8-4bcd-9d5a-713d079a955c)
 
![Puertos 4](https://github.com/user-attachments/assets/44b8b27b-1a56-4f56-94fd-aeb20b35232a)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **8 → Creación del banco de trabajo + servidor HTTP en Python para revisar los análisis vía web:**
 
![Extra 1](https://github.com/user-attachments/assets/f09b5cc8-4174-40ef-af18-7e1bde34006f)
 
![Extra 2](https://github.com/user-attachments/assets/14186cd1-a482-404e-853a-b9d35f241f3e)
 
![Extra 3](https://github.com/user-attachments/assets/8732c927-9abb-4e8c-8845-91ae12df9bb5)
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
✅ **9 → Salir** de la herramienta de forma limpia.
 
------------------------------------------------------------------------------------------------------------------------------------------------------------
 
# ❤️ ¡Hasta aquí todo!
 
Si NDiscover te resulta útil, ⭐ deja una estrella en el repositorio y comparte tu *feedback*. ¡Gracias por usarla!
