 #!/bin/bashping 
 
source IoT.conf


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


echo $getdate

touch $getdate.txt | exit

echo "Datum der Angaben:" >> $getdate.txt
cat data_temp.txt | tail -n1 | cut -d ',' -f3 | tee >> $getdate.txt;

echo "Zeit der Angaben:" >> $getdate.txt
cat data_temp.txt | tail -n1 | cut -d ',' -f4 | tee >> $getdate.txt;

echo "Temperatur in Crad:" >> $getdate.txt
cat data_temp.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;

echo "Luftfeuchtigkeit in %:" >> $getdate.txt
cat data_hum.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;

echo "helligkeit:" >> $getdate.txt
cat data_light.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;

echo "Lautstärke in Dezibell:" >> $getdate.txt
cat data_sound.txt | tail -n1 | cut -d ',' -f2 | tee >> $getdate.txt;

mpack -s "Im Anhang sind die IoT Daten, die dir zugestellt werden." -a /home/moin/IoT/$getdate.txt cyrill@kaelin.org

#externe Datei
getdate=$(date +%Y:%m:%d:%H:%M)
gettemp=$xargs cat /home/moin/IoT/data_temp.txt | tail -n1 | cut -d ',' -f2 
getluftfeuchtigkeit=$xargs cat /home/moin/IoT/data_hum.txt | tail -n1 | cut -d ',' -f2
gethelligkeit=$xargs cat /home/moin/IoT/data_light.txt | tail -n1 | cut -d ',' -f2
getlautstaerke=$xargs cat /home/moin/IoT/data_sound.txt | tail -n1 | cut -d ',' -f2