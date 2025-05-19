# Модуль "`GitLab CI/CD`" - `GLCI-01.1 — Первый pipeline на GitLab`

 ### 🎯 Цель урока
Понять, как устроены GitHub Actions

---

 ## 📘 Теория (кратко)

🔹 Что такое GitLab CI/CD?

GitLab CI/CD — это встроенная система непрерывной интеграции и доставки в GitLab. Она позволяет:
	•	автоматически собирать, тестировать и разворачивать приложение,
	•	запускать пайплайны при каждом коммите,
	•	строить сложные цепочки этапов: от linting до production-деплоя.

CI (Continuous Integration) — проверка и сборка при каждом изменении
CD (Continuous Delivery / Deployment) — автоматическое выкатывание в staging / prod

⸻

🔹 Как это работает?

GitLab CI/CD использует специальный файл — .gitlab-ci.yml, который размещается в корне репозитория.

⛓️ Основные элементы .gitlab-ci.yml:
stages Определяет этапы (build, test, deploy и т.д.)
job_name Название задачи (job), например build_app
script Набор команд, которые будут выполнены
only, rules Условия, при которых будет запущена job
artifacts Что сохранять после выполнения job
image Docker-образ окружения (например, node:18)
before_script, after_script Общие команды до/после каждой job

🧭 Пример базового .gitlab-ci.yml
stages:
  - build
  - test

build_app:
  stage: build
  script:
    - echo "Сборка проекта"
    - npm install

test_app:
  stage: test
  script:
    - echo "Запуск тестов"
    - npm test

🛠 Runner’ы

GitLab CI использует Runner’ы — это агенты, которые запускают твои job’ы.
	•	Shared runners — общие, предоставленные GitLab.
	•	Custom runners — приватные, разворачиваются DevOps-инженером (будем проходить позже).

⸻

📊 Сценарии использования GitLab CI/CD:
	•	Сборка и тестирование при каждом коммите.
	•	Автоматическое выкладывание Docker-образов в GitLab Registry.
	•	Автодеплой на staging и production.
	•	Генерация и публикация отчетов о тестах, покрытии и безопасности.


 ## Ключевые команды:1

---

### Задание

1. Создай .gitlab-ci.yml, который:
	•	содержит 2 стадии: build и test
	•	включает 2 job’ы:
	•	build_app — выводит echo "Building App"
	•	test_app — выводит echo "Running tests"

1. `Создай новый GitLab-проект (или используй уже созданный).`
```
mkdir GLCI_01
cd GLCI_01
```
2. `Создай файл .gitlab-ci.yml в корне.`
```
touch .gitlab-ci.yml
```
3. `Пропиши структуру пайплайна
`
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
git push -u origin main
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 10 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 288 bytes | 288.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
To http://gitlab.local/root/docker.git
   0c02029..b0307cb  main -> main
branch 'main' set up to track 'origin/main'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Getting source from Git repository
00:03
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/root/docker/.git/
Created fresh repository.
Checking out b0307cb2 as detached HEAD (ref is main)...
Skipping Git submodules setup

Executing "step_script" stage of the job script
00:00
Using effective pull policy of [always] for container alpine:latest
Using docker image sha256:8d591b0b7dea080ea3be9e12ae563eebf9869168ffced1cb25b2470a3d9fe15e for alpine:latest with digest alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c ...
$ echo "Building App"
Building App

Cleaning up project directory and file based variables
00:01
Job succeeded

Preparing environment
00:00
Using effective pull policy of [always] for container sha256:baa6d10c5c05b5a531bb23e95913868e9b39130923ded43f41f7086f90738243
Running on runner-8dzmwvfox-project-1-concurrent-0 via MacBook-Pro-Sergey.local...

Getting source from Git repository
00:01
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/root/docker/.git/
Created fresh repository.
Checking out b0307cb2 as detached HEAD (ref is main)...
Skipping Git submodules setup

Executing "step_script" stage of the job script
00:01
Using effective pull policy of [always] for container alpine:latest
Using docker image sha256:8d591b0b7dea080ea3be9e12ae563eebf9869168ffced1cb25b2470a3d9fe15e for alpine:latest with digest alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c ...
$ echo "Running tests"
Running tests

Cleaning up project directory and file based variables
00:00
Job succeeded
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`GitLab CI/CD`" - `GLCI-02 Структура pipeline: stages, jobs`

 ### 🎯 Цель урока
Структура pipeline: stages, jobs и их последовательность

---

 ## 📘 Теория (кратко)

🔹 Что такое pipeline?

Pipeline — это последовательность шагов, которые GitLab выполняет автоматически: сборка, тестирование, публикация, деплой.

Он состоит из:
	•	stages (этапы) — логические блоки (build, test, deploy)
	•	jobs (задачи) — конкретные действия в этих блоках

⸻

🔹 Что такое stage?

stages: — это очерёдность выполнения:
stages:
  - build
  - test
  - deploy
	•	Выполняются по порядку сверху вниз
	•	Jobs одного stage выполняются параллельно
	•	Следующий stage начинается только после завершения предыдущего

🔹 Что такое job?

Job — это единица работы: запуск тестов, установка зависимостей, билд, деплой.
Каждая job:
	•	привязана к stage
	•	выполняет один или несколько script-команд
  install_dependencies:
  stage: build
  script:
    - npm ci

run_tests:
  stage: test
  script:
    - npm test

📊 Схема пайплайна:
stages: [build, test, deploy]

     install      →     test         →      deploy_prod
  (job: build)     (job: test)            (job: deploy)
Если один из jobs на этапе упал — весь pipeline останавливается.

🧠 Советы
	•	stages — всегда в начале .gitlab-ci.yml
	•	Названия job’ов могут быть любыми, но stage — нет (важен порядок!)
	•	В одной стадии можно запускать несколько jobs параллельно

🧪 Расширенный пример:
stages:
  - install
  - lint
  - test
  - deploy

install_deps:
  stage: install
  script:
    - npm ci

lint_code:
  stage: lint
  script:
    - npm run lint

unit_tests:
  stage: test
  script:
    - npm run test

deploy_app:
  stage: deploy
  script:
    - echo "Deploying app"


 ## Конспект:
 🧱 Структура GitLab CI/CD:
- pipeline = stages + jobs

🔹 stages:
- Выполняются последовательно (сверху вниз)
- Определяют порядок работы pipeline

🔹 jobs:
- Привязаны к stage
- Выполняются параллельно внутри одного stage
- Содержат команды в script

📌 Ошибка в любой job — останавливает весь pipeline

---

### Задание

1. Создай .gitlab-ci.yml, в котором:
	•	Объявлены stages: install, lint, test
	•	Есть 3 job’а:
	•	install_deps — устанавливает зависимости (npm ci)
	•	lint_code — линтит код (npm run lint)
	•	run_tests — запускает тесты (npm test)

1. `Обнови файл .gitlab-ci.yml в проекте.`

```
image: node:18

stages:
  - install
  - lint
  - test

install_deps:
  stage: install
  script:
    - npm ci

lint_code:
  stage: lint
  before_script:
    - npm ci
  script:
    - npm run lint

run_tests:
  stage: test
  script:
    - npm test
```
2. `Сделай commit и push.`

```
git push -u origin main
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 10 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 360 bytes | 360.00 KiB/s, done.
Total 3 (delta 2), reused 0 (delta 0), pack-reused 0
To http://gitlab.local/root/docker.git
   d7bdf64..4c3e952  main -> main
branch 'main' set up to track 'origin/main'.
```
3. `Убедись, что pipeline запускается, и job’ы выполняются в нужном порядке.`

```
Preparing environment
00:00
Using effective pull policy of [always] for container sha256:baa6d10c5c05b5a531bb23e95913868e9b39130923ded43f41f7086f90738243
Running on runner-8dzmwvfox-project-1-concurrent-0 via MacBook-Pro-Sergey.local...

Getting source from Git repository
00:02
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/root/docker/.git/
Created fresh repository.
Checking out 4c3e9526 as detached HEAD (ref is main)...
Skipping Git submodules setup

Executing "step_script" stage of the job script
00:09
Using effective pull policy of [always] for container node:18
Using docker image sha256:d8e077204fde4cbcd3a508ae19860c3ed2e98293a7e837bf2de23d871286d9ac for node:18 with digest node@sha256:867be01f97d45cb7d89a8ef0b328d23e8207412ebec4564441ed8cabc8cc4ecd ...
$ npm ci
added 231 packages, and audited 232 packages in 9s
115 packages are looking for funding
  run npm fund for details
found 0 vulnerabilities

Cleaning up project directory and file based variables
00:00
Job succeeded

Preparing environment
00:01
Using effective pull policy of [always] for container sha256:baa6d10c5c05b5a531bb23e95913868e9b39130923ded43f41f7086f90738243
Running on runner-8dzmwvfox-project-1-concurrent-0 via MacBook-Pro-Sergey.local...

Getting source from Git repository
00:01
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/root/docker/.git/
Created fresh repository.
Checking out 4c3e9526 as detached HEAD (ref is main)...
Removing node_modules/
Skipping Git submodules setup

Executing "step_script" stage of the job script
00:11
Using effective pull policy of [always] for container node:18
Using docker image sha256:d8e077204fde4cbcd3a508ae19860c3ed2e98293a7e837bf2de23d871286d9ac for node:18 with digest node@sha256:867be01f97d45cb7d89a8ef0b328d23e8207412ebec4564441ed8cabc8cc4ecd ...
$ npm ci
added 231 packages, and audited 232 packages in 9s
115 packages are looking for funding
  run npm fund for details
found 0 vulnerabilities
$ npm run lint
> gitlab@1.0.0 lint
> eslint .
Warning: React version not specified in eslint-plugin-react settings. See https://github.com/jsx-eslint/eslint-plugin-react#configuration .

Cleaning up project directory and file based variables
00:01
Job succeeded

Preparing environment
00:00
Using effective pull policy of [always] for container sha256:baa6d10c5c05b5a531bb23e95913868e9b39130923ded43f41f7086f90738243
Running on runner-8dzmwvfox-project-1-concurrent-0 via MacBook-Pro-Sergey.local...

Getting source from Git repository
00:01
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/root/docker/.git/
Created fresh repository.
Checking out 4c3e9526 as detached HEAD (ref is main)...
Removing node_modules/
Skipping Git submodules setup

Executing "step_script" stage of the job script
00:01
Using effective pull policy of [always] for container node:18
Using docker image sha256:d8e077204fde4cbcd3a508ae19860c3ed2e98293a7e837bf2de23d871286d9ac for node:18 with digest node@sha256:867be01f97d45cb7d89a8ef0b328d23e8207412ebec4564441ed8cabc8cc4ecd ...
$ npm test
> gitlab@1.0.0 test
> echo "✅ Тесты пока не настроены, но CI работает!"
✅ Тесты пока не настроены, но CI работает!

Cleaning up project directory and file based variables
00:00
Job succeeded
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-03 Runner’ы и переменные`

 ### 🎯 Цель урока
Runner’ы и переменные в GitLab CI/CD

---

 ## 📘 Теория (кратко)

🔹 Что такое Runner?

Runner — это агент, который выполняет job’ы из .gitlab-ci.yml.

📦 Виды runner’ов:
Shared - На серверах GitLab - GitLab
Group - Установлен на уровне группы - Вы
Project - Только для одного проекта - Вы

Shared — удобны для начала, но кастомные позволяют тонко настроить окружение.

🔹 Архитектура пайплайна
.gitlab-ci.yml  →  GitLab CI Engine  →  Runner  →  Выполнение job
	•	GitLab CI запускает pipeline
	•	Находит подходящий runner
	•	Runner забирает job и запускает команды в изолированной среде (чаще всего — Docker)

🛠 Пример запуска в Docker:
job:
  script: echo Hello
  tags:
    - docker
Runner должен быть зарегистрирован с соответствующим tag: docker.

🔐 Переменные в GitLab CI/CD

CI/CD переменные — это способ передавать настройки, секреты и пути в pipeline без хардкода.

📑 Где задаются переменные:
	•	В GitLab UI → Settings → CI/CD → Variables
	•	В .gitlab-ci.yml (только простые, не секретные)
	•	Через .env-файлы (в продвинутых случаях)

🔍 Пример:
variables:
  NODE_ENV: production

deploy_job:
  script:
    - echo "Deploying in $NODE_ENV mode"

🔐 Типы переменных:
Переменные проекта - Через UI, доступны во всех job
Protected - Работают только в protected-ветках
Masked - Не выводятся в логи (например, токены)
File - Значение сохраняется во временный файл

🧠 Полезные переменные GitLab
CI_COMMIT_BRANCH - Текущая ветка
CI_PIPELINE_ID - ID текущего pipeline
CI_JOB_STAGE - Название текущего stage
CI_REGISTRY_IMAGE - Ссылка на GitLab Container Registry


 ## Конспект:
🔧 GitLab Runner:
- Shared: по умолчанию, управляется GitLab
- Custom: можно разворачивать на своих серверах (Docker, SSH, Shell)
- Runner = агент, исполняющий job

🔐 Переменные:
- Назначаются через UI или .gitlab-ci.yml
- Используются в скриптах: $MY_VAR
- Типы: обычные, protected, masked, file


---

### Задание

1. Создай .gitlab-ci.yml, который:
	•	использует кастомную переменную APP_MODE
	•	выводит её в job’е print_mode
	•	использует встроенную переменную CI_COMMIT_BRANCH

Дополнительно — добавь тег runner’а (например, docker), даже если он не обязателен.


1. `Перейди в GitLab UI: Settings → CI/CD → Variables → создай переменную APP_MODE = development.`

```

```
2. `Обнови .gitlab-ci.yml`

```
image: node:18

stages:
  - info

print_mode:
  stage: info
  tags:
    - docker
  script:
    - echo "APP_MODE is $APP_MODE"
    - echo "Current branch is $CI_COMMIT_BRANCH"


```
3. `Используй matrix.env: [dev, stage, prod]`

```
Preparing environment
00:00
Using effective pull policy of [always] for container sha256:baa6d10c5c05b5a531bb23e95913868e9b39130923ded43f41f7086f90738243
Running on runner-8dzmwvfox-project-1-concurrent-0 via MacBook-Pro-Sergey.local...

Getting source from Git repository
00:02
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/root/docker/.git/
Created fresh repository.
Checking out 79ea67c7 as detached HEAD (ref is main)...
Skipping Git submodules setup

Executing "step_script" stage of the job script
00:00
Using effective pull policy of [always] for container node:18
Using docker image sha256:d8e077204fde4cbcd3a508ae19860c3ed2e98293a7e837bf2de23d871286d9ac for node:18 with digest node@sha256:867be01f97d45cb7d89a8ef0b328d23e8207412ebec4564441ed8cabc8cc4ecd ...
$ echo "APP_MODE is $APP_MODE"
APP_MODE is development
$ echo "Current branch is $CI_COMMIT_BRANCH"
Current branch is main

Cleaning up project directory and file based variables
00:00
Job succeeded
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `GLCI-04 Conditions и only/except / rules`

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

1. Создай CI workflow, который:
	•	Запускается при push в любую ветку
	•	Делает:
	•	Линтинг — проверь синтаксис *.yml файлов (например, yamllint)
	•	Тест — симулируй тестирование (команда echo "Тесты пройдены")
	•	Build — создай папку build/ с каким-то файлом (например, touch build/app.txt)
	•	Загрузи build/ как артефакт

1. `Ветка: gha-04-ci-pipeline`

```
git switch -c gha-04-ci-pipeline
Switched to a new branch 'gha-04-ci-pipeline'
```
2. `Файл: .github/workflows/ci.yml`

```
touch .github/workflows/ci.yml
```
3. `Стадии: lint, test, build — как отдельные job, Используй upload-artifact только в job build, Линт — можешь установить yamllint (pip install yamllint) или сделать echo "Lint passed" — главное структура`

```
---
name: CI Pipeline

on:
  push:


jobs:
  lint:
    name: Линтинг YAML файлов
    runs-on: ubuntu-latest
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Проверка синтаксиса YAML (симулированная)
        run: |
           sudo apt update
           sudo apt install -y python3-pip
           pip install yamllint
           yamllint .

  test:
    name: Тестирование
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Запускаем тесты (симуляция)
        run: echo "Тесты пройдены"

  build:
    name: Сборка
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Создаём папку build/ и файл
        run: |
          mkdir -p build
          echo "Hello from build" > build/app.txt

      - name: Загружаем артефакт
        uses: actions/upload-artifact@v4
        with:
          name: build-artifact
          path: build/

```
4. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-04-ci-pipeline
Enumerating objects: 26, done.
Counting objects: 100% (26/26), done.
Delta compression using up to 10 threads
Compressing objects: 100% (13/13), done.
Writing objects: 100% (14/14), 1.26 KiB | 1.26 MiB/s, done.
Total 14 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   b55b770..adaba9e  gha-04-ci-pipeline -> gha-04-ci-pipeline
branch 'gha-04-ci-pipeline' set up to track 'origin/gha-04-ci-pipeline'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Reading package lists...
Building dependency tree...
Reading state information...
python3-pip is already the newest version (24.0+dfsg-1ubuntu1.1).
0 upgraded, 0 newly installed, 0 to remove and 16 not upgraded.
Defaulting to user installation because normal site-packages is not writeable
Collecting yamllint
  Downloading yamllint-1.37.1-py3-none-any.whl.metadata (4.3 kB)
Collecting pathspec>=0.5.3 (from yamllint)
  Downloading pathspec-0.12.1-py3-none-any.whl.metadata (21 kB)
Requirement already satisfied: pyyaml in /usr/lib/python3/dist-packages (from yamllint) (6.0.1)
Downloading yamllint-1.37.1-py3-none-any.whl (68 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 68.8/68.8 kB 9.4 MB/s eta 0:00:00
Downloading pathspec-0.12.1-py3-none-any.whl (31 kB)
Installing collected packages: pathspec, yamllint
Successfully installed pathspec-0.12.1 yamllint-1.37.1
./.github/workflows/matrix.yml

./.github/workflows/ci.yml

./.github/workflows/conditional.yml

./.github/workflows/basic.yml

Run echo "Тесты пройдены"
Тесты пройдены

Run mkdir -p build
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-05 — Деплой и кастомные действия (actions)`

 ### 🎯 Цель урока
Деплой и кастомные действия (actions)

---

 ## 📘 Теория (кратко)

🔹 Деплой в CI/CD

Под “деплоем” в GitHub Actions обычно понимается:
	•	пуш в DockerHub / GitHub Container Registry
	•	деплой в Kubernetes, облако, FTP, сервер и т.д.

🧠 Сам деплой может быть:
	•	Через обычный run: ...
	•	Через сторонние готовые actions
	•	Через кастомные actions, написанные под проект

🔹 Готовые actions (из маркетплейса)

Пример: деплой на FTP
- name: Deploy via FTP
  uses: SamKirkland/FTP-Deploy-Action@v4
  with:
    server: ftp.example.com
    username: ${{ secrets.FTP_USER }}
    password: ${{ secrets.FTP_PASS }}

🔹 Кастомные actions (свои)

Ты можешь создать свою action:
	•	В формате Docker (исполняется в контейнере)
	•	В формате JavaScript (исполняется прямо в раннере)

📁 Структура:
/my-action
  └── action.yml
  └── entrypoint.sh

🧾 action.yml (пример shell-скрипта):
name: Hello Action
description: Prints Hello
runs:
  using: "docker"
  image: "Dockerfile"

🧾 Dockerfile:
FROM alpine
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

🧾 entrypoint.sh:
#!/bin/sh
echo "Hello from custom action!"

 ## Ключевые команды:

---

### Задание

1. Создай кастомную action на shell (через Docker), которая:
	•	Выводит сообщение: 📦 Deploying $APP_NAME to $ENV

Создай workflow, который:
	•	Запускается по push
	•	Передаёт в action переменные APP_NAME и ENV
	•	Вызывает кастомную action из поддиректории .github/actions/deploy

1. `Ветка: gha-05-custom-deploy`

```
git switch -c gha-05-custom-deploy
Switched to a new branch 'gha-05-custom-deploy'
```
2. `Создай структуру`

```
.github/
  workflows/ci-deploy.yml
  actions/deploy/
    Dockerfile
    entrypoint.sh
    action.yml
```
3. `Кастомная action должна принимать input-параметры: •	app_name •	env`

```

```
4. `В workflow передай эти параметры в uses: ./github/actions/deploy`

```
.github/actions/deploy/entrypoint.sh
---
#!/bin/sh
echo "📦 Deploying $APP_NAME to $ENV"

 .github/actions/deploy/Dockerfile
 ---
 FROM alpine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

.github/actions/deploy/action.yml
---
name: Hello Deploy Action
description: Кастомная action для вывода деплоя

inputs:
  app_name:
    description: Название приложения
    required: true
  env:
    description: Окружение
    required: true

runs:
  using: "docker"
  image: "Dockerfile"
  env:
    APP_NAME: ${{ inputs.app_name }}
    ENV: ${{ inputs.env }}

 .github/workflows/ci-deploy.yml
 ---
 name: Deploy Workflow

on:
  push:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy via custom action
        uses: ./github/actions/deploy
        with:
          app_name: MyCoolApp
          env: stage
```
5. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-05-custom-deploy

Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 10 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 421 bytes | 421.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   9b7b60a..204ffc0  gha-05-custom-deploy -> gha-05-custom-deploy
branch 'gha-05-custom-deploy' set up to track 'origin/gha-05-custom-deploy'.
```
6. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name e9dfd6c852384a3524454c9d77e2e9bf2fbae5_0e4e7c --label e9dfd6 --workdir /github/workspace --rm -e "INPUT_APP_NAME" -e "INPUT_ENV" -e "APP_NAME" -e "ENV" -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" e9dfd6:c852384a3524454c9d77e2e9bf2fbae5
📦 Deploying MyCoolApp to stage
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `DOC-GHA-01 Автосборка Docker-образа по пушу`

 ### 🎯 Цель урока
Как работает автосборка Docker-образа через GitHub Actions
---

 ## 📘 Теория (кратко)

🔹 Общая идея:

GitHub Actions позволяет запускать CI/CD-процессы при событиях в репозитории. В случае Docker-сборки — при каждом пуше GitHub может:
	•	Проверить код
	•	Собрать Docker-образ
	•	Потестировать его
	•	Отправить в DockerHub или другой реестр

🔹 Основные компоненты:
.github/workflows/*.ymlОписание пайплайна
on: Триггер (например, push, pull_request)
jobs: Список задач, которые выполняются
runs-on: Указывает ОС runner-а (например, ubuntu-latest)
steps: Последовательность шагов внутри job-а

🔹 Как происходит сборка Docker-образа
	1.	Получение кода — GitHub сам клонирует репозиторий.
	2.	Установка Docker — runner использует Ubuntu с предустановленным Docker.
	3.	Сборка образа — docker build -t имя .
	4.	(опционально) Push — docker push требует логина в реестр (будет в следующем юните)

⸻

🔹 Что важно учитывать:
	•	GitHub Actions не работает “по крону” сам по себе — нужны события: push, pull_request, workflow_dispatch (ручной запуск).
	•	Runner’ы имеют ограничения по ресурсам (CPU, RAM) и времени выполнения (обычно 6 часов для public repo).
	•	Переменные и секреты задаются в разделе Settings → Secrets репозитория.
	•	GitHub Actions можно запускать вручную или автоматически, и это позволяет внедрить инфраструктуру как код даже на уровне CI.


 ## Ключевые команды:


---

### Задание

1. Настрой автоматическую сборку Docker-образа при пуше в репозиторий.
Workflow должен запускаться при любом коммите в ветку main.
Цель — убедиться, что образ успешно собирается на CI, но не пушится в DockerHub (ещё рано).

1. `Создай .github/workflows/docker-build.yml.`

```
touch .github/workflows/docker-build.yml
```
2. `Укажи событие push в ветку main.`

```

```
3. `Добавь job на базе ubuntu-latest.`

```

```
4. `Добавь step для сборки Docker-образа из Dockerfile в корне репозитория.`

```
nano .github/workflows/docker-build.yml
name: Build Docker image

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t test-image:latest ./.github/actions/deploy

```

5. `Убедись, что workflow проходит после коммита.`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name ccc482fb2784ff45f69a94bb5eb091235c_985deb --label 0443cc --workdir /github/workspace --rm -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" 0443cc:c482fb2784ff45f69a94bb5eb091235c
Hello from the deploy action!
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `DOC-GHA-03 Разделение build и push по шагам`

 ### 🎯 Цель урока
Зачем разделять build и push в GitHub Actions

---

 ## 📘 Теория (кратко)

🔹 Почему нельзя всё в одном шаге?

Сборка и публикация — это разные стадии CI/CD:
	•	build — можно кэшировать, использовать как артефакт, проверять на ошибки.
	•	push — требует внешнего взаимодействия, секретов и даёт побочный эффект (меняет внешний реестр).

Разделение даёт:
	•	🧪 Гибкость: можно выполнять тесты между build и push.
	•	🔒 Безопасность: push выполняется только при определённых условиях (например, из main, из PR с одобрением и т.д.).
	•	💨 Кэширование и многопоточность: docker/build-push-action умеет собирать быстрее через buildx.

🔹 Используемые экшены:
- uses: docker/setup-buildx-action@v3
- uses: docker/login-action@v3
- uses: docker/build-push-action@v5

🔹 Стратегия:
      - name: Build (only)
        uses: docker/build-push-action@v5
        with:
          push: false

      - name: Push (only)
        uses: docker/build-push-action@v5
        with:
          push: true
🔹 Пример сценария:
	1.	Выполняем build → проверяем → если всё хорошо, push.
	2.	Это удобно при pull request’ах: build делается, но push разрешён только в main.



 ## Ключевые команды:

---

### Задание

1. Настрой .github/workflows/docker-release.yml, в котором:
	•	При пуше в main происходит сборка образа,
	•	Потом (в отдельном step-е) — публикация его в DockerHub.

Оба шага должны быть чётко разделены, и между ними можно будет вставить шаг проверки или echo.

1. `Создай workflow docker-release.yml.`

```
touch docker-release.yml
```
2. `Используй docker/setup-buildx-action для подготовки билдера.`

```

```
3. `Первый шаг — build образа, но без пуша (push: false).`

```

```
4. `Второй шаг — push образа в DockerHub, используй secrets.`

```

```
5. `Теги: yourusername/appname:latest`

```
name: Docker Release

on:
  push:
    branches:
      - main  # только при пуше в main

jobs:
  docker-release:
    name: 🐳 Build & Push Docker Image
    runs-on: ubuntu-latest

    steps:
      - name: 📥 Checkout repo
        uses: actions/checkout@v3

      - name: 🔧 Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: 🔐 Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: 🛠️ Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: yourusername/appname:latest
          outputs: type=docker  # локальный образ для следующего шага

      - name: ✅ Проверка после сборки
        run: echo "Образ успешно собран. Переходим к публикации..."

      - name: 📤 Push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: yourusername/appname:latest
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-01 — Введение в GitHub Actions`

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



# Модуль "`GitLab CI/CD`" - `GHA-02 Переменные, секреты и матрицы`

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


# Модуль "`GitLab CI/CD`" - `GHA-03 Основы job-стратегий и условий выполнения`

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

# Модуль "`GitLab CI/CD`" - `GHA-04 — CI-пайплайн: линтинг, тесты, артефакты`

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

1. Создай CI workflow, который:
	•	Запускается при push в любую ветку
	•	Делает:
	•	Линтинг — проверь синтаксис *.yml файлов (например, yamllint)
	•	Тест — симулируй тестирование (команда echo "Тесты пройдены")
	•	Build — создай папку build/ с каким-то файлом (например, touch build/app.txt)
	•	Загрузи build/ как артефакт

1. `Ветка: gha-04-ci-pipeline`

```
git switch -c gha-04-ci-pipeline
Switched to a new branch 'gha-04-ci-pipeline'
```
2. `Файл: .github/workflows/ci.yml`

```
touch .github/workflows/ci.yml
```
3. `Стадии: lint, test, build — как отдельные job, Используй upload-artifact только в job build, Линт — можешь установить yamllint (pip install yamllint) или сделать echo "Lint passed" — главное структура`

```
---
name: CI Pipeline

on:
  push:


jobs:
  lint:
    name: Линтинг YAML файлов
    runs-on: ubuntu-latest
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Проверка синтаксиса YAML (симулированная)
        run: |
           sudo apt update
           sudo apt install -y python3-pip
           pip install yamllint
           yamllint .

  test:
    name: Тестирование
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Запускаем тесты (симуляция)
        run: echo "Тесты пройдены"

  build:
    name: Сборка
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Создаём папку build/ и файл
        run: |
          mkdir -p build
          echo "Hello from build" > build/app.txt

      - name: Загружаем артефакт
        uses: actions/upload-artifact@v4
        with:
          name: build-artifact
          path: build/

```
4. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-04-ci-pipeline
Enumerating objects: 26, done.
Counting objects: 100% (26/26), done.
Delta compression using up to 10 threads
Compressing objects: 100% (13/13), done.
Writing objects: 100% (14/14), 1.26 KiB | 1.26 MiB/s, done.
Total 14 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   b55b770..adaba9e  gha-04-ci-pipeline -> gha-04-ci-pipeline
branch 'gha-04-ci-pipeline' set up to track 'origin/gha-04-ci-pipeline'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Reading package lists...
Building dependency tree...
Reading state information...
python3-pip is already the newest version (24.0+dfsg-1ubuntu1.1).
0 upgraded, 0 newly installed, 0 to remove and 16 not upgraded.
Defaulting to user installation because normal site-packages is not writeable
Collecting yamllint
  Downloading yamllint-1.37.1-py3-none-any.whl.metadata (4.3 kB)
Collecting pathspec>=0.5.3 (from yamllint)
  Downloading pathspec-0.12.1-py3-none-any.whl.metadata (21 kB)
Requirement already satisfied: pyyaml in /usr/lib/python3/dist-packages (from yamllint) (6.0.1)
Downloading yamllint-1.37.1-py3-none-any.whl (68 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 68.8/68.8 kB 9.4 MB/s eta 0:00:00
Downloading pathspec-0.12.1-py3-none-any.whl (31 kB)
Installing collected packages: pathspec, yamllint
Successfully installed pathspec-0.12.1 yamllint-1.37.1
./.github/workflows/matrix.yml

./.github/workflows/ci.yml

./.github/workflows/conditional.yml

./.github/workflows/basic.yml

Run echo "Тесты пройдены"
Тесты пройдены

Run mkdir -p build
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-05 — Деплой и кастомные действия (actions)`

 ### 🎯 Цель урока
Деплой и кастомные действия (actions)

---

 ## 📘 Теория (кратко)

🔹 Деплой в CI/CD

Под “деплоем” в GitHub Actions обычно понимается:
	•	пуш в DockerHub / GitHub Container Registry
	•	деплой в Kubernetes, облако, FTP, сервер и т.д.

🧠 Сам деплой может быть:
	•	Через обычный run: ...
	•	Через сторонние готовые actions
	•	Через кастомные actions, написанные под проект

🔹 Готовые actions (из маркетплейса)

Пример: деплой на FTP
- name: Deploy via FTP
  uses: SamKirkland/FTP-Deploy-Action@v4
  with:
    server: ftp.example.com
    username: ${{ secrets.FTP_USER }}
    password: ${{ secrets.FTP_PASS }}

🔹 Кастомные actions (свои)

Ты можешь создать свою action:
	•	В формате Docker (исполняется в контейнере)
	•	В формате JavaScript (исполняется прямо в раннере)

📁 Структура:
/my-action
  └── action.yml
  └── entrypoint.sh

🧾 action.yml (пример shell-скрипта):
name: Hello Action
description: Prints Hello
runs:
  using: "docker"
  image: "Dockerfile"

🧾 Dockerfile:
FROM alpine
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

🧾 entrypoint.sh:
#!/bin/sh
echo "Hello from custom action!"

 ## Ключевые команды:

---

### Задание

1. Создай кастомную action на shell (через Docker), которая:
	•	Выводит сообщение: 📦 Deploying $APP_NAME to $ENV

Создай workflow, который:
	•	Запускается по push
	•	Передаёт в action переменные APP_NAME и ENV
	•	Вызывает кастомную action из поддиректории .github/actions/deploy

1. `Ветка: gha-05-custom-deploy`

```
git switch -c gha-05-custom-deploy
Switched to a new branch 'gha-05-custom-deploy'
```
2. `Создай структуру`

```
.github/
  workflows/ci-deploy.yml
  actions/deploy/
    Dockerfile
    entrypoint.sh
    action.yml
```
3. `Кастомная action должна принимать input-параметры: •	app_name •	env`

```

```
4. `В workflow передай эти параметры в uses: ./github/actions/deploy`

```
.github/actions/deploy/entrypoint.sh
---
#!/bin/sh
echo "📦 Deploying $APP_NAME to $ENV"

 .github/actions/deploy/Dockerfile
 ---
 FROM alpine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

.github/actions/deploy/action.yml
---
name: Hello Deploy Action
description: Кастомная action для вывода деплоя

inputs:
  app_name:
    description: Название приложения
    required: true
  env:
    description: Окружение
    required: true

runs:
  using: "docker"
  image: "Dockerfile"
  env:
    APP_NAME: ${{ inputs.app_name }}
    ENV: ${{ inputs.env }}

 .github/workflows/ci-deploy.yml
 ---
 name: Deploy Workflow

on:
  push:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy via custom action
        uses: ./github/actions/deploy
        with:
          app_name: MyCoolApp
          env: stage
```
5. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-05-custom-deploy

Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 10 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 421 bytes | 421.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   9b7b60a..204ffc0  gha-05-custom-deploy -> gha-05-custom-deploy
branch 'gha-05-custom-deploy' set up to track 'origin/gha-05-custom-deploy'.
```
6. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name e9dfd6c852384a3524454c9d77e2e9bf2fbae5_0e4e7c --label e9dfd6 --workdir /github/workspace --rm -e "INPUT_APP_NAME" -e "INPUT_ENV" -e "APP_NAME" -e "ENV" -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" e9dfd6:c852384a3524454c9d77e2e9bf2fbae5
📦 Deploying MyCoolApp to stage
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `DOC-GHA-01 Автосборка Docker-образа по пушу`

 ### 🎯 Цель урока
Как работает автосборка Docker-образа через GitHub Actions
---

 ## 📘 Теория (кратко)

🔹 Общая идея:

GitHub Actions позволяет запускать CI/CD-процессы при событиях в репозитории. В случае Docker-сборки — при каждом пуше GitHub может:
	•	Проверить код
	•	Собрать Docker-образ
	•	Потестировать его
	•	Отправить в DockerHub или другой реестр

🔹 Основные компоненты:
.github/workflows/*.ymlОписание пайплайна
on: Триггер (например, push, pull_request)
jobs: Список задач, которые выполняются
runs-on: Указывает ОС runner-а (например, ubuntu-latest)
steps: Последовательность шагов внутри job-а

🔹 Как происходит сборка Docker-образа
	1.	Получение кода — GitHub сам клонирует репозиторий.
	2.	Установка Docker — runner использует Ubuntu с предустановленным Docker.
	3.	Сборка образа — docker build -t имя .
	4.	(опционально) Push — docker push требует логина в реестр (будет в следующем юните)

⸻

🔹 Что важно учитывать:
	•	GitHub Actions не работает “по крону” сам по себе — нужны события: push, pull_request, workflow_dispatch (ручной запуск).
	•	Runner’ы имеют ограничения по ресурсам (CPU, RAM) и времени выполнения (обычно 6 часов для public repo).
	•	Переменные и секреты задаются в разделе Settings → Secrets репозитория.
	•	GitHub Actions можно запускать вручную или автоматически, и это позволяет внедрить инфраструктуру как код даже на уровне CI.


 ## Ключевые команды:


---

### Задание

1. Настрой автоматическую сборку Docker-образа при пуше в репозиторий.
Workflow должен запускаться при любом коммите в ветку main.
Цель — убедиться, что образ успешно собирается на CI, но не пушится в DockerHub (ещё рано).

1. `Создай .github/workflows/docker-build.yml.`

```
touch .github/workflows/docker-build.yml
```
2. `Укажи событие push в ветку main.`

```

```
3. `Добавь job на базе ubuntu-latest.`

```

```
4. `Добавь step для сборки Docker-образа из Dockerfile в корне репозитория.`

```
nano .github/workflows/docker-build.yml
name: Build Docker image

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t test-image:latest ./.github/actions/deploy

```

5. `Убедись, что workflow проходит после коммита.`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name ccc482fb2784ff45f69a94bb5eb091235c_985deb --label 0443cc --workdir /github/workspace --rm -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" 0443cc:c482fb2784ff45f69a94bb5eb091235c
Hello from the deploy action!
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `DOC-GHA-03 Разделение build и push по шагам`

 ### 🎯 Цель урока
Зачем разделять build и push в GitHub Actions

---

 ## 📘 Теория (кратко)

🔹 Почему нельзя всё в одном шаге?

Сборка и публикация — это разные стадии CI/CD:
	•	build — можно кэшировать, использовать как артефакт, проверять на ошибки.
	•	push — требует внешнего взаимодействия, секретов и даёт побочный эффект (меняет внешний реестр).

Разделение даёт:
	•	🧪 Гибкость: можно выполнять тесты между build и push.
	•	🔒 Безопасность: push выполняется только при определённых условиях (например, из main, из PR с одобрением и т.д.).
	•	💨 Кэширование и многопоточность: docker/build-push-action умеет собирать быстрее через buildx.

🔹 Используемые экшены:
- uses: docker/setup-buildx-action@v3
- uses: docker/login-action@v3
- uses: docker/build-push-action@v5

🔹 Стратегия:
      - name: Build (only)
        uses: docker/build-push-action@v5
        with:
          push: false

      - name: Push (only)
        uses: docker/build-push-action@v5
        with:
          push: true
🔹 Пример сценария:
	1.	Выполняем build → проверяем → если всё хорошо, push.
	2.	Это удобно при pull request’ах: build делается, но push разрешён только в main.



 ## Ключевые команды:

---

### Задание

1. Настрой .github/workflows/docker-release.yml, в котором:
	•	При пуше в main происходит сборка образа,
	•	Потом (в отдельном step-е) — публикация его в DockerHub.

Оба шага должны быть чётко разделены, и между ними можно будет вставить шаг проверки или echo.

1. `Создай workflow docker-release.yml.`

```
touch docker-release.yml
```
2. `Используй docker/setup-buildx-action для подготовки билдера.`

```

```
3. `Первый шаг — build образа, но без пуша (push: false).`

```

```
4. `Второй шаг — push образа в DockerHub, используй secrets.`

```

```
5. `Теги: yourusername/appname:latest`

```
name: Docker Release

on:
  push:
    branches:
      - main  # только при пуше в main

jobs:
  docker-release:
    name: 🐳 Build & Push Docker Image
    runs-on: ubuntu-latest

    steps:
      - name: 📥 Checkout repo
        uses: actions/checkout@v3

      - name: 🔧 Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: 🔐 Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: 🛠️ Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: yourusername/appname:latest
          outputs: type=docker  # локальный образ для следующего шага

      - name: ✅ Проверка после сборки
        run: echo "Образ успешно собран. Переходим к публикации..."

      - name: 📤 Push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: yourusername/appname:latest
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-01 — Введение в GitHub Actions`

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



# Модуль "`GitLab CI/CD`" - `GHA-02 Переменные, секреты и матрицы`

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


# Модуль "`GitLab CI/CD`" - `GHA-03 Основы job-стратегий и условий выполнения`

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

# Модуль "`GitLab CI/CD`" - `GHA-04 — CI-пайплайн: линтинг, тесты, артефакты`

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

1. Создай CI workflow, который:
	•	Запускается при push в любую ветку
	•	Делает:
	•	Линтинг — проверь синтаксис *.yml файлов (например, yamllint)
	•	Тест — симулируй тестирование (команда echo "Тесты пройдены")
	•	Build — создай папку build/ с каким-то файлом (например, touch build/app.txt)
	•	Загрузи build/ как артефакт

1. `Ветка: gha-04-ci-pipeline`

```
git switch -c gha-04-ci-pipeline
Switched to a new branch 'gha-04-ci-pipeline'
```
2. `Файл: .github/workflows/ci.yml`

```
touch .github/workflows/ci.yml
```
3. `Стадии: lint, test, build — как отдельные job, Используй upload-artifact только в job build, Линт — можешь установить yamllint (pip install yamllint) или сделать echo "Lint passed" — главное структура`

```
---
name: CI Pipeline

on:
  push:


jobs:
  lint:
    name: Линтинг YAML файлов
    runs-on: ubuntu-latest
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Проверка синтаксиса YAML (симулированная)
        run: |
           sudo apt update
           sudo apt install -y python3-pip
           pip install yamllint
           yamllint .

  test:
    name: Тестирование
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Запускаем тесты (симуляция)
        run: echo "Тесты пройдены"

  build:
    name: Сборка
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Создаём папку build/ и файл
        run: |
          mkdir -p build
          echo "Hello from build" > build/app.txt

      - name: Загружаем артефакт
        uses: actions/upload-artifact@v4
        with:
          name: build-artifact
          path: build/

```
4. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-04-ci-pipeline
Enumerating objects: 26, done.
Counting objects: 100% (26/26), done.
Delta compression using up to 10 threads
Compressing objects: 100% (13/13), done.
Writing objects: 100% (14/14), 1.26 KiB | 1.26 MiB/s, done.
Total 14 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   b55b770..adaba9e  gha-04-ci-pipeline -> gha-04-ci-pipeline
branch 'gha-04-ci-pipeline' set up to track 'origin/gha-04-ci-pipeline'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Reading package lists...
Building dependency tree...
Reading state information...
python3-pip is already the newest version (24.0+dfsg-1ubuntu1.1).
0 upgraded, 0 newly installed, 0 to remove and 16 not upgraded.
Defaulting to user installation because normal site-packages is not writeable
Collecting yamllint
  Downloading yamllint-1.37.1-py3-none-any.whl.metadata (4.3 kB)
Collecting pathspec>=0.5.3 (from yamllint)
  Downloading pathspec-0.12.1-py3-none-any.whl.metadata (21 kB)
Requirement already satisfied: pyyaml in /usr/lib/python3/dist-packages (from yamllint) (6.0.1)
Downloading yamllint-1.37.1-py3-none-any.whl (68 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 68.8/68.8 kB 9.4 MB/s eta 0:00:00
Downloading pathspec-0.12.1-py3-none-any.whl (31 kB)
Installing collected packages: pathspec, yamllint
Successfully installed pathspec-0.12.1 yamllint-1.37.1
./.github/workflows/matrix.yml

./.github/workflows/ci.yml

./.github/workflows/conditional.yml

./.github/workflows/basic.yml

Run echo "Тесты пройдены"
Тесты пройдены

Run mkdir -p build
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-05 — Деплой и кастомные действия (actions)`

 ### 🎯 Цель урока
Деплой и кастомные действия (actions)

---

 ## 📘 Теория (кратко)

🔹 Деплой в CI/CD

Под “деплоем” в GitHub Actions обычно понимается:
	•	пуш в DockerHub / GitHub Container Registry
	•	деплой в Kubernetes, облако, FTP, сервер и т.д.

🧠 Сам деплой может быть:
	•	Через обычный run: ...
	•	Через сторонние готовые actions
	•	Через кастомные actions, написанные под проект

🔹 Готовые actions (из маркетплейса)

Пример: деплой на FTP
- name: Deploy via FTP
  uses: SamKirkland/FTP-Deploy-Action@v4
  with:
    server: ftp.example.com
    username: ${{ secrets.FTP_USER }}
    password: ${{ secrets.FTP_PASS }}

🔹 Кастомные actions (свои)

Ты можешь создать свою action:
	•	В формате Docker (исполняется в контейнере)
	•	В формате JavaScript (исполняется прямо в раннере)

📁 Структура:
/my-action
  └── action.yml
  └── entrypoint.sh

🧾 action.yml (пример shell-скрипта):
name: Hello Action
description: Prints Hello
runs:
  using: "docker"
  image: "Dockerfile"

🧾 Dockerfile:
FROM alpine
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

🧾 entrypoint.sh:
#!/bin/sh
echo "Hello from custom action!"

 ## Ключевые команды:

---

### Задание

1. Создай кастомную action на shell (через Docker), которая:
	•	Выводит сообщение: 📦 Deploying $APP_NAME to $ENV

Создай workflow, который:
	•	Запускается по push
	•	Передаёт в action переменные APP_NAME и ENV
	•	Вызывает кастомную action из поддиректории .github/actions/deploy

1. `Ветка: gha-05-custom-deploy`

```
git switch -c gha-05-custom-deploy
Switched to a new branch 'gha-05-custom-deploy'
```
2. `Создай структуру`

```
.github/
  workflows/ci-deploy.yml
  actions/deploy/
    Dockerfile
    entrypoint.sh
    action.yml
```
3. `Кастомная action должна принимать input-параметры: •	app_name •	env`

```

```
4. `В workflow передай эти параметры в uses: ./github/actions/deploy`

```
.github/actions/deploy/entrypoint.sh
---
#!/bin/sh
echo "📦 Deploying $APP_NAME to $ENV"

 .github/actions/deploy/Dockerfile
 ---
 FROM alpine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

.github/actions/deploy/action.yml
---
name: Hello Deploy Action
description: Кастомная action для вывода деплоя

inputs:
  app_name:
    description: Название приложения
    required: true
  env:
    description: Окружение
    required: true

runs:
  using: "docker"
  image: "Dockerfile"
  env:
    APP_NAME: ${{ inputs.app_name }}
    ENV: ${{ inputs.env }}

 .github/workflows/ci-deploy.yml
 ---
 name: Deploy Workflow

on:
  push:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy via custom action
        uses: ./github/actions/deploy
        with:
          app_name: MyCoolApp
          env: stage
```
5. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-05-custom-deploy

Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 10 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 421 bytes | 421.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   9b7b60a..204ffc0  gha-05-custom-deploy -> gha-05-custom-deploy
branch 'gha-05-custom-deploy' set up to track 'origin/gha-05-custom-deploy'.
```
6. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name e9dfd6c852384a3524454c9d77e2e9bf2fbae5_0e4e7c --label e9dfd6 --workdir /github/workspace --rm -e "INPUT_APP_NAME" -e "INPUT_ENV" -e "APP_NAME" -e "ENV" -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" e9dfd6:c852384a3524454c9d77e2e9bf2fbae5
📦 Deploying MyCoolApp to stage
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `DOC-GHA-01 Автосборка Docker-образа по пушу`

 ### 🎯 Цель урока
Как работает автосборка Docker-образа через GitHub Actions
---

 ## 📘 Теория (кратко)

🔹 Общая идея:

GitHub Actions позволяет запускать CI/CD-процессы при событиях в репозитории. В случае Docker-сборки — при каждом пуше GitHub может:
	•	Проверить код
	•	Собрать Docker-образ
	•	Потестировать его
	•	Отправить в DockerHub или другой реестр

🔹 Основные компоненты:
.github/workflows/*.ymlОписание пайплайна
on: Триггер (например, push, pull_request)
jobs: Список задач, которые выполняются
runs-on: Указывает ОС runner-а (например, ubuntu-latest)
steps: Последовательность шагов внутри job-а

🔹 Как происходит сборка Docker-образа
	1.	Получение кода — GitHub сам клонирует репозиторий.
	2.	Установка Docker — runner использует Ubuntu с предустановленным Docker.
	3.	Сборка образа — docker build -t имя .
	4.	(опционально) Push — docker push требует логина в реестр (будет в следующем юните)

⸻

🔹 Что важно учитывать:
	•	GitHub Actions не работает “по крону” сам по себе — нужны события: push, pull_request, workflow_dispatch (ручной запуск).
	•	Runner’ы имеют ограничения по ресурсам (CPU, RAM) и времени выполнения (обычно 6 часов для public repo).
	•	Переменные и секреты задаются в разделе Settings → Secrets репозитория.
	•	GitHub Actions можно запускать вручную или автоматически, и это позволяет внедрить инфраструктуру как код даже на уровне CI.


 ## Ключевые команды:


---

### Задание

1. Настрой автоматическую сборку Docker-образа при пуше в репозиторий.
Workflow должен запускаться при любом коммите в ветку main.
Цель — убедиться, что образ успешно собирается на CI, но не пушится в DockerHub (ещё рано).

1. `Создай .github/workflows/docker-build.yml.`

```
touch .github/workflows/docker-build.yml
```
2. `Укажи событие push в ветку main.`

```

```
3. `Добавь job на базе ubuntu-latest.`

```

```
4. `Добавь step для сборки Docker-образа из Dockerfile в корне репозитория.`

```
nano .github/workflows/docker-build.yml
name: Build Docker image

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t test-image:latest ./.github/actions/deploy

```

5. `Убедись, что workflow проходит после коммита.`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name ccc482fb2784ff45f69a94bb5eb091235c_985deb --label 0443cc --workdir /github/workspace --rm -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" 0443cc:c482fb2784ff45f69a94bb5eb091235c
Hello from the deploy action!
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `DOC-GHA-03 Разделение build и push по шагам`

 ### 🎯 Цель урока
Зачем разделять build и push в GitHub Actions

---

 ## 📘 Теория (кратко)

🔹 Почему нельзя всё в одном шаге?

Сборка и публикация — это разные стадии CI/CD:
	•	build — можно кэшировать, использовать как артефакт, проверять на ошибки.
	•	push — требует внешнего взаимодействия, секретов и даёт побочный эффект (меняет внешний реестр).

Разделение даёт:
	•	🧪 Гибкость: можно выполнять тесты между build и push.
	•	🔒 Безопасность: push выполняется только при определённых условиях (например, из main, из PR с одобрением и т.д.).
	•	💨 Кэширование и многопоточность: docker/build-push-action умеет собирать быстрее через buildx.

🔹 Используемые экшены:
- uses: docker/setup-buildx-action@v3
- uses: docker/login-action@v3
- uses: docker/build-push-action@v5

🔹 Стратегия:
      - name: Build (only)
        uses: docker/build-push-action@v5
        with:
          push: false

      - name: Push (only)
        uses: docker/build-push-action@v5
        with:
          push: true
🔹 Пример сценария:
	1.	Выполняем build → проверяем → если всё хорошо, push.
	2.	Это удобно при pull request’ах: build делается, но push разрешён только в main.



 ## Ключевые команды:

---

### Задание

1. Настрой .github/workflows/docker-release.yml, в котором:
	•	При пуше в main происходит сборка образа,
	•	Потом (в отдельном step-е) — публикация его в DockerHub.

Оба шага должны быть чётко разделены, и между ними можно будет вставить шаг проверки или echo.

1. `Создай workflow docker-release.yml.`

```
touch docker-release.yml
```
2. `Используй docker/setup-buildx-action для подготовки билдера.`

```

```
3. `Первый шаг — build образа, но без пуша (push: false).`

```

```
4. `Второй шаг — push образа в DockerHub, используй secrets.`

```

```
5. `Теги: yourusername/appname:latest`

```
name: Docker Release

on:
  push:
    branches:
      - main  # только при пуше в main

jobs:
  docker-release:
    name: 🐳 Build & Push Docker Image
    runs-on: ubuntu-latest

    steps:
      - name: 📥 Checkout repo
        uses: actions/checkout@v3

      - name: 🔧 Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: 🔐 Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: 🛠️ Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: yourusername/appname:latest
          outputs: type=docker  # локальный образ для следующего шага

      - name: ✅ Проверка после сборки
        run: echo "Образ успешно собран. Переходим к публикации..."

      - name: 📤 Push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: yourusername/appname:latest
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-01 — Введение в GitHub Actions`

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



# Модуль "`GitLab CI/CD`" - `GHA-02 Переменные, секреты и матрицы`

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


# Модуль "`GitLab CI/CD`" - `GHA-03 Основы job-стратегий и условий выполнения`

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

# Модуль "`GitLab CI/CD`" - `GHA-04 — CI-пайплайн: линтинг, тесты, артефакты`

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

1. Создай CI workflow, который:
	•	Запускается при push в любую ветку
	•	Делает:
	•	Линтинг — проверь синтаксис *.yml файлов (например, yamllint)
	•	Тест — симулируй тестирование (команда echo "Тесты пройдены")
	•	Build — создай папку build/ с каким-то файлом (например, touch build/app.txt)
	•	Загрузи build/ как артефакт

1. `Ветка: gha-04-ci-pipeline`

```
git switch -c gha-04-ci-pipeline
Switched to a new branch 'gha-04-ci-pipeline'
```
2. `Файл: .github/workflows/ci.yml`

```
touch .github/workflows/ci.yml
```
3. `Стадии: lint, test, build — как отдельные job, Используй upload-artifact только в job build, Линт — можешь установить yamllint (pip install yamllint) или сделать echo "Lint passed" — главное структура`

```
---
name: CI Pipeline

on:
  push:


jobs:
  lint:
    name: Линтинг YAML файлов
    runs-on: ubuntu-latest
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Проверка синтаксиса YAML (симулированная)
        run: |
           sudo apt update
           sudo apt install -y python3-pip
           pip install yamllint
           yamllint .

  test:
    name: Тестирование
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Запускаем тесты (симуляция)
        run: echo "Тесты пройдены"

  build:
    name: Сборка
    runs-on: ubuntu-latest
    needs: test
    steps:
      - name: Клонируем код
        uses: actions/checkout@v3

      - name: Создаём папку build/ и файл
        run: |
          mkdir -p build
          echo "Hello from build" > build/app.txt

      - name: Загружаем артефакт
        uses: actions/upload-artifact@v4
        with:
          name: build-artifact
          path: build/

```
4. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-04-ci-pipeline
Enumerating objects: 26, done.
Counting objects: 100% (26/26), done.
Delta compression using up to 10 threads
Compressing objects: 100% (13/13), done.
Writing objects: 100% (14/14), 1.26 KiB | 1.26 MiB/s, done.
Total 14 (delta 7), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   b55b770..adaba9e  gha-04-ci-pipeline -> gha-04-ci-pipeline
branch 'gha-04-ci-pipeline' set up to track 'origin/gha-04-ci-pipeline'.
```
5. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Reading package lists...
Building dependency tree...
Reading state information...
python3-pip is already the newest version (24.0+dfsg-1ubuntu1.1).
0 upgraded, 0 newly installed, 0 to remove and 16 not upgraded.
Defaulting to user installation because normal site-packages is not writeable
Collecting yamllint
  Downloading yamllint-1.37.1-py3-none-any.whl.metadata (4.3 kB)
Collecting pathspec>=0.5.3 (from yamllint)
  Downloading pathspec-0.12.1-py3-none-any.whl.metadata (21 kB)
Requirement already satisfied: pyyaml in /usr/lib/python3/dist-packages (from yamllint) (6.0.1)
Downloading yamllint-1.37.1-py3-none-any.whl (68 kB)
   ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 68.8/68.8 kB 9.4 MB/s eta 0:00:00
Downloading pathspec-0.12.1-py3-none-any.whl (31 kB)
Installing collected packages: pathspec, yamllint
Successfully installed pathspec-0.12.1 yamllint-1.37.1
./.github/workflows/matrix.yml

./.github/workflows/ci.yml

./.github/workflows/conditional.yml

./.github/workflows/basic.yml

Run echo "Тесты пройдены"
Тесты пройдены

Run mkdir -p build
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GHA-05 — Деплой и кастомные действия (actions)`

 ### 🎯 Цель урока
Деплой и кастомные действия (actions)

---

 ## 📘 Теория (кратко)

🔹 Деплой в CI/CD

Под “деплоем” в GitHub Actions обычно понимается:
	•	пуш в DockerHub / GitHub Container Registry
	•	деплой в Kubernetes, облако, FTP, сервер и т.д.

🧠 Сам деплой может быть:
	•	Через обычный run: ...
	•	Через сторонние готовые actions
	•	Через кастомные actions, написанные под проект

🔹 Готовые actions (из маркетплейса)

Пример: деплой на FTP
- name: Deploy via FTP
  uses: SamKirkland/FTP-Deploy-Action@v4
  with:
    server: ftp.example.com
    username: ${{ secrets.FTP_USER }}
    password: ${{ secrets.FTP_PASS }}

🔹 Кастомные actions (свои)

Ты можешь создать свою action:
	•	В формате Docker (исполняется в контейнере)
	•	В формате JavaScript (исполняется прямо в раннере)

📁 Структура:
/my-action
  └── action.yml
  └── entrypoint.sh

🧾 action.yml (пример shell-скрипта):
name: Hello Action
description: Prints Hello
runs:
  using: "docker"
  image: "Dockerfile"

🧾 Dockerfile:
FROM alpine
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

🧾 entrypoint.sh:
#!/bin/sh
echo "Hello from custom action!"

 ## Ключевые команды:

---

### Задание

1. Создай кастомную action на shell (через Docker), которая:
	•	Выводит сообщение: 📦 Deploying $APP_NAME to $ENV

Создай workflow, который:
	•	Запускается по push
	•	Передаёт в action переменные APP_NAME и ENV
	•	Вызывает кастомную action из поддиректории .github/actions/deploy

1. `Ветка: gha-05-custom-deploy`

```
git switch -c gha-05-custom-deploy
Switched to a new branch 'gha-05-custom-deploy'
```
2. `Создай структуру`

```
.github/
  workflows/ci-deploy.yml
  actions/deploy/
    Dockerfile
    entrypoint.sh
    action.yml
```
3. `Кастомная action должна принимать input-параметры: •	app_name •	env`

```

```
4. `В workflow передай эти параметры в uses: ./github/actions/deploy`

```
.github/actions/deploy/entrypoint.sh
---
#!/bin/sh
echo "📦 Deploying $APP_NAME to $ENV"

 .github/actions/deploy/Dockerfile
 ---
 FROM alpine

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

.github/actions/deploy/action.yml
---
name: Hello Deploy Action
description: Кастомная action для вывода деплоя

inputs:
  app_name:
    description: Название приложения
    required: true
  env:
    description: Окружение
    required: true

runs:
  using: "docker"
  image: "Dockerfile"
  env:
    APP_NAME: ${{ inputs.app_name }}
    ENV: ${{ inputs.env }}

 .github/workflows/ci-deploy.yml
 ---
 name: Deploy Workflow

on:
  push:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Deploy via custom action
        uses: ./github/actions/deploy
        with:
          app_name: MyCoolApp
          env: stage
```
5. `Сделай git push — проверь, что workflow сработал`

```
git push -u origin gha-05-custom-deploy

Enumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 10 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 421 bytes | 421.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/DavyRoy/DevOps_practick.git
   9b7b60a..204ffc0  gha-05-custom-deploy -> gha-05-custom-deploy
branch 'gha-05-custom-deploy' set up to track 'origin/gha-05-custom-deploy'.
```
6. `Перейди в GitHub → вкладка Actions → убедись в успешном выполнении`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name e9dfd6c852384a3524454c9d77e2e9bf2fbae5_0e4e7c --label e9dfd6 --workdir /github/workspace --rm -e "INPUT_APP_NAME" -e "INPUT_ENV" -e "APP_NAME" -e "ENV" -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" e9dfd6:c852384a3524454c9d77e2e9bf2fbae5
📦 Deploying MyCoolApp to stage
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `DOC-GHA-01 Автосборка Docker-образа по пушу`

 ### 🎯 Цель урока
Как работает автосборка Docker-образа через GitHub Actions
---

 ## 📘 Теория (кратко)

🔹 Общая идея:

GitHub Actions позволяет запускать CI/CD-процессы при событиях в репозитории. В случае Docker-сборки — при каждом пуше GitHub может:
	•	Проверить код
	•	Собрать Docker-образ
	•	Потестировать его
	•	Отправить в DockerHub или другой реестр

🔹 Основные компоненты:
.github/workflows/*.ymlОписание пайплайна
on: Триггер (например, push, pull_request)
jobs: Список задач, которые выполняются
runs-on: Указывает ОС runner-а (например, ubuntu-latest)
steps: Последовательность шагов внутри job-а

🔹 Как происходит сборка Docker-образа
	1.	Получение кода — GitHub сам клонирует репозиторий.
	2.	Установка Docker — runner использует Ubuntu с предустановленным Docker.
	3.	Сборка образа — docker build -t имя .
	4.	(опционально) Push — docker push требует логина в реестр (будет в следующем юните)

⸻

🔹 Что важно учитывать:
	•	GitHub Actions не работает “по крону” сам по себе — нужны события: push, pull_request, workflow_dispatch (ручной запуск).
	•	Runner’ы имеют ограничения по ресурсам (CPU, RAM) и времени выполнения (обычно 6 часов для public repo).
	•	Переменные и секреты задаются в разделе Settings → Secrets репозитория.
	•	GitHub Actions можно запускать вручную или автоматически, и это позволяет внедрить инфраструктуру как код даже на уровне CI.


 ## Ключевые команды:


---

### Задание

1. Настрой автоматическую сборку Docker-образа при пуше в репозиторий.
Workflow должен запускаться при любом коммите в ветку main.
Цель — убедиться, что образ успешно собирается на CI, но не пушится в DockerHub (ещё рано).

1. `Создай .github/workflows/docker-build.yml.`

```
touch .github/workflows/docker-build.yml
```
2. `Укажи событие push в ветку main.`

```

```
3. `Добавь job на базе ubuntu-latest.`

```

```
4. `Добавь step для сборки Docker-образа из Dockerfile в корне репозитория.`

```
nano .github/workflows/docker-build.yml
name: Build Docker image

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Build Docker image
        run: docker build -t test-image:latest ./.github/actions/deploy

```

5. `Убедись, что workflow проходит после коммита.`

```
Run ./.github/actions/deploy
Building docker image
/usr/bin/docker run --name ccc482fb2784ff45f69a94bb5eb091235c_985deb --label 0443cc --workdir /github/workspace --rm -e "HOME" -e "GITHUB_JOB" -e "GITHUB_REF" -e "GITHUB_SHA" -e "GITHUB_REPOSITORY" -e "GITHUB_REPOSITORY_OWNER" -e "GITHUB_REPOSITORY_OWNER_ID" -e "GITHUB_RUN_ID" -e "GITHUB_RUN_NUMBER" -e "GITHUB_RETENTION_DAYS" -e "GITHUB_RUN_ATTEMPT" -e "GITHUB_ACTOR_ID" -e "GITHUB_ACTOR" -e "GITHUB_WORKFLOW" -e "GITHUB_HEAD_REF" -e "GITHUB_BASE_REF" -e "GITHUB_EVENT_NAME" -e "GITHUB_SERVER_URL" -e "GITHUB_API_URL" -e "GITHUB_GRAPHQL_URL" -e "GITHUB_REF_NAME" -e "GITHUB_REF_PROTECTED" -e "GITHUB_REF_TYPE" -e "GITHUB_WORKFLOW_REF" -e "GITHUB_WORKFLOW_SHA" -e "GITHUB_REPOSITORY_ID" -e "GITHUB_TRIGGERING_ACTOR" -e "GITHUB_WORKSPACE" -e "GITHUB_ACTION" -e "GITHUB_EVENT_PATH" -e "GITHUB_ACTION_REPOSITORY" -e "GITHUB_ACTION_REF" -e "GITHUB_PATH" -e "GITHUB_ENV" -e "GITHUB_STEP_SUMMARY" -e "GITHUB_STATE" -e "GITHUB_OUTPUT" -e "RUNNER_OS" -e "RUNNER_ARCH" -e "RUNNER_NAME" -e "RUNNER_ENVIRONMENT" -e "RUNNER_TOOL_CACHE" -e "RUNNER_TEMP" -e "RUNNER_WORKSPACE" -e "ACTIONS_RUNTIME_URL" -e "ACTIONS_RUNTIME_TOKEN" -e "ACTIONS_CACHE_URL" -e "ACTIONS_RESULTS_URL" -e GITHUB_ACTIONS=true -e CI=true -v "/var/run/docker.sock":"/var/run/docker.sock" -v "/home/runner/work/_temp/_github_home":"/github/home" -v "/home/runner/work/_temp/_github_workflow":"/github/workflow" -v "/home/runner/work/_temp/_runner_file_commands":"/github/file_commands" -v "/home/runner/work/DevOps_practick/DevOps_practick":"/github/workspace" 0443cc:c482fb2784ff45f69a94bb5eb091235c
Hello from the deploy action!
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `DOC-GHA-03 Разделение build и push по шагам`

 ### 🎯 Цель урока
Зачем разделять build и push в GitHub Actions

---

 ## 📘 Теория (кратко)

🔹 Почему нельзя всё в одном шаге?

Сборка и публикация — это разные стадии CI/CD:
	•	build — можно кэшировать, использовать как артефакт, проверять на ошибки.
	•	push — требует внешнего взаимодействия, секретов и даёт побочный эффект (меняет внешний реестр).

Разделение даёт:
	•	🧪 Гибкость: можно выполнять тесты между build и push.
	•	🔒 Безопасность: push выполняется только при определённых условиях (например, из main, из PR с одобрением и т.д.).
	•	💨 Кэширование и многопоточность: docker/build-push-action умеет собирать быстрее через buildx.

🔹 Используемые экшены:
- uses: docker/setup-buildx-action@v3
- uses: docker/login-action@v3
- uses: docker/build-push-action@v5

🔹 Стратегия:
      - name: Build (only)
        uses: docker/build-push-action@v5
        with:
          push: false

      - name: Push (only)
        uses: docker/build-push-action@v5
        with:
          push: true
🔹 Пример сценария:
	1.	Выполняем build → проверяем → если всё хорошо, push.
	2.	Это удобно при pull request’ах: build делается, но push разрешён только в main.



 ## Ключевые команды:

---

### Задание

1. Настрой .github/workflows/docker-release.yml, в котором:
	•	При пуше в main происходит сборка образа,
	•	Потом (в отдельном step-е) — публикация его в DockerHub.

Оба шага должны быть чётко разделены, и между ними можно будет вставить шаг проверки или echo.

1. `Создай workflow docker-release.yml.`

```
touch docker-release.yml
```
2. `Используй docker/setup-buildx-action для подготовки билдера.`

```

```
3. `Первый шаг — build образа, но без пуша (push: false).`

```

```
4. `Второй шаг — push образа в DockerHub, используй secrets.`

```

```
5. `Теги: yourusername/appname:latest`

```
name: Docker Release

on:
  push:
    branches:
      - main  # только при пуше в main

jobs:
  docker-release:
    name: 🐳 Build & Push Docker Image
    runs-on: ubuntu-latest

    steps:
      - name: 📥 Checkout repo
        uses: actions/checkout@v3

      - name: 🔧 Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: 🔐 Login to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: 🛠️ Build Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: yourusername/appname:latest
          outputs: type=docker  # локальный образ для следующего шага

      - name: ✅ Проверка после сборки
        run: echo "Образ успешно собран. Переходим к публикации..."

      - name: 📤 Push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: yourusername/appname:latest
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---
