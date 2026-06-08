#!/bin/bash
#
# ═════════════════════════════════════════════════════════════════════════
#   NDiscover — Network Discovery Toolkit
#   by Matt~
# ═════════════════════════════════════════════════════════════════════════

# ───── Paleta de colores (truecolor si está disponible) ─────
if [[ "${COLORTERM:-}" == "truecolor" || "${COLORTERM:-}" == "24bit" ]]; then
  C_PRIMARY=$'\033[38;2;0;230;200m'
  C_ACCENT=$'\033[38;2;255;90;180m'
  C_OK=$'\033[38;2;100;240;130m'
  C_WARN=$'\033[38;2;255;200;80m'
  C_ERR=$'\033[38;2;255;90;110m'
  C_DIM=$'\033[38;2;130;130;150m'
  C_TEXT=$'\033[38;2;225;225;235m'
  C_HL=$'\033[38;2;120;180;255m'
else
  C_PRIMARY=$'\033[1;36m'
  C_ACCENT=$'\033[1;35m'
  C_OK=$'\033[1;32m'
  C_WARN=$'\033[1;33m'
  C_ERR=$'\033[1;31m'
  C_DIM=$'\033[2;37m'
  C_TEXT=$'\033[0;37m'
  C_HL=$'\033[1;34m'
fi
RESET=$'\033[0m'
BOLD=$'\033[1m'

# ───── Símbolos ─────
S_OK="✔"
S_ERR="✖"
S_WARN="⚠"
S_ARROW="➜"
S_BULLET="◆"
S_DOT="·"
S_ENTER="↩"

# ═════════════════════════════════════════════════════════════════════════
#   Helpers de interfaz
# ═════════════════════════════════════════════════════════════════════════

hr() {
  local cols=("38;2;0;230;200" "38;2;80;200;240" "38;2;160;160;240" "38;2;220;120;220" "38;2;255;90;180")
  printf "  "
  local c
  for c in "${cols[@]}"; do
    printf "\033[%sm%s" "$c" "$(printf '━%.0s' $(seq 1 14))"
  done
  printf "%s\n" "$RESET"
}

banner() {
  clear
  local lines=(
    " ███╗   ██╗██████╗ ██╗███████╗ ██████╗ ██████╗ ██╗   ██╗███████╗██████╗ "
    " ████╗  ██║██╔══██╗██║██╔════╝██╔════╝██╔═══██╗██║   ██║██╔════╝██╔══██╗"
    " ██╔██╗ ██║██║  ██║██║███████╗██║     ██║   ██║██║   ██║█████╗  ██████╔╝"
    " ██║╚██╗██║██║  ██║██║╚════██║██║     ██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗"
    " ██║ ╚████║██████╔╝██║███████║╚██████╗╚██████╔╝ ╚████╔╝ ███████╗██║  ██║"
    " ╚═╝  ╚═══╝╚═════╝ ╚═╝╚══════╝ ╚═════╝ ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝"
  )
  local colors=(
    $'\033[38;2;0;230;220m'
    $'\033[38;2;60;200;240m'
    $'\033[38;2;130;170;245m'
    $'\033[38;2;190;130;235m'
    $'\033[38;2;235;100;210m'
    $'\033[38;2;255;90;170m'
  )
  echo
  local i
  for i in 0 1 2 3 4 5; do
    printf "  %s%s%s\n" "${colors[$i]}" "${lines[$i]}" "$RESET"
  done
  echo
  printf "  %s%s%s  %sNetwork Discovery Toolkit%s   %s%s%s   %sby %s%sMatt~%s\n" \
    "$C_ACCENT" "$S_BULLET" "$RESET" \
    "$BOLD$C_TEXT" "$RESET" \
    "$C_DIM" "$S_DOT" "$RESET" \
    "$C_DIM" "$RESET" "$C_ACCENT$BOLD" "$RESET"
  echo
}

section() {
  local title="$1"
  local icon="${2:-$S_BULLET}"
  echo
  hr
  printf "  %s%s%s   %s%s%s\n" "$C_ACCENT" "$icon" "$RESET" "$BOLD$C_PRIMARY" "$title" "$RESET"
  hr
  echo
}

ok()   { printf "  %s%s%s  %s\n" "$C_OK"   "$S_OK"    "$RESET" "$1"; }
err()  { printf "  %s%s%s  %s\n" "$C_ERR"  "$S_ERR"   "$RESET" "$1"; }
warn() { printf "  %s%s%s  %s\n" "$C_WARN" "$S_WARN"  "$RESET" "$1"; }
info() { printf "  %s%s%s  %s\n" "$C_HL"   "$S_ARROW" "$RESET" "$1"; }

ask() {
  local prompt="$1"
  local varname="$2"
  printf "  %s%s%s  %s%s%s " "$C_ACCENT" "$S_ARROW" "$RESET" "$C_TEXT" "$prompt" "$RESET"
  IFS= read -r "$varname"
}

pause() {
  echo
  printf "  %s%s  Pulsa %sEnter%s%s para volver al menú...%s " \
    "$C_DIM" "$S_ENTER" "$BOLD" "$RESET" "$C_DIM" "$RESET"
  read -r _
}

# ═════════════════════════════════════════════════════════════════════════
#   1 · Menú de ayuda
# ═════════════════════════════════════════════════════════════════════════

help_menu() {
  section "AYUDA · GUÍA DE USO" "❓"
  printf "  %s¡Saludos! Soy %sMatt%s%s, Analista de Ciberseguridad especializado en Hacking Ético.%s\n\n" \
    "$C_TEXT" "$BOLD$C_ACCENT" "$RESET" "$C_TEXT" "$RESET"

  printf "  %sNDiscover te permite:%s\n" "$BOLD$C_PRIMARY" "$RESET"
  printf "    %s%s%s  Descubrir hosts activos en tu red local\n" "$C_ACCENT" "$S_BULLET" "$RESET"
  printf "    %s%s%s  Escanear puertos con Nmap (TCP · UDP · SCTP)\n"  "$C_ACCENT" "$S_BULLET" "$RESET"
  printf "    %s%s%s  Generar documentación HTML lista para navegar\n" "$C_ACCENT" "$S_BULLET" "$RESET"
  printf "    %s%s%s  Crear un banco de trabajo y servir archivos vía HTTP\n\n" "$C_ACCENT" "$S_BULLET" "$RESET"

  printf "  %sFlujo recomendado:%s\n" "$BOLD$C_HL" "$RESET"
  printf "    %s2%s instalar dependencias  %s→%s  %s4%s descubrir hosts  %s→%s  %s6/7%s Nmap  %s→%s  %s8%s banco + HTTP\n\n" \
    "$C_ACCENT$BOLD" "$RESET" "$C_DIM" "$RESET" \
    "$C_ACCENT$BOLD" "$RESET" "$C_DIM" "$RESET" \
    "$C_ACCENT$BOLD" "$RESET" "$C_DIM" "$RESET" \
    "$C_ACCENT$BOLD" "$RESET"

  printf "  %sSi te resulta útil, apóyame en GitHub. ¡Gracias por usar NDiscover!%s\n" "$C_DIM" "$RESET"
  printf "  %s~Matt%s\n" "$C_ACCENT$BOLD" "$RESET"
  pause
}

# ═════════════════════════════════════════════════════════════════════════
#   2 · Verificar dependencias
# ═════════════════════════════════════════════════════════════════════════

check_tools() {
  section "VERIFICAR DEPENDENCIAS" "📦"
  local tools=(nmap python3 xsltproc)
  local missing=()
  local t
  for t in "${tools[@]}"; do
    if command -v "$t" >/dev/null 2>&1; then
      ok "$t instalado"
    else
      err "$t no instalado"
      missing+=("$t")
    fi
  done
  echo
  if [[ ${#missing[@]} -eq 0 ]]; then
    ok "Todas las dependencias están listas."
    pause
    return
  fi
  warn "Faltan: ${missing[*]}"
  local resp
  ask "¿Instalarlas con apt? [s/N]:" resp
  case "${resp,,}" in
    s|si|sí|y|yes)
      if ! command -v apt >/dev/null 2>&1; then
        err "apt no disponible. Instálalas manualmente: ${missing[*]}"
      else
        sudo apt update && sudo apt install -y "${missing[@]}" && ok "Instalación finalizada."
      fi
      ;;
    *)
      warn "Saltando instalación."
      ;;
  esac
  pause
}

# ═════════════════════════════════════════════════════════════════════════
#   3 · Interfaces de red
# ═════════════════════════════════════════════════════════════════════════

get_interfaces() {
  section "INTERFACES DE RED" "🌐"
  if ip -color=always -brief address >/dev/null 2>&1; then
    ip -color=always -brief address
  else
    ip address
  fi
  pause
}

# ═════════════════════════════════════════════════════════════════════════
#   4 · Descubrimiento de hosts (ARP · ICMP · IPv6)
# ═════════════════════════════════════════════════════════════════════════

parse_nmap_sn() {
  local vendor_file="/tmp/ndiscover_vendors.$$"
  > "$vendor_file"
  awk -v c1="$C_PRIMARY" -v c2="$C_DIM" -v cR="$RESET" -v cH="$C_HL" -v cW="$C_WARN" \
      -v vf="$vendor_file" '
    function get_vendor_by_oui(mac) {
      gsub(/[:-]/, "", mac)
      mac = tolower(mac)
      oui = substr(mac, 1, 6)
      if (oui ~ /^(000c29|001c14|005056)/) return "VMware"
      if (oui == "080027")                return "VirtualBox"
      if (oui == "525400")                return "QEMU/KVM"
      if (oui ~ /^(a4bb6d|b827eb|dca632|e45f01)/) return "Raspberry Pi"
      return ""
    }
    /Nmap scan report for/ {
      if (ip != "") print_line()
      ip = $NF
      gsub(/[()]/, "", ip)
      mac = ""
      vendor = ""
    }
    /MAC Address:/ {
      mac = $3
      start = index($0, "(")
      if (start > 0) {
        vendor = substr($0, start + 1)
        gsub(/\).*$/, "", vendor)
      }
      if (vendor == "") vendor = get_vendor_by_oui(mac)
      if (vendor != "" && mac != "") {
        print mac "|" vendor >> vf
      }
    }
    function print_line() {
      printf "      %s%-18s%s  %s%s%s", c1, ip, cR, c2, (mac ? mac : "(sin MAC)"), cR
      if (vendor != "") {
        printf "  %s[%s]%s", cH, vendor, cR
      } else if (mac != "") {
        printf "  %s[Desconocido]%s", cW, cR
      }
      printf "\n"
    }
    END {
      if (ip != "") print_line()
      close(vf)
    }
  '
}

scan_ipv6_neighbors() {
  local iface vendor_file="/tmp/ndiscover_vendors.$$"
  iface="$(ip -6 route show default 2>/dev/null | awk '{print $5; exit}')"
  if [[ -z "$iface" ]]; then
    iface="$(ip -o link show up 2>/dev/null | awk -F': ' '$2 !~ /^lo/ {gsub(" ","",$2); print $2; exit}')"
  fi
  if [[ -z "$iface" ]]; then
    err "No se detectó interfaz activa para IPv6."
    return
  fi
  info "Interfaz IPv6: ${BOLD}${iface}${RESET}"
  ping -6 -c 2 -W 1 -I "$iface" ff02::1 >/dev/null 2>&1 || true
  local found
  found="$(ip -6 neigh show 2>/dev/null \
    | awk -v c1="$C_PRIMARY" -v c2="$C_DIM" -v cR="$RESET" -v cH="$C_HL" -v cW="$C_WARN" \
      -v vf="$vendor_file" -v ifc="$iface" '
      BEGIN {
        while ((getline line < vf) > 0) {
          split(line, a, "|")
          gsub(/[:-]/, "", a[1])
          vendors[tolower(a[1])] = a[2]
        }
        close(vf)
      }
      function normalize_mac(mac) {
        gsub(/[:-]/, "", mac)
        return tolower(mac)
      }
      $1 ~ /^fe80/ {
        mac = $5
        norm = normalize_mac(mac)
        vendor = (norm in vendors) ? vendors[norm] : ""
        ip6 = $1 "%" ifc
        printf "      %s%-46s%s  %s%s%s", c1, ip6, cR, c2, mac, cR
        if (vendor != "") {
          printf "  %s[%s]%s", cH, vendor, cR
        } else {
          printf "  %s[Desconocido]%s", cW, cR
        }
        printf "\n"
      }
    ')"
  if [[ -z "$found" ]]; then
    warn "No se detectaron vecinos IPv6 link-local."
  else
    echo "$found"
  fi
}

get_network() {
  section "DESCUBRIMIENTO DE HOSTS" "🔍"
  local ip_privada network
  ask "IP privada (ej. 192.168.1.20):" ip_privada
  if [[ -z "$ip_privada" || ! "$ip_privada" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    err "Formato de IP inválido."
    pause
    return
  fi
  network="$(echo "$ip_privada" | awk -F. '{print $1"."$2"."$3".0/24"}')"
  ok "Red derivada: $network"
  echo

  info "ARP (capa 2)..."
  nmap -sn -PR "$network" 2>/dev/null | parse_nmap_sn
  echo

  info "ICMP echo (capa 3)..."
  nmap -sn -PE "$network" 2>/dev/null | parse_nmap_sn
  echo

  info "IPv6 link-local..."
  scan_ipv6_neighbors

  echo
  ok "Happy hunting :)"
  pause
  rm -f /tmp/ndiscover_vendors.$$
}

# ═════════════════════════════════════════════════════════════════════════
#   5 · Detección de SO por TTL
# ═════════════════════════════════════════════════════════════════════════

detect_os_by_ttl() {
  section "DETECCIÓN DE SO POR TTL" "🕵️"
  local ip_target ttl
  ask "IP a analizar (ej. 192.168.0.10):" ip_target
  if [[ -z "$ip_target" ]]; then
    err "IP vacía."
    pause
    return
  fi
  info "Enviando ping a $ip_target ..."
  ttl="$(ping -c 1 -W 2 "$ip_target" 2>/dev/null | sed -n 's/.*ttl=\([0-9]*\).*/\1/p' | head -n1)"
  if [[ -z "$ttl" || ! "$ttl" =~ ^[0-9]+$ ]]; then
    err "No se obtuvo TTL. El host puede estar inalcanzable."
    pause
    return
  fi
  ok "TTL recibido: $ttl"
  echo
  if   (( ttl <= 64 ));  then info "Probable: ${BOLD}Linux / Unix${RESET}  (TTL inicial 64)"
  elif (( ttl <= 128 )); then info "Probable: ${BOLD}Windows${RESET}  (TTL inicial 128)"
  else                        info "Probable: ${BOLD}Dispositivo de red${RESET}  (TTL inicial 255)"
  fi
  pause
}

# ═════════════════════════════════════════════════════════════════════════
#   6/7 · Nmap IPv4 / IPv6 (TCP · UDP · SCTP)
# ═════════════════════════════════════════════════════════════════════════

_run_nmap_suite() {
  # $1 = "" o "-6"   $2 = target   $3 = label ("IPv4"|"IPv6")
  local six="$1" target="$2" label="$3"

  info "Escaneo TCP..."
  nmap $six --stats-every=5s -p- --open --min-rate=5000 -T5 -A -sT -Pn -n -v "$target" -oX "nmap_TCP_${label}.xml"
  echo
  info "Escaneo UDP..."
  nmap $six --stats-every=5s -p- --min-rate=5000 -T5 -O --traceroute -sU -Pn -n -v "$target" -oX "nmap_UDP_${label}.xml"
  echo
  info "Escaneo SCTP..."
  nmap $six --stats-every=5s -p- --open --min-rate=5000 -T5 -O --traceroute -sY -Pn -n -v "$target" -oX "nmap_SCTP_${label}.xml"
  echo

  info "Generando reportes HTML..."
  local proto base
  for proto in TCP UDP SCTP; do
    base="nmap_${proto}_${label}"
    if [[ -f "${base}.xml" ]]; then
      if xsltproc "${base}.xml" -o "${base}.html" 2>/dev/null; then
        ok "${base}.html generado"
        rm -f "${base}.xml"
      else
        warn "${base}.html no generado (xsltproc falló); se conserva ${base}.xml"
      fi
    fi
  done
}

advanced_scan_ipv4() {
  section "NMAP IPv4 · TCP · UDP · SCTP" "💻"
  local ip nombre workdir
  ask "IP IPv4 (ej. 192.168.0.10):" ip
  ask "Nombre del banco de trabajo (ej. Dockerlabs_Maquina_Upload):" nombre
  if [[ -z "$ip" || -z "$nombre" ]]; then
    err "Datos incompletos."
    pause
    return
  fi
  workdir="/opt/${nombre}/nmap_IPV4"
  info "Directorio de trabajo: $workdir"
  if ! mkdir -p "$workdir" 2>/dev/null; then
    err "No se pudo crear $workdir (¿necesitas sudo?)"
    pause
    return
  fi
  ( cd "$workdir" && _run_nmap_suite "" "$ip" "IPv4" )
  echo
  ok "Escaneos completos para $ip en $workdir"
  pause
}

advanced_scan_ipv6() {
  section "NMAP IPv6 · TCP · UDP · SCTP" "💻"
  local ip nombre workdir
  ask "IP IPv6 (ej. fe80::20c:29ff:fe43:4b01%eth0):" ip
  ask "Nombre del banco de trabajo:" nombre
  if [[ -z "$ip" || -z "$nombre" ]]; then
    err "Datos incompletos."
    pause
    return
  fi
  workdir="/opt/${nombre}/nmap_IPV6"
  info "Directorio de trabajo: $workdir"
  if ! mkdir -p "$workdir" 2>/dev/null; then
    err "No se pudo crear $workdir (¿necesitas sudo?)"
    pause
    return
  fi
  ( cd "$workdir" && _run_nmap_suite "-6" "$ip" "IPv6" )
  echo
  ok "Escaneos completos para $ip en $workdir"
  pause
}

# ═════════════════════════════════════════════════════════════════════════
#   8 · Banco de trabajo + servidor HTTP
# ═════════════════════════════════════════════════════════════════════════

create_server() {
  section "BANCO DE TRABAJO + SERVIDOR HTTP" "📂"
  local nombre workdir opcion puerto
  ask "Nombre del banco de trabajo:" nombre
  if [[ -z "$nombre" ]]; then
    err "Nombre vacío."
    pause
    return
  fi
  workdir="/opt/$nombre"
  if [[ ! -d "$workdir" ]]; then
    warn "$workdir no existe. Creándolo..."
    if ! mkdir -p "$workdir" 2>/dev/null; then
      err "No se pudo crear $workdir (¿necesitas sudo?)"
      pause
      return
    fi
  fi

  echo
  info "1)  Crear subdirectorios estándar (ftp, ssh, smb, ...)"
  info "2)  Iniciar servidor HTTP"
  info "3)  Ambos"
  ask "Elige [1/2/3]:" opcion

  case "$opcion" in
    1|3)
      mkdir -p "$workdir"/{ftp,ssh,telnet,smtp,http,https,smb,credentials,exploit,content}
      ok "Subdirectorios creados en $workdir"
      ;;
  esac

  case "$opcion" in
    2|3)
      ask "Puerto HTTP [80]:" puerto
      puerto="${puerto:-80}"
      info "Sirviendo $workdir en puerto $puerto. ${BOLD}Ctrl+C${RESET} para detener."
      echo
      # bash ignora SIGINT mientras python lo gestiona y sale limpio
      trap '' INT
      ( cd "$workdir" && python3 -m http.server "$puerto" )
      trap - INT
      echo
      ok "Servidor detenido."
      ;;
  esac

  case "$opcion" in
    1|2|3) ;;
    *) err "Opción inválida." ;;
  esac
  pause
}

# ═════════════════════════════════════════════════════════════════════════
#   9 · Salida
# ═════════════════════════════════════════════════════════════════════════

handle_exit() {
  section "SALIR" "❌"
  local resp
  ask "¿Cerrar NDiscover? [s/N]:" resp
  case "${resp,,}" in
    s|si|sí|y|yes)
      echo
      printf "  %s%s%s   Hasta la próxima.   %s~Matt%s\n\n" \
        "$C_ACCENT" "$S_BULLET" "$RESET" "$C_ACCENT$BOLD" "$RESET"
      exit 0
      ;;
    *)
      warn "Cancelado."
      sleep 1
      ;;
  esac
}

# ═════════════════════════════════════════════════════════════════════════
#   Menú principal
# ═════════════════════════════════════════════════════════════════════════

print_option() {
  local n="$1" icon="$2" title="$3" desc="$4"
  printf "    %s[%s%s%s]%s   %s   %s%s%s   %s%s  %s%s\n" \
    "$C_DIM" "$BOLD$C_ACCENT" "$n" "$C_DIM" "$RESET" \
    "$icon" \
    "$BOLD$C_TEXT" "$title" "$RESET" \
    "$C_DIM" "$S_DOT" "$desc" "$RESET"
}

main_menu() {
  local choice
  while true; do
    banner
    hr
    printf "  %s%s   MENÚ PRINCIPAL%s\n" "$BOLD$C_PRIMARY" "$S_BULLET" "$RESET"
    hr
    echo
    print_option 1 "❓" "Ayuda y guía"            "Cómo usar NDiscover"
    print_option 2 "📦" "Verificar dependencias"  "nmap · python3 · xsltproc"
    print_option 3 "🌐" "Interfaces de red"       "Lista interfaces activas"
    print_option 4 "🔍" "Descubrir hosts"         "ARP · ICMP · IPv6"
    print_option 5 "🕵️" "Detección de SO"         "Sistema operativo por TTL"
    print_option 6 "💻" "Nmap IPv4"               "TCP · UDP · SCTP + HTML"
    print_option 7 "💻" "Nmap IPv6"               "TCP · UDP · SCTP + HTML"
    print_option 8 "📂" "Banco + HTTP"            "Directorios y servidor"
    print_option 9 "❌" "Salir"                   "Cerrar NDiscover"
    echo
    hr
    ask "Elige una opción [1-9]:" choice

    case "$choice" in
      1) help_menu ;;
      2) check_tools ;;
      3) get_interfaces ;;
      4) get_network ;;
      5) detect_os_by_ttl ;;
      6) advanced_scan_ipv4 ;;
      7) advanced_scan_ipv6 ;;
      8) create_server ;;
      9) handle_exit ;;
      *) warn "Opción inválida. Usa un número del 1 al 9."; sleep 1 ;;
    esac
  done
}

main_menu
