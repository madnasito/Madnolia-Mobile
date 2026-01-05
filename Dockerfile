FROM instrumentisto/flutter:3.38.5

WORKDIR /app


RUN apt-get update && apt-get install -y android-tools-adb

COPY . .

RUN flutter pub get

# No ejecutamos 'flutter devices' aquí porque en el build no habrá nada conectado
CMD ["flutter", "doctor -v"]
