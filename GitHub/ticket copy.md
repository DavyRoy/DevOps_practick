# Модуль "`GitHub Actions`" - `GHA-01 — Введение в GitHub Actions`

 ### 🎯 Цель урока
Понять, как устроены GitHub Actions

---

 ## 📘 Теория (кратко)

📂 Где живёт CI?

GitHub Actions читают YAML-файлы из каталога .github/workflows/.
Каждый .yml в этой папке — это workflow, который выполняется по определённому событию (push, pull_request и т.д.)

🛠 Основная структура файла workflow:
name: Имя воркфлоу

on: событие_триггер
jobs:
  имя_джоба:
    runs-on: runner
    steps:
      - name: шаг
        run: команда

🔑 Ключевые элементы:
name: Имя workflow (для читаемости в GitHub UI)
on: Событие, при котором запускается workflow (push, pull_request, schedule, и др.)
jobs: Логические блоки задач, которые могут запускаться параллельно или последовательно
runs-on: Тип runner’а (обычно ubuntu-latest)
steps: Последовательные шаги внутри job
run: Shell-команда для выполнения
uses: Использование стороннего действия (например, actions/checkout@v4)

🧠 Как это работает:
	•	GitHub Actions следит за событиями (on:).
	•	При совпадении события (push, pull_request) — запускается workflow.
	•	В jobs: описаны независимые блоки задач, исполняющиеся на runner-ах.
	•	В steps: находятся конкретные действия: shell-команды или сторонние actions.

 ## Ключевые команды:1

---

### Задание

1. Разверни минимальный workflow, который при каждом пуше:
	•	Выполняет checkout репозитория
	•	Выводит текущее время и приветствие в лог

1. `Создай новую ветку gha-01-basic-workflow`
```
git switch -c gha-01-basic-workflow
Switched to a new branch 'gha-01-basic-workflow'
```
2. `В папке .github/workflows/ создай файл basic.yml`
```
mkdir .github/workflows/
touch .github/workflows/basic.yml
```
3. `Опиши workflow по шаблону выше (используй run: и uses: шаги)`
```
`name: CI Pipeline

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print Hello and Date
        run: |
          echo "Привет! Сейчас: $(date '+%d.%m.%Y %H:%M')"
```
4. `Сделай git push — проверь, что workflow сработал`

```
git add .
git commit -m "new commit"
[gha-01-basic-workflow 746985d] new commit
 5 files changed, 1498 insertions(+), 940 deletions(-)
 create mode 100644 .github/ISSUE_TEMPLATE/workflows/basic.yml
 create mode 100644 GitHub/test copy.md
 delete mode 100644 GitHub/test.md
 create mode 100644 GitHub/ticket copy.md
 delete mode 100644 GitHub/ticket.md
git push -u origin gha-01-basic-workflow
Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 10 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (4/4), 408 bytes | 408.00 KiB/s, done.
Total 4 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/DavyRoy/DevOps_practick.git
   746985d..c4ea227  gha-01-basic-workflow -> gha-01-basic-workflow
branch 'gha-01-basic-workflow' set up to track 'origin/gha-01-basic-workflow'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
build
succeeded 9 minutes ago in 4s

0s
Current runner version: '2.323.0'
Operating System
Runner Image
Runner Image Provisioner
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download immutable action package 'actions/checkout@v4'
Complete job name: build
1s
Run actions/checkout@v4
Syncing repository: DavyRoy/DevOps_practick
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/4acc4139-13aa-4f28-850e-6c16ddc41bb1' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/DevOps_practick/DevOps_practick
Deleting the contents of '/home/runner/work/DevOps_practick/DevOps_practick'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
/usr/bin/git log -1 --format=%H
c4ea2274a198f461fafb6ba5001ea85a6e87c526
0s
Run echo "Привет! Сейчас: $(date '+%d.%m.%Y %H:%M')"
Привет! Сейчас: 15.05.2025 08:15
0s
Post job cleanup.
/usr/bin/git version
git version 2.49.0
Temporarily overriding HOME='/home/runner/work/_temp/4f3e3cd8-aa84-4030-bbf1-3ad269c0bcd9' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/DevOps_practick/DevOps_practick
/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
http.https://github.com/.extraheader
/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
0s
Cleaning up orphan processes
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`GitHub Actions`" - `GHA-02 Переменные, секреты и матрицы`

 ### 🎯 Цель урока
Переменные, секреты и матрицы

---

 ## 📘 Теория (кратко)

🔹 1. Переменные (env)

GitHub Actions поддерживает переменные окружения, которые можно определять:
	•	На уровне workflow: 
env:
  APP_ENV: production

	•	Внутри job или step:
jobs:
  build:
    runs-on: ubuntu-latest
    env:
      BUILD_MODE: release

	•	Внутри конкретного step:
      - name: Print mode
        run: echo "$BUILD_MODE"
        env:
          BUILD_MODE: debug
🔸 Также переменные можно переопределять на любом уровне.

🔐 2. Секреты (secrets)
	•	Хранятся в Settings → Secrets вашего репозитория.
	•	Доступны через ${{ secrets.MY_SECRET }}
Пример:
      - name: Login to DockerHub
        run: docker login -u ${{ secrets.DOCKER_USER }} -p ${{ secrets.DOCKER_PASS }}
⚠️ Никогда не логируй секреты с помощью echo.

🔁 3. Матрицы (matrix)

Позволяют запускать job несколько раз с разными параметрами:
jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        node: [14, 16, 18]
    steps:
      - run: echo "Testing with Node.js ${{ matrix.node }}"
📌 В этом примере:
	•	job выполнится 3 раза
	•	В каждой итерации matrix.node будет 14, 16 и 18

Можно передавать несколько параметров:
strategy:
  matrix:
    os: [ubuntu-latest, macos-latest]
    version: [1.0, 2.0]
👉 Будет 2×2 = 4 запусках job’а (все комбинации os + version)

 ## Ключевые команды:


---

### Задание

1. Создай новый workflow, который:
	•	Запускается при push
	•	Использует матрицу из 3-х параметров: "dev", "stage", "prod"
	•	Для каждого варианта:
	•	Печатает Текущий ENV: dev (и т.п.)
	•	Использует переменную APP_NAME
	•	(по желанию) — используй секрет SUPER_SECRET (можешь создать фиктивный)

1. `Создай новую ветку gha-02-matrix-env`

```
git switch -c gha-02-matrix-env
Switched to a new branch 'gha-02-matrix-env'
```
2. `Создай matrix.yml в .github/workflows/`

```
touch .github/workflows/matrix.yml
```
3. `Определи: •	env: переменную APP_NAME •	matrix: стратегию с env: [dev, stage, prod]`

```
name: CI Pipeline

on: [push]

env:
  APP_NAME: MyCoolApp

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        env: [dev, stage, prod]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Print Deploy
        run: echo "Deploying $APP_NAME to ${{ matrix.env }}"

      - name: Use secret
        run: echo "Secret доступен"
```
4. `Сделай git push — проверь, что workflow сработал`

```
 git push -u origin gha-02-matrix-env
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 10 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 479 bytes | 479.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   f9d5ef2..ed49aa4  gha-02-matrix-env -> gha-02-matrix-env
branch 'gha-02-matrix-env' set up to track 'origin/gha-02-matrix-env'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Run echo "Deploying $APP_NAME to dev"
Deploying MyCoolApp to dev

Run echo "Deploying $APP_NAME to stage"
Deploying MyCoolApp to stage

Run echo "Deploying $APP_NAME to prod"
Deploying MyCoolApp to prod

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitHub Actions`" - `GHA-03 Основы job-стратегий и условий выполнения`

 ### 🎯 Цель урока
Основы job-стратегий и условий выполнения (strategy + if)

---

 ## 📘 Теория (кратко)

GitHub Actions поддерживает гибкое управление выполнением задач с помощью:

📌 Условных операторов (if)

Позволяют выполнять шаги или job’ы только при выполнении условий: if: github.ref == 'refs/heads/main'
Примеры:
if: success() Выполнить, если предыдущие шаги успешны (по умолчанию)
if: failure() Выполнить, если предыдущие шаги завершились с ошибкой
if: github.actor == 'DavyRoy' Только если запустил указанный пользователь
if: matrix.env == 'prod' Выполнять шаг только для prod-окружения

📌 Стратегия fail-fast и max-parallel

strategy:
  fail-fast: false - Останавливает все job’ы, если одна упала (true по умолчанию)
  max-parallel: 2 - Число job’ов, выполняемых параллельно

📌 Условие на шаг (step) vs job:

jobs:
  deploy:
    if: github.ref == 'refs/heads/main' # условие на весь job
    ...
    steps:
      - name: Only on prod
        if: matrix.env == 'prod'


 ## Ключевые команды:


---

### Задание

1. Создай workflow, который:
	•	Запускается по push
	•	Имеет матрицу окружений: dev, stage, prod
	•	Выполняет:
	•	echo "Деплой на ..." во всех
	•	Дополнительный step только для prod с echo "!!! Production deploy !!!"
	•	Добавь fail-fast: false
	•	Установи max-parallel: 1


1. `Создай новую ветку gha-03-conditional-prod`

```
git switch -c gha-03-conditional-prod
Switched to a new branch 'gha-03-conditional-prod'
```
2. `Файл .github/workflows/conditional.yml`

```
touch .github/workflows/conditional.yml

```
3. `Используй matrix.env: [dev, stage, prod]`

```

```
4. `Добавь: •	if: matrix.env == 'prod' для спец-шагов •	Параметры fail-fast, max-parallel в стратегии`

```
name: CI Pipeline

on: [push]

env:
  APP_NAME: ConditionalAPP

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      max-parallel: 1
      matrix:
        env: [dev, stage, prod]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Диплой всех окружений
        run: echo "Диплой $APP_NAME на ${{ matrix.env }}"

      - name: Only on prod
        if: matrix.env == 'prod'
        run: echo "!!! Production deploy !!!"
```
5. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-02-matrix-env
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 10 threads
Compressing objects: 100% (5/5), done.
Writing objects: 100% (5/5), 479 bytes | 479.00 KiB/s, done.
Total 5 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   f9d5ef2..ed49aa4  gha-02-matrix-env -> gha-02-matrix-env
branch 'gha-02-matrix-env' set up to track 'origin/gha-02-matrix-env'.
```
6. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Run echo "Диплой $APP_NAME на dev"
Диплой ConditionalAPP на dev

Run echo "Диплой $APP_NAME на stage"
Диплой ConditionalAPP на stage

Run echo "Диплой $APP_NAME на prod"
Диплой ConditionalAPP на prod
0s
Run echo "!!! Production deploy !!!"
!!! Production deploy !!!
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitHub Actions`" - `GHA-04 — CI-пайплайн: линтинг, тесты, артефакты`

 ### 🎯 Цель урока
CI-пайплайн: линтинг, тесты, артефакты

---

 ## 📘 Теория (кратко)

Цель любого CI-пайплайна — автоматическая проверка кода перед мержем или деплоем. Классическая структура пайплайна:
	1.	Lint — проверка стиля (например, eslint, flake8, yamllint)
	2.	Test — юнит-тесты, интеграционные тесты (pytest, jest, go test, и т.п.)
	3.	Build / Артефакты — создание артефактов (например, бинарников, отчётов о тестах и пр.)

📌 Как сохранять артефакты в GitHub Actions?
- name: Save build artifacts
  uses: actions/upload-artifact@v4
  with:
    name: my-artifacts
    path: ./build/
🔹 Файл или папка ./build/ будет доступна для скачивания из вкладки Artifacts в интерфейсе Actions.

🛠 Пример CI:
jobs:
  lint:
    steps:
      - run: flake8 app/
  test:
    steps:
      - run: pytest tests/
  build:
    steps:
      - run: make build
      - uses: actions/upload-artifact@v4
        with:
          name: binary
          path: ./dist/


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