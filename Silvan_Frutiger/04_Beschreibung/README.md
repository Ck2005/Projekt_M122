## 1. 
Als erstes müssen die Vorbereitungen getroffen werden, werlche in [01_Vorbereitungen](/Silvan_Frutiger/01_Vorbereitungen) festegehalten wurden.

---
## 2. 
Den Quellcode aus [03_Script](/Silvan_Frutiger/03_Script) kopieren und in eine .bash Datei einfügen

---
## 3. 
Anschliesend muss der folgende Befehl im Terminal ausgeführt werde.

|chmod +x "/paht/of/script.bash"|
---
---
## 4.
Damit das Script autom. ausgeführt wird, muss ein Crontab eingerichtet werden.
Hierführ muss folgender Befehl im Terminal ausgeführt werden.
|sudo crontab -e|
---

Anschliesend muss die "1" gewählt werden. 
Der Crontab kann dann auf der Untersten Zeile in der Datei eingefügt werden. 
Ein Beispiel wäre:
|55 23 * * * /paht/of/script.bash|
---
## (5.)
Das Script kann mit auch Manuell ausgefüghrt werden. Hierfür muss folgendes im Terminal eigegeben werden:
|./path/of/script.bash|
---