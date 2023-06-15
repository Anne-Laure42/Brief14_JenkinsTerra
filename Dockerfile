FROM python:3.9-slim

RUN apt-get update && apt-get install -y \
    python3-dev \
    python3-pip

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 1234

CMD ["python3", "app.py"]
