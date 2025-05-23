# Модуль "`Terraform" - `TF-01 — Теория: Что такое Terraform и IaC`

 ## 📘 Теория (кратко)
🔹 Что это вообще?

Terraform — это инструмент из категории Infrastructure as Code (IaC).
Он позволяет описывать и управлять инфраструктурой (серверы, контейнеры, сети, БД и т.д.) с помощью конфигурационных файлов на языке HCL (HashiCorp Configuration Language).

⸻

🧠 Почему Terraform так важен?
📦 Автоматизация Вся инфраструктура поднимается одной командой (terraform apply)
💥 Изменения под контролем Все изменения видны через terraform plan до их применения
📜 Документируемость Всё описано в коде: легко понять, что развёрнуто и где
🔄 Воспроизводимость Можешь поднять одинаковое окружение на разных машинах/клауд-платформах
🧪 Тестируемость Инфраструктура как код → можно покрыть тестами, валидировать, lint-ить

🔧 Как работает Terraform? (Архитектура)

1. Ты пишешь конфигурации

Файл main.tf — описывает, что ты хочешь:
resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
}
2. Terraform сравнивает

Он видит, что ты хочешь такую виртуалку, а в реальности её нет → предлагает создать.

3. Terraform применяет

Ты говоришь terraform apply, он делает запросы к API (например, AWS или Docker) и создаёт ресурсы.

4. Сохраняет состояние

Всё, что создано — Terraform записывает в terraform.tfstate. Это как «память» о текущем состоянии.

⸻

🧱 Основные компоненты Terraform:
provider Говорит Terraform, с чем он работает (AWS, GCP, Docker и т.д.)
resource Что ты хочешь создать (машины, сети, контейнеры и т.д.)
variable Переменные для гибкости конфигурации
output Что вывести после исполнения (IP, логин и т.п.)
module Модуль — переиспользуемый кусок кода
data Импорт существующих объектов

⚙️ Где Terraform применяется в реальной работе?
Развёртывание AWS-инфраструктуры Создание VPC, EC2, RDS, S3 и др. через main.tf
Автоматизация Docker-контейнеров Управление контейнерами и сетями как кодом
CI/CD окружения На каждый PR — своё окружение через terraform apply
Multi-cloud подход Поддержка разных облаков через провайдеры
Валидация и lint инфраструктуры Автоматический аудит кода перед применением


 ## Конспект :

 Базовая структура Terraform
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "nginx" {
  image = "nginx:latest"
  name  = "my-nginx"
}
terraform init Инициализация проекта
terraform plan Показывает, что будет сделано
terraform apply Применяет изменения
terraform destroy Удаляет созданные

---


# Модуль "`Terraform" - `TF-02 Установка, структура проекта и первая команда terraform`

 ## 📘 Теория (кратко)
 Базовая структура проекта

Хорошая структура нужна, чтобы:
	•	Поддерживать порядок при работе с несколькими окружениями
	•	Масштабировать проект (dev, stage, prod)
	•	Упростить навигацию другим членам команды

🔹 Простейшая структура:
terraform-lab/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars

🔹 Структура с модулями:
terraform-lab/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   └── nginx/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

🔹 Структура с окружениями:
environments/
├── dev/
│   └── main.tf
├── stage/
│   └── main.tf
└── prod/
    └── main.tf

🔧 Основные команды Terraform
terraform init Подгружает провайдеры и инициализирует проект
terraform plan Показывает, что будет создано/удалено/изменено
terraform apply Применяет изменения — создаёт инфраструктуру
terraform destroy Удаляет всё, что описано в текущем проекте
terraform show Показывает текущее состояние
terraform output Показывает выходные переменные (output)
terraform validate Проверяет корректность синтаксиса
terraform fmt Форматирует код по Terraform-стандарту

🧠 Почему важно использовать validate и fmt?
	•	❌ Плохой стиль и ошибки в конфигурациях = баги и сбои
	•	✅ fmt = читаемый код
	•	✅ validate = предотвращение глупых ошибок до применения

⸻

📝 Пример: разделение конфигурации

main.tf
resource "docker_container" "nginx" {
  image = var.nginx_image
  name  = var.nginx_name
}

variables.tf
variable "nginx_image" {
  type    = string
  default = "nginx:latest"
}

variable "nginx_name" {
  type    = string
  default = "my-nginx"
}

outputs.tf
output "container_name" {
  value = docker_container.nginx.name
}

 ## Конспект:

terraform init         # инициализация
terraform plan         # предварительный просмотр
terraform apply        # применить
terraform destroy      # снести всё
terraform validate     # проверить синтаксис
terraform fmt          # привести в порядок формат
terraform show         # текущее состояние
terraform output       # вывести outputs

---

### Задание

1. 	•	Организовать структуру проекта из 3 файлов: main.tf, variables.tf, outputs.tf
	•	Использовать переменные (var.image, var.name)
	•	Применить terraform validate и terraform fmt
	•	Убедиться, что контейнер запускается, и output работает


1. `Создай папку terraform-lab/tf-02`

```

```
2. `Вынеси конфигурации по файлам: •	main.tf — логика контейнера •	variables.tf — переменные image, name •	outputs.tf — вывод имени контейнера`

```
terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = "nginx:latest"
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "my-nginx"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + container_name = "my-nginx"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 0s [id=e3c69951c194dcfb1bfd0f3c909182a03fd354d77a94c3f27d8b708ad6e30d9d]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

container_name = "my-nginx"
➜  tf-02 git:(main) ✗ terraform fmt
main.tf
variables.tf
➜  tf-02 git:(main) ✗ terraform validate
Success! The configuration is valid.

➜  tf-02 git:(main) ✗ terraform output
container_name = "my-nginx"
```
3. `Инициализируй проект: terraform init`

```

```
4. `Проверь код: terraform validate`

```

```
5. `Отформатируй: terraform fmt`

```

```
6. `Применение: terraform apply`

```

```
7. `Проверка: terraform output`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Terraform" - `TF-03 provider: как выбрать, настроить и использовать`

 ## 📘 Теория (кратко)

🔹 Определение

provider — это плагин, который позволяет Terraform управлять внешними сервисами:
AWS, Docker, GitHub, Kubernetes, GCP, Vault, Cloudflare и сотни других.

⸻

🔹 Как это работает?

Terraform:
	1.	Находит в конфигурации provider
	2.	Загружает нужную версию (при terraform init)
	3.	Через API создаёт/удаляет/меняет ресурсы

⸻

🧱 Структура блока provider
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.25.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
required_providers Задаёт источник и версию (HashiCorp Registry, GitHub и т.п.)
provider "docker" Конфигурирует подключение: socket, token, region и т.п.

🔍 Как выбрать нужный provider
	1.	Идёшь на registry.terraform.io
	2.	Ищешь, например, “AWS”, “Docker”, “Cloudflare”
	3.	Смотришь:
	•	Какой источник (hashicorp/aws, kreuzwerker/docker, cloudflare/cloudflare)
	•	Версии, зависимости
	•	Конфигурацию (access_key, region, host, и т.д.)

⸻

🔧 Несколько провайдеров
provider "aws" {
  alias  = "us"
  region = "us-east-1"
}

provider "aws" {
  alias  = "eu"
  region = "eu-west-1"
}

resource "aws_instance" "web_us" {
  provider = aws.us
  ...
}

resource "aws_instance" "web_eu" {
  provider = aws.eu
  ...
}

⚠️ Ошибки, которые часто случаются
Не указан source у провайдера Указывай required_providers
Несовместимая версия Используй ~>, например: ~> 3.0
Не прописан alias при мульти-провайдерах Добавляй alias и указывай в ресурсах
Конфликт имён провайдеров в модулях Прокидывай alias в module через providers блок


 ## Конспект :

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.25.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
terraform init        # скачает провайдер
terraform providers   # покажет, какие используются

---

### Задание

1. 	•	Чётко указать и настроить provider "docker" в блоке terraform
	•	Обновить конфиг, как в теории
	•	Протестировать terraform init, terraform providers
	•	Понять, откуда берётся плагин, и какая версия используется

1. `В main.tf добавь блок terraform { required_providers { ... } }`

```

```
2. `Укажи source = "kreuzwerker/docker" и версию`

```

```
3. `Запусти:`

```
terraform init
terraform providers
```
4. `Убедись, что провайдер подтянулся с нужной версией`

```

```
5. `Посмотри: где он установлен (.terraform/plugins/...)`

```

```
6. `Попробуй немного изменить версию (~> 2.24.0), и повтори init`

```
erraform init
Initializing the backend...
Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "~> 2.25.0"...
- Installing kreuzwerker/docker v2.25.0...
- Installed kreuzwerker/docker v2.25.0 (self-signed, key ID BD080C4571C6104C)
Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://developer.hashicorp.com/terraform/cli/plugins/signing
Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
➜  tf-03 git:(main) ✗ terraform providers

Providers required by configuration:
.
└── provider[registry.terraform.io/kreuzwerker/docker] ~> 2.25.0

➜  tf-03 git:(main) ✗ terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
╷
│ Error: Failed to query available provider packages
│
│ Could not retrieve the list of available versions for provider kreuzwerker/docker: locked provider
│ registry.terraform.io/kreuzwerker/docker 2.25.0 does not match configured version constraint ~> 2.24.0; must use terraform
│ init -upgrade to allow selection of new versions
│
│ To see which modules are currently depending on kreuzwerker/docker and what versions are specified, run the following
│ command:
│     terraform providers

terraform init -upgrade
Initializing the backend...
Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "~> 2.24.0"...
- Installing kreuzwerker/docker v2.24.0...
- Installed kreuzwerker/docker v2.24.0 (self-signed, key ID BD080C4571C6104C)
Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://developer.hashicorp.com/terraform/cli/plugins/signing
Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
➜  tf-03 git:(main) ✗ terraform providers

Providers required by configuration:
.
└── provider[registry.terraform.io/kreuzwerker/docker] ~> 2.24.0
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Terraform" - `TF-04 resource: создание инфраструктуры как кода`

 ## 📘 Теория (кратко)

🔹 Что такое resource?

resource — это базовая единица в Terraform, которая описывает то, что нужно создать, изменить или удалить.

Примеры ресурсов:
	•	Виртуальная машина (например, aws_instance)
	•	Docker контейнер (docker_container)
	•	GitHub-репозиторий (github_repository)
	•	Kubernetes Pod (kubernetes_pod)

⸻

🔧 Общая структура ресурса
resource "<провайдер>_<тип>" "<имя>" {
   параметры ресурса
}
🔍 Пример для Docker:
resource "docker_container" "nginx" {
  image = "nginx:latest"
  name  = "my-nginx"
}
💡 Что стоит знать про resource:
<провайдер>_<тип> Тип ресурса (например, docker_container, aws_instance)
<имя> Локальное имя — используется в ссылках и output
Параметры (image, name) Атрибуты — они задают поведение, настройки и свойства ресурса

🧠 Как работает resource

Terraform:
	1.	Читает твой main.tf
	2.	Сравнивает текущее состояние (из .tfstate) и то, что ты хочешь
	3.	Генерирует plan — список того, что нужно создать/удалить/обновить
	4.	Выполняет действия, чтобы привести инфраструктуру к желаемому виду

⸻

📌 Важные возможности resource:
Вложенные блокиНапример, ports, env, volumes
Динамические блоки Позже изучим в TF-12
Связи через depends_on Позже изучим
Использование переменных image = var.nginx_image

🔥 Пример с Docker-портом
resource "docker_container" "nginx" {
  image = "nginx:latest"
  name  = "webserver"

  ports {
    internal = 80
    external = 8080
  }
}

 ## Конспект:

resource "docker_container" "my_nginx" {
  image = "nginx:latest"
  name  = "nginx-container"

  ports {
    internal = 80
    external = 8080
  }

  env = ["NGINX_PORT=8080"]
}

terraform plan Показывает, что будет создано
terraform apply Применяет изменения и создаёт ресурс
terraform destroy Удаляет ресурс
terraform show Показывает текущее состояние

---

### Задание

1. 	•	Определить ресурс docker_container c параметрами:
	•	image = "nginx:latest"
	•	name = "web-nginx"
	•	Открытый порт: 8080 наружу → 80 внутри
	•	Переменная окружения: NGINX_PORT=8080


1. `Создай main.tf в папке tf-04`

```

```
2. `Используй resource "docker_container"`

```

```
3. `Добавь env = [...]`

```
resource "docker_container" "web-nginx" {
  name  = "web-nginx"
  image = "nginx:latest"

  ports {
    internal = 80
    external = 8081
  }

  env = ["NGINX_PORT=8081"]
  }

```
4. `Добавь блок ports { internal, external }`

```

```
5. `Запусти:`

```
terraform init
terraform apply
```
6. `Проверь:`

```
docker ps
curl http://localhost:8080
```
7. `Вывод:`

```
terraform show
# docker_container.web-nginx:
resource "docker_container" "web-nginx" {
    attach                                      = false
    bridge                                      = null
    command                                     = [
        "nginx",
        "-g",
        "daemon off;",
    ]
    container_read_refresh_timeout_milliseconds = 15000
    cpu_set                                     = null
    cpu_shares                                  = 0
    domainname                                  = null
    entrypoint                                  = [
        "/docker-entrypoint.sh",
    ]
    env                                         = [
        "NGINX_PORT=8081",
    ]
    gateway                                     = "172.17.0.1"
    hostname                                    = "c2b825fdb0be"
    id                                          = "c2b825fdb0be173b809d3a8e13d9f0a4eb1f19ca469e32e97d1e33b34441a829"
    image                                       = "sha256:997e7f2550611062e12ab5f008169e1c768711c806646de5a3eb8aed5db2de90"
    init                                        = false
    ip_address                                  = "172.17.0.3"
    ip_prefix_length                            = 16
    ipc_mode                                    = "private"
    log_driver                                  = "json-file"
    logs                                        = false
    max_retry_count                             = 0
    memory                                      = 0
    memory_swap                                 = 0
    must_run                                    = true
    name                                        = "web-nginx"
    network_data                                = [
        {
            gateway                   = "172.17.0.1"
            global_ipv6_address       = null
            global_ipv6_prefix_length = 0
            ip_address                = "172.17.0.3"
            ip_prefix_length          = 16
            ipv6_gateway              = null
            network_name              = "bridge"
        },
    ]
    network_mode                                = "bridge"
    pid_mode                                    = null
    privileged                                  = false
    publish_all_ports                           = false
    read_only                                   = false
    remove_volumes                              = true
    restart                                     = "no"
    rm                                          = false
    runtime                                     = "runc"
    security_opts                               = []
    shm_size                                    = 64
    start                                       = true
    stdin_open                                  = false
    stop_signal                                 = "SIGQUIT"
    stop_timeout                                = 0
    tty                                         = false
    user                                        = null
    userns_mode                                 = null
    wait                                        = false
    wait_timeout                                = 60
    working_dir                                 = null

    ports {
        external = 8081
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
➜  tf-04 git:(main) ✗ docker ps
CONTAINER ID   IMAGE                 COMMAND                  CREATED         STATUS         PORTS                                              NAMES
c2b825fdb0be   nginx:latest          "/docker-entrypoint.…"   8 seconds ago   Up 8 seconds   0.0.0.0:8081->80/tcp                               web-nginx
cb6d9be86eb9   jenkins/jenkins:lts   "/usr/bin/tini -- /u…"   3 days ago      Up 47 hours    0.0.0.0:8080->8080/tcp, 0.0.0.0:50000->50000/tcp   jenkins

curl http://localhost:8081
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Terraform" - `TF-05 output: экспорт значений и передача между `

 ## 📘 Теория (кратко)

🔹 Определение

output — это блок, который выводит значения после выполнения terraform apply.

🔧 Применяется для:
	•	Отображения важной информации пользователю (IP, URL, логин и т.д.)
	•	Использования этих значений в других модулях или инструментах (CI/CD, Bash, Ansible и т.п.)

⸻

💡 Простой пример
output "container_name" {
  value = docker_container.web-nginx.name
}
После terraform apply ты получишь:
container_name = "web-nginx"

📦 Где используется output?
CI/CD pipeline Считать IP ресурса и передать в следующий этап
Другой модуль Terraform Передать выходное значение через module.<имя>.output_name
Bash-скрипт Получить токен, имя, порт, путь к файлу и т.д.

🧠 Синтаксис блока output
output "<имя>" {
  value       = <выражение>
  description = "Что это такое"     # (опционально)
  sensitive   = true/false          # (если скрыть, например, пароль)
}

🔧 Типичные примеры:
output "container_id" {
  value = docker_container.web-nginx.id
}

output "ip_address" {
  value = docker_container.web-nginx.ip_address
}

📜 Получение значений после apply
terraform output Показывает все output-переменные
terraform output <имя> Показывает конкретное значение


 ## Конспект :

output "name" {
  value       = docker_container.web-nginx.name
  description = "Имя контейнера"
}

terraform apply
terraform output name

---

### Задание

1. 	•	Добавь в проект 3 output-переменные:
	•	container_name — имя контейнера
	•	container_id — его ID
	•	container_ip — его IP

1. `В проекте tf-05 добавь файл outputs.tf`

```

```
2. `Определи 3 блока output с нужными значениями: •	docker_container.web-nginx.name •	docker_container.web-nginx.id •	docker_container.web-nginx.ip_address`

```

```
3. `Запусти:`

```
terraform apply
terraform output
```
4. `Убедись, что все 3 значения корректны и совпадают с docker ps и terraform show`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Terraform" - `TF-06 variable: переменные, типы и default значения`

 ## 📘 Теория (кратко)
🔹 Зачем нужны переменные?
	•	Переиспользование конфигураций (не менять вручную в 10 местах)
	•	Упрощение CI/CD и динамических окружений
	•	Работа с чувствительными данными (например, секреты)
	•	Возможность передавать значения через .tfvars, CLI, ENV и т.п.

⸻

🧱 Объявление переменной
variable "имя" {
  type        = string
  description = "Что это такое"
  default     = "значение"
}
🔍 Пример:
variable "nginx_image" {
  type        = string
  description = "Docker-образ nginx"
  default     = "nginx:latest"
}

🧪 Использование переменной
resource "docker_container" "web" {
  name  = var.container_name
  image = var.nginx_image
}

💡 Где можно задать значение переменной?
В default Внутри variables.tf
В terraform.tfvars nginx_image = "custom/nginx:v2"
Через CLI terraform apply -var="nginx_image=custom/nginx"
Через ENV TF_VAR_nginx_image=custom/nginx

📋 Типы переменных
string "nginx:latest"
number 2, 0.5
bool true, false
list ["one", "two"]
map { name = "nginx", port = 80 }
object object({ name = string, port = number })


 ## Конспект :
variable "nginx_port" {
  type        = number
  default     = 8080
  description = "Порт, на котором будет работать Nginx"
}

resource "docker_container" "web" {
  name  = "nginx"
  image = "nginx:latest"

  ports {
    internal = 80
    external = var.nginx_port
  }
}

terraform apply -var="nginx_port=8081"

---

### Задание

1. 	•	Вынеси параметры контейнера в переменные:
	•	nginx_image (тип: string)
	•	nginx_name (тип: string)
	•	nginx_port (тип: number)
	•	Укажи для них description и default
	•	Примени значения из переменных в main.tf

1. `Создай variables.tf (если его ещё нет)`

```

```
2. `Определи 3 переменные с type, description, default`

```

```
3. `Обнови main.tf, чтобы использовать var.имя`

```

```
4. `Убедись, что terraform plan и apply работают`

```

```
5. `Потестируй terraform apply -var="nginx_port=8090" и убедись, что значение подставилось`

```
terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.web-nginx-06 will be created
  + resource "docker_container" "web-nginx-06" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = "nginx:latest"
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "web-nginx-06"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 8083
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + container_id    = (known after apply)
  + container_image = "nginx:latest"
  + container_ip    = (known after apply)
  + container_name  = "web-nginx-06"
╷
│ Warning: Deprecated attribute
│
│   on outputs.tf line 10, in output "container_ip":
│   10:   value = docker_container.web-nginx-06.ip_address
│
│ The attribute "ip_address" is deprecated. Refer to the provider documentation for details.
│
│ (and one more similar warning elsewhere)
╵

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_container.web-nginx-06: Creating...
docker_container.web-nginx-06: Creation complete after 0s [id=282615fe6e44e9b53a973b261b0f78a2c2f313f246d275a7634d19c1872d5a71]
╷
│ Warning: Deprecated attribute
│
│   on outputs.tf line 10, in output "container_ip":
│   10:   value = docker_container.web-nginx-06.ip_address
│
│ The attribute "ip_address" is deprecated. Refer to the provider documentation for details.
╵

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

container_id = "282615fe6e44e9b53a973b261b0f78a2c2f313f246d275a7634d19c1872d5a71"
container_image = "nginx:latest"
container_ip = "172.17.0.4"
container_name = "web-nginx-06"
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Terraform" - `TF-07 locals и вычисления внутри Terraform`


 ## 📘 Теория (кратко)

🔹 Определение

locals — это локальные переменные, которые:
	•	определяются один раз
	•	могут быть вычислены
	•	используются внутри текущего модуля
	•	не переопределяются извне (в отличие от variable)

⸻

🧠 Для чего нужны locals?
Вычисляемые значения Комбинация строк, конкатенация, тернарные операторы
Повторяющиеся значения Чтобы не писать одинаковое 10 раз
Улучшение читаемости Вынести длинные выражения
Условные выражения count, enabled ? val1 : val2

🧱 Синтаксис locals
locals {
  name_with_prefix = "${var.env}-${var.name}"
  nginx_port       = var.base_port + 100
}

🧪 Пример использования locals в resource
locals {
  full_name = "${var.env}-${var.app_name}"
}

resource "docker_container" "app" {
  name  = local.full_name
  image = "nginx:latest"
}

🔄 Поддержка типов и логики

Terraform поддерживает:
	•	if/else через тернарный оператор: condition ? true_value : false_value
	•	join, replace, format, lower, upper
	•	concat, merge, zipmap, lookup

 ## Конспект :

locals {
  full_name     = "${var.env}-${var.name}"
  internal_port = 80
  external_port = var.base_port + 1
}

resource "docker_container" "web" {
  name  = local.full_name
  image = var.image

  ports {
    internal = local.internal_port
    external = local.external_port
  }
}

---

### Задание

1. Создать локальные переменные:
	•	full_name — объединение var.env и var.name
	•	external_port — значение var.base_port + 10

Использовать их в resource:
	•	name = local.full_name
	•	ports.external = local.external_port

1. `В файл variables.tf добавь переменные: •	env (string, default = “dev”) •	name (string, default = “nginx”) •	base_port (number, default = 8000)`

```
variable "nginx_image" {
  type    = string
  default = "nginx:latest"
}

variable "nginx_name" {
  type    = string
  default = "web-nginx-06"
}

variable "base_port" {
  type    = number
  default = 8083
}

variable "env" {
  type    = string
  default = "dev"
}

variable "name" {
  type    = string
  default = "nginx"
}

```
2. `Создай или обнови блок locals в main.tf`

```
locals {
  full_name = "${var.env}-${var.name}"
  internal_port = 80
  external_port = var.base_port + 1
}


resource "docker_container" "web-nginx-06" {
  name  = local.full_name
  image = var.nginx_image

  ports {
    internal = local.internal_port
    external = local.external_port
  }
}

```
3. `Обнови docker_container, использовав local.full_name и local.external_port`

```
output "container_name" {
  value = docker_container.web-nginx-06.name
}

output "container_id" {
  value = docker_container.web-nginx-06.id
}

output "container_ip" {
  value = docker_container.web-nginx-06.network_data[0].ip_address
}

output "container_image" {
  value = docker_container.web-nginx-06.image
}

```
4. `Прогони terraform apply`

```
terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # docker_container.web-nginx-06 will be created
  + resource "docker_container" "web-nginx-06" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = "nginx:latest"
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "dev-nginx"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 8084
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + container_id    = (known after apply)
  + container_image = "nginx:latest"
  + container_ip    = (known after apply)
  + container_name  = "dev-nginx"
╷
│ Warning: Deprecated attribute
│
│   on outputs.tf line 10, in output "container_ip":
│   10:   value = docker_container.web-nginx-06.ip_address
│
│ The attribute "ip_address" is deprecated. Refer to the provider documentation for details.
│
│ (and one more similar warning elsewhere)
╵

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

docker_container.web-nginx-06: Creating...
docker_container.web-nginx-06: Creation complete after 1s [id=2ca75afc54ef6ab1ecb2522416c99c5dbb589cc1e52420823ce93537bf83feba]
╷
│ Warning: Deprecated attribute
│
│   on outputs.tf line 10, in output "container_ip":
│   10:   value = docker_container.web-nginx-06.ip_address
│
│ The attribute "ip_address" is deprecated. Refer to the provider documentation for details.
╵

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

container_id = "2ca75afc54ef6ab1ecb2522416c99c5dbb589cc1e52420823ce93537bf83feba"
container_image = "nginx:latest"
container_ip = "172.17.0.5"
container_name = "dev-nginx"
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Terraform" - `TF-08 data sources: импорт внешних данных`

 ## 📘 Теория (кратко)

data — это способ “подсмотреть” внешний ресурс, не управляя им напрямую.
Terraform может использовать API внешней системы (например, Docker, AWS, GitHub) чтобы:
	•	прочитать существующие ресурсы,
	•	получить ID, имя, IP и другие свойства,
	•	использовать их внутри своих resource, output, locals, variable и т.п.

⸻

🧠 Когда data нужен?
Ресурс уже создан вручную Terraform не пересоздаёт, а просто читает его
Нужно получить внешний ресурс для зависимости Например, использовать образ, volume, VPC и т.п.
Скомбинировать resource + data Например, data достаёт IP, а resource его использует

🧱 Синтаксис data
data "<провайдер>_<тип>" "<имя>" {
   аргументы запроса
}
🔍 Пример:
data "docker_image" "nginx" {
  name = "nginx:latest"
}
Теперь можно использовать data.docker_image.nginx.image_id

🔧 Практика с Docker

Импорт образа:
data "docker_image" "nginx" {
  name = "nginx:latest"
}

Использование в ресурсе:
resource "docker_container" "external-nginx" {
  name  = "nginx-from-data"
  image = data.docker_image.nginx.name

  ports {
    internal = 80
    external = 8085
  }
}


### Задание

1. 	•	Использовать data "docker_image" для получения nginx:latest
	•	Вывести через output:
	•	имя образа
	•	ID образа
	•	Создать контейнер, использующий data.docker_image.nginx.name как image

1. `Добавь в main.tf:`

```
data "docker_image" "nginx" {
  name = "nginx:latest"
}
```
2. `В resource "docker_container" используй data.docker_image.nginx.name`

```

```
3. `В outputs.tf добавь:`

```
output "nginx_image_name" {
  value = data.docker_image.nginx.name
}

output "nginx_image_id" {
  value = data.docker_image.nginx.image_id
}
```
4. `Прогони:`

```
terraform init
terraform apply
terraform output
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Terraform" - `TF-09 module: как переиспользовать код, структура и best practices`

 ## 📘 Теория (кратко)

🔹 Определение

module — это переиспользуемый блок Terraform-кода, как функция в программировании.
Ты можешь вынести повторяющийся код (например, контейнер, сервер, VPC и т.д.) в модуль и подключать его в разных местах:
	•	разных окружениях (dev, prod)
	•	разных проектах (frontend, backend)
	•	CI/CD пайплайнах, микросервисах и т.п.

⸻

🧱 Структура модуля

📂 Пример:
project-root/
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    └── nginx/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

🔄 Как использовать модуль
module "nginx_instance" {
  source      = "./modules/nginx"
  name        = "frontend"
  image       = "nginx:latest"
  external_port = 8088
}

🔧 Внутри модуля (modules/nginx/):

main.tf
resource "docker_container" "nginx" {
  name  = var.name
  image = var.image

  ports {
    internal = 80
    external = var.external_port
  }
}

variables.tf
variable "name" {
  type = string
}

variable "image" {
  type = string
}

variable "external_port" {
  type = number
}

outputs.tf
output "container_id" {
  value = docker_container.nginx.id
}

🔁 Зачем использовать модули?
Один и тот же шаблон инфраструктуры в dev, stage, prod Переиспользование модуля с разными параметрами
Микросервисная архитектура Модуль = шаблон развёртывания одного сервиса
Упрощение CI/CD Модуль легко использовать из pipeline
Разделение ответственности (Dev vs Infra) Разработчики используют готовый модуль

---

### Задание

1. Создать модуль modules/nginx/:
	•	с переменными: name, image, external_port
	•	ресурс: docker_container
	•	output: container_id, container_name
2. Подключить модуль дважды в main.tf:
	•	nginx1: порт 8088
	•	nginx2: порт 8089
3. Проверить, что оба контейнера созданы и работают

1. `Создай папку modules/nginx/`

```

```
2. `Внутри создай: •	main.tf с ресурсом docker_container •	variables.tf с тремя переменными •	outputs.tf с container_id и container_name`

```

```
3. `В корневом main.tf подключи модуль дважды`

```

```
4. `Прогони:`

```
terraform init
terraform apply
docker ps
curl localhost:8088
curl localhost:8089
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Terraform" - `TF-10 terraform.tfstate: что это, где хранить и как защитить`

 ## 📘 Теория (кратко)

🔹 Что такое terraform.tfstate?

Это JSON-файл, в котором Terraform:
	•	хранит текущее состояние всех ресурсов, созданных им;
	•	сопоставляет описание в .tf-файлах с реальными объектами (контейнерами, VM, сервисами);
	•	отслеживает, что уже есть, а что нужно создать, изменить или удалить.

⸻

📦 Что внутри?
{
  "resources": [
    {
      "type": "docker_container",
      "name": "nginx",
      "instances": [
        {
          "attributes": {
            "id": "abc123",
            "name": "my-nginx",
            "image": "nginx:latest"
          }
        }
      ]
    }
  ]
}

🔍 Как Terraform использует .tfstate
plan Сравнивает .tf с текущим состоянием из tfstate
apply Применяет изменения, обновляет tfstate
destroy Удаляет ресурсы, и тоже обновляет tfstate

⚠️ Почему terraform.tfstate критичен?
Потеря tfstate Terraform не знает, что ты уже создавал
Разные tfstate у разных людей Конфликты, неожиданные удаления
tfstate в Git Утечка паролей, токенов и других секретов

💡 Best practices

✅ Храни terraform.tfstate:
	•	В удалённом бекенде (см. TF-11)
	•	S3, GCS, Azure Blob, HTTP, GitLab remote state и т.п.
	•	Всегда включай terraform.lock.hcl в Git
	•	Никогда не комить terraform.tfstate в Git

🛡️ Что можно сделать:
backend Надёжное удалённое хранилище (s3, gcs и т.п.)
encrypt = true (в S3) Шифрует tfstate
versioning = true (в S3) Хранит историю изменений
lock = true Предотвращает одновременное применение


 ## Ключевые команды:

- terraform show      # посмотреть текущее состояние
terraform state list        # список всех управляемых ресурсов
terraform state show <ресурс>  # детали конкретного ресурса
-  Никогда не комить:
.terraform/
terraform.tfstate
terraform.tfstate.*

---

### Задание

1. Изучи содержимое terraform.tfstate
2. Посмотри список ресурсов и их детали через CLI
3. Убедись, что .tfstate не коммитится в Git
4. Создай .gitignore, если его нет

1. `Выполни:`

```
terraform show
terraform state list
terraform state show <любой_ресурс>
```
2. `Открой terraform.tfstate как JSON (через VS Code или cat)`

```

```
3. `Убедись, что .gitignore содержит:`

```
.terraform/
terraform.tfstate
terraform.tfstate.*
```
4. `Попробуй случайно удалить terraform.tfstate, а потом сделать plan — посмотри, что произойдёт`

```
terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
  + create

Terraform will perform the following actions:

  # module.nginx1.docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = "nginx:latest"
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "frontend_new"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 8088
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

  # module.nginx2.docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach                                      = false
      + bridge                                      = (known after apply)
      + command                                     = (known after apply)
      + container_logs                              = (known after apply)
      + container_read_refresh_timeout_milliseconds = 15000
      + entrypoint                                  = (known after apply)
      + env                                         = (known after apply)
      + exit_code                                   = (known after apply)
      + gateway                                     = (known after apply)
      + hostname                                    = (known after apply)
      + id                                          = (known after apply)
      + image                                       = "nginx:latest"
      + init                                        = (known after apply)
      + ip_address                                  = (known after apply)
      + ip_prefix_length                            = (known after apply)
      + ipc_mode                                    = (known after apply)
      + log_driver                                  = (known after apply)
      + logs                                        = false
      + must_run                                    = true
      + name                                        = "backand_new"
      + network_data                                = (known after apply)
      + read_only                                   = false
      + remove_volumes                              = true
      + restart                                     = "no"
      + rm                                          = false
      + runtime                                     = (known after apply)
      + security_opts                               = (known after apply)
      + shm_size                                    = (known after apply)
      + start                                       = true
      + stdin_open                                  = false
      + stop_signal                                 = (known after apply)
      + stop_timeout                                = (known after apply)
      + tty                                         = false
      + wait                                        = false
      + wait_timeout                                = 60

      + healthcheck (known after apply)

      + labels (known after apply)

      + ports {
          + external = 8089
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
you run "terraform apply" now.
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Terraform" - `TF-11 backend: удалённое хранение состояния`

 ## 📘 Теория (кратко)

🔹 Зачем нужен backend?

terraform backend управляет:
	•	где и как хранится terraform.tfstate
	•	кто и как к нему имеет доступ
	•	как обеспечить блокировку, чтобы два DevOps-инженера не применяли изменения одновременно

⸻

🧠 Без backend’а
	•	.tfstate хранится локально
	•	легко потерять / забыть
	•	нельзя работать в команде
	•	нельзя заблокировать одновременные изменения

⸻

✅ С backend’ом

Terraform может хранить tfstate в:
S3 AWS (часто в сочетании с DynamoDB для lock)
GitLab Встроенное хранилище (если GitLab настроен)
HTTP/HTTPS Хранение на собственном API или сервере
Local Можно использовать с блокировкой
GCS / Azure Облачные решения для Google Cloud и

🔧 Пример: local backend (учебный)
terraform {
  backend "local" {
    path = "backend/terraform.tfstate"
  }
}
📂 В этом случае .tfstate будет храниться не в корне проекта, а в backend/

🔐 Пример: backend для GitLab
terraform {
  backend "http" {
    address        = "https://gitlab.example.com/api/v4/projects/<id>/terraform/state/<name>"
    lock_address   = "https://gitlab.example.com/api/v4/projects/<id>/terraform/state/<name>/lock"
    unlock_address = "https://gitlab.example.com/api/v4/projects/<id>/terraform/state/<name>/unlock"
    lock_method    = "POST"
    unlock_method  = "DELETE"
    username       = "gitlab-ci-token"
    password       = "<your-token>"
  }
}

⚠️ Важные правила:
	•	backend нельзя объявлять как ресурс → он описывается в terraform блоке
	•	После первого terraform init с backend, нельзя просто так изменить backend
	•	Чтобы поменять backend → нужно terraform init -migrate-state

---

### Задание

1. Настроить backend типа local, чтобы terraform.tfstate хранился в отдельной папке (backend/)
2. Применить terraform init с миграцией состояния
3. Убедиться, что:
	•	backend/terraform.tfstate появился
	•	в корне .tfstate больше нет
4. Проверить работу terraform plan

1. `В main.tf (в любом проекте) добавь:`

```
terraform {
  backend "local" {
    path = "backend/terraform.tfstate"
  }
}
```
2. `Выполни:`

```
mkdir -p backend
terraform init -migrate-state
terraform plan
```
3. `Убедись, что: •	в папке backend/ появился файл .tfstate •	в корне он исчез •	terraform plan отрабатывает без проблем`

```
ls backend
terraform.tfstate
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`Terraform" - `TF-12 lifecycle, depends_on, count, for_each — управление логикой`

 ## 📘 Теория (кратко)

🔹 1. lifecycle — управление жизненным циклом ресурса

Позволяет управлять поведением создания, удаления, пересоздания ресурса.
resource "docker_container" "nginx" {
  name  = "web"
  image = "nginx:latest"

  lifecycle {
    prevent_destroy = true     # не даст случайно удалить
    ignore_changes  = [image]  # не реагировать на изменения образа
  }
}

🔹 2. depends_on — жёсткая зависимость между ресурсами

Иногда Terraform не понимает порядок. Тогда указываем явно:
resource "null_resource" "after_nginx" {
  depends_on = [docker_container.nginx]
}

🔹 3. count — создание N экземпляров ресурса

Управляет количеством создаваемых объектов по числу:
variable "replicas" {
  default = 3
}

resource "docker_container" "nginx" {
  count = var.replicas
  name  = "nginx-${count.index}"
  image = "nginx:latest"
}

🔹 4. for_each — создание объектов по ключам/значениям

Управляет поэлементным созданием по map или set:
variable "containers" {
  default = {
    "frontend" = 8080
    "backend"  = 8081
  }
}

resource "docker_container" "nginx" {
  for_each = var.containers

  name  = each.key
  image = "nginx:latest"

  ports {
    internal = 80
    external = each.value
  }
}

 ## Ключевые команды:

lifecycle Защита от удаления, игнор изменений
depends_on Жёсткий порядок действий
count Повторение ресурса N раз
for_each Повторение ресурса по map/list


---

### Задание

1. Создай два контейнера через for_each:
	•	frontend:8088
	•	backend:8089
2. Включи lifecycle с prevent_destroy = true для одного из них
3. Создай null_resource.waiter, который зависит от одного из контейнеров (depends_on)

1. `Объяви variable "containers" типа map, где ключ = имя, значение = порт`

```

```
2. `Создай ресурс docker_container с for_each = var.containers`

```

```
3. `В lifecycle для frontend поставь prevent_destroy = true`

```

```
4. `Добавь null_resource с depends_on = [docker_container.frontend]`

```

```
5. `Прогони terraform apply, а потом попробуй terraform destroy`

```
variable "containers" {
  default = {
    "frontend" = 8081
    "backend"  = 8092
  }
}

resource "docker_container" "nginx" {
  for_each = var.containers

  name  = each.key
  image = "nginx:latest"

  lifecycle {
    prevent_destroy = each.key == "frontend" ? true : false
    ignore_changes  = [image]
  }

  ports {
    internal = 80
    external = each.value
  }
}

resource "null_resource" "wait_for_frontend" {
  depends_on = [docker_container.nginx["frontend"]]

  provisioner "local-exec" {
    command = "echo 'Frontend container is ready'"
  }
}
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Terraform" - `TF-13 Разделение окружений: prod, stage, dev через workspaces и каталоги`

 ## 📘 Теория (кратко)

🔹 Подход 1: workspaces — логическое разделение

Terraform позволяет создавать несколько рабочих пространств в одном проекте. У каждого будет свой terraform.tfstate, но код — общий.

terraform workspace new dev
terraform workspace new prod
terraform workspace select dev
terraform apply

📂 Внутри .terraform/ появится папка для каждого окружения и отдельный tfstate.

🔹 Подход 2: Каталоги (envs/) — физическое разделение

Создаёшь отдельные папки с main.tf для каждого окружения:
project/
├── modules/
│   └── app/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── envs/
│   ├── dev/
│   │   └── main.tf   # module "app" {...}
│   ├── stage/
│   │   └── main.tf
│   └── prod/
│       └── main.tf
Каждая среда:
	•	может передавать свои переменные
	•	использовать разные backend’ы, облака, модули, теги

✅ Что выбрать?
workspaces
Одинаковый код, разные стейты
Каталоги (envs)
Когда отличаются переменные, провайдеры, архитектура

Часто используют оба одновременно: workspace + env directory = 🔥

### Задание

1. `Создай Terraform-проект с одним модулем (nginx)`

```

```
2. `Внутри main.tf используй terraform.workspace для изменения имени контейнера`

```

```
3. `Создай 2 окружения: •	dev •	prod`

```

```
4. `Убедись, что terraform apply в dev и prod создаёт разные контейнеры с уникальными именами`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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

# Модуль "`Terraform" - `DOC-01 Что такое Docker: концепции и архитектура`

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



# Модуль "`Terraform" - `DOC-02 Установка Docker на macOS (M4)`

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


# Модуль "`Terraform" - `DOC-03 Docker CLI: команды, образы, контейнеры`

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

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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

# Модуль "`Terraform" - `DOC-01 Что такое Docker: концепции и архитектура`

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



# Модуль "`Terraform" - `DOC-02 Установка Docker на macOS (M4)`

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


# Модуль "`Terraform" - `DOC-03 Docker CLI: команды, образы, контейнеры`

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

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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

# Модуль "`Terraform" - `DOC-01 Что такое Docker: концепции и архитектура`

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



# Модуль "`Terraform" - `DOC-02 Установка Docker на macOS (M4)`

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


# Модуль "`Terraform" - `DOC-03 Docker CLI: команды, образы, контейнеры`

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

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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

# Модуль "`Terraform" - `DOC-01 Что такое Docker: концепции и архитектура`

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



# Модуль "`Terraform" - `DOC-02 Установка Docker на macOS (M4)`

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


# Модуль "`Terraform" - `DOC-03 Docker CLI: команды, образы, контейнеры`

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

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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

# Модуль "`Terraform" - `DOC-01 Что такое Docker: концепции и архитектура`

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



# Модуль "`Terraform" - `DOC-02 Установка Docker на macOS (M4)`

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


# Модуль "`Terraform" - `DOC-03 Docker CLI: команды, образы, контейнеры`

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

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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

# Модуль "`Terraform" - `DOC-01 Что такое Docker: концепции и архитектура`

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



# Модуль "`Terraform" - `DOC-02 Установка Docker на macOS (M4)`

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


# Модуль "`Terraform" - `DOC-03 Docker CLI: команды, образы, контейнеры`

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

# Модуль "`Terraform" - `DOC-04 Dockerfile и создание собственного образа`

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


# Модуль "`Terraform" - `DOC-05 Docker Compose: многоконтейнерные приложения`

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

# Модуль "`Terraform" - `DOC-06 Volumes и управление данными`

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


# Модуль "`Terraform" - `DOC-07 Сетевые режимы Docker`

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

# Модуль "`Terraform" - `DOC-08 Практика: сборка и запуск веб-приложения`

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


# Модуль "`Terraform" - `DOC-09 Docker Registry: работа с DockerHub и собственным реестром`

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

# Модуль "`Terraform" - `DOC-10 Лучшие практики контейнеризации и безопасность`

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
