FROM python:3.9
MAINTAINER Jake Runyan

# Set some env variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY runyanjake/ /code/
COPY requirements.txt /code/

WORKDIR /code/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["python","manage.py","runserver","0.0.0.0:8000"]

