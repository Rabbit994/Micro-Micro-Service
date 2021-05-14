FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-slim
WORKDIR /app
RUN rm main.py
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY app/ app/
ENV email_domain=example.com
ENV MODULE_NAME=app.name_micro 