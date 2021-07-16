FROM python:3.9-slim-buster
WORKDIR /app
COPY loadtester/requirements.txt requirements.txt
RUN python3 -m pip install -r requirements.txt
COPY loadtester/load_gen.py load_gen.py
RUN ls -l
CMD ["python3", "./load_gen.py"]