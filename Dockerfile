FROM unaimillan/nsjail AS nsjail

FROM python:3.9-slim

COPY requirements.txt requirements.txt

# deps install
RUN pip install -r requirements.txt

COPY . /app
WORKDIR /app


COPY --from=nsjail /bin/nsjail /bin/nsjail

# for dynamin linking of python lib
RUN ln -s /usr/local/lib/libpython3.9.so.1.0 /usr/lib/libpython3.9.so.1.0

EXPOSE 8080

CMD ["python", "app.py"]
