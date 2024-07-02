# FROM nsjailcontainer AS nsjail  

FROM python:3.9-slim 

RUN apt-get -y update && apt-get install -y \
    autoconf \
    bison \
    flex \
    gcc \
    g++ \
    git \
    libprotobuf-dev \
    libnl-route-3-dev \
    libtool \
    make \
    pkg-config \
    protobuf-compiler \
    libseccomp-dev \
    && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/google/nsjail.git /tmp/nsjail \
&& cd /tmp/nsjail \
&& make \
&& cp nsjail /usr/local/bin/nsjail \
&& rm -rf /tmp/nsjail

# COPY . /nsjail

# RUN cd /nsjail && make && mv /nsjail/nsjail /bin && rm -rf -- /nsjail

# RUN python -m pip install --upgrade pip setuptools

COPY . /app
WORKDIR /app

# RUN cd /nsjail && make && mv /nsjail/nsjail /bin && rm -rf -- /nsjail

# deps install
RUN pip install -r requirements.txt

# COPY --from=nsjail /bin/nsjail /bin/nsjail
# COPY --from=nsjail /usr/lib/x86_64-linux-gnu/libprotobuf.so.10 /usr/lib/x86_64-linux-gnu/
# COPY --from=nsjail /usr/lib/x86_64-linux-gnu/libnl-route-3.so.200 /usr/lib/x86_64-linux-gnu/
# COPY --from=nsjail /lib/x86_64-linux-gnu/libseccomp.so.2 /lib/x86_64-linux-gnu/
# COPY --from=nsjail /lib/x86_64-linux-gnu/libnl-3.so.200 /lib/x86_64-linux-gnu/

# for dynamin linking of python lib
RUN ln -s /usr/local/lib/libpython3.9.so.1.0 /usr/lib/libpython3.9.so.1.0

EXPOSE 8080

CMD ["python", "app.py"]
