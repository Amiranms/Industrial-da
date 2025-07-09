FROM alpine:3.21

RUN apk update && apk add --no-cache bash \
                                     git \
                                    build-base \
                                    cmake \
                                    vim \
                                    musl-dev \
                                    libffi-dev \
                                    python3-dev \
                                    py3-pip \
                                    which

COPY . / 

RUN python3 -m venv /venv

RUN /venv/bin/pip install --no-cache-dir -r requirements.txt

RUN adduser -D devops2024user

RUN g++ hello-world.cpp -o /bin/print_hello

RUN mkdir build && cd build && cmake .. && make

RUN chown devops2024user:devops2024user /bin/C /bin/print_hello /app.py

EXPOSE 8898 

USER devops2024user


CMD ["/venv/bin/python", "/app.py", "--host=0.0.0.0", "--port=8898"]