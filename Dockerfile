# Usar la imagen base de Python 3.10
FROM python:3.10-slim

# Establecer el directorio de trabajo en el contenedor
WORKDIR /app/

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar los archivos locales al contenedor
COPY . /app/

# Ejecutar el script de Python al iniciar el contenedor
CMD ["python", "main.py"]
