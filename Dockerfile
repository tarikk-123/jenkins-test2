# Temel imaj
FROM python:3.11-slim

# Çalışma dizini oluştur
WORKDIR /app

# Gereksinimleri ve uygulama dosyasını kopyala
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Uygulamayı başlat
CMD ["python", "app.py"]
