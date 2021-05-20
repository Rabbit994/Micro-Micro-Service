FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim
WORKDIR /app
RUN rm main.py
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY app/ app/
ENV MODULE_NAME=app.date_micro