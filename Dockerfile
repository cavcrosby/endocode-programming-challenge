FROM python:3

WORKDIR /app

COPY . .

RUN make setup

CMD ["make", "run"]
