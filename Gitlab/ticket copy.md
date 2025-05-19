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
Условия: only, except и rules

---

 ## 📘 Теория (кратко)

В реальных проектах ты не хочешь запускать весь pipeline всегда. Например:
	•	билд только в main
	•	деплой — только при наличии тега
	•	линтер — только в Merge Request

Для этого используются условия.

⸻

🔹 Устаревшие директивы: only и except (до GitLab 12.3)
job:
  script: echo Hello
  only:
    - main
  except:
    - tags
  🔻 Минусы:
	•	Маловыразительные
	•	Не поддерживают сложную логику
	•	Устаревают — лучше не использовать

✅ Современный способ: rules
job:
  script: echo Hello
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - if: '$CI_COMMIT_TAG'
      when: manual
    - when: never
    🔹 Что умеют rules:
	•	Условные выражения (if)
	•	Указание когда запускать: on_success, manual, never
	•	Объединение по приоритету (срабатывает первое подходящее правило)

🔍 Примеры

🔸 Только в main:
rules:
  - if: '$CI_COMMIT_BRANCH == "main"'
🔸 Только для тега:
rules:
  - if: '$CI_COMMIT_TAG'
🔸 Merge Request:
rules:
  - if: '$CI_PIPELINE_SOURCE == "merge_request_event"'
🔸 Пропустить job:
rules:
  - when: never


 ## Ключевые команды:

---

### Задание

1. Добавь в .gitlab-ci.yml следующие условия:
	•	build_app — запускается только в ветке main
	•	test_app — запускается всегда
	•	deploy_app — запускается только при наличии тега и вручную (manual)

1. `Обнови текущий .gitlab-ci.yml, используя rules.`

```

```
2. `Добавь необходимые блоки rules: в каждую job.`

```

```
3. `Сделай коммит в main, убедись, что сработали только build_app и test_app.`

```

```
4. `Создай тег (git tag v1.0 && git push origin v1.0) — проверь, появилась кнопка ручного запуска для deploy_app.`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy_app

build_app:
  stage: build_app
  script: echo Hello
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app:
  stage: test_app
  script: echo Hello
  rules:
    - when: always

deploy_app:
  stage: deploy_app
  script: echo Hello
  rules:
    - if: '$CI_COMMIT_TAG == "v1.0"'
      when: always
    - if: '$CI_COMMIT_TAG'
      when: manual
    - when: never

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-05 Кэш и артефакты `

 ### 🎯 Цель урока
Кэширование и артефакты: ускорение и передача данных между job’ами

---

 ## 📘 Теория (кратко)

В GitLab CI/CD ты можешь сохранять:
	•	🗂 Кэш — чтобы избежать повторной установки зависимостей, ускорить job’ы.
	•	📦 Артефакты — чтобы передать файлы между стадиями (например, результаты сборки).

🔹 cache: — ускорение

Кэш сохраняется на стороне runner’а и используется между job’ами и пайплайнами.
cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - node_modules/
key — определяет уникальность кэша (можно по ветке, ветке + lock-файлу, и т.д.)

🔹 artifacts: — передача данных

Артефакты передаются от job к job, но только если они в разных stages.
build_app:
  stage: build
  script:
    - npm run build
  artifacts:
    paths:
      - dist/
Затем в следующем этапе:
deploy_app:
  stage: deploy
  script:
    - ls dist/

📦 Типы артефактов:
paths: Указывает файлы/директории для сохранения
expire_in: Время жизни (например, 1 day, 1 week)
when: Условие (on_success, always, on_failure)
reports: JUnit, coverage, performance и др

🤔 Как они работают вместе?
	•	cache: — для ускорения, работает даже между пайплайнами
	•	artifacts: — для передачи результатов между job’ами в рамках одного pipeline

🛠 Пример: сборка + деплой
stages:
  - build
  - deploy

build_app:
  stage: build
  script:
    - npm ci
    - npm run build
  cache:
    paths:
      - node_modules/
  artifacts:
    paths:
      - dist/

deploy_app:
  stage: deploy
  script:
    - ls dist/
    - echo "Deploying app"

 ## Конспект:
 🗂 cache:
- Используется для ускорения job (зависимости, пакеты и т.д.)
- Работает между job'ами и пайплайнами
- Указывается через key + paths

📦 artifacts:
- Передают файлы между job'ами
- Работают только между job'ами разных stage
- Указываются через paths, expire_in, when

---

### Задание

1. Обнови свой .gitlab-ci.yml, чтобы:
	•	build_app кэшировал node_modules/
	•	build_app сохранял папку dist/ как артефакт
	•	deploy_app выводил содержимое dist/ (для проверки)

1. `В build_app добавь: •	cache: на node_modules/ •	artifacts: на dist/`

```

```
2. `В deploy_app — просто ls dist/`

```

```
3. `Убедись, что: •	кэш сохраняется •	артефакты передаются •	dist/ видна в deploy_app`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy_app

build_app:
  stage: build_app
  script:
    - echo Hello
    - npm ci
  cache:
    paths:
      - node_modules/
  artifacts:
    paths:
      - disk/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app:
  stage: test_app
  script: echo Hello
  rules:
    - when: always

deploy_app:
  stage: deploy_app
  script:
    - echo Hello
    - ls disk/

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `GLCI-06 Тесты на двух версиях Node.js параллельно`

 ### 🎯 Цель урока
Matrix jobs и параллельные job’ы в GitLab CI/CD
---

 ## 📘 Теория (кратко)

🔹 Что такое parallel jobs?

Это способ выполнять несколько job’ов одновременно, чтобы:
	•	ускорить pipeline
	•	тестировать параллельно
	•	минимизировать дублирование кода

🔸 Способы:

1. Обычное распараллеливание

Несколько job’ов с одинаковым stage, но разными задачами:
test_node14:
  stage: test
  image: node:14
  script: npm test

test_node18:
  stage: test
  image: node:18
  script: npm test
▶️ Эти job’ы выполняются одновременно, потому что находятся в одном stage.

2. Параметр parallel:
tests:
  stage: test
  script: run_tests.sh
  parallel: 4
▶️ Создаст 4 одинаковых job с индексами от 0 до 3. Это удобно для разбиения по shard’ам (частям данных/тестов).

Внутри job будет переменная $CI_NODE_INDEX.

3. Matrix strategy (GitLab Premium / Ultimate)
.test_template:
  stage: test
  script: npm test

test_matrix:
  extends: .test_template
  parallel:
    matrix:
      - NODE_VERSION: [14, 16, 18]
🔹 GitLab создаст 3 job:
	•	с NODE_VERSION=14
	•	с NODE_VERSION=16
	•	с NODE_VERSION=18

🧠 Используемые переменные:
CI_NODE_TOTAL Общее количество parallel job’ов
CI_NODE_INDEX Индекс текущего job’а
NODE_VERSION Значение из matrix

 ## Конспект:
🟦 parallel:
- Запускает N одинаковых job
- Поддерживает переменные: CI_NODE_INDEX, CI_NODE_TOTAL

🟧 matrix:
- Создаёт job'ы с разными параметрами
- Нужно использовать extends или шаблонную job

💡 Параллельные job'ы → экономия времени + масштабируемость

---

### Задание

1. Добавь в .gitlab-ci.yml job, который:
	•	расширяет шаблонную job
	•	запускает тесты с NODE_VERSION: 14 и NODE_VERSION: 18
	•	использует parallel.matrix (если Premium недоступен — сделай два job вручную)

1. `Добавь шаблонную job (например, .test_template)`

```
touch .github/workflows/docker-build.yml
```
2. `Создай test_matrix job с matrix или два отдельных: test_node14, test_node18`

```

```
3. `Убедись, что в логах видно версию Node:`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy_app

build_app:
  stage: build_app
  script:
    - echo Hello
    - npm ci
  cache:
    paths:
      - node_modules/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app17:
  stage: test_app
  image: node:17
  script: npm test

test_app18:
  stage: test_app
  image: node:18
  script: npm test

deploy_app:
  stage: deploy_app
  script:
    - echo Hello

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-07 — Сборка и публикация Docker-образа в GitLab Registry`

 ### 🎯 Цель урока
Интеграция с GitLab Container Registry
---

 ## 📘 Теория (кратко)

🔹 Что такое GitLab Container Registry?

Это встроенный Docker Registry, привязанный к каждому GitLab-проекту. Он позволяет:
	•	хранить Docker-образы,
	•	использовать их в пайплайнах и деплоях,
	•	автоматизировать CI/CD-сборку и публикацию.

📦 Работает по адресу:
registry.gitlab.com/<namespace>/<project>
или
gitlab.example.com:5050/<namespace>/<project> — для self-hosted

🔐 Аутентификация

GitLab автоматически предоставляет переменные:
	•	$CI_REGISTRY — адрес Registry
	•	$CI_REGISTRY_IMAGE — путь образа
	•	$CI_REGISTRY_USER — логин (обычно = gitlab-ci-token)
	•	$CI_REGISTRY_PASSWORD — временный токен

🛠 Стандартная схема CI-сборки:
build_image:
  stage: build
  image: docker:latest
  services:
    - docker:dind
  script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD" "$CI_REGISTRY"
    - docker build -t "$CI_REGISTRY_IMAGE:latest" .
    - docker push "$CI_REGISTRY_IMAGE:latest"
Важно: нужен docker:dind (Docker-in-Docker), чтобы запускать docker build внутри CI.

📁 Dockerfile — минимальный
FROM node:18
WORKDIR /app
COPY . .
RUN npm ci
CMD ["npm", "start"]

 ## Ключевые команды:

---

### Задание

1.

1. ` `

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-08 Notifications и integration (Slack, etc)`

 ### 🎯 Цель урока
Уведомления и интеграции (Slack, Telegram, Discord и др.)

---

 ## 📘 Теория (кратко)

🔹 Зачем нужны уведомления?

В реальной разработке pipeline:
	•	ломаются (и об этом нужно знать),
	•	успешно проходят (но можно фильтровать),
	•	требуют ручного действия (например, manual deploy).

Оповещения = реакция команды в реальном времени.

⸻

🔸 Поддерживаемые интеграции GitLab:
	•	Slack
	•	Microsoft Teams
	•	Telegram (через Webhook)
	•	Discord (через Webhook)
	•	Mattermost
	•	Email, Webhook, Prometheus, Sentry, PagerDuty и др.

🔧 Способы настроек

✅ 1. Slack через GitLab UI (рекомендуется)
	1.	Перейди в:
Settings → Integrations → Slack notifications
	2.	Настрой Webhook (из Slack → Apps → Incoming Webhooks)
	3.	Выбери события:
✅ Pipeline events, ✅ Job events

🔹 GitLab будет автоматически отправлять сообщения по событиям CI/CD.

✅ 2. Slack через Webhook в .gitlab-ci.yml (гибче)

Если хочешь кастомное сообщение, используй curl:
notify_slack:
  stage: notify
  script:
    - curl -X POST -H 'Content-type: application/json' --data '{"text":"✅ Pipeline Succeeded!"}' $SLACK_WEBHOOK_URL
  rules:
    - if: '$CI_JOB_STATUS == "success"'
🔐 SLACK_WEBHOOK_URL добавляется в GitLab → Settings → CI/CD → Variables (Masked)

🧠 Полезные переменные
CI_PIPELINE_STATUS
Статус pipeline (success, failed)
CI_JOB_STATUS
Статус job
CI_COMMIT_BRANCH
Ветка
CI_PROJECT_NAME
Название


 ## Ключевые команды:1

---

### Задание

1. Сделай отдельную job notify_slack, которая:
	•	использует Webhook
	•	отправляет JSON-сообщение об успехе pipeline
	•	работает только при success

1. `Добавь в GitLab: •	Settings → CI/CD → Variables •	Name: SLACK_WEBHOOK_URL •	Value: твой Slack Webhook (masked, protected — желательно)`
```

```
2. `Добавь в .gitlab-ci.yml job:`
```

```
3. `Результат`
```
image: node:18

stages:
  - build_app
  - test_app
  - deploy_app
  - notify

build_app:
  stage: build_app
  script:
    - echo Hello
    - npm ciloosadgdsg
  cache:
    paths:
      - node_modules/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app17:
  stage: test_app
  image: node:17
  script: npm test
    - echo Hello

deploy_app:
  stage: deploy_app
  script:
    - echo Hello

notify_success:
  stage: notify
  script:
    - |
      MESSAGE="✅ УСПЕХ%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_success
  allow_failure: false

notify_failure:
  stage: notify
  script:
    - |
      MESSAGE="❌ ОШИБКА%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_failure
  allow_failure: true

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`GitLab CI/CD`" - `GLCI-09 CI/CD variables: secret, protected`

 ### 🎯 Цель урока
CI/CD переменные: секретные, protected и file

---

 ## 📘 Теория (кратко)

🔹 Что такое переменные CI/CD?

Это значения, которые можно использовать в .gitlab-ci.yml, чтобы:
	•	скрыть секреты (токены, ключи, пароли)
	•	задавать параметры окружения (например, NODE_ENV=production)
	•	переиспользовать конфигурации между job’ами

📂 Где задаются?

🔹 GitLab UI
Settings → CI/CD → Variables

🔹 В .gitlab-ci.yml (не для секретов):
variables:
  NODE_ENV: production

🔐 Типы переменных (по флагам)
Protected Переменная доступна только в protected-ветках и тегах
Masked Значение не видно в логах, даже при echo $TOKEN
File Значение сохраняется как временный файл — удобно для ключей и конфигов

🔐 Masked vs обычная переменная
echo $TOKEN
	•	Если Masked — ты увидишь *** в логе.
	•	Если нет — токен попадёт в лог = утечка.

📂 Protected branches и tags

Если ты пометишь ветку как protected, то:
	•	В ней работают только protected variables
	•	Только разрешённые пользователи могут пушить

Пример:
	•	PROD_API_KEY — protected
	•	Работает только в main, release/*, prod ветках

📁 File-переменные

Для случаев, где нужно физически записать файл (например, kubeconfig, service-account.json):
deploy:
  script:
    - echo "$KUBECONFIG_CONTENT" > kubeconfig.yaml
    - kubectl apply -f kubeconfig.yaml
Если KUBECONFIG_CONTENT = File-переменная — GitLab сам создаст временный файл, и ты можешь его использовать как путь.

 ## Ключевые команды:


---

### Задание

1.

1. ` `

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-10 Deploy job: SSH, SCP, rsync`

 ### 🎯 Цель урока
Deploy job через SSH, SCP и rsync

---

 ## 📘 Теория (кратко)

🔹 Когда нужен SSH-деплой?

В реальных проектах:
	•	нет Kubernetes или облака,
	•	деплой происходит на VM или bare metal сервере,
	•	нет доступа к CI Runner на проде.

🔐 Тогда CI/CD деплой происходит по SSH.

🔧 Способы деплоя с GitLab CI:
SSH Выполнение команд на удалённом сервере
SCP Копирование файлов
rsync Копирование с оптимизацией и

🔐 Как передать SSH-ключи?

1. Создай SSH-ключ:
ssh-keygen -t rsa -b 4096 -C "gitlab-ci"
2. Добавь публичный ключ в ~/.ssh/authorized_keys на целевом сервере
3. Добавь приватный ключ как переменную в GitLab:
	•	SSH_PRIVATE_KEY (masked, protected)

🛠 Подключение по SSH в .gitlab-ci.yml
deploy_app:
  stage: deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache openssh-client
    - mkdir -p ~/.ssh
    - echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
    - chmod 600 ~/.ssh/id_rsa
    - ssh-keyscan -H $DEPLOY_HOST >> ~/.ssh/known_hosts
  script:
    - scp ./dist/* $DEPLOY_USER@$DEPLOY_HOST:/var/www/html/
    - ssh $DEPLOY_USER@$DEPLOY_HOST 'sudo systemctl restart myapp'
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'

🔑 Что ещё добавить в GitLab Variables:
SSH_PRIVATE_KEY -----BEGIN RSA... File, masked, protected
DEPLOY_USER ubuntu обычная
DEPLOY_HOST 192.168.1.100 или prod.example.com обычная


 ## Ключевые команды:


---

### Задание

1.


1. ` `

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `GLCI-11 Manual jobs и environment`

 ### 🎯 Цель урока
Manual jobs и environments: контроль, staging и прод

---

 ## 📘 Теория (кратко)

🔹 Manual job — запуск вручную

Иногда нужно, чтобы job не запускалась автоматически, а только по кнопке:
	•	ручной деплой на production,
	•	одобрение QA,
	•	запуск очистки или бэкапа.
job_name:
  script: ...
  when: manual
🔹 Можно комбинировать с allow_failure: true, чтобы она не ломала pipeline, если не запущена.

🔹 Environments — окружения в GitLab

GitLab позволяет вести трекинг деплоев в разные среды (например, dev, staging, prod).
deploy_staging:
  environment:
    name: staging
    url: https://staging.example.com
📍 В GitLab появится вкладка Deployments, где видно:
	•	кто деплоил,
	•	когда,
	•	на какое окружение,
	•	commit SHA и pipeline.

🔄 Смена окружения

GitLab умеет:
	•	показывать активную версию на staging/prod,
	•	переключать между окружениями,
	•	сравнивать состояния.

🧠 Типовой пример:
deploy_production:
  stage: deploy
  script:
    - echo "Deploy to PROD"
  environment:
    name: production
    url: https://prod.example.com
  when: manual
  only:
    - main



 ## Ключевые команды:

---

### Задание

1. Создай job:
	•	имя: deploy_staging
	•	тип: manual
	•	окружение: staging
	•	URL: https://staging.example.com
	•	команда: echo Deploy to STAGING


1. `Добавь в .gitlab-ci.yml`

```
deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to STAGING"
  when: manual
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main
```
2. `Сделай push в main`

```

```
3. `В UI появится кнопка “Play” в пайплайне`

```

```
4. `Запусти job и проверь, что в Deployments → staging появилась запись`

```

```
5. `Результат`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy
  - notify

build_app:
  stage: build_app
  script:
    - echo Hello
    - npm ci
  cache:
    paths:
      - node_modules/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app:
  stage: test_app
  image: node:17
  script: npm test
    - echo Hello

deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to STAGING"
  when: manual
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

notify_success:
  stage: notify
  script:
    - |
      MESSAGE="✅ УСПЕХ%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_success
  allow_failure: false

notify_failure:
  stage: notify
  script:
    - |
      MESSAGE="❌ ОШИБКА%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_failure
  allow_failure: true

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-12 Review Apps и dynamic environments`

 ### 🎯 Цель урока
Review Apps и Dynamic Environments

---

 ## 📘 Теория (кратко)
🔹 Что такое Review App?

Review App — это временное окружение, которое GitLab создаёт на каждую ветку или Merge Request. Например:
	•	MR feature/login создаёт review/feature-login с сайтом feature-login.example.com
	•	После мержа — автоматически удаляется

🧠 Это позволяет:
	•	Тестировать каждую ветку изолированно
	•	Демонстрировать изменения менеджеру или QA
	•	Не держать всё в staging

🔹 Что такое dynamic environment?

Dynamic environment — это переменная часть имени окружения, которая зависит от ветки или MR.
environment:
  name: review/$CI_COMMIT_REF_SLUG
  url: https://$CI_COMMIT_REF_SLUG.example.com
📌 $CI_COMMIT_REF_SLUG = slug-версия имени ветки (feature/login → feature-login)

🔁 Автоматическое удаление

GitLab умеет удалять временные окружения:
environment:
  name: review/$CI_COMMIT_REF_SLUG
  action: stop
Job со action: stop можно триггерить по кнопке или автоматически в GitLab UI при закрытии MR.

🧠 Пример: деплой на поддомен
deploy_review:
  stage: deploy
  script:
    - ./deploy.sh $CI_COMMIT_REF_SLUG
  environment:
    name: review/$CI_COMMIT_REF_SLUG
    url: https://$CI_COMMIT_REF_SLUG.example.com
  only:
    - merge_requests

 ## Ключевые команды:

---

### Задание

1.

1. ` `

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `GLCI-13 Include, extends, `

 ### 🎯 Цель урока
Include, extends и templates в GitLab CI/CD
---

 ## 📘 Теория (кратко)

🔹 Проблема

Когда .gitlab-ci.yml разрастается, он становится:
	•	нечитабельным,
	•	неудобным для поддержки,
	•	сложным для повторного использования.

🧠 Решение: разбить на части и переиспользовать код.

🔸 1. include: — подключение внешних .yml файлов
include:
  - local: 'ci/deploy.yml'
  - project: 'group/other-project'
    file: '/templates/test.yml'
  - remote: 'https://example.com/gitlab-ci-template.yml'
local Файл внутри текущего проекта
project Файл из другого проекта
remote Внешний URL
template Официальные шаблоны GitLab (например, Docker, Go, Node.js

🔸 2. extends: — переиспользование job-шаблонов
Позволяет создать базовую job, а потом на её основе создавать другие:
.default_test_template:
  script:
    - npm ci
    - npm test
  image: node:18

unit_test:
  extends: .default_test_template
  stage: test
🧠 Все поля script, image, before_script и т.д. унаследуются.

🔸 3. default: — переопределение значений по умолчанию
default:
  image: node:18
  before_script:
    - npm ci
Тогда в каждой job не нужно повторять это снова.

✅ Пример большого пайплайна:
include:
  - local: 'ci/deploy.yml'
  - remote: 'https://gitlab.com/templates/node-ci.yml'

default:
  image: node:18
  before_script:
    - npm ci

.test_template:
  script:
    - npm test

test_unit:
  extends: .test_template
  stage: test


 ## Ключевые команды:


---

### Задание

1. 	Вынеси job деплоя в файл ci/deploy.yml
2.	Создай шаблон .test_template и используй его в unit_test
3.	Добавь include: local: ci/deploy.yml

1. `Файл 1: .gitlab-ci.yml`

```
include:
  - local: 'ci/deploy.yml'

default:
  image: node:18

.test_template:
  script:
    - npm test

unit_test:
  extends: .test_template
  stage: test
```
2. `Файл 2: ci/deploy.yml`

```
deploy_prod:
  stage: deploy
  script:
    - echo "Deploy to PROD"
  only:
    - main
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-14 Мониторинг и отчёты в пайплайне`

 ### 🎯 Цель урока
Мониторинг и отчёты в GitLab CI/CD

---

 ## 📘 Теория (кратко)

🔹 Зачем мониторинг внутри CI/CD?

DevOps — это не только деплой. Это:
	•	проверка качества: тесты, линт, покрытие,
	•	сбор артефактов: HTML-отчёты, скриншоты,
	•	визуализация результатов.

🧠 GitLab CI поддерживает:
	•	junit отчёты (unit-тесты)
	•	coverage (покрытие кода)
	•	HTML-отчёты (линтеры, тесты, сканеры)

🔸 1. JUnit отчёты

Формат: XML-файл junit.xml.
Добавь в job:
unit_tests:
  script:
    - npm test -- --reporters=jest-junit
  artifacts:
    reports:
      junit: report.xml
📊 Результаты появятся в GitLab UI → Tests → ✔/❌

🔸 2. Покрытие кода (coverage:)

GitLab умеет собирать и отображать % покрытия прямо в UI.
unit_tests:
  coverage: '/All files[^|]*\|[^|]*\s+([\d\.]+)/'
Ты можешь:
	•	задать регулярку,
	•	видеть покрытие прямо в Merge Request,
	•	добавить “fail if coverage < threshold”.

🔸 3. HTML-отчёты

Например, ESLint, Jest, Lighthouse, SAST — всё, что может сгенерировать HTML.
lint_job:
  script:
    - npm run lint
  artifacts:
    paths:
      - eslint-report.html
    reports:
      dotenv: eslint-report.html
Или просто:
  artifacts:
    paths:
      - coverage/
GitLab отобразит это как доступный для скачивания артефакт.


 ## Ключевые команды:

---

### Задание

1.Добавь в pipeline:
	•	unit_tests job
	•	отчёт в формате JUnit (report.xml)
	•	регулярку на coverage (вывод вида: Coverage: 84.2%)
	•	HTML-отчёт из coverage/index.html

1. `Убедись, что coverage выводится в логах.`

```
unit_tests:
  stage: test
  script:
    - npm run test -- --coverage
    - cp coverage/lcov-report/index.html coverage/index.html
  coverage: '/Coverage:\s(\d+\.\d+)%/'
  artifacts:
    paths:
      - coverage/index.html
    reports:
      junit: report.xml
```
2. `	Зайди в UI → Tests, Coverage, Download.`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy
  - notify

build_app:
  stage: build_app
  script:
    - echo Hello
    - npm ci
  cache:
    paths:
      - node_modules/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app:
  stage: test_app
  script:
    - npm run test -- --coverage
    - cp coverage/lcov-report/index.html coverage/index.html
  coverage: '/Coverage:\s(\d+\.\d+)%/'
  artifacts:
    paths:
      - coverage/index.html
    reports:
      junit: report.xml

deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to STAGING"
  when: manual
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

notify_success:
  stage: notify
  script:
    - |
      MESSAGE="✅ УСПЕХ%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_success
  allow_failure: false

notify_failure:
  stage: notify
  script:
    - |
      MESSAGE="❌ ОШИБКА%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_failure
  allow_failure: true

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `GLCI-15 CI/CD для монорепы`

 ### 🎯 Цель урока
CI/CD для монорепозитория (monorepo)

---

 ## 📘 Теория (кратко)

🔹 Что такое монорепозиторий?

Monorepo (монорепозиторий) — это один Git-репозиторий, в котором хранятся несколько приложений, сервисов или компонентов.

Пример структуры:
.
├── services/
│   ├── frontend/
│   ├── backend/
│   └── api-gateway/
├── shared/
│   └── utils/
.gitlab-ci.yml

🔸 Проблема

При каждом коммите:
	•	GitLab запускает весь пайплайн, даже если ты изменил только frontend/
	•	Это медленно, неэффективно и дорого

✅ Решения

1. Использовать rules: changes:
build_frontend:
  script: cd services/frontend && npm run build
  rules:
    - changes:
        - services/frontend/**/*
🔹 GitLab сравнивает изменённые файлы, и запускает job только при наличии изменений.

2. Использовать include-файлы для подмодулей

Разделяй пайплайн на отдельные файлы:
include:
  - local: .gitlab-ci/frontend.yml
  - local: .gitlab-ci/backend.yml
Каждый файл содержит job’ы для соответствующего сервиса.

3. Переиспользование шаблонов через extends

Создай шаблон job’а и применяй к нужным модулям:
.build_template:
  script:
    - npm ci
    - npm run build

build_backend:
  extends: .build_template
  rules:
    - changes:
        - services/backend/**/*

💡 Best practices
rules: changes: для избирательных запусков
include: для разделения логики
extends: для шаблонов


 ## Ключевые команды:

---

### Задание

1. Создай job:
	•	build_frontend
	•	Запускается ТОЛЬКО если изменён код в services/frontend/**
	•	Выполняет: npm install && npm run build

1. `Можно сделать такой же job для backend — повторить с другой директорией.`
```
build_frontend:
  stage: build
  script:
    - cd services/frontend
    - npm install
    - npm run build
  rules:
    - changes:
        - services/frontend/**/*
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`GitLab CI/CD`" - `DOCKER-GLCI-01 Docker-образ: сборка и пуш в GitLab Registry`

 ### 🎯 Цель урока
Собрать Docker-образ приложения и автоматически запушить его в GitLab Container Registry с помощью .gitlab-ci.yml.

---

 ## 📂 Исходные условия:
	•	Есть проект в GitLab с исходным кодом (можно заглушку).
	•	Установлен и зарегистрирован GitLab Runner (shared или custom).
	•	Docker доступен на runner’е (shell- или docker-executor с установленным Docker).
	•	Приватный токен/логин не нужен, если используешь встроенный GitLab Registry (он работает по CI_REGISTRY, CI_REGISTRY_IMAGE, CI_JOB_TOKEN).

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

1. `Добавь .gitlab-ci.yml, в котором: •	есть stage build •	job использует Docker •	билдит образ •	пушит его в registry.gitlab.com/<твой_юзер>/<твой_проект>:latest`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy
  - notify

build_app:
  stage: build_app
  image: docker:24.0.7
  services:
    - docker:24.0.7-dind
  variables:
    DOCKER_DRIVER: overlay2
  before_script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_JOB_TOKEN" "$CI_REGISTRY"
  script:
    - docker build -t "$CI_REGISTRY_IMAGE:latest" .
    - docker push "$CI_REGISTRY_IMAGE:latest"

test_app:
  stage: test_app
  script:
    - npm run test -- --coverage
    - cp coverage/lcov-report/index.html coverage/index.html
  coverage: '/Coverage:\s(\d+\.\d+)%/'
  artifacts:
    paths:
      - coverage/index.html
    reports:
      junit: report.xml

deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to STAGING"
  when: manual
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

notify_success:
  stage: notify
  script:
    - |
      MESSAGE="✅ УСПЕХ%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_success
  allow_failure: false

notify_failure:
  stage: notify
  script:
    - |
      MESSAGE="❌ ОШИБКА%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_failure
  allow_failure: true


```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`GitLab CI/CD`" - `DOCKER-GLCI-02 Автосборка по пушу в main`

 ### 🎯 Цель урока
Настроить CI/CD-процесс так, чтобы Docker-образ автоматически собирался и пушился в GitLab Registry при каждом коммите в ветку main.

---

 ## 📂 Исходные условия:
	•	.gitlab-ci.yml уже содержит job по сборке Docker-образа (см. DOCKER-GLCI-01)
	•	Проект размещён в GitLab, ветка main есть


 ## Ключевые команды:


---

### Задание

1.


1. `1.	Ограничь запуск сборки только для ветки main в job’е build_app:
🔹 Используй директиву:`

```
rules:
  - if: '$CI_COMMIT_BRANCH == "main"'
    when: always
```
2. `Результат`

```
touch .github/workflows/conditional.yml

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`GitLab CI/CD`" - `DOCKER-GLCI-03 — CI/CD с multi-stage Dockerfile`

 ### 🎯 Цель урока
Оптимизировать Dockerfile проекта с помощью multi-stage build, а затем настроить .gitlab-ci.yml, чтобы он использовал этот новый, более эффективный процесс сборки и пуша образа.

---

 ## 📂 Исходные условия:
	•	У тебя уже есть рабочий .gitlab-ci.yml и Dockerfile
	•	Используется Node.js (судя по предыдущим job’ам)
	•	Образ пушится в GitLab Registry

 ## Ключевые команды:

---

### Задание


1. `Перепиши Dockerfile в формате multi-stage: •	Первый stage: сборка приложения (node install, npm run build) •	Второй stage: только финальные артефакты, например dist/, public/, без node_modules, кэша, etc. Пример (если фронтенд-приложение на Node):`

```
# Stage 1: Build
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2: Runtime
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
```
2. `Обнови .gitlab-ci.yml: •	Ничего принципиально менять не нужно, если docker build по-прежнему находит Dockerfile`

```
image: node:18

stages:
  - build_app
  - test_app
  - deploy
  - notify

build_app:
  stage: build_app
  image: docker:24.0.7
  services:
    - docker:24.0.7-dind
  variables:
    DOCKER_DRIVER: overlay2
  before_script:
    - docker login -u "$CI_REGISTRY_USER" -p "$CI_JOB_TOKEN" "$CI_REGISTRY"
  script:
    - docker build -t "$CI_REGISTRY_IMAGE:latest" .
    - docker push "$CI_REGISTRY_IMAGE:latest"
  cache:
    paths:
      - node_modules/
  rules:
    - if: '$CI_COMMIT_BRANCH == "main"'
      when: always
    - when: never

test_app:
  stage: test_app
  script:
    - npm run test -- --coverage
    - cp coverage/lcov-report/index.html coverage/index.html
  coverage: '/Coverage:\s(\d+\.\d+)%/'
  artifacts:
    paths:
      - coverage/index.html
    reports:
      junit: report.xml

deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to STAGING"
  when: manual
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - main

notify_success:
  stage: notify
  script:
    - |
      MESSAGE="✅ УСПЕХ%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_success
  allow_failure: false

notify_failure:
  stage: notify
  script:
    - |
      MESSAGE="❌ ОШИБКА%0AПроект: *${CI_PROJECT_NAME}*%0AВетка: *${CI_COMMIT_BRANCH}*%0A[Пайплайн](${CI_PIPELINE_URL})"
      curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
        -d chat_id="${TG_CHAT_ID}" \
        -d text="${MESSAGE}" \
        -d parse_mode=Markdown
  when: on_failure
  allow_failure: true

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


