
FROM node:14.13.0-alpine3.12
LABEL maintainer="Daniel Rataj <daniel.rataj@centrum.cz>"
LABEL org.opencontainers.image.source="https://github.com/whoopsmonitor/whoopsmonitor-check-json-expect"
LABEL com.whoopsmonitor.documentation="https://github.com/whoopsmonitor/whoopsmonitor-check-json-expect"
LABEL com.whoopsmonitor.icon="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAQAAAAAYLlVAAAC3klEQVR42u2ZTWjUQBTHp6vbm8VD1YPK5r2Ja1vEHnJUK6LFz1OpB8XTgjkVLxaFLuKxN0UEYSmiiNiDUqgnC4IHRUUX7cEP8KAgCrJSPWhbobUrmUxMZpLYJJMVxJl3ymTezC8z/zdfISSUqI1NJftCLaKSlAFUEXIAUEPgAK+oldZgwkeAz7BVCQDq6T2hxhp/jnNKCKoAUDP68LvCQKgDEKKEkAeAEkI+AAoIeQFkRsgPICNCngCZEJQBJsTpCU/jEstvlLr+zkQUa9TWAC0G+ANaXQNoAA2gATSABtAAGkADaIB/CaDUTW1q40CeADjg1FnqJjolT+VOp9PEUaMmHnVzfZOGbzUepDYMblov5ltFGDR6l6tflKLlHqcCVd+MOm75HmYHXoIfPH8JJ0tGQAMXsQkLdF98/csAWEV8FH3e+63zdfBSejfj3wjAU/fiztyQEQAqvNJPUBeNF2+Du7zELDzDGX5Z+d7sCIYhNvH+zpWZAHCSPU31tEeXNvbyBi5vXuX0lzHMLyWqEkATR7P1wENW3cnYOB9jpZ+QgnxrGgL4ifuzANxgAC9MGjPTPXDeG8MB/13Mfz4EwJWQdggOSAKbhzpUSFv8VCt9gAtwHRc9JaQEIASuRsTANQ8hGQC1oeopITUAKeApaMgIUEkHQAo45SrBQ/G+74oTUngkIKttrIEFgWoFlPmfgX6c5rJzSz9mTyfi/H1AXIsf3TciwDh7vB2o4Cwr9iauh3jgzSXzD/aQ0ec1HgQ4xrt0iLvv5j8dzseu8EOuopP5i0MEIyGAnnZ8zbOmcQzu8WnkG93IXapQCxrecr8CxhP6ixop4J3QWmL04ldJYotwWAyzkM36W4wk/r5IzTXwIRQFpS5hwXkLe+QtlRQBDegnqfyDUcKV8E6eUrfjGajhKByyisKIS0MAF4zj3kKTwn+HJONzuEXvvKI3Y1ZrrNyZ4lzQCkt1MPlvAH4BJ6Ke8jOfk4AAAAAASUVORK5CYII="
LABEL com.whoopsmonitor.env.WM_API_ENDPOINT="https://"
LABEL com.whoopsmonitor.env.WM_EXPECT="status/number/=/200"

WORKDIR /app
COPY ./src/index.js ./src/index.js
COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

RUN npm install

CMD [ "npm", "start", "--silent" ]
