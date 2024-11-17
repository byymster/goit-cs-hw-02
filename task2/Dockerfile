FROM python:3.12-slim
ENV PORT=8000
EXPOSE ${PORT}
WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY Computer-Systems-hw02/requirements.txt /app
RUN  pip install --upgrade pip && \
     pip install -r requirements.txt

COPY Computer-Systems-hw02 /app


CMD ["python", "main.py"]