# Модуль "`GitHub Actions`" - `GHA-01 — Введение в GitHub Actions`

 ### 🎯 Цель урока
Понять, как устроены GitHub Actions

---

 ## 📘 Теория (кратко)

🔹 Что такое Docker?

Docker — это платформа контейнеризации, позволяющая запускать приложения в изолированных окружениях, называемых контейнерами. Контейнеры используют общее ядро операционной системы, но при этом полностью изолированы на уровне процессов, сети, файловой системы и окружения.

🔹 Отличие контейнера от виртуальной машины
    - Контейнер                   
Лёгкий, использует общее ядро хоста
Запускается за секунды
Использует меньше ресурсов
Уровень — изоляция процессов

    - Виртуальная машина
Тяжёлый, содержит полную гостевую ОС
Требует времени на загрузку
Использует много ресурсов
Уровень — виртуализация оборудования

🔹 Компоненты Docker:
	1.	Docker Client (CLI):
	•	Ты вводишь команды (docker run, docker build)
	•	Передаёт инструкции Docker Daemon
	2.	Docker Daemon (dockerd):
	•	Слушает команды от клиента
	•	Управляет контейнерами, образами, сетями, томами
	3.	Docker Images:
	•	Шаблоны файловой системы (read-only)
	•	Содержат всё для запуска приложения (библиотеки, код, команды запуска)
	4.	Docker Containers:
	•	Изолированное рабочее окружение
	•	Запускается из образа (image)
	•	Лёгкий, быстро создаётся и удаляется
	5.	Dockerfile:
	•	Сценарий создания образа (шаги: копировать, установить, запустить)
	6.	Docker Registry:
	•	Хранилище образов (Docker Hub, GitHub Container Registry, self-hosted)



 ## Ключевые команды:

- 'docker build . → Собираем образ по Dockerfile'
- 'docker run myimage → Контейнер создаётся и запускается из образа'

---

### Задание

1. Тимлид просит тебя разобраться и визуализировать архитектуру Docker. А также объяснить это своими словами как будто ты наставник джуна.

1. `Найди или сам нарисуй архитектурную схему Docker (можно draw.io, Excalidraw, даже от руки и в PDF) •Отрази взаимодействие: CLI → Daemon → Image → Container → Registry`

`При необходимости прикрепитe сюда скриншоты
![Схема Docker](/Users/sergeylapshov/Documents/Devops/docker/image/14484804052022_08fda0244b5397e030ee401fd2bea5b24f78a72b.jpg)`

```
Поле для вставки кода...
....
....
....
....
```
2. `Напиши объяснение своими словами: •	Что делает каждая часть •	Как всё это работает вместе`

```
CLI - взаимодействие клиента с docker по средствам команд введенных через терминал 
Daemon - принимает команды от клиента 
Image - шаблон приложения 
Container - изолированное рабочее окружение которое запускается из image
Registry - хранилище образа 
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`Docker — Основы контейнеризации`" - `DOC-02 Установка Docker на macOS (M4)`

 ### 🎯 Цель урока
Установка Docker на macOS

---

 ## 📘 Теория (кратко)

📘 Теория: Установка Docker на macOS (Apple Silicon)

На macOS Docker работает через Docker Desktop — это GUI-приложение, которое устанавливает:
	•	Docker Engine (демон)
	•	Docker CLI
	•	Docker Compose
	•	Docker VM (под капотом — через виртуализацию)

Особенности для M1/M2/M3/M4 чипов (ARM64):
	•	Используется встроенный hypervisor.framework, никакого VirtualBox
	•	Требуются ARM-совместимые образы
	•	Docker сам запускается внутри lightweight виртуальной машины

🔹 Что будет установлено:
	•	docker — клиент
	•	docker compose — работа с многоконтейнерными приложениями
	•	docker buildx — для сборки multi-arch образов
	•	docker info, docker version — диагностика

 ## Ключевые команды:


---

### Задание

1. Установи Docker на свою машину и подтверди его работоспособность через CLI.

1. `Перейди на официальный сайт Docker Desktop`

```
....
```
2. `Скачай версию для macOS (Apple chip)`

```
....
```
3. `Установи приложение как обычную .dmg`

```
....
```
4. `Открой Docker Desktop, дождись появления зелёной иконки 🟢`

```
....
```
5. `В терминале проверь:•	docker version •	docker info`

```
docker version
Client:
 Version:           28.0.4
 API version:       1.48
 Go version:        go1.23.7
 Git commit:        b8034c0
 Built:             Tue Mar 25 15:06:09 2025
 OS/Arch:           darwin/arm64
 Context:           desktop-linux

Server: Docker Desktop 4.40.0 (187762)
 Engine:
  Version:          28.0.4
  API version:      1.48 (minimum version 1.24)
  Go version:       go1.23.7
  Git commit:       6430e49
  Built:            Tue Mar 25 15:07:18 2025
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.7.26
  GitCommit:        753481ec61c7c8955a23d6ff7bc8e4daed455734
 runc:
  Version:          1.2.5
  GitCommit:        v1.2.5-0-g59923ef
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0

docker info
Client:
 Version:    28.0.4
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.1.3
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-ai
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.22.0-desktop.1
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-buildx
  cloud: Docker Cloud (Docker Inc.)
    Version:  0.2.20
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-cloud
  compose: Docker Compose (Docker Inc.)
    Version:  v2.34.0-desktop.1
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-compose
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.0.38
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-debug
  desktop: Docker Desktop commands (Beta) (Docker Inc.)
    Version:  v0.1.6
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-desktop
  dev: Docker Dev Environments (Docker Inc.)
    Version:  v0.1.2
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-dev
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.27
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-extension
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.0
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-init
  model: Docker Model Runner (Docker Inc.)
    Version:  v0.1.4
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-model
  sbom: View the packaged-based Software Bill Of Materials (SBOM) for an image (Anchore Inc.)
    Version:  0.6.0
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-sbom
  scout: Docker Scout (Docker Inc.)
    Version:  v1.17.0
    Path:     /Users/sergeylapshov/.docker/cli-plugins/docker-scout

Server:
 Containers: 41
  Running: 21
  Paused: 0
  Stopped: 20
 Images: 20
 Server Version: 28.0.4
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Using metacopy: false
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
 CDI spec directories:
  /etc/cdi
  /var/run/cdi
 Swarm: inactive
 Runtimes: io.containerd.runc.v2 runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 753481ec61c7c8955a23d6ff7bc8e4daed455734
 runc version: v1.2.5-0-g59923ef
 init version: de40ad0
 Security Options:
  seccomp
   Profile: unconfined
  cgroupns
 Kernel Version: 6.10.14-linuxkit
 Operating System: Docker Desktop
 OSType: linux
 Architecture: aarch64
 CPUs: 10
 Total Memory: 15.6GiB
 Name: docker-desktop
 ID: 3982237c-a55c-477c-a874-fce353e2b31f
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 HTTP Proxy: http.docker.internal:3128
 HTTPS Proxy: http.docker.internal:3128
 No Proxy: hubproxy.docker.internal
 Labels:
  com.docker.desktop.address=unix:///Users/sergeylapshov/Library/Containers/com.docker.docker/Data/docker-cli.sock
 Experimental: false
 Insecure Registries:
  hubproxy.docker.internal:5555
  ::1/128
  127.0.0.0/8
 Live Restore Enabled: false

WARNING: DOCKER_INSECURE_NO_IPTABLES_RAW is set
WARNING: daemon is not using the default seccomp profile

```
6. `Запусти тест:•	docker run hello-world`

```
docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c9c5fd25a1bd: Pull complete 
Digest: sha256:c41088499908a59aae84b0a49c70e86f4731e588a737f1637e73c8c09d995654
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Docker — Основы контейнеризации`" - `DOC-03 Docker CLI: команды, образы, контейнеры`

 ### 🎯 Цель урока
Docker CLI — базовые команды

---

 ## 📘 Теория (кратко)

Docker CLI — это интерфейс командной строки для взаимодействия с Docker Engine. Именно через него ты управляешь всем: от скачивания образов до запуска контейнеров, настройки сети и управления данными.

🔹 Основные сущности и действия

🧱 Образы (images)

Шаблоны, из которых создаются контейнеры.
	•	docker pull nginx — скачать образ
	•	docker images — список образов
	•	docker rmi nginx — удалить образ

📦 Контейнеры (containers)

Работающие инстансы образов.
	•	docker run nginx — создать и запустить контейнер
	•	docker ps — запущенные контейнеры
	•	docker ps -a — все контейнеры
	•	docker stop <id> — остановить
	•	docker rm <id> — удалить

🧩 Тома (volumes)

Хранилища данных вне контейнера.
	•	docker volume create mydata
	•	docker volume ls
	•	docker run -v mydata:/data nginx

🌐 Сети (networks)

Изоляция и взаимодействие между контейнерами.
	•	docker network ls
	•	docker network create mynet
	•	docker run --network=mynet nginx

📑 Полезные:
	•	docker inspect <id> — детальная информация
	•	docker logs <id> — логи контейнера
	•	docker exec -it <id> bash — подключение внутрь



 ## Ключевые команды:


---

### Задание

1. Ты получаешь временный dev-сервер, где нужно:
	•	Развернуть тестовое окружение на nginx
	•	Подключить том для хранения /usr/share/nginx/html
	•	Создать кастомную сеть и запустить 2 контейнера в ней


1. `Очисти окружение: удали все старые контейнеры и образы (опционально).`

```

```
2. `Скачай nginx и redis образы.`

```
docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
943331d8a9a9: Pull complete 
67ef22056282: Pull complete 
844fa86a5e03: Pull complete 
4e82158dafdd: Pull complete 
e1242a59b7fa: Pull complete 
ff2745aabaf7: Pull complete 
a53cddf3d9ee: Pull complete 
Digest: sha256:c15da6c91de8d2f436196f3a768483ad32c258ed4e1beb3d367a27ed67253e66
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest

docker pull redis
Using default tag: latest
latest: Pulling from library/redis
943331d8a9a9: Already exists 
5a0938ddd3e8: Pull complete 
06242992f645: Pull complete 
47fccd451853: Pull complete 
6c1d4ef16ede: Pull complete 
4f4fb700ef54: Pull complete 
3595f9893a45: Pull complete 
Digest: sha256:1b7c17f650602d97a10724d796f45f0b5250d47ee5ba02f28de89f8a1531f3ce
Status: Downloaded newer image for redis:latest
docker.io/library/redis:latest

```
3. `Создай:•	том webdata •	сеть dev-net`

```
docker volume create webdata
webdata

docker network create dev-net
2791c19b808fe4dd9ea9d9e07779785b68d4c16e2d58f01037646a70a0e9be51
```
4. `Запусти два контейнера: •	nginx с монтированным томом webdata:/usr/share/nginx/html •	redis в той же сети`

```
docker run -d --network=dev-net -v webdata:/usr/share/nginx/html nginx
ab630092b0b417060cf7b4d1dde7bc66d2ef8ab3652f1013ce370ba0573e6676

docker run -d --network=dev-net redis
6bce259f79a896dc133b6af90ce939a953ea9154ecece6b919e32c2fbe0c09b7

6bce259f79a8   redis                         "docker-entrypoint.s…"   14 seconds ago   Up 14 seconds      6379/tcp   adoring_poitras
ab630092b0b4   nginx                         "/docker-entrypoint.…"   57 seconds ago   Up 57 seconds      80/tcp     sleepy_roentgen
```
5. `Зайди в контейнер nginx, проверь, что /usr/share/nginx/html монтировано`

```
docker exec -it ab630092b0b4 bash

root@ab630092b0b4:/# ls
bin  boot  dev  docker-entrypoint.d  docker-entrypoint.sh  etc  home  lib  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
```
6. `Останови контейнеры и удали только их (не образы!)`

```
docker stop ab630092b0b4 6bce259f79a8
ab630092b0b4
6bce259f79a8

docker rm ab630092b0b4 6bce259f79a8
ab630092b0b4
6bce259f79a8

docker ps -a
CONTAINER ID   IMAGE                                 COMMAND                  CREATED       STATUS                     PORTS                                                                                                                                  NAMES
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Docker — Основы контейнеризации`" - `DOC-04 Dockerfile и создание собственного образа`

 ### 🎯 Цель урока
Что такое Dockerfile

---

 ## 📘 Теория (кратко)

Dockerfile — это скрипт, содержащий пошаговые инструкции, по которым Docker собирает образ (image).

Ты буквально программируешь, что установить, какие файлы скопировать, как запустить, и всё это становится частью одного файла.

🔹 Основные директивы Dockerfile
FROM Базовый образ (например, ubuntu, python, node)
RUN Выполнение команды (например, установка пакетов)
COPY Копирование файлов из текущей директории внутрь образа
WORKDIR Установка рабочей директории в контейнере
CMD Команда по умолчанию при запуске контейнера
EXPOSE Документирование порта (не пробрасывает!)
ENV Установка переменных окружения
ENTRYPOINT Альтернатива CMD, задаёт основную команду контейнера

🔹 Пример Dockerfile (Python Hello API)
	FROM python:3.12-alpine
	WORKDIR /app
	COPY . .
	RUN pip install fastapi uvicorn
	EXPOSE 8000
	CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

 ## Ключевые команды:

---

### Задание

1. Собери Docker-образ, в котором запущено простое Python-приложение на FastAPI, и проверь, что оно работает на localhost:8000.

1. `Создай рабочую директорию docker/04-dockerfile`

```
mkdir 04-dockerfile | cd 04-dockerfile
```
2. `Создай файл main.py: from fastapi import FastAPI app = FastAPI() @app.get("/") def root(): return {"message": "Hello from Docker!"`

```
echo 'from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from Docker!"}' > main.py
```
3. `Напиши Dockerfile с инструкциями: •	Базовый образ python:3.12-alpine •	Копировать main.py внутрь •	Установить fastapi, uvicorn •	Открыть порт 8000 •	Запустить uvicorn`

```
nano Dockerfile
FROM python:3.12-alpine
WORKDIR /app
COPY . .
RUN pip install fastapi uvicorn
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```
4. `Собери образ: docker build -t myapi .`

```
docker build -t myapi .
[+] Building 34.5s (9/9) FINISHED                                                                                                            docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                                         0.0s
 => => transferring dockerfile: 232B                                                                                                                         0.0s
 => [internal] load metadata for docker.io/library/python:3.12-alpine                                                                                        1.9s
 => [internal] load .dockerignore                                                                                                                            0.0s
 => => transferring context: 2B                                                                                                                              0.0s
 => [1/4] FROM docker.io/library/python:3.12-alpine@sha256:9c51ecce261773a684c8345b2d4673700055c513b4d54bc0719337d3e4ee552e                                  6.4s
 => => resolve docker.io/library/python:3.12-alpine@sha256:9c51ecce261773a684c8345b2d4673700055c513b4d54bc0719337d3e4ee552e                                  0.0s
 => => sha256:7692574bf4801943e7fc167f876c99a00dd65e9748b9cfd4840a398c57bf4f6c 13.71MB / 13.71MB                                                             5.7s
 => => sha256:0caf59132a0bc45e45c1d3c3cdea5e9adedca3b84de1300ec64d4ad49182ef2b 248B / 248B                                                                   2.5s
 => => sha256:9c51ecce261773a684c8345b2d4673700055c513b4d54bc0719337d3e4ee552e 10.30kB / 10.30kB                                                             0.0s
 => => sha256:28c8ac013225c99f00023757b69cb69b145f848da6ea7d86a0205d48164fd6f4 1.74kB / 1.74kB                                                               0.0s
 => => sha256:477ccb1ed21644af730edcd55e02034e6be58aea743ed7a13a6bd246ec1ebb76 5.35kB / 5.35kB                                                               0.0s
 => => sha256:f50b10efc2b0f5c71ea50728af1c0b9c1a4787270fc322139a1e8ceb93bb3b43 462.07kB / 462.07kB                                                           3.1s
 => => extracting sha256:f50b10efc2b0f5c71ea50728af1c0b9c1a4787270fc322139a1e8ceb93bb3b43                                                                    0.1s
 => => extracting sha256:7692574bf4801943e7fc167f876c99a00dd65e9748b9cfd4840a398c57bf4f6c                                                                    0.6s
 => => extracting sha256:0caf59132a0bc45e45c1d3c3cdea5e9adedca3b84de1300ec64d4ad49182ef2b                                                                    0.0s
 => [internal] load build context                                                                                                                            0.0s
 => => transferring context: 421B                                                                                                                            0.0s
 => [2/4] WORKDIR /app                                                                                                                                       0.1s
 => [3/4] COPY . .                                                                                                                                           0.0s
 => [4/4] RUN pip install fastapi uvicorn                                                                                                                   25.9s
 => exporting to image                                                                                                                                       0.1s
 => => exporting layers                                                                                                                                      0.1s
 => => writing image sha256:40905fb3b642d9f5add81c50b67e29903543b0b8b07882563be6a0b42d4f7d86                                                                 0.0s
 => => naming to docker.io/library/myapi                                                                                                                     0.0s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/eq57w4zertponjt6r1vjqrspd
```
5. `Запусти контейнер: docker run -d -p 8000:8000 myapi`

```
docker run -d -p 8003:8000 myapi
75f807b7e90563486e3c676136750efaeffd821d85937b4adb25707c5c94bfb3
```
6. `Проверь в браузере или через curl http://localhost:8000`

```
curl http://localhost:8003
{"message":"Hello from Docker!"}
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Docker — Основы контейнеризации`" - `DOC-05 Docker Compose: многоконтейнерные приложения`

 ### 🎯 Цель урока
Что такое Docker Compose

---

 ## 📘 Теория (кратко)

Docker Compose — это инструмент, который позволяет определять и запускать многоконтейнерные Docker-приложения с помощью одного YAML-файла.
Вместо длинных docker run ... ты описываешь всё в docker-compose.yml.

⸻

🔹 Ключевые концепции
	•	services — контейнеры (например: web, db, redis)
	•	image / build — либо используем готовый образ, либо собираем из Dockerfile
	•	ports — проброс портов (хост:контейнер)
	•	volumes — монтирование директорий/томов
	•	networks — объединение сервисов в одну виртуальную сеть
	•	depends_on — указывает, что один сервис зависит от другого

Пример docker-compose.yml

version: '3.9'

services:
  web:
    build: .
    ports:
      - "8000:8000"
    depends_on:
      - redis
  redis:
    image: redis:alpine

 ## Ключевые команды:

- `docker compose up -d - апуск всех сервисов'
  'docker compose down - Остановка и удаление'
  'docker compose ps - Список сервисов'
  'docker compose logs - Логи всех сервисов'
  'docker compose exec web sh - Войти внутрь сервиса` 

---

### Задание

1. Разверни многоконтейнерное приложение, состоящее из:
	•	FastAPI-приложения, как в DOC-04
	•	Redis-сервера

1. `Создай рабочую папку: docker/05-compose/`

```
mkdir 05-compose | cd 05-compose
```
2. `Возьми main.py из прошлой миссии и обнови его, чтобы: •	сохранял в Redis ключ "status": "ok" •	возвращал значение по запросу`

```
touch main.py
import redis
from fastapi import FastAPI

app = FastAPI()
r = redis.Redis(host="redis", port=6379)

@app.get("/")
def root():
    r.set("status", "ok")
    return {"status": r.get("status").decode()}
```
3. `Создай Dockerfile (можно взять из DOC-04)`

```
touch Dockerfile 
FROM python:3.12-alpine
WORKDIR /app
COPY . .
RUN pip install fastapi uvicorn redis
EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```
4. `Напиши docker-compose.yml, который: •	собирает web из Dockerfile •	запускает redis:alpine •	пробрасывает порт 8005:8000`

```
touch docker-compose.yml
services:
  web:
    build: .
    ports:
      - "8005:8000"
    depends_on:
      - redis
  redis:
    image: "redis:alpine" 
```
5. `Запусти docker compose up -d`

```
docker compose up -d
[+] Running 8/8
 ✔ redis Pulled                                                                                                                                             26.6s 
Compose can now delegate builds to bake for better performance.
 To do so, set COMPOSE_BAKE=true.
[+] Building 35.4s (10/10) FINISHED                                                                                                          docker:desktop-linux
 => [web internal] load build definition from Dockerfile                                                                                                     0.0s
 => => transferring dockerfile: 232B                                                                                                                         0.0s
 => [web internal] load metadata for docker.io/library/python:3.12-alpine                                                                                    4.2s
 => [web internal] load .dockerignore                                                                                                                        0.0s
 => => transferring context: 2B                                                                                                                              0.0s
 => [web 1/4] FROM docker.io/library/python:3.12-alpine@sha256:9c51ecce261773a684c8345b2d4673700055c513b4d54bc0719337d3e4ee552e                              0.0s
 => [web internal] load build context                                                                                                                        0.0s
 => => transferring context: 715B                                                                                                                            0.0s
 => CACHED [web 2/4] WORKDIR /app                                                                                                                            0.0s
 => [web 3/4] COPY . .                                                                                                                                       0.0s
 => [web 4/4] RUN pip install fastapi uvicorn                                                                                                               31.0s
 => [web] exporting to image                                                                                                                                 0.1s
 => => exporting layers                                                                                                                                      0.1s
 => => writing image sha256:280279a5871f8c7ae640804fb80af34eed70fe80ae295017a52e684a759586f9                                                                 0.0s
 => => naming to docker.io/library/05-compose-web                                                                                                            0.0s
 => [web] resolving provenance for metadata file                                                                                                             0.0s
[+] Running 4/4
 ✔ web                           Built                                                                                                                       0.0s 
 ✔ Network 05-compose_default    Created                                                                                                                     0.0s 
 ✔ Container 05-compose-redis-1  Started                                                                                                                     0.2s 
 ✔ Container 05-compose-web-1    Started            
```
6. `Проверь, что на localhost:8005 возвращается JSON: {"status": "ok"}`

```
curl http://localhost:8005
{"status":"ok"}% 
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Docker — Основы контейнеризации`" - `DOC-06 Volumes и управление данными`

 ### 🎯 Цель урока
Что такое Docker Volume
---

 ## 📘 Теория (кратко)

🔹 Проблема

По умолчанию всё, что записано внутри контейнера — исчезает после его удаления.
Нам нужно хранить:
	•	Файлы приложения
	•	Конфигурации
	•	Базы данных
	•	Кэш и временные логи (по необходимости)

🔹 Решение: Volume

Volume — это постоянное хранилище данных, управляемое самим Docker.

🔹 Виды volume-подключений
Named Volume: -v mydata:/data - стандарт
Anonymous Volume: -v /data - одноразовое
Bind Mount: -v $(pwd)/data:/data - доступ к локальной папке
Read-only Volume: -v mydata:/data:ro - защита от записи

🔹 Где лежат volume’ы?

На macOS с Docker Desktop — внутри виртуального окружения (не напрямую в /var/lib/docker/volumes).

🔹 Использование в Compose

volumes:
  - webdata:/usr/share/nginx/html

volumes:
  webdata:

 ## Ключевые команды:

- `docker volume create mydata
docker volume ls
docker volume inspect mydata
docker volume rm mydata`

---

### Задание

1. Разверни Tomcat-контейнер, который:
	•	отдаёт HTML-файл снаружи (через volume)
	•	при перезапуске контейнера данные не теряются

1. `Создай рабочую директорию: docker/06-volumes/`

```
mkdir 06-volume | cd 06-volume
```
2. `Создай HTML-файл index.html с фразой "Hello from persistent volume"`

```
touch index.html 
Hello from persistent volume
```
3. `Создай volume webcontent`

```
docker volume create webcontent
webcontent
```
4. `Запусти контейнер`

```
docker run -d -p 8088:8080 -v webcontent:/usrlocal/tomcat/webapps/ROOT tomcat
Unable to find image 'tomcat:latest' locally
latest: Pulling from library/tomcat
2f074dc76c5d: Pull complete 
866e6e02a3bf: Pull complete 
495e17cf917e: Pull complete 
966861f2a238: Pull complete 
4b1b55ea8a34: Pull complete 
1d58fcd48c92: Pull complete 
4f4fb700ef54: Pull complete 
46b8d1047035: Pull complete 
Digest: sha256:80585828cfe3aa2e12c231761b9f429c49a7a9c30987c6405af96faee57c70d3
Status: Downloaded newer image for tomcat:latest
b1222c163523d9481493570c2f96d457aad3377e568bbb410e8483c01d00d8bb
```

5. `Скопируй файл внутрь тома`

```
docker cp index.html b1222c163523:/usr/local/tomcat/webapps/ROOT
Successfully copied 2.05kB to b1222c163523:/usr/local/tomcat/webapps/ROOT
```

6. `Проверь через curl http://localhost:8080 — должен быть HTML`

```
curl http://localhost:8088
Hello from persistent volume
```

7. `Удали контейнер, заново запусти tomcat, проверь, сохранился ли файл`

```
docker stop b1222c163523
b1222c163523

docker rm b1222c163523
b1222c163523

docker run -d -p 8088:8080 -v webcontent:/usr/local/tomcat/webapps/ROOT tomcat
f48643deddedc2d3eca176b84ab65f9bc0a7fbc1ca64a809c59441c1788f61fb

curl http://localhost:8088
Hello from persistent volume
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Docker — Основы контейнеризации`" - `DOC-07 Сетевые режимы Docker`

 ### 🎯 Цель урока
Сетевые драйверы и режимы в Docker

---

 ## 📘 Теория (кратко)

Docker предоставляет несколько сетевых режимов (network drivers), каждый из которых определяет, как контейнер взаимодействует с внешним миром и другими контейнерами.

🔹 Основные сетевые режимы
bridge - 🧱 По умолчанию. Контейнер получает IP в отдельной сети. Может выходить в интернет.
host - 🏠 Контейнер использует сетевой стек хоста напрямую (Linux only).
none - ❌ Полная изоляция. Контейнер без сети.
overlay - 🌐 Сети между хостами (в Docker Swarm или k8s).
macvlan - 📡 Контейнер получает отдельный IP, как устройство в сети. Требует продвинутой настройки.

🔹 Кастомная сеть: как связать контейнеры по имени
	1.	Создаёшь сеть: docker network create dev-net
	2.	Запускаешь два контейнера: --network=dev-net
	3.	Они могут обращаться друг к другу по имени (DNS внутри Docker)


 ## Ключевые команды:

- `docker network ls # Список сетей
docker network inspect bridge # Детали по сети
docker network create mynet # Создание кастомной сети
docker network rm mynet # Удаление`
- `docker run --network=bridge ...
docker run --network=host ...
docker run --network=none ...` 

---

### Задание

1. Создай три контейнера, каждый в своём сетевом режиме (bridge, host, none), и проверь доступность интернета и других контейнеров.

1. `Создай папку docker/07-network/`

```
mkdir 07-network | cd 07-network
```
2. `Запусти контейнер alpine в режиме bridge`

```
docker run -dit --network=bridge --name=bridge-test alpine sh
```
3. `Запусти alpine в режиме none`

```
docker run -dit --network=none --name=none-test alpine sh
```
4. `Запусти alpine в режиме host (только на Linux)`

```
docker run -dit --network=host --name=host-test alpine sh
```
5. `В каждом контейнере выполни ping 8.8.8.8`

```
docker exec -it 42038cab3be0 sh 
/ # apk update && ping -c 2 8.8.8.8
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/aarch64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/aarch64/APKINDEX.tar.gz
v3.21.3-480-gb04256b6954 [https://dl-cdn.alpinelinux.org/alpine/v3.21/main]
v3.21.3-482-gf091f8194f5 [https://dl-cdn.alpinelinux.org/alpine/v3.21/community]
OK: 25250 distinct packages available
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=63 time=351.664 ms
64 bytes from 8.8.8.8: seq=1 ttl=63 time=563.316 ms

--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 351.664/457.490/563.316 ms

docker exec -it 59e162742e7b sh
/ # apk update && ping -c 2 8.8.8.8
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/aarch64/APKINDEX.tar.gz
WARNING: updating and opening https://dl-cdn.alpinelinux.org/alpine/v3.21/main: temporary error (try again later)
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/aarch64/APKINDEX.tar.gz
WARNING: updating and opening https://dl-cdn.alpinelinux.org/alpine/v3.21/community: temporary error (try again later)
4 unavailable, 0 stale; 15 distinct packages available

docker exec -it 99cc7358240c sh
/ # apk update && ping -c 2 8.8.8.8
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/aarch64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/aarch64/APKINDEX.tar.gz
v3.21.3-480-gb04256b6954 [https://dl-cdn.alpinelinux.org/alpine/v3.21/main]
v3.21.3-482-gf091f8194f5 [https://dl-cdn.alpinelinux.org/alpine/v3.21/community]
OK: 25250 distinct packages available
PING 8.8.8.8 (8.8.8.8): 56 data bytes
64 bytes from 8.8.8.8: seq=0 ttl=64 time=429.227 ms
64 bytes from 8.8.8.8: seq=1 ttl=64 time=351.167 ms

--- 8.8.8.8 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 351.167/390.197/429.227 ms
```
6. `Проверь: в каком режиме есть доступ в интернет, а в каком — нет`

```
в режиме none нет сети 
```
7. `Создай сеть custom-net и запусти два контейнера`

```
docker network create custom-net
docker run -dit --network=custom-net --name=web alpine sh
docker run -dit --network=custom-net --name=db alpine sh
66dc922c4982cf41cef058369bdcdddfdd60d2fa716426f6222ce08d48f0642b
7b34ff25cf0a1922c44c8ba554511fbc6dd15ae56486480af3e6f17517cc00fa
b800c7ec6bcd4b3e8186787ed5b552274bd19b63206c847ad6ece744429ebe27
```
8. `Из web попробуй ping db — должен работать`

```
docker exec -it 7b34ff25cf0a sh 
/ # ping db
PING db (172.22.0.3): 56 data bytes
64 bytes from 172.22.0.3: seq=0 ttl=64 time=0.094 ms
64 bytes from 172.22.0.3: seq=1 ttl=64 time=0.169 ms
64 bytes from 172.22.0.3: seq=2 ttl=64 time=0.197 ms
64 bytes from 172.22.0.3: seq=3 ttl=64 time=0.179 ms
64 bytes from 172.22.0.3: seq=4 ttl=64 time=0.137 ms
64 bytes from 172.22.0.3: seq=5 ttl=64 time=0.178 ms
64 bytes from 172.22.0.3: seq=6 ttl=64 time=0.160 ms
64 bytes from 172.22.0.3: seq=7 ttl=64 time=0.159 ms
ç64 bytes from 172.22.0.3: seq=8 ttl=64 time=0.175 ms
64 bytes from 172.22.0.3: seq=9 ttl=64 time=0.175 ms
^C
--- db ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max = 0.094/0.162/0.197 ms
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Docker — Основы контейнеризации`" - `DOC-08 Практика: сборка и запуск веб-приложения`

 ### 🎯 Цель урока
НПрактика: сборка и запуск веб-приложения

---

 ## 📘 Теория (кратко)

В реальной разработке приложения часто состоят минимум из двух частей:
	•	Frontend (например, на React, Vue, HTML)
	•	Backend/API (например, на FastAPI, Django, Node.js)

Мы упакуем оба компонента в свои контейнеры, настроим проброс портов и обеспечим связку.

🔹 Общие принципы
	•	Каждый компонент = отдельный контейнер
	•	Общение — через одну сеть
	•	Управление — через Docker Compose

 ## Ключевые команды:

---

### Задание

1. Собери и запусти простое fullstack-приложение:
	•	Frontend — HTML-страница с fetch('/api')
	•	Backend — FastAPI, отдающий JSON
	•	Связь через Docker Compose

1. `Создай папку: docker/08-fullstack-app/`

```
mkdir 08-fullstack-app
```
2. `Внутри — 2 подпапки frontend и backend`

```
frontend/
└── index.html

backend/
└── main.py
└── Dockerfile
```
3. `index.html - <!DOCTYPE html>
<html>
  <body>
    <h1>Frontend: Fetch from Backend</h1>
    <div id="result">Loading...</div>
    <script>
      fetch('http://backend:8000/api')
        .then(res => res.json())
        .then(data => {
          document.getElementById('result').innerText = data.message;
        });
    </script>
  </body>
</html>`

```
Поле для вставки кода...
<!DOCTYPE html>
<html>
  <body>
    <h1>Frontend: Fetch from Backend</h1>
    <div id="result">Loading...</div>
  <script>
    fetch('/api')
      .then(res => res.json())
      .then(data => {
        document.getElementById('result').innerText = data.message;
      });
  </script>
  </body>
</html>
```
4. `main.py - from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.get("/api")
def read_root():
    return {"message": "Hello from Backend"}`

```
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"]
)

@app.get("/api")
def read_root():
    return {"message": "Hello from Backend"}
```
5. `Запусти`

```
version: '3.9'

services:
  backend:
    build: ./backend
    container_name: backend
    ports:
      - "8000:8000"

  frontend:
    image: nginx:alpine
    container_name: frontend
    volumes:
      - ./frontend:/usr/share/nginx/html
      - ./frontend/nginx.conf:/etc/nginx/nginx.conf
    ports:
      - "8089:80"
    depends_on:
      - backend
```
6. `Перейди в браузере на: http://localhost:8080 — и должен появиться ответ от бэкенда!`

```
curl http://localhost:8089/api
{"message":"Hello from Backend"}
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---




 ### 🎯 Цель урока
Научиться устанавливать Docker, запускать контейнеры, управлять ими и проверять их статус.

---

 ## 📘 Теория (кратко)

Docker — это инструмент для контейнеризации, позволяющий упаковывать приложение и его зависимости в единый образ.

 ## Ключевые команды:

- `docker run`, `docker ps`, `docker stop`, `docker rm`
- `docker images`, `docker exec` 

---

### Задание

1. Установи Docker (если не установлен)
2. Запусти контейнер с NGINX на порту 8080
3. Запусти контейнер с PostgreSQL
4. Убедись, что контейнеры работают
5. Останови и удали один из них

1. `Заполните здесь этапы выполнения, если требуется ....`

```
Поле для вставки кода...
....
....
....
....
```
2. `Заполните здесь этапы выполнения, если требуется ....`

```
Поле для вставки кода...
....
....
....
....
```
3. `Заполните здесь этапы выполнения, если требуется ....`

```
Поле для вставки кода...
....
....
....
....
```
4. `Заполните здесь этапы выполнения, если требуется ....`

```
Поле для вставки кода...
....
....
....
....
```
5. `Заполните здесь этапы выполнения, если требуется ....`

```
Поле для вставки кода...
....
....
....
....
```
6. `Заполните здесь этапы выполнения, если требуется ....`

```
Поле для вставки кода...
....
....
....
....
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---