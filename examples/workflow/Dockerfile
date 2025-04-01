FROM python:3.10-slim

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app

COPY simple.py .

CMD ["python", "simple.py"]