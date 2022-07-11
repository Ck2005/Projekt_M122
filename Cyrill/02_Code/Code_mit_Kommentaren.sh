 #!/bin/bashping 
 
#ist die Datei, in der ich getdate definiert habe
source IoT.conf

#holt die Dateien von dem Server
ftpHost="m122-server.local"
ftpUser="IoT-Log"
ftpPass="THLS-60s"
ftpDir=""
localDir="/home/moin/IoT"

ftp -inv << FTPANWEISUNG

quote USER $ftpUser
quote PASS $ftpPass

passive
ascii

lcd $localDir
mget *.txt

close

FTPANWEISUNG

#dateien überschreiben mit >

#gibt Datum mit exakter Zeit aus/Dateinamen, weil ich diese so benennen
echo $getdate
#erstellt die Datei, in der wir die Angaben einfügen, falls die Datei bereits existiert macht es einfach weiter
touch $getdate.txt | exit

echo "Datum der Angaben:" >> $getdate.txt
cat data_temp.txt | tail -n1 | cut -d ',' -f3 | tee > $getdate.txt;

echo "Zeit der Angaben:" >> $getdate.txt
cat data_temp.txt | tail -n1 | cut -d ',' -f4 | tee >> $getdate.txt;

echo "Temperatur in Crad:" >> $getdate.txt
cat data_temp.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;
#lisest aus der Datei data_temp.txt in der letzten Zeile der zweite Abschnitt nach dem Komma, diesen fügt er in die Datei $getdate.txt einfügen. $getdate ist der Befehl, dieser ist das heutige Datum mit zeit
echo "Luftfeuchtigkeit in %:" >> $getdate.txt
cat data_hum.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;
echo "helligkeit:" >> $getdate.txt
cat data_light.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;
echo "Lautstärke in Dezibell:" >> $getdate.txt
cat data_sound.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;

mpack -s "Im Anhang sind die IoT Daten, die dir zugestellt werden." -a /home/moin/IoT/$getdate.txt cyrill@kaelin.org
#schickt die Datei an cyrill@kaelin.org


#mti Crontab -e kann und dach 1 kann ich die Crontab Datei bearbeiten. da habe ich dann 0 für Minuten 20 für die Stunde und die Sternchen sind danach für Tag monat und Jahr. den Datei Pfad ist dazu da, das es weiss welches Skript das es ausführen muss.

#externe Datei IoT.conf
getdate=$(date +%Y:%m:%d:%H:%M)
gettemp=$xargs cat /home/moin/IoT/data_temp.txt | tail -n1 | cut -d ',' -f2 
getluftfeuchtigkeit=$xargs cat /home/moin/IoT/data_hum.txt | tail -n1 | cut -d ',' -f2
gethelligkeit=$xargs cat /home/moin/IoT/data_light.txt | tail -n1 | cut -d ',' -f2
getlautstaerke=$xargs cat /home/moin/IoT/data_sound.txt | tail -n1 | cut -d ',' -f2