FROM python:3.8-slim-buster

ENV PYTHONUNBUFFERED=0
WORKDIR /app
COPY requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt
COPY token.txt token.txt
COPY pixel.py pixel.py
CMD ["python3", "-u", "pixel.py"]