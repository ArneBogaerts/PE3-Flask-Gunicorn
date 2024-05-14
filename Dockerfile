# Gebruik een officiële Python runtime als parent image
FROM python:3.9-slim

# Stel de werkdirectory in de container in
WORKDIR /app

# Kopieer de huidige directory inhoud naar de container op /app
COPY . /app

# Installeer de benodigde packages uit requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Maak poort 80 beschikbaar voor de buitenwereld
EXPOSE 80

# Zorg ervoor dat de database wordt geïnitialiseerd en migraties worden uitgevoerd
CMD ["sh", "-c", "flask db init || true && flask db migrate -m 'initial migration' || true && flask db upgrade && gunicorn -w 4 -b 0.0.0.0:80 crudapp:app"]
