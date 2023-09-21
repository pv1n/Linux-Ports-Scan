#!/bin/bash
declare -A services=( [21]="FTP" [22]="SSH" [23]="Telnet" [25]="SMTP" [53]="DNS" [80]="HTTP" [110]="POP3" [143]="IMAP" [443]="HTTPS" [465]="SMTPS" [993]="IMAPS" [995]="POP3S" [3306]="MySQL" [3389]="RDP" [5432]="PostgreSQL" [5900]="VNC" [6379]="Redis" [27017]="MongoDB")

while getopts i:h flag
do
    case "${flag}" in
        i) ip=${OPTARG};;
        h) echo "Uso: ./ports.sh -i <IP>"; exit;;
    esac
done

if [ -z "$ip" ]
then
    echo "Por favor, proporciona una dirección IP con la opción -i. Ejemplo: ./ports.sh -i 10.10.0.132"
    exit
fi

for port in $(seq 1 65535); do
    (
        timeout 1 bash -c "echo '' > /dev/tcp/$ip/$port" &>/dev/null && echo "[*] El puerto $port esta abierto y el servicio es ${services[$port]}" &
    ) &
done; wait
