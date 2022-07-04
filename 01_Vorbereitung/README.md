# Vorbereitungen
## SSMTP (Secure Simple Mail Transfer Protocol ) installieren
-> Terminal öffnen und folgendes eingeben und bei der Aufforderung mit "Y" bestätigen.
| sudo apt install ssmtp |
|---|

## AuthPass erstellen
1. Auf https://myaccount.google.com gehen
2. Auf "Sicherheit" wechseln und sicherstellen, dass Zweifaktorauthentifizierung aktiviert ist.
3. Auf APP-Passwörter wechseln
4. App auswählen -> "andere..."
5. Einen Namen definieren und den Code merken (Code wird weiter unten benötigt)

---
## FIlssmtp.conf bearbeiten
| sudo nano /etc/ssmpt/ssmpt.conf|
|---|
---
Im File under "# Mark this..." folgendes schreiben
|root=example@gmail.com|
|---|
Unter "# MX records..." folgendes schreiben:

| mailhub=ssmtp.gmail.com:465 |
|---|

|FromLineOverride=YES|
|---|

|AuthUser=example@gmail.com|
|---|

|AuthPass=example|
|---|

|UseTLS=YES|
|---|

