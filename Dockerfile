# Verwenden des offiziellen Python-Images als Basisimage
FROM python:3.9

# Festlegen des Arbeitsverzeichnisses im Container
WORKDIR /app

# Installieren der benötigten Python-Pakete
RUN pip install requests beautifulsoup4

# Befehl, der ausgeführt wird, wenn der Container startet
CMD ["python"]
