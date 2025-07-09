FROM python:3.11-slim

RUN mkdir -p app

COPY . /app

WORKDIR /app 

RUN python3 -m venv /venv 

RUN pip install --no-cache-dir -r /app/requirements.txt

CMD ["sh", "-c", "python init_db.py && uvicorn main:app --host 0.0.0.0 --port 8000"]

