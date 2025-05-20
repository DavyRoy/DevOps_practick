# Модуль "`Jenkins`" - `JEN-01: Установка Jenkins в Docker`

 ### 🎯 Цель урока
Установка Jenkins в Docker

---

 ## 📘 Теория (кратко)

🔹 Что такое Jenkins?

Jenkins — сервер автоматизации с открытым исходным кодом. Он позволяет:
	•	запускать пайплайны CI/CD,
	•	подключать тысячи плагинов (Docker, GitHub, GitLab, Kubernetes),
	•	управлять задачами через UI или Jenkinsfile.

🔹 Зачем запускать Jenkins в Docker?
	•	Быстрое развертывание без установки на хост.
	•	Лёгкая миграция конфигураций (volume).
	•	Можно запускать на любой машине, где есть Docker.

🔹 Компоненты контейнерного запуска:
jenkins/jenkins:lts Официальный образ Jenkins
-p 8080:8080 Порт для UI
-v jenkins_home:/var/jenkins_home Постоянное хранилище данных
docker network Для будущей интеграции с агентами и Docker

 ## Конспект :

- `docker volume create jenkins_home

docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

  	•	UI: http://localhost:8080
	•	Админ-пароль: docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`


---

### Задание

1. Разверни Jenkins в Docker с постоянным хранилищем и доступом по localhost:8080.


1. `Создай volume для хранения конфигураций.`

```
docker volume create jenkins_home
```
2. `Дождись готовности и получи initial password.`

```
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```
3. `Заполните здесь этапы выполнения, если требуется ....`

```
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
4. `Зайди на localhost:8080 и проверь, работает ли Jenkins.`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`Jenkins`" - `JEN-02: Первичная настройка и плагины`

 ### 🎯 Цель урока
Первичная настройка Jenkins

---

 ## 📘 Теория (кратко)

🔹 После запуска Jenkins:
	1.	Ввод initial admin password
→ его можно получить из контейнера:
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

	2.	Выбор типа установки
	•	⚡ Install suggested plugins — быстрее, подойдёт для большинства
	•	🧩 Select plugins to install — для тонкой настройки
	3.	Создание admin-пользователя
Важно задать логин и пароль, которые ты запомнишь (используем в будущем для интеграций с Git, Docker и т.д.)
	4.	Настройка URL Jenkins (Jenkins URL)
Оставь http://localhost:8080 — позже может пригодиться для вебхуков и API.

🔹 Плагины: зачем и какие?

Jenkins — это ядро + плагины.
Без плагинов Jenkins ничего не умеет: ни собирать Docker, ни работать с GitHub.
🐙 Git Git plugin подключение Git-реп
🐳 Docker Docker plugin, Docker Pipeline работа с контейнерами
🧬 CI/CD Pipeline DSL-пайплайны
💻 UI Blue Ocean улучшенный интерфейс пайплайнов
🔑 Credentials Credentials Binding безопасное хранение секретов
☁️ SCM GitHub, GitLab интеграции
⚠️ Безопасность Role Strategy разграничение прав


 ## Конспект:

   •	Пароль для входа: docker exec jenkins cat /var/.../initialAdminPassword
	•	Выбери “Install suggested plugins”
	•	Создай admin-пользователя
	•	Установи:
	•	Git plugin
	•	Docker Pipeline
	•	Blue Ocean
	•	GitHub plugin
	•	Pipeline

---

### Задание

1. Произвести начальную настройку Jenkins и установить ключевые плагины.


1. `Зайди в браузер на http://localhost:8080`

```

```
2. `Введи initial password`

```

```
3. `Выбери Install suggested plugins`

```

```
4. `Создай админ-учётку`

```

```
5. `Дождись установки плагинов`

```

```
6. `Перейди в Manage Jenkins → Plugins → Installed`

```

```

6. `Установи дополнительно: •	Docker Pipeline •	GitHub •	Blue Ocean (UI)`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Jenkins`" - `JEN-03: Концепция Job’ов: Freestyle и Pipeline`

 ### 🎯 Цель урока
Job’ы в Jenkins

---

 ## 📘 Теория (кратко)

🔹 Что такое Job?

Job (или проект) — это единица работы в Jenkins.
Когда ты хочешь что-то собрать, протестировать, запустить, ты создаёшь Job.

⸻

🔹 Виды Job’ов:
Freestyle Project - GUI-настройка шагов - Простые задачи, новичкам
Pipeline Project - Код (Jenkinsfile) - Продвинутые пайплайны, GitOps
Multibranch Pipeline - Автоматизация для всех веток Git - Большие проекты с CI/CD
External Job / Folder / DSL - Спец. назначения - Особые случаи

🔹 Freestyle Jobs
	•	Шаги указываются в UI
	•	Можно подключать Git, билдить, тестировать
	•	Мало гибкости, сложно поддерживать

📌 Пример:
	•	SCM → GitHub репозиторий
	•	Build → Shell-команда npm install && npm test

🔹 Pipeline Jobs
	•	Написаны в виде Jenkinsfile (DSL-скрипт)
	•	Гибкие, version-controlled
	•	Можно делать много стадий, параллелизм, условия

📌 Пример Jenkinsfile:
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh 'npm install'
      }
    }
    stage('Test') {
      steps {
        sh 'npm test'
      }
    }
  }
}

 ## Конспект:

    •	Freestyle: графическая настройка
	•	Pipeline: код в Jenkinsfile
	•	Pipeline лучше для автоматизации и GitOps
	•	Jenkinsfile = декларативное описание пайплайна
	•	Оба типа можно запускать вручную или по событиям

---

### Задание

1. Создай в Jenkins два задания:
	•	Freestyle Job: сборка простого проекта
	•	Pipeline Job: тот же проект через Jenkinsfile


1. `Создай New Item → Pipeline → "hello-pipeline"`

```

```
2. `Выбери “Pipeline script” или “Pipeline from SCM"`

```

```
3. `Добавь Jenkinsfile с простым пайплайном:`

```
pipeline {
  agent any
  stages {
    stage('Hello') {
      steps {
        echo 'Hello from Pipeline!'
      }
    }
  }
}
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Jenkins`" - `JEN-04: Создание первого Freestyle Job’а`

 ### 🎯 Цель урока
Как работает Freestyle Job

---

 ## 📘 Теория (кратко)

🔹 Что делает Freestyle Job?
	•	Клонирует репозиторий из Git (или другого SCM)
	•	Выполняет shell-команды (сборка, тесты)
	•	Может архивировать артефакты, отправлять уведомления, запускать другие Job’ы

⸻

🔹 Основные блоки в UI:
General Название, описание, GitHub integration
Source Code Management Git-репозиторий проекта
Build Triggers Когда запускать (вручную, по таймеру, webhook)
Build Environment Переменные, cleanup и др.
Build Steps Шаги: shell, make, docker и т.д.
Post-build Actions Что делать после (архивация, рассылка)

Пример использования:

Ты хочешь:
	•	Клонировать свой проект с GitHub
	•	Выполнить npm install && npm test
	•	Сохранить отчёт test-results.xml как артефакт

 ## Конспект:

	•	Freestyle Job = UI + shell-команды
	•	Обязательно указывай репозиторий
	•	Build step → Execute shell → твои команды
	•	После билда можешь архивировать файлы (Post-build Actions → Archive artifacts)


---

### Задание

1. Создай в Jenkins настоящий Freestyle Job, который:
	•	Клонирует твой GitHub-репозиторий
	•	Выполняет shell-команды
	•	Архивирует один файл как артефакт


1. `New Item → Freestyle project → "build-freestyle"`

```

```
2. `Source Code Management → Git •	Введи URL своего репозитория, например: https://github.com/username/jenkins-docker-lab.git`

```

```
3. `Build Steps → Execute Shell:`

```
echo "Установка зависимостей"
npm install || true  # если нет package.json, не упадёт

echo "Сборка или тест"
echo "Hello Jenkins" > result.txt
```
4. `Вывод`

```
Started by user sergey
Running as SYSTEM
Building in workspace /var/jenkins_home/workspace/build-freestyle
[build-freestyle] $ /bin/sh -xe /tmp/jenkins6278463253508147183.sh
+ echo Установка зависимостей
Установка зависимостей
+ npm install
/tmp/jenkins6278463253508147183.sh: 3: npm: not found
+ true
+ echo Сборка или тест
Сборка или тест
+ echo Hello Jenkins
Recording fingerprints
Finished: SUCCESS
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Jenkins`" - `JEN-05: Основы Pipeline DSL (Declarative vs Scripted)`

 ### 🎯 Цель урока
Jenkins Pipeline DSL

---

 ## 📘 Теория (кратко)

🔹 Что такое Jenkins Pipeline?

Jenkins Pipeline — это способ описания CI/CD процессов в виде кода.
Записывается в файл Jenkinsfile, который добавляется в репозиторий проекта.

🔹 Преимущества:
	•	💾 Хранение в Git (история, ревью, откаты)
	•	🔁 Повторяемость
	•	🧩 Гибкость: условия, параллельность, reuse
	•	🔐 Лучшее управление секретами

🔹 Виды синтаксиса Pipeline:
Declarative - Простой и читаемый DSL - 80% задач в CI/CD
Scripted  - На Groovy, как полноценный язык - Сложная логика, циклы, API

📘 Declarative Pipeline (рекомендуется)
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        echo 'Сборка проекта...'
      }
    }
    stage('Test') {
      steps {
        echo 'Тесты идут...'
      }
    }
  }
}

📘 Scripted Pipeline (Groovy API)
node {
  stage('Build') {
    echo 'Сборка проекта...'
  }
  stage('Test') {
    echo 'Тесты идут...'
  }
}

🧠 Ключевые элементы Declarative:
pipeline {} корневая структура
agent any где запускать (any, label, docker)
stages {} последовательные этапы
stage('name') этап пайплайна
steps {} команды shell, скрипты
environment {} переменные
post {} действия после билдов (success/failure/always)


 ## Конспект:

	•	Jenkinsfile — файл с описанием CI/CD
	•	Declarative — проще, безопаснее, читаемее
	•	Scripted — мощнее, но сложнее
	•	pipeline → agent → stages → stage → steps
	•	Используем echo, sh, checkout scm, archiveArtifacts


---

### Задание

1. Создай Jenkins Pipeline Job, который читает Jenkinsfile из репозитория.


1. `В своём репозитории (jenkins-docker-lab) создай новый файл: Jenkinsfile`

```

```
2. `Напиши простой Declarative Pipeline:`

```
pipeline {
  agent any

  stages {
    stage('Hello') {
      steps {
        echo 'Hello from Declarative Pipeline!'
      }
    }
  }
}
```
3. `В Jenkins: •	New Item → Pipeline → hello-pipeline-file •	Выбери: “Pipeline from SCM” •	Укажи Git URL и путь к Jenkinsfile`

```

```
4. `Запусти сборку. Убедись, что pipeline работает, и выводит сообщение.`

```
Started by user sergey
Obtained Jenkins/jenkins-docker-lab/Jenkinsfile from git https://github.com/DavyRoy/DevOps_practick.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/hello-pipeline-file
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential GitHub
Cloning the remote Git repository
Cloning repository https://github.com/DavyRoy/DevOps_practick.git
 > git init /var/jenkins_home/workspace/hello-pipeline-file # timeout=10
Fetching upstream changes from https://github.com/DavyRoy/DevOps_practick.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.5'
using GIT_ASKPASS to set credentials GitHub Access Token
 > git fetch --tags --force --progress -- https://github.com/DavyRoy/DevOps_practick.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/DavyRoy/DevOps_practick.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 49488f6040df68fddf22fc75a160fb627d4e7c44 (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 49488f6040df68fddf22fc75a160fb627d4e7c44 # timeout=10
Commit message: "Jenkins 01"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Hello)
[Pipeline] echo
Hello from Declarative Pipeline!
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Jenkins`" - `JEN-06: Jenkinsfile и Git — интеграция с репозиторием`

 ### 🎯 Цель урока
Git + Jenkins Pipeline

---

 ## 📘 Теория (кратко)

🔹 Jenkinsfile в Git
	•	Jenkins может брать pipeline напрямую из репозитория
	•	Это делается через “Pipeline from SCM”
	•	Jenkinsfile должен находиться в корне проекта или по указанному пути

🔹 Способы подключения репозитория:
HTTPS - https://github.com/user/repo.git - Доступен публично или через токен
SSH - git@github.com:user/repo.git - Jenkins должен иметь SSH-ключ
Private Repo (GitHub/GitLab) - Через Credentials - Токен или SSH-пара доступов

🔹 Принцип работы:
	1.	Jenkins проверяет Git-репозиторий
	2.	Считывает Jenkinsfile
	3.	Выполняет пайплайн
	4.	(опционально) Триггер по вебхуку

🔹 Credentials в Jenkins

Если репозиторий приватный — Jenkins должен знать, как авторизоваться:
	•	Manage Jenkins → Credentials
	•	Добавить Username + Password (или Token)
или
SSH Key (если используешь git@)

🔹 Пример Jenkinsfile из репозитория:
pipeline {
  agent any

  stages {
    stage('Git Checkout') {
      steps {
        checkout scm
        echo 'Код успешно получен!'
      }
    }
    stage('Build') {
      steps {
        sh 'echo "Сборка..."'
      }
    }
  }
}
📌 checkout scm — встроенная команда, чтобы получить репозиторий, указанный в Pipeline Job.

 ## Конспект:

 	•	Pipeline Job может подключаться к Git-репозиторию и использовать Jenkinsfile
	•	Протоколы: HTTPS (удобно), SSH (надёжно)
	•	Приватный репозиторий = нужны credentials
	•	checkout scm — встроенная команда получения кода


---

### Задание

1. Создай Jenkins Pipeline Job, который:
	•	Подключается к GitHub-репозиторию
	•	Считывает Jenkinsfile
	•	Клонирует весь проект
	•	Выполняет пайплайн с checkout scm


1. `Убедись, что Jenkinsfile лежит в корне твоего проекта (ветка 06-git-integration)`

```

```

2. `Пример Jenkinsfile`

```
pipeline {
  agent any

  stages {
    stage('Git') {
      steps {
        checkout scm
        echo 'Репозиторий загружен.'
      }
    }
    stage('Build') {
      steps {
        sh 'echo "CI выполняется..."'
      }
    }
  }
}
```
3. `В Jenkins: •	New Item → Pipeline → git-integration-pipeline •	Pipeline from SCM → Git •	Введи URL репозитория •	Укажи ветку 06-git-integration •	(если приватный — добавь credentials)`

```

```
4. `Сохрани и запусти Job. Убедись, что код клонирован, Jenkinsfile исполнен`

```
Started by user sergey
Obtained Jenkins/06-git-integration/Jenkinsfile from git https://github.com/DavyRoy/DevOps_practick.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/git-integration-pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential GitHub
Cloning the remote Git repository
Cloning repository https://github.com/DavyRoy/DevOps_practick.git
 > git init /var/jenkins_home/workspace/git-integration-pipeline # timeout=10
Fetching upstream changes from https://github.com/DavyRoy/DevOps_practick.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.5'
using GIT_ASKPASS to set credentials GitHub Access Token
 > git fetch --tags --force --progress -- https://github.com/DavyRoy/DevOps_practick.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/DavyRoy/DevOps_practick.git # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
Avoid second fetch
 > git rev-parse refs/remotes/origin/06-git-integration^{commit} # timeout=10
Checking out Revision 841bf3f3331b85ae3d148f5a4d99025313371ab4 (refs/remotes/origin/06-git-integration)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 841bf3f3331b85ae3d148f5a4d99025313371ab4 # timeout=10
Commit message: "Jenkins 02"
First time build. Skipping changelog.
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Git)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential GitHub
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/git-integration-pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/DavyRoy/DevOps_practick.git # timeout=10
Fetching upstream changes from https://github.com/DavyRoy/DevOps_practick.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.5'
using GIT_ASKPASS to set credentials GitHub Access Token
 > git fetch --tags --force --progress -- https://github.com/DavyRoy/DevOps_practick.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/06-git-integration^{commit} # timeout=10
Checking out Revision 841bf3f3331b85ae3d148f5a4d99025313371ab4 (refs/remotes/origin/06-git-integration)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 841bf3f3331b85ae3d148f5a4d99025313371ab4 # timeout=10
Commit message: "Jenkins 02"
[Pipeline] echo
Репозиторий загружен.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build)
[Pipeline] sh
+ echo CI выполняется...
CI выполняется...
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Jenkins`" - `JEN-07: Jenkins + Webhooks`

 ### 🎯 Цель урока
Как работают Webhooks

---

 ## 📘 Теория (кратко)

🔹 Что такое webhook?

Webhook — это механизм, при котором GitHub уведомляет Jenkins о событиях (push, pull request и др.) с помощью HTTP-запроса.

🔹 Как Jenkins запускается через webhook?
	1.	Разработчик делает git push
	2.	GitHub отправляет HTTP POST на http://your-jenkins-host/github-webhook/
	3.	Jenkins получает событие и запускает соответствующий Job

🔹 Что нужно для webhook-интеграции:
🧠 Jenkins Должен быть доступен по внешнему адресу или через ngrok
🔐 Credentials Не нужны, если репозиторий публичный
🔗 GitHub Указать URL webhook-а и включить события push
🔁 Jenkins Job Должен использовать GitHub hook trigger for GITScm polling

📘 Пример схемы:
[GitHub Push]
     ↓
[Webhook → http://localhost:8080/github-webhook/]
     ↓
[Jenkins получает POST → триггерит pipeline]

🔹 Локальный Jenkins? Используй ngrok:
ngrok http 8080
→ Получишь внешний адрес, например: https://a1b2c3d4.ngrok.io

→ Укажи webhook: https://a1b2c3d4.ngrok.io/github-webhook/


 ## Конспект:

    •	Webhook — пуш-событие, запускающее билд
	•	URL для webhook-а в Jenkins: /github-webhook/
	•	Job должен использовать GitHub hook trigger
	•	Локальный Jenkins = нужен ngrok или внешний сервер
	•	GitHub → Settings → Webhooks → Add


---

### Задание

1. Настрой автоматический запуск pipeline при каждом git push в GitHub-репозиторий.


1. `Убедись, что твой Job использует Pipeline from SCM`

```

```
2. `В настройках Job включи:`

```
Build Triggers → [x] GitHub hook trigger for GITScm polling
```
3. `Настрой доступность Jenkins:`

```
	•	Если Jenkins локальный:
	1.	Установи ngrok
	2.	Запусти: ngrok http 8080
	3.	Получи URL: https://a1b2c3.ngrok.io
```
4. `На стороне GitHub:`

```
	1.	Перейди в Settings → Webhooks → Add webhook
	2.	URL: https://your-ngrok/github-webhook/
	3.	Content type: application/json
	4.	Events: только Just the push event
	5.	Нажми “Add webhook”
```
5. `Проверь`

```
	•	Сделай git push в нужную ветку (например 07-webhook)
	•	Убедись, что Jenkins Job запустился без нажатия кнопки “Build Now”
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Jenkins`" - `JEN-08: Условия, параметры и окружения`

 ### 🎯 Цель урока
Динамика внутри Jenkinsfile

---

 ## 📘 Теория (кратко)

🎛 Параметры (parameters)

Позволяют запускать пайплайн вручную с выбором: ветка, среда, yes/no и т.д.

Пример:
parameters {
  string(name: 'TARGET_ENV', defaultValue: 'dev', description: 'Target environment')
  booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Run tests?')
}

🔹 🔁 Условия (when)

Позволяют выполнять stage только при определённых условиях — например, только на main, или если переменная RUN_TESTS == true.

Пример:
stage('Deploy to Prod') {
  when {
    branch 'main'
    environment name: 'TARGET_ENV', value: 'prod'
  }
  steps {
    echo 'Deploying to production!'
  }
}

🔹 🌍 Переменные окружения (environment)

Позволяют задать переменные на уровне пайплайна или stage:
environment {
  VERSION = "1.0.${BUILD_NUMBER}"
}
Использование:
sh 'echo Deploying version $VERSION'

🧩 Когда это нужно в реальной работе:
Разные команды для main и dev when → branch
Вручную выбирать окружение перед запуском parameters
Хранить версию, токены, API-ключи environment
Не запускать тесты, если флаг выключен when → expression


 ## Конспект:

	•	parameters {} → выбор при запуске вручную
	•	environment {} → переменные для всех этапов
	•	when {} → условия выполнения stage’а
	•	branch, environment, expression, not, allOf, anyOf


---

### Задание

1. Создай пайплайн, который:
	•	принимает параметр окружения (TARGET_ENV)
	•	имеет stage Test, который выполняется только если RUN_TESTS == true
	•	имеет stage Deploy, который выполняется только если ветка main и TARGET_ENV == prod


1. `Создай ветку: 08-params-conditions`

```

```
2. `Обнови Jenkinsfile`

```
pipeline {
  agent any

  parameters {
    string(name: 'TARGET_ENV', defaultValue: 'dev', description: 'Куда деплоим?')
    booleanParam(name: 'RUN_TESTS', defaultValue: true, description: 'Запускать ли тесты?')
  }

  environment {
    VERSION = "1.0.${BUILD_NUMBER}"
  }

  stages {
    stage('Echo Params') {
      steps {
        echo "TARGET_ENV = ${params.TARGET_ENV}"
        echo "RUN_TESTS = ${params.RUN_TESTS}"
        echo "VERSION = ${env.VERSION}"
      }
    }

    stage('Test') {
      when {
        expression { return params.RUN_TESTS == true }
      }
      steps {
        echo "Выполняем тесты..."
      }
    }

    stage('Deploy') {
      when {
        allOf {
          branch 'main'
          environment name: 'TARGET_ENV', value: 'prod'
        }
      }
      steps {
        echo "Деплой в production!"
      }
    }
  }
}
```
3. `Обнови Pipeline Job: •	Убедись, что This project is parameterized включено (Jenkins сам определит) •	Укажи ветку 08-params-conditions`

```

```
4. `Запусти вручную, выбрав разные параметры`

```

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Jenkins`" - `JEN-09: Распараллеливание и стадии`

 ### 🎯 Цель урока
Параллельные стадии в Jenkins Pipeline

---

 ## 📘 Теория (кратко)

🔹 Что такое parallel?

Это блок, который позволяет запустить несколько под-этапов одновременно внутри одного stage.

📌 Используется только внутри Scripted или Declarative → stage → parallel

⸻

🔹 Пример: Declarative Pipeline с parallel
pipeline {
  agent any

  stages {
    stage('Parallel Checks') {
      parallel {
        stage('Unit Tests') {
          steps {
            echo 'Running unit tests...'
            sleep 3
          }
        }
        stage('Lint') {
          steps {
            echo 'Linting code...'
            sleep 2
          }
        }
        stage('Security Scan') {
          steps {
            echo 'Scanning for vulnerabilities...'
            sleep 4
          }
        }
      }
    }

    stage('Build') {
      steps {
        echo 'Building application...'
      }
    }
  }
}

🔹 Зачем это нужно:
Много тестов/анализов Значительно сокращает общее время
Параллельная сборка нескольких компонентов Быстрее фидбек
Параллельные деплои в разные окружения Одновременная

🔹 Ограничения:
	•	Нельзя использовать parallel внутри script {} — только как stage
	•	Внутри каждого parallel stage нужен свой steps {} блок
	•	Параллельные стадии нельзя вкладывать друг в друга

 ## Конспект:

	•	stage('Имя') { parallel { ... } } — запуск стадий одновременно
	•	Каждая подстадия — как обычный stage
	•	Используется для тестов, сканов, линтеров, сборок
	•	Не вложенные, не script-блоки

---

### Задание

1. Добавь stage с 3 параллельными задачами:
	•	Unit Tests: эмуляция тестов (sleep 2)
	•	Lint: эмуляция линтинга (sleep 1)
	•	Security Scan: эмуляция проверки (sleep 3)


1. `Создай ветку: 09-parallel-stages`

```

```
2. `Обнови Jenkinsfile`

```
pipeline {
  agent any

  stages {
    stage('Parallel QA') {
      parallel {
        stage('Unit Tests') {
          steps {
            echo 'Running unit tests...'
            sleep 2
          }
        }
        stage('Lint') {
          steps {
            echo 'Running linter...'
            sleep 1
          }
        }
        stage('Security Scan') {
          steps {
            echo 'Running security checks...'
            sleep 3
          }
        }
      }
    }

    stage('Build') {
      steps {
        echo 'All checks passed, building...'
      }
    }
  }
}
```



`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Jenkins`" - `JEN-10: Хранение артефактов и отчётов`

 ### 🎯 Цель урока
Что такое артефакты и как их сохранить

---

 ## 📘 Теория (кратко)

🔹 Артефакты (Artifacts)

Это файлы, сгенерированные в ходе пайплайна, которые Jenkins сохраняет после сборки и делает доступными для скачивания или анализа.

Примеры:
	•	build/app.jar
	•	coverage/index.html
	•	lint-report.xml
	•	logs/*.log

⸻

🔹 Сохранение артефактов:

📌 В Declarative Pipeline:
post {
  success {
    archiveArtifacts artifacts: 'build/*.jar', fingerprint: true
  }
}

🔹 Просмотр:

После выполнения Job:
	•	в интерфейсе Jenkins появится блок “Archived Artifacts”
	•	ты сможешь скачать файл
	•	или подключить сторонние шаги (например, публиковать HTML-отчёт)

⸻

🔹 Публикация HTML-отчётов:

Если ты создаёшь отчёт с HTML:
	1.	Сохрани его как артефакт
	2.	Подключи плагин [HTML Publisher Plugin]
	3.	Используй шаг:
    publishHTML([
  reportDir: 'coverage',
  reportFiles: 'index.html',
  reportName: 'Coverage Report'
])


 ## Конспект:

	•	archiveArtifacts → сохраняет файлы после билда
	•	Используется в блоке post { success { ... } }
	•	Путь можно указывать с шаблоном (*.xml, **/*.log)
	•	Артефакты можно скачивать из Jenkins UI
	•	HTML-отчёты требуют доп. плагин HTML Publisher

---

### Задание

1. Сымитируй CI-сборку, которая:
	•	создаёт файл build/output.txt
	•	сохраняет этот файл как артефакт
	•	выводит сообщение об успешной архивации

1. `Создай ветку: 10-artifacts`

```

```
2. `Обнови Jenkinsfile`

```
pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        sh '''
          mkdir -p build
          echo "This is a build artifact." > build/output.txt
        '''
      }
    }
  }

  post {
    success {
      archiveArtifacts artifacts: 'build/output.txt', fingerprint: true
      echo 'Артефакт сохранён.'
    }
  }
}
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

