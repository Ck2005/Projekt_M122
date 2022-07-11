d#!/bin/bash
#
#---------------------------------------------------------------------------------
# Script: iot-to-mail
#
#
# Author: Silvan Frutiger
#
# Desc.:
# Das Script list die Daten vom Server kel.internet-box.ch aus und 
# gibt die Max. und Min. Luftfeuchigkeit des aktuellen Tages an. 
# Das Script wird automatisch einmal pro Tag ausgefüht.
#---------------------------------------------------------------------------------
# 
#--------------------------------- Variables -------------------------------------

# Setzt Variabel für das Lokale verzeichnis
base_dir="/home/silvan/iot/"
#
# Setzt Variabel für den Pfad ../log im Lokalen verzeichnis
log_dir="${base_dir}log/"
#
# Setzt Variabel für das Logfile
logfile="${log_dir}iot_to_mail.bash.log"
#
# Setzt Variabel für die IoT-Daten, welche auf den aktuellen Tag gefiltert sind
data_hum_today="${base_dir}data_hum_today.txt"
#
# Setzt Variabel für die Datei, welche vom Server heruntergeladen wird
data_hum="${log_dir}data_hum.txt"
#
# Setzt Varibabel für den IoT-Server
iot_server="172.16.17.228"
#
# Setzt Variabel für die Datei auf dem Iot-Server
iot_server_data="${iot_server}/log/data_hum.txt"
#
# Setzt Variabel für die E-Mail, an welche das Mail erfolgt
mail_to="silvan-leon.frutiger@gmx.net"
#
# Setzt Variabel für das Aktuelle Datum
date_now=$(date +%Y-%m-%d)
#
#
#
#----------------------------------- START ---------------------------------------

# Daten herunterladen und überschreibt die bestehende Datei
wget -O $data_hum $iot_server_data
#
# Daten werden in nach dem Datum aussortiert und 
# nur die Datensätze mit dem aktuellen Datum werden ins neue File geschrieben
cat $data_hum | grep $date_now > $data_hum_today
#
# Variabeln werden für die Max. und Min. Luftfeuchtigkeit gesetzt
# Mit "sort -nk 2" wird die zweite Spalte aufsteigend sortiert.
# Mit "tail -1" bzw. "head -1" wird die unterste bzw. die oberste Zeile ausgelesen
# Mit "cut -d ',' -f2" wird die Spalte nach dem Koma getrennt und der zweite wert ausgewählt
max_hum=$(cat $data_hum_today | sort -nk 2 | tail -1 | cut -d ',' -f2)
min_hum=$(cat $data_hum_today | sort -nk 2 | head -1 | cut -d ',' -f2)
#
# Das Mail wird versendet
# Mit EOP kannn es als ganzer Text markiert werden
cat << EOF | mailx -s "Meldung: Luftfeuchtigkeit vom ${date_now}" $mail_to
Die maximale Luftfeuchtigkeit vom $date_now ist ${max_hum}%.
Die minimale Luftfeuchtigkeit vom $date_now ist ${min_hum}%.
EOF
