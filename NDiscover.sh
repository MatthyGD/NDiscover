#!/bin/bash

# ================================================================== By Matt~ ==================================================================

# NDiscover es mi primer proyecto, estoy emocionado de compartirlo con ustedes, espero que podais sacarle partido en vuestras investigaciones!

# ================================================================== By Matt~ ==================================================================

# ====================== Definición de colores ======================
RESET="\033[0m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
MAGENTA="\033[35m"
WHITE="\033[37m"

# ====================== Emojis ======================
SCANNER="🔍"
COMPUTER="💻"
NETWORK="🌐"
FOLDER="📂"
WARNING="⚠️"
CHECKMARK="✅"
SERVER="🌐📡"
EXIT="❌"
DUDE="❓"

# ====================== 1: Menú de Ayuda ======================
help_menu() {
  # Menú de ayuda profesional
  echo -e "\n${CYAN}====================== ${WARNING} Asistencia para el uso de NDiscover ${WARNING} ======================${RESET}\n"
  echo -e "\n${YELLOW} ¡Saludos! Soy Matt, Analista de Ciberseguridad especializado en Hacking Ético.${RESET}"
  echo -e "\n${YELLOW} NDiscover es una herramienta avanzada que permite realizar escaneos de Hosts activos y puertos abiertos, además de generar documentación detallada sobre los hallazgos en HTML para visualizarla mediante un navegador web.${RESET}"
  echo -e "\n${YELLOW} Se recomienda seguir el flujo sugerido por la herramienta (Instalacion de dependencias, Descubrimiento de Hosts, Escaneo con Nmap, Creación de directorios y servidor en Python) para una experiencia óptima y completa.${RESET}"
  echo -e "\n${YELLOW} Es importante destacar que, gracias a los múltiples protocolos utilizados durante los descubrimientos, se puede obtener información precisa tanto de la red local como de los puertos disponibles sin preocuparnos de nada.${RESET}"
  echo -e "\n${YELLOW} Si consideras útil esta herramienta, puedes brindarme tu apoyo en GitHub.${RESET}"
  echo -e "\n${YELLOW} ¡Gracias por utilizar NDiscover!${RESET}"
  echo -e "\n${YELLOW} ~Matt${RESET}\n"
  # Recordatorio para continuar
  echo -e "\n${YELLOW}${WARNING} El proceso ha finalizado. Presiona Enter para continuar.${RESET}"
  read -r
}

# ====================== 2: Función para verificar herramientas necesarias ======================
check_tools() {
  echo -e "\n${CYAN}====================== ${SCANNER} Verificando herramientas necesarias ${SCANNER} ======================${RESET}\n"
  
  tools=("nmap" "python3")
  all_installed=true
  
  for tool in "${tools[@]}"; do
    if ! which $tool > /dev/null 2>&1; then
      echo -e "${RED}❌ $tool no está instalado.${RESET}"
      all_installed=false
    else
      echo -e "${GREEN}✅ $tool está instalado.${RESET}"
    fi
  done
  
  if [ "$all_installed" = true ]; then
    echo -e "\n${GREEN}${CHECKMARK} Todas las herramientas necesarias están instaladas.${RESET}"
  else
    echo -e "\n${RED}${WARNING} Algunas herramientas necesarias no están instaladas. ¿Quieres instalarlas?${RESET}"
    echo -e "1) ${GREEN}Sí${RESET}"
    echo -e "2) ${RED}No${RESET}"
    read -p "Seleccione una opción: " choice
    if [ "$choice" -eq 1 ]; then
      for tool in "${tools[@]}"; do
        if ! which $tool > /dev/null 2>&1; then
          echo -e "\n${CYAN}Instalando $tool...${RESET}"
          sudo apt install -y $tool
        fi
      done
      echo -e "\n${GREEN}${CHECKMARK} Todas las herramientas necesarias han sido instaladas.${RESET}"
    else
      echo -e "\n${RED}${WARNING} Algunas herramientas necesarias no están instaladas. Por favor, instálalas antes de continuar.${RESET}"
    fi
  fi  
  # Recordatorio para continuar
  echo -e "\n${YELLOW}${WARNING} El proceso ha finalizado. Presiona Enter para continuar.${RESET}"
  read -r
}

# ====================== 3: Función para obtener las interfaces de red ======================
get_interfaces() {
  # Obtenemos las interfaces de Red
  echo -e "\n${CYAN}====================== ${NETWORK} Obteniendo las interfaces de red disponibles ${NETWORK} ======================${RESET}\n"
  sleep 3
  ip a
  # Recordatorio de continuar
  echo -e "\n${YELLOW}${WARNING} El proceso ha finalizado. Presiona Enter para continuar.${RESET}"
  read -r
}

# ====================== 4:1 Función para Derivar la Red al Subnetting ======================
get_network() {
  # Solicitar IP privada del usuario
  echo -e -n "\n${CYAN}${SCANNER} Ingresa tu IP privada (Ejemplo: 192.168.1.20): ${RESET}"
  read ip_privada

  # Extraer la red en formato /24
  network=$(echo $ip_privada | awk -F. '{print $1 "." $2 "." $3 ".0/24"}')
  echo -e "\n${GREEN}${CHECKMARK} Red derivada: ${network}${RESET}"

  # Llamar a la función para escanear la red
  scan_network $network
}

# ====================== 4.2: Función para escanear la red ======================
scan_network() {
  local network=$1
  echo -e "\n${CYAN}====================== ${SCANNER} Escaneando toda la red ${SCANNER} ======================${RESET}\n"

  # Escaneo ARP
  echo -e "${YELLOW}=================================== ARP ${SCANNER} ===================================${RESET}\n"
  nmap -sn -PR $network | awk '/Nmap scan report/{ip=$NF} /Host is up/{printf "%s\t", ip} /MAC Address/{print $3, $4, $5, $6}'
  echo -e "\n"

  # Escaneo ICMP
  echo -e "${GREEN}=================================== ICMP ${NETWORK} ===================================${RESET}\n"
  nmap -sn -PE $network | awk '/Nmap scan report/{ip=$NF} /Host is up/{printf "%s\t", ip} /MAC Address/{print $3, $4, $5, $6}'
  echo -e "\n"

  # Escaneo IPv6
  echo -e "${MAGENTA}=================================== IPv6 ${COMPUTER} ===================================${RESET}\n"
  ping6 -c2 -I eth0 ff02::1
  echo -e "\n"

  # Recordatorio de continuar
  echo -e "\n${YELLOW}${WARNING} El proceso ha finalizado. Presiona Enter para continuar.${RESET}"
  read -r
}

# ====================== 5: Función para escanear en IPv4 ======================
advanced_scan_ipv4() {
  # Solicitar IP de la víctima
  echo -e -n "\n${CYAN}${SCANNER} Ingresa la IP IPv4 que deseas escanear (Ejemplo: 192.168.0.10): ${RESET}"
  read ip_victima_4

  # Solicitar nombre del banco de trabajo
  echo -e -n "\n${CYAN}${SCANNER} Ingresa el nombre del banco de trabajo que deseas crear (Ejemplo: Dockerlabs_Maquina_Upload): ${RESET}"
  read nombre_banco

  # Crear directorio de trabajo
  echo -e "\n${YELLOW}=================================== ${FOLDER} Creando directorios para guardar los resultados en: ${RESET}/opt/${nombre_banco}/nmap_IPV4\n"
  mkdir -p /opt/$nombre_banco/nmap_IPV4 && cd /opt/$nombre_banco/nmap_IPV4

  # Escaneo TCP
  echo -e "\n${GREEN}=================================== Escaneo TCP ${SCANNER} ===================================${RESET}\n"
  nmap -p 1-65535 --open --min-rate=5000 -T5 -A -sT -Pn -n -v $ip_victima_4 -oX nmap_TCP_IPv4.xml
  xsltproc nmap_TCP_IPv4.xml -o nmap_TCP_IPv4.html

  # Escaneo UDP
  echo -e "\n${MAGENTA}=================================== Escaneo UDP ${NETWORK} ===================================${RESET}\n"
  nmap -p 1-65535 --min-rate=5000 -T5 -O --traceroute -sU -Pn -n -v $ip_victima_4 -oX nmap_UDP_IPv4.xml
  xsltproc nmap_UDP_IPv4.xml -o nmap_UDP_IPv4.html

  # Escaneo SCTP
  echo -e "\n${BLUE}=================================== Escaneo SCTP ${COMPUTER} ===================================${RESET}\n"
  nmap -p 1-65535 --open --min-rate=5000 -T5 -O --traceroute -sY -Pn -n -v $ip_victima_4 -oX nmap_SCTP_IPv4.xml
  xsltproc nmap_SCTP_IPv4.xml -o nmap_SCTP_IPv4.html

  # Eliminar archivos XML
  echo -e "\n${RED}${WARNING} Eliminando archivos XML y Obteniendo archivos HTML para Documetacion Web${RESET}\n"
  sleep 3
  rm *xml*
  echo -e "\n${GREEN}${CHECKMARK} Escaneos completados para la IP: ${ip_victima_4}${RESET}"

  # Recordatorio de continuar
  echo -e "\n${YELLOW}${WARNING} El proceso ha finalizado. Presiona Enter para continuar.${RESET}"
  read -r
}

# ====================== 6: Función para escanear en IPv6 ======================
advanced_scan_ipv6() {
  # Solicitar IP de la víctima
  echo -e -n "\n${CYAN}${SCANNER} Ingresa la IP IPv6 que deseas escanear (Ejemplo: fe80::20c:29ff:fe43:4b01%eth0): ${RESET}"
  read ip_victima_6

  # Solicitar nombre del banco de trabajo
  echo -e -n "\n${CYAN}${SCANNER} Ingresa el nombre del banco de trabajo que deseas crear (Ejemplo: Dockerlabs_Maquina_Upload): ${RESET}"
  read nombre_banco

  # Crear directorio de trabajo
  echo -e "\n${YELLOW}=================================== ${FOLDER} Creando directorios para guardar los resultados en: ${RESET}/opt/${nombre_banco}/nmap_IPV6\n"
  mkdir -p /opt/$nombre_banco/nmap_IPV6 && cd /opt/$nombre_banco/nmap_IPV6

  # Escaneo TCP
  echo -e "\n${GREEN}=================================== Escaneo TCP ${SCANNER} ===================================${RESET}\n"
  nmap -6 -p 1-65535 --open --min-rate=5000 -T5 -A -sT -Pn -n -v $ip_victima_6 -oX nmap_TCP_IPv6.xml
  xsltproc nmap_TCP_IPv6.xml -o nmap_TCP_IPv6.html

  # Escaneo UDP
  echo -e "\n${MAGENTA}=================================== Escaneo UDP ${NETWORK} ===================================${RESET}\n"
  nmap -6 -p 1-65535 --min-rate=5000 -T5 -O --traceroute -sU -Pn -n -v $ip_victima_6 -oX nmap_UDP_IPv6.xml
  xsltproc nmap_UDP_IPv6.xml -o nmap_UDP_IPv6.html

  # Escaneo SCTP
  echo -e "\n${BLUE}=================================== Escaneo SCTP ${COMPUTER} ===================================${RESET}\n"
  nmap -6 -p 1-65535 --open --min-rate=5000 -T5 -O --traceroute -sY -Pn -n -v $ip_victima_6 -oX nmap_SCTP_IPv6.xml
  xsltproc nmap_SCTP_IPv6.xml -o nmap_SCTP_IPv6.html

  # Eliminar archivos XML
  echo -e "\n${RED}${WARNING} Eliminando archivos XML y Obteniendo archivos HTML para Documetacion Web${RESET}\n"
  rm *xml*
  echo -e "\n${GREEN}${CHECKMARK} Escaneos completados para la IP: ${ip_victima_6}${RESET}"

  # Recordatorio de continuar
  echo -e "\n${YELLOW}${WARNING} El proceso ha finalizado. Presiona Enter para continuar.${RESET}"
  read -r
}

# ====================== 7: Función para crear directorios y servidor ======================
create_server() {
  # Solicitar al usuario el nombre del directorio de trabajo
  echo -e -n "\n${CYAN}Ingresa el nombre del banco de trabajo anteriormente creado (Ejemplo: Dockerlabs_Maquina_Upload): ${RESET}"
  read nombre_banco

  # Definir la ruta absoluta
  directorio_trabajo="$nombre_banco"

  # Verificar si el directorio de trabajo existe
  if [[ ! -d "/opt/$directorio_trabajo" ]]; then
    echo -e "\n${YELLOW}El directorio no existe asi que crearemos uno nuevo ${directorio_trabajo}${RESET}"
    mkdir -p "/opt/$directorio_trabajo"
  fi

  # Preguntar si el usuario quiere continuar
  echo -e "\n${CYAN}¿Qué deseas hacer a continuación?${RESET}\n"
  echo -e "${GREEN}1. Crear directorios adicionales en el directorio de trabajo${RESET}"
  echo -e "${MAGENTA}2. Iniciar servidor HTTP en el directorio de trabajo${RESET}"
  echo -e "${YELLOW}3. Iniciar todo, incluyendo la creación de directorios y servidor HTTP en el directorio de trabajo${RESET}\n"
  echo -e -n "\n${CYAN}Elige una opcion valida: ${RESET}"
  read opcion

  # Acciones dependiendo de la opción elegida
  case $opcion in
    1)
      echo -e "\n${YELLOW}Creando carpetas adicionales, espere un momento${RESET}\n"
      mkdir -p "/opt/$directorio_trabajo"/{ftp,ssh,telnet,smtp,http,https,smb,credentials,exploit,content}
      sleep 3
      echo -e "\n${GREEN}Carpetas creadas exitosamente en $directorio_trabajo${RESET}"
      ;;
    2)
     # Solicitar al usuario el puerto para el servidor HTTP
      echo -e -n "\n${CYAN}¿En qué puerto deseas iniciar el servidor HTTP? (Por defecto: 80): ${RESET}"
      read puerto
      puerto=${puerto:-80}  # Establecer puerto por defecto si el usuario no ingresa ninguno

      # Iniciar el servidor HTTP en el puerto elegido
      echo -e "\n${MAGENTA}Iniciando servidor HTTP en el puerto ${puerto}...${SERVER}${RESET}\n"
      cd "/opt/$directorio_trabajo" && python3 -m http.server $puerto
      ;;
    3)
      # Crear directorios y luego iniciar el servidor HTTP
      echo -e "\n${YELLOW}Creando carpetas adicionales, espere un momento${RESET}\n"
      mkdir -p "/opt/$directorio_trabajo"/{ftp,ssh,telnet,smtp,http,https,smb,credentials,exploit,content}
      sleep 3
      echo -e "\n${GREEN}Carpetas creadas exitosamente en $directorio_trabajo${RESET}"

      # Solicitar al usuario el puerto para el servidor HTTP
      echo -e -n "\n${CYAN}¿En qué puerto deseas iniciar el servidor HTTP? (Por defecto: 80): ${RESET}"
      read puerto
      puerto=${puerto:-80}  # Establecer puerto por defecto si el usuario no ingresa ninguno

      # Iniciar el servidor HTTP en el puerto elegido
      echo -e "\n${MAGENTA}Iniciando servidor HTTP en el puerto ${puerto}...${SERVER}${RESET}\n"
      cd "/opt/$directorio_trabajo" && python3 -m http.server $puerto
      ;;
    *)
      echo -e "\n${RED}Opción no válida. Por favor, selecciona una opción correcta.${RESET}"
      ;;
  esac
}

# ====================== 8: Función de salida ======================
handle_exit() {
  clear
  echo -e "${CYAN}====================== ${EXIT} ¡Saliendo del programa! ${EXIT} ======================${RESET}"
  echo -e "1) ${CHECKMARK} Sí"
  echo -e "2) ${EXIT} No"
  read respuesta
  if [[ "$respuesta" == "1" ]]; then
    echo -e "${EXIT} Saliendo...${RESET}"
    exit 0
  elif [[ "$respuesta" == "2" ]]; then
    main_menu
  fi
}

# ====================== Menú principal ======================
main_menu() {
  while true; do
    clear
    echo -e "${CYAN}====================== Menú Principal ======================${RESET}"
    echo -e "${YELLOW}1.${RESET} Menu de ayuda ${DUDE}"
    echo -e "${YELLOW}2.${RESET} Instalar Dependencias ${SCANNER}"
    echo -e "${BLUE}3.${RESET} Obtener las interfaces de Red ${NETWORK}"
    echo -e "${BLUE}4.${RESET} Escanear Host (ARP, ICMP, IPv6) ${NETWORK}"
    echo -e "${MAGENTA}5.${RESET} Nmap IPv4 (TCP, UDP, SCTP) ${COMPUTER}"
    echo -e "${MAGENTA}6.${RESET} Nmap IPv6 (TCP, UDP, SCTP) ${COMPUTER}"
    echo -e "${RED}7.${RESET} Extra: Crear subdirectorios adicionales y servidor en Python ${FOLDER}"
    echo -e "${RED}8.${RESET} Salir de la herramienta ${EXIT}"
    echo -e -n "${CYAN}Por favor seleccione una opcion: ${RESET}"
    read opcion
    case $opcion in
      1)
	help_menu
        ;;
      2)
	check_tools
        ;;
      3)
 	get_interfaces
	;;
      4)
        get_network
        ;;
      5)
        advanced_scan_ipv4
        ;;
      6)
        advanced_scan_ipv6
        ;;
      7)
        create_server
        ;;
      8)
        handle_exit
        ;;
      *)
        echo -e "${WARNING}Opción inválida, elige una opcion correcta${RESET}"
    esac
  done
}

# ====================== Trap para Ctrl+C ======================
trap 'handle_exit' SIGINT

# ====================== Iniciar menú principal ======================
main_menu
