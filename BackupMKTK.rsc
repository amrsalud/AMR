# oct/18/2016 08:57:32 by RouterOS 6.37.1
# software id = 7WGQ-854A
#
/interface bridge
add name=BridgeGeneral
/interface ethernet
set [ find default-name=ether1 ] advertise=1000M-half,1000M-full name=\
    ether1-WHAL speed=1Gbps
set [ find default-name=ether2 ] advertise=1000M-half,1000M-full disabled=yes
set [ find default-name=ether3 ] arp=proxy-arp name=ether3-VIRTUAL
set [ find default-name=ether4 ] advertise=1000M-half,1000M-full name=\
    ether4-FILESERVER
set [ find default-name=ether5 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full arp=proxy-arp name=\
    ether5-LANAMR
set [ find default-name=ether6 ] advertise=\
    100M-half,100M-full,1000M-half,1000M-full arp=proxy-arp name=ether6-PROXY
set [ find default-name=ether7 ] name=ether7-WIFI
set [ find default-name=ether8 ] name=ether8-PROXMOX
set [ find default-name=ether9 ] arp=proxy-arp name=ether9-ARNET
set [ find default-name=ether10 ] name=ether10-EREA
set [ find default-name=sfp1 ] advertise=1000M-half,1000M-full name=\
    sfp-MUTUAL
/interface eoip
add !keepalive loop-protect-disable-time=0s loop-protect-send-interval=0s \
    mac-address=02:8A:91:63:51:7F name=eoip-tunnel-Wifi remote-address=\
    200.45.234.36 tunnel-id=0
/ip neighbor discovery
set ether1-WHAL discover=no
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip firewall layer7-protocol
add name=facebook regexp="^.*(facebook).*\$"
add name=youtube regexp="^.*(youtube).*\$"
add name=whatsapp regexp="^.*(whatsapp).*\$"
/ip ipsec policy group
set
/ip ipsec proposal
set [ find default=yes ] disabled=yes enc-algorithms=\
    aes-256-cbc,aes-128-cbc,3des lifetime=0s pfs-group=none
add enc-algorithms=aes-256-cbc,aes-128-cbc,3des lifetime=0s name=AMR \
    pfs-group=none
/ip pool
add name=Pool-SSTP ranges=172.16.1.1-172.16.1.250
add name=Pool-L2TP ranges=10.0.100.1-10.0.100.200
add name=DHCP-AMRSalud ranges=192.168.1.1-192.168.1.100
/ip dhcp-server
add address-pool=DHCP-AMRSalud interface=ether2 name=default
add address-pool=DHCP-AMRSalud interface=ether5-LANAMR name=DHCP-LANAMR
/ppp profile
add dns-server=8.8.8.8,8.8.4.4 local-address=10.0.100.254 name=L2TP_IPSEC \
    remote-address=Pool-L2TP use-encryption=required
/queue simple
add name="SQL " packet-marks=slqM target=""
/queue type
add kind=sfq name=BAJADA
add kind=sfq name=SUBIDA
/queue tree
add name="SMTP - Prioridad 1" packet-mark=smtpM parent=BridgeGeneral \
    priority=1 queue=default
add name="SQL - Prioridad 2" packet-mark=slqM parent=BridgeGeneral priority=2 \
    queue=default
/snmp community
set [ find default=yes ] addresses=192.168.1.0/24 name=computosv2
add addresses=192.168.1.0/24 authentication-password=P4r4gu4y--711 \
    authentication-protocol=SHA1 encryption-password=Mnacho--89111689 name=\
    computos security=authorized
/interface bridge port
add bridge=BridgeGeneral interface=ether1-WHAL
add bridge=BridgeGeneral interface=ether3-VIRTUAL
add bridge=BridgeGeneral interface=ether5-LANAMR
add bridge=BridgeGeneral interface=ether4-FILESERVER
add bridge=BridgeGeneral interface=sfp-MUTUAL
add bridge=BridgeGeneral interface=ether2
add bridge=BridgeGeneral interface=ether8-PROXMOX
/ip settings
set accept-redirects=yes
/interface l2tp-server server
set authentication=mschap1,mschap2 default-profile=L2TP_IPSEC enabled=yes \
    ipsec-secret=P4r4gu4y--711 keepalive-timeout=disabled max-sessions=50
/interface ovpn-server server
set cipher=aes256 require-client-certificate=yes
/interface pptp-server server
set authentication=mschap2
/interface sstp-server server
set authentication=mschap2 certificate=CA
/ip address
add address=200.45.234.34/29 comment=ARNET interface=ether9-ARNET network=\
    200.45.234.32
add address=192.168.90.50/24 comment=EREA disabled=yes interface=ether10-EREA \
    network=192.168.90.0
add address=192.168.1.254/24 comment="IP LAN" interface=BridgeGeneral \
    network=192.168.1.0
add address=192.168.254.1/30 comment=PROXY interface=ether6-PROXY network=\
    192.168.254.0
add address=200.45.234.35/29 comment=ARNET interface=ether9-ARNET network=\
    200.45.234.32
add address=10.0.0.254/24 comment=WIFI interface=ether7-WIFI network=10.0.0.0
add address=200.45.234.36/29 comment=ARNET interface=ether9-ARNET network=\
    200.45.234.32
/ip arp
add address=192.168.1.250 interface=BridgeGeneral mac-address=\
    A4:BA:DB:45:23:BC
add address=192.168.1.150 interface=BridgeGeneral mac-address=\
    34:40:B5:9E:10:CE
add address=192.168.254.2 interface=ether6-PROXY mac-address=\
    00:06:4F:80:0C:36
add address=200.45.234.33 interface=ether9-ARNET mac-address=\
    10:F3:11:DC:58:8E
add address=200.45.234.36 interface=ether9-ARNET mac-address=\
    E8:94:F6:BB:AF:DF
add address=192.168.1.154 interface=BridgeGeneral mac-address=\
    4C:CC:6A:0A:97:80
add address=192.168.1.121 interface=BridgeGeneral mac-address=\
    00:40:48:B1:13:1F
add address=192.168.1.149 interface=BridgeGeneral mac-address=\
    00:18:FE:7A:7A:D3
/ip dhcp-client
add comment="default configuration" dhcp-options=hostname,clientid disabled=\
    no interface=ether1-WHAL
/ip dhcp-server network
add address=192.168.88.0/24 comment="default configuration" gateway=\
    192.168.88.1
/ip dns
set allow-remote-requests=yes cache-size=12288KiB servers=\
    200.45.191.35,200.45.48.233,8.8.8.8,8.8.4.4,200.59.197.108,200.59.197.109
/ip dns static
add address=192.168.1.254 disabled=yes name=amrsalud.com.ar
add address=192.168.1.254 disabled=yes name=http://amrsalud.com.ar
add address=192.168.1.254 disabled=yes name=http://www.amrsalud.com.ar
add address=192.168.1.150 name=amr
add address=192.168.1.250 name=fileserver
add address=192.168.1.152 name=WS2K8r2-Leon.amrsalud.com.ar
add address=192.168.1.254 disabled=yes name=vpn.amrsalud.com.ar
add address=192.168.1.250 disabled=yes name=www.amrsalud.com/glpi
/ip firewall address-list
add address=200.45.234.34 list=AMRSalud
add address=200.45.234.35 list=AMRSalud
add address=200.45.234.36 list=AMRSalud
add address=200.45.234.37 list=AMRSalud
add address=200.45.234.38 list=AMRSalud
add address=190.139.100.42 list=AMRSalud
add address=186.148.117.212 list=AMRSalud
add address=186.0.202.106 list="AMR Gestion"
add address=200.69.207.81 list="AMR Gestion"
add address=201.212.81.4 disabled=yes list=AMRSalud
add address=192.168.1.19 list=PCPermitidas
add address=192.168.1.20 list=PCPermitidas
add address=192.168.1.71 list=PCPermitidas
add address=192.168.1.151 list=PCPermitidas
add address=192.168.1.18 list=PCPermitidas
add address=192.168.1.22 list=PCPermitidas
add address=192.168.1.17 list=PCPermitidas
add address=192.168.1.7 list=PCPermitidas
/ip firewall filter
add action=accept chain=forward comment="Acepta Server Correo" disabled=yes \
    dst-port=465 protocol=tcp
add action=accept chain=forward comment="Consola DNS Connaxis" port=2083 \
    protocol=tcp
add action=accept chain=forward comment="Acepta Server Correo" dst-port=\
    25,110 in-interface=ether9-ARNET protocol=tcp
add action=accept chain=input comment="Acepta Actualizaciones Mikrotik" \
    in-interface=ether9-ARNET protocol=tcp src-port=80,443
add action=drop chain=forward comment="Drop Facebook" in-interface=\
    BridgeGeneral layer7-protocol=facebook src-address-list=!PCPermitidas
add action=drop chain=forward comment="Drop Youtube" in-interface=\
    BridgeGeneral layer7-protocol=youtube src-address-list=!PCPermitidas
add action=drop chain=forward comment="Drop WhatsApp" in-interface=\
    BridgeGeneral layer7-protocol=whatsapp src-address-list=!PCPermitidas
add action=drop chain=forward comment="Conexiones Invalidas" \
    connection-state=invalid
add action=drop chain=input connection-state=invalid
add action=accept chain=forward comment="VPN - WHAL" dst-address=\
    192.168.1.150 out-interface=BridgeGeneral src-address=10.0.100.0/24
add action=accept chain=forward comment="VPN-Espa\F1ol-Fileserver" \
    dst-address=192.168.1.250 out-interface=BridgeGeneral src-address=\
    10.0.100.215
add action=accept chain=forward comment=VPN-GPALLOTTO-Fileserver \
    out-interface=BridgeGeneral src-address=10.0.100.217
add action=accept chain=forward comment=VPN-NCALDERON-Fileserver \
    out-interface=BridgeGeneral src-address=10.0.100.216
add action=accept chain=forward comment=VPN-IMARINI-Fileserver out-interface=\
    BridgeGeneral src-address=10.0.100.218
add action=drop chain=forward comment="VPN - LAN AMR" dst-address=\
    192.168.1.0/24 out-interface=BridgeGeneral src-address=10.0.100.0/24
add action=drop chain=forward comment=\
    "Drop Tablet Internet - Fallan paginas en clientes" disabled=yes \
    dst-port=443 out-interface=ether9-ARNET protocol=tcp src-address=\
    10.0.100.0/24
add action=accept chain=forward comment="Acepto conexion para camaras" \
    dst-port=88 protocol=tcp
add action=accept chain=forward dst-port=8000 protocol=tcp
add action=accept chain=forward comment="Puertos Camaras" dst-port=88,8000 \
    protocol=tcp
add action=accept chain=input protocol=icmp
add action=accept chain=input comment="Acepto API" dst-port=8728 \
    in-interface=BridgeGeneral protocol=tcp
add action=accept chain=input comment="Acepta SNMP" dst-port=161,1023 \
    in-interface=BridgeGeneral protocol=tcp
add action=accept chain=input dst-port=161,1023 in-interface=BridgeGeneral \
    protocol=udp
add action=accept chain=input comment="Puerto L2TP" dst-port=1701 protocol=\
    tcp
add action=accept chain=input comment="IPSEC y L2TP" dst-port=500,1701,4500 \
    protocol=udp
add action=accept chain=input protocol=gre
add action=accept chain=input dst-port=115 protocol=tcp
add action=accept chain=input protocol=ipsec-esp
add action=accept chain=input protocol=ipsec-ah
add action=accept chain=forward comment="Acceso completo entre Bridge" \
    dst-address=192.168.1.0/24 src-address=192.168.1.0/24
add action=accept chain=forward comment="Forward VPN-LAN" dst-address=\
    192.168.1.0/24 src-address=10.0.10.0/24
add action=accept chain=input comment="Acepta Forward VPN" src-address=\
    10.0.10.0/24
add action=accept chain=forward src-address=10.0.10.0/24
add action=accept chain=output comment=WebProxy dst-port=3128 protocol=tcp
add action=accept chain=forward dst-port=3128 protocol=tcp
add action=accept chain=input comment="Acepta puerto VPN-SSTP" dst-port=443 \
    in-interface=ether9-ARNET protocol=tcp
add action=accept chain=forward dst-port=443 protocol=tcp
add action=add-src-to-address-list address-list=ICMP address-list-timeout=2m \
    chain=input comment="Port Snouking" packet-size=0-128 protocol=icmp ttl=\
    greater-than:200
add action=accept chain=input dst-port=22 in-interface=BridgeGeneral \
    protocol=tcp
add action=drop chain=input dst-port=22 protocol=tcp src-address-list=!ICMP
add action=accept chain=input packet-size=0-128 protocol=icmp \
    src-address-list=ICMP ttl=greater-than:200
add action=drop chain=input comment="Ping de la Muerte" in-interface=\
    ether9-ARNET packet-size=129-65535 protocol=icmp
add action=accept chain=input comment=NTP dst-port=123 in-interface=\
    ether9-ARNET protocol=udp
add action=accept chain=input dst-port=123 in-interface=ether7-WIFI protocol=\
    udp
add action=accept chain=input comment="Acepta Cedyca" protocol=tcp \
    src-address=190.193.47.232
add action=accept chain=input comment="Acepta WinBox AMR" dst-port=8291 \
    protocol=tcp
add action=drop chain=input comment="Drop Ssh Brute Forcers" dst-port=22 \
    protocol=tcp src-address-list=ssh_blacklist
add action=add-src-to-address-list address-list=ssh_blacklist \
    address-list-timeout=10h chain=input connection-state=new dst-port=22 \
    protocol=tcp src-address-list=ssh_stage3
add action=add-src-to-address-list address-list=ssh_stage3 \
    address-list-timeout=1m chain=input connection-state=new dst-port=22 \
    protocol=tcp src-address-list=ssh_stage2
add action=add-src-to-address-list address-list=ssh_stage2 \
    address-list-timeout=1m chain=input connection-state=new dst-port=22 \
    protocol=tcp src-address-list=ssh_stage1
add action=add-src-to-address-list address-list=ssh_stage1 \
    address-list-timeout=1m chain=input connection-state=new dst-port=22 \
    protocol=tcp src-address-list=!ICMP
add action=accept chain=input dst-port=22 protocol=tcp src-address-list=ICMP
add action=drop chain=input comment="Bloquear Ataques FTP" dst-port=21 \
    in-interface=ether9-ARNET protocol=tcp src-address-list=ftp_blacklist
add action=accept chain=output content="530 Login incorrect" dst-limit=\
    1/1m,9,dst-address/1m protocol=tcp
add action=add-dst-to-address-list address-list=ftp_blacklist \
    address-list-timeout=3h chain=output content="530 Login incorrect" \
    protocol=tcp
add action=accept chain=input comment="Acepta WinBox desde Bridge" dst-port=\
    8291 in-interface=BridgeGeneral protocol=tcp
add action=add-src-to-address-list address-list=Winbox address-list-timeout=\
    1w chain=input comment="Agrega IPs Que entran  por Winbox" dst-port=8291 \
    in-interface=ether9-ARNET protocol=tcp
add action=accept chain=input comment="IPERF o  NETFLOW" dst-port=1234 \
    protocol=tcp
add action=accept chain=forward comment="Acepta Remoto AMR Gestion" dst-port=\
    3384-3389 protocol=tcp src-address-list="AMR Gestion"
add action=drop chain=forward comment="Seguridad Escritorio Remoto" dst-port=\
    3384-3389 in-interface=ether9-ARNET protocol=tcp src-address-list=\
    ER_Blacklist
add action=add-src-to-address-list address-list=ER_Blacklist \
    address-list-timeout=0s chain=forward connection-state=new dst-port=\
    3384-3389 in-interface=ether9-ARNET protocol=tcp src-address-list=\
    ER_Fase3
add action=add-src-to-address-list address-list=ER_Fase3 \
    address-list-timeout=2h chain=forward connection-state=new dst-port=\
    3384-3389 in-interface=ether9-ARNET protocol=tcp src-address-list=\
    ER_Fase2
add action=add-src-to-address-list address-list=ER_Fase2 \
    address-list-timeout=39m chain=forward connection-state=new dst-port=\
    3384-3389 in-interface=ether9-ARNET protocol=tcp src-address-list=\
    ER_Fase1
add action=add-src-to-address-list address-list=ER_Fase1 \
    address-list-timeout=30m chain=forward connection-state=new dst-port=\
    3384-3389 in-interface=ether9-ARNET protocol=tcp src-address-list=\
    ER_Fase0
add action=add-src-to-address-list address-list=ER_Fase0 \
    address-list-timeout=20s chain=forward connection-state=new dst-port=\
    3384-3389 in-interface=ether9-ARNET protocol=tcp
add action=accept chain=forward dst-port=3384-3389 in-interface=ether9-ARNET \
    protocol=tcp src-address-list=!ER_Blacklist
add action=accept chain=forward comment="Acepto Entrada Conexion Reloj" \
    dst-port=4370 in-interface=ether9-ARNET protocol=tcp src-address-list=\
    "AMR Gestion"
add action=accept chain=forward comment=\
    "Acepto conexion Prestadores-CTM AMR Gestion" dst-port=9000-9001 \
    in-interface=ether9-ARNET protocol=tcp src-address-list="AMR Gestion"
add action=accept chain=forward comment="Acepta OCS" dst-address=\
    200.45.234.34 dst-port=80 in-interface=ether9-ARNET protocol=tcp
add action=accept chain=forward comment="Acepta SQL" dst-port=1433 \
    in-interface=ether9-ARNET protocol=tcp
add action=add-src-to-address-list address-list=WebFig address-list-timeout=\
    1w chain=input comment="Acepta WebFig" dst-port=888 protocol=tcp
add action=accept chain=input dst-port=888 in-interface=BridgeGeneral \
    protocol=tcp
add action=drop chain=input comment="Bloqueo DNS cache externo" dst-port=53 \
    in-interface=ether9-ARNET protocol=udp
add action=accept chain=input comment="Acepta DNS Local" protocol=udp \
    src-port=53
add action=accept chain=forward comment="Protocolos de Salida del Bridge" \
    dst-port=443 in-interface=BridgeGeneral protocol=tcp
add action=accept chain=forward dst-port=993 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=80 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=995 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=465 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=587 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=5222 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=2255 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=9000-9001 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward dst-port=20-21 in-interface=BridgeGeneral \
    protocol=tcp
add action=accept chain=forward comment=\
    "VPN Paola - soporte_entidades@redlink.com.ar" dst-address=200.45.17.2 \
    dst-port=500,4500 in-interface=BridgeGeneral protocol=udp
add action=accept chain=forward dst-address=200.45.17.2 dst-port=80 \
    in-interface=BridgeGeneral protocol=tcp
add action=accept chain=forward dst-address=200.51.90.193 dst-port=500,4500 \
    in-interface=BridgeGeneral protocol=udp
add action=accept chain=forward dst-address=200.51.90.193 dst-port=80 \
    in-interface=BridgeGeneral protocol=tcp
add action=accept chain=forward dst-address=200.32.32.132 dst-port=500,4500 \
    in-interface=BridgeGeneral protocol=udp
add action=accept chain=forward dst-address=200.32.32.132 dst-port=80 \
    in-interface=BridgeGeneral protocol=tcp
add action=accept chain=forward dst-address=10.2.0.80 dst-port=9003 \
    in-interface=BridgeGeneral protocol=tcp
add action=accept chain=forward comment="VPN Paola" dst-port=500,4500,9003 \
    in-interface=BridgeGeneral protocol=udp
add action=accept chain=forward dst-port=500,4500,9003,80 in-interface=\
    BridgeGeneral protocol=tcp
add action=accept chain=forward comment="Aplicacion Cubos" dst-port=8443 \
    in-interface=BridgeGeneral protocol=udp
add action=accept chain=forward comment=\
    "Deniega Acceso Wifi  a BridgeGeneral" in-interface=BridgeGeneral \
    out-interface=ether7-WIFI
add action=drop chain=forward comment="Deniega Acceso Wifi  a BridgeGeneral" \
    in-interface=ether7-WIFI out-interface=BridgeGeneral
add action=drop chain=forward comment="Drop de ARNET a WebProxy" dst-port=80 \
    in-interface=!BridgeGeneral out-interface=ether6-PROXY protocol=tcp
add action=drop chain=input comment="Drop Puertos Conocidos Mikrotik" \
    in-interface=ether9-ARNET log-prefix="IP Entradas" protocol=tcp src-port=\
    1-1024
add action=drop chain=forward comment="Drop All P2P" in-interface=\
    BridgeGeneral log-prefix=P2P p2p=all-p2p protocol=tcp
add action=drop chain=forward comment="Bloquea Actualizaciones Windows" \
    content=muv4wuredir.cab in-interface=BridgeGeneral
add action=drop chain=forward content=muv3wuredir.cab in-interface=\
    BridgeGeneral
add action=drop chain=input comment="Deniego todo lo IMPUT" in-interface=\
    ether9-ARNET
add action=drop chain=input in-interface=ether7-WIFI
add action=drop chain=forward comment="Deniego todo lo FORWAD" disabled=yes \
    in-interface=ether9-ARNET log-prefix=DROP
add action=drop chain=forward disabled=yes in-interface=ether7-WIFI
/ip firewall mangle
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes SQL Server - Prioridad 2" dst-port=1433 \
    new-connection-mark=sqlC passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=sqlC dst-port=1433 \
    new-packet-mark=slqM passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes HTTP" dst-port=80 new-connection-mark=httpC \
    passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=httpsC dst-port=80 \
    new-packet-mark=httpsM passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes Pidgin - Prioridad 3" dst-port=5222 \
    new-connection-mark=pidginC passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=pidginC dst-port=5222 \
    new-packet-mark=pidgimM passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes HTTPS - Prioridad 4" dst-port=443 \
    new-connection-mark=httpsUC passthrough=yes protocol=udp
add action=mark-packet chain=prerouting connection-mark=httpsUC dst-port=443 \
    new-packet-mark=httpsUM passthrough=no protocol=udp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes HTTPS" dst-port=443 new-connection-mark=\
    httpsC passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=httpsC dst-port=443 \
    new-packet-mark=httpsM passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes SSH" dst-port=22 new-connection-mark=sshC \
    passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=sshC dst-port=22 \
    new-packet-mark=sshM passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes  SMTP - Prioridad 1" dst-port=25 \
    new-connection-mark=smtpC passthrough=yes protocol=tcp
add action=mark-packet chain=prerouting connection-mark=smtpC dst-port=25 \
    new-packet-mark=smtpM passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment=\
    "Marca Conexiones y Paquetes DNS" disabled=yes dst-port=53 \
    new-connection-mark=dnsC passthrough=yes protocol=udp
add action=mark-packet chain=prerouting connection-mark=dnsC disabled=yes \
    dst-port=53 new-packet-mark=dnsM passthrough=no protocol=udp
/ip firewall nat
add action=accept chain=srcnat comment="NAT VPN AMR-COMERCIAL" dst-address=\
    192.168.10.0/24 src-address=192.168.1.0/24
add action=accept chain=dstnat comment="NAT VPN-LAN" dst-address=\
    192.168.1.0/24 src-address=10.0.100.0/24 to-addresses=192.168.1.253
add action=accept chain=dstnat dst-address=10.0.100.0/24 src-address=\
    192.168.1.0/24 to-addresses=192.168.1.253
add action=dst-nat chain=dstnat comment="SMTP amrsalud.com" dst-address=\
    200.45.234.35 dst-port=25 protocol=tcp to-addresses=192.168.1.212 \
    to-ports=25
add action=dst-nat chain=dstnat comment="POP amrsalud.com" dst-address=\
    200.45.234.35 dst-port=110 protocol=tcp to-addresses=192.168.1.212 \
    to-ports=110
add action=dst-nat chain=dstnat comment="IMAP amrsalud.com" dst-address=\
    200.45.234.35 dst-port=143 protocol=tcp to-addresses=192.168.1.212 \
    to-ports=143
add action=dst-nat chain=dstnat comment="Redireccion OCS" dst-port=80 \
    in-interface=ether9-ARNET protocol=tcp to-addresses=192.168.1.250 \
    to-ports=80
add action=dst-nat chain=dstnat comment="Redirecciona WebProxy" disabled=yes \
    dst-port=80 in-interface=BridgeGeneral protocol=tcp to-addresses=\
    192.168.254.2 to-ports=3128
add action=redirect chain=dstnat comment="Redireccion DNS Cache " dst-port=53 \
    in-interface=BridgeGeneral protocol=udp to-ports=53
add action=dst-nat chain=dstnat comment="Redirecciona Camaras" dst-port=8000 \
    protocol=tcp to-addresses=192.168.1.121 to-ports=8000
add action=dst-nat chain=dstnat comment="Redirecciona Camaras" dst-port=88 \
    protocol=tcp to-addresses=192.168.1.121 to-ports=88
add action=dst-nat chain=dstnat comment="Redirecciona SQL a servidor WHAL" \
    dst-address=200.45.234.34 dst-port=1433 in-interface=ether9-ARNET \
    protocol=tcp to-addresses=192.168.1.150 to-ports=1433
add action=dst-nat chain=dstnat comment=\
    "Redirecciona Remoto a PC Ignacio Marini" dst-address=200.45.234.34 \
    dst-port=3387 in-interface=ether9-ARNET protocol=tcp to-addresses=\
    192.168.1.19 to-ports=3389
add action=dst-nat chain=dstnat comment=\
    "Redirecciona Remoto a PC Gisela Palloto" dst-address=200.45.234.34 \
    dst-port=3385 in-interface=ether9-ARNET protocol=tcp to-addresses=\
    192.168.1.20 to-ports=3389
add action=dst-nat chain=dstnat comment=\
    "Redirecciona Remoto a PC Cecilia Ustaran" dst-address=200.45.234.34 \
    dst-port=3386 in-interface=ether9-ARNET protocol=tcp to-addresses=\
    192.168.1.7 to-ports=3389
add action=dst-nat chain=dstnat comment=\
    "Redirecciona Remoto a PC Susana Porcel" dst-address=200.45.234.34 \
    dst-port=3384 in-interface=ether9-ARNET protocol=tcp to-addresses=\
    192.168.1.151 to-ports=3389
add action=dst-nat chain=dstnat comment="Redirecciona Remoto a PC Jose Terol" \
    dst-address=200.45.234.34 dst-port=3388 in-interface=ether9-ARNET \
    protocol=tcp to-addresses=192.168.1.71 to-ports=3389
add action=dst-nat chain=dstnat comment="Redirecciona Remoto a servidor WHAL" \
    dst-address=200.45.234.34 dst-port=3389 in-interface=ether9-ARNET \
    protocol=tcp to-addresses=192.168.1.150 to-ports=3389
add action=dst-nat chain=dstnat comment="Redirecciona FTP Fileserver" \
    dst-address=200.45.234.34 dst-port=21 in-interface=ether9-ARNET protocol=\
    tcp to-addresses=192.168.1.250 to-ports=21
add action=dst-nat chain=dstnat comment="Redirecciona FTP Fileserver" \
    dst-address=200.45.234.35 dst-port=21 in-interface=ether9-ARNET protocol=\
    tcp to-addresses=192.168.1.250 to-ports=21
add action=dst-nat chain=dstnat comment="Redirecciona FTP Fileserver" \
    dst-address=200.45.234.34 dst-port=20 in-interface=ether9-ARNET protocol=\
    tcp to-addresses=192.168.1.250 to-ports=20
add action=dst-nat chain=dstnat comment="Redirecciona FTP Fileserver" \
    dst-address=200.45.234.34 dst-port=21 in-interface=ether9-ARNET protocol=\
    tcp to-addresses=192.168.1.250 to-ports=20
add action=dst-nat chain=dstnat comment="Redirecciona Reloj" dst-address=\
    200.45.234.34 dst-port=4370 in-interface=ether9-ARNET protocol=tcp \
    src-address-list="AMR Gestion" to-addresses=192.168.1.201 to-ports=4370
add action=dst-nat chain=dstnat comment=OSC dst-address=200.45.234.34 \
    dst-port=80 in-interface=ether9-ARNET protocol=tcp to-addresses=\
    192.168.1.250 to-ports=80
add action=dst-nat chain=dstnat comment="Redireciona Squid" dst-address=\
    192.168.254.2 dst-port=10443 in-interface=BridgeGeneral protocol=tcp \
    to-addresses=192.168.254.2 to-ports=10443
add action=redirect chain=dstnat comment="Redirecciona WebProxy" dst-port=\
    1928 in-interface=ether9-ARNET protocol=tcp to-ports=8291
add action=masquerade chain=VPN-L2TP comment=VPN-L2TP src-address=\
    10.0.100.0/24
add action=masquerade chain=srcnat comment=ARNET out-interface=ether9-ARNET
add action=masquerade chain=srcnat comment=EREA out-interface=ether7-WIFI
/ip firewall raw
add action=notrack chain=prerouting dst-address=192.168.1.0/24 src-address=\
    192.168.10.0/24
add action=notrack chain=prerouting dst-address=192.168.10.0/24 src-address=\
    192.168.1.0/24
/ip firewall service-port
set tftp disabled=yes
set irc disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
/ip ipsec peer
add address=0.0.0.0/0 dh-group=modp2048 enc-algorithm=aes-256,aes-128,3des \
    exchange-mode=main-l2tp generate-policy=port-override passive=yes secret=\
    P4r4gu4y--711
/ip ipsec policy
set 0 proposal=AMR
/ip proxy
set port=3128
/ip proxy access
add src-address=192.168.1.0/24
add action=deny dst-host=":(windowsupdate|microsoft)\\.com" path=\
    ":muv[0-9]wuredir\\.cab"
/ip route
add check-gateway=ping distance=1 gateway=200.45.234.33
add distance=2 gateway=192.168.90.1
add distance=1 dst-address=192.168.1.212/32 gateway=200.45.234.35
/ip service
set telnet disabled=yes
set www address=192.168.1.19/32 port=888
set ssh address="200.45.234.34/32,200.45.234.35/32,200.45.234.36/32,200.45.234\
    .37/32,190.139.100.42/32,192.168.10.253/32,192.168.1.19/32"
set api-ssl disabled=yes
/lcd
set default-screen=interfaces
/ppp secret
add name=imarini password=nacho_161189 profile=L2TP_IPSEC remote-address=\
    10.0.100.218 service=l2tp
add name=cedyca password=P4r4gu4y--713 profile=L2TP_IPSEC routes=\
    192.168.11.0/24 service=l2tp
add name=localfunes password=P4r4gu4y--711 profile=L2TP_IPSEC remote-address=\
    10.0.100.23 routes=192.168.11.0/24 service=l2tp
add name=martadiccico password=Mrt--1470 profile=L2TP_IPSEC service=l2tp
add name=notebookamr password=P4r4gu4y--713 profile=L2TP_IPSEC service=l2tp
add name=localventas password=Paraguay--713 profile=L2TP_IPSEC \
    remote-address=10.0.100.24 routes=\
    "192.168.11.0/24, 192.168.11.254, 10.0.10.254" service=l2tp
add name=ncalderon password=ncl57800 profile=L2TP_IPSEC remote-address=\
    10.0.100.216 service=l2tp
add name=cgonzalez password=lisandro12 profile=L2TP_IPSEC routes=\
    192.168.11.0/24 service=l2tp
add name=ababbini password=Aba--245 profile=L2TP_IPSEC service=l2tp
add name=amanuel password=amel--953 profile=L2TP_IPSEC service=l2tp
add name=ffontanella password=123 profile=L2TP_IPSEC service=l2tp
add name=ndemonte password=nestor1187 profile=L2TP_IPSEC service=l2tp
add name=ngianmal password=ngianmal2016 profile=L2TP_IPSEC remote-address=\
    10.0.100.28 service=l2tp
add name=nrossi password=nancy1270 profile=L2TP_IPSEC service=l2tp
add name=secasal password=123 profile=L2TP_IPSEC service=l2tp
add name=sfernandez password=123 profile=L2TP_IPSEC service=l2tp
add name=sjansa password=sebajansa2013 profile=L2TP_IPSEC service=l2tp
add name=fmaciel password=crack4213 profile=L2TP_IPSEC service=l2tp
add name=ealbanesi password=Ean--882 profile=L2TP_IPSEC service=l2tp
add name=bdominguez password=pasco875 profile=L2TP_IPSEC service=l2tp
add name=lsuarez password=LOLA2016 profile=L2TP_IPSEC service=l2tp
add name=cnemi password=claus2710 profile=L2TP_IPSEC service=l2tp
add name=sgonzalez password=silvina1977 profile=L2TP_IPSEC service=l2tp
add name=cgranado password=Cgra--146 profile=L2TP_IPSEC service=l2tp
add name=gpallotto password=232807patu profile=L2TP_IPSEC remote-address=\
    10.0.100.217 service=l2tp
add name=psanlorenzo password=Pnl--1470 profile=L2TP_IPSEC remote-address=\
    10.0.100.219 service=l2tp
add name=ofespanol password=Ofespa--328 profile=L2TP_IPSEC remote-address=\
    10.0.100.215 service=l2tp
add name=gmutto password=123 profile=L2TP_IPSEC service=l2tp
add name=fpelozo password=manzana profile=L2TP_IPSEC service=l2tp
add name=mhidalgo password=MTS603MH profile=L2TP_IPSEC service=l2tp
add name=lsilicani password=isidoro2601 profile=L2TP_IPSEC service=l2tp
/routing ospf interface
add interface=ether9-ARNET network-type=broadcast passive=yes
add network-type=point-to-point
add network-type=point-to-point
add network-type=point-to-point
add network-type=point-to-point
/snmp
set contact=computos@amr.org.ar enabled=yes trap-generators=interfaces \
    trap-interfaces="all,ether1-WHAL,ether3-VIRTUAL,ether4-FILESERVER,ether5-L\
    ANAMR,ether9-ARNET,BridgeGeneral" trap-version=2
/system clock
set time-zone-name=America/Argentina/Cordoba
/system identity
set name=AMRSalud
/system logging
add disabled=yes topics=ipsec
/system note
set note="Bienvenido Usuario.\
    \nEste equipo corresponde a AMR Salud.\
    \nContacto: computos@amr.org.ar\
    \n\
    \nEl mismo se reserva derecho de autor."
/system ntp client
set enabled=yes primary-ntp=200.89.75.197 secondary-ntp=170.155.148.1
/system package update
set channel=release-candidate
/system scheduler
add interval=2w1d name=ScBackupUserPPP on-event=\
    "system script  run BackupUserPPP" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=oct/05/2016 start-time=12:29:30
add interval=2w1d name=ScScripBackupUserPPP policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=oct/05/2016 start-time=12:27:07
/system script
add name=MarioBross owner=Ignacio policy=read source=":beep frequency=660 leng\
    th=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=510 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=770 length=100ms;\r\
    \n:delay 550ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 575ms;\r\
    \n\r\
    \n:beep frequency=510 length=100ms;\r\
    \n:delay 450ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 400ms;\r\
    \n:beep frequency=320 length=100ms;\r\
    \n:delay 500ms;\r\
    \n:beep frequency=440 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=480 length=80ms;\r\
    \n:delay 330ms;\r\
    \n:beep frequency=450 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=760 length=50ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=860 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=700 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=760 length=50ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=520 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=580 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=480 length=80ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=510 length=100ms;\r\
    \n:delay 450ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 400ms;\r\
    \n:beep frequency=320 length=100ms;\r\
    \n:delay 500ms;\r\
    \n:beep frequency=440 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=480 length=80ms;\r\
    \n:delay 330ms;\r\
    \n:beep frequency=450 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 200ms;\r\
    \n:beep frequency=760 length=50ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=860 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=700 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=760 length=50ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=520 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=580 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=480 length=80ms;\r\
    \n:delay 500ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=760 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=720 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=680 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=620 length=150ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=650 length=150ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=570 length=100ms;\r\
    \n:delay 220ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=760 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=720 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=680 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=620 length=150ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=650 length=200ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=1020 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=1020 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=1020 length=80ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=760 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=720 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=680 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=620 length=150ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=650 length=150ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=570 length=100ms;\r\
    \n:delay 420ms;\r\
    \n\r\
    \n:beep frequency=585 length=100ms;\r\
    \n:delay 450ms;\r\
    \n\r\
    \n:beep frequency=550 length=100ms;\r\
    \n:delay 420ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 360ms;\r\
    \n\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=760 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=720 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=680 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=620 length=150ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=650 length=150ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=570 length=100ms;\r\
    \n:delay 220ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=760 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=720 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=680 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=620 length=150ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=650 length=200ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=1020 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=1020 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=1020 length=80ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=760 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=720 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=680 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=620 length=150ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=650 length=150ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=430 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=570 length=100ms;\r\
    \n:delay 420ms;\r\
    \n\r\
    \n:beep frequency=585 length=100ms;\r\
    \n:delay 450ms;\r\
    \n\r\
    \n:beep frequency=550 length=100ms;\r\
    \n:delay 420ms;\r\
    \n\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 360ms;\r\
    \n\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=100ms;\r\
    \n:delay 300ms;\r\
    \n\r\
    \n:beep frequency=500 length=60ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=60ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=580 length=80ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=430 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=380 length=80ms;\r\
    \n:delay 600ms;\r\
    \n\r\
    \n:beep frequency=500 length=60ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=60ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=580 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 550ms;\r\
    \n\r\
    \n:beep frequency=870 length=80ms;\r\
    \n:delay 325ms;\r\
    \n:beep frequency=760 length=80ms;\r\
    \n:delay 600ms;\r\
    \n\r\
    \n:beep frequency=500 length=60ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=500 length=60ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=580 length=80ms;\r\
    \n:delay 350ms;\r\
    \n:beep frequency=660 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=500 length=80ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=430 length=80ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=380 length=80ms;\r\
    \n:delay 600ms;\r\
    \n\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 150ms;\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=510 length=100ms;\r\
    \n:delay 100ms;\r\
    \n:beep frequency=660 length=100ms;\r\
    \n:delay 300ms;\r\
    \n:beep frequency=770 length=100ms;\r\
    \n:delay 550ms;\r\
    \n:beep frequency=380 length=100ms;\r\
    \n:delay 575ms;"
add name=BackupUserPPP owner=Ignacio policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "ppp secret export file=\"BackupUserPPP\""
/tool e-mail
set address=64.233.186.108 from="Mikrotik AMRSalud" password=Gnacho--89111689 \
    port=465 start-tls=yes user=computos@amr.org.ar
/tool graphing interface
add
/tool mac-server
set [ find default=yes ] disabled=yes
add interface=ether2
add interface=ether3-VIRTUAL
add interface=ether4-FILESERVER
add interface=ether5-LANAMR
add interface=ether6-PROXY
add interface=ether7-WIFI
add interface=ether8-PROXMOX
add interface=ether9-ARNET
add interface=ether10-EREA
add interface=sfp-MUTUAL
add interface=BridgeGeneral
/tool mac-server mac-winbox
set [ find default=yes ] disabled=yes
add interface=ether2
add interface=ether3-VIRTUAL
add interface=ether4-FILESERVER
add interface=ether5-LANAMR
add interface=ether6-PROXY
add interface=ether7-WIFI
add interface=ether8-PROXMOX
add interface=ether9-ARNET
add interface=ether10-EREA
add interface=sfp-MUTUAL
add interface=BridgeGeneral

