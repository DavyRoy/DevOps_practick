# Модуль "`Ansible`" - `ANS-01 — Что такое Ansible: основы конфигурационного управления`

 ### 🎯 Цель урока
Что такое Ansible

---

 ## 📘 Теория (кратко)

❓ Что такое Ansible

Ansible — это инструмент автоматизации, используемый для:
	•	Конфигурационного управления
	•	Установки ПО
	•	Оркестрации развертывания
	•	Управления инфраструктурой

Работает по push-модели — ты (control node) управляешь целевыми машинами (managed nodes) по SSH без установки агентов.

⸻

🧩 Архитектура Ansible
	•	Control Node — твоя локальная машина или сервер, где установлен Ansible
	•	Managed Nodes — машины, которыми ты управляешь (через SSH)
	•	Inventory — список управляемых машин
	•	Playbook — сценарий (на YAML), который описывает задачи (tasks)
	•	Модули — готовые действия (например, ping, copy, apt, docker_container)
	•	Роли — структурированные, переиспользуемые плейбуки
	•	Факты — информация о системе (через setup)

⸻

🛠 Пример сценария
- name: Установить nginx
  hosts: web
  become: true
  tasks:
    - name: Установка nginx
      apt:
        name: nginx
        state: present

✅ Преимущества Ansible
Без агентов Работает по SSH, не требует установки на серверах
Язык — YAML Понятный и человекочитаемый
Кросс-платформенность Работает с Linux, macOS, иногда даже Windows
Идемпотентность Повторный запуск не ломает систему
Простая установка Можно запустить даже с ноутбука

🔥 Когда и где используется
	•	Настройка серверов (nginx, docker, firewall)
	•	Массовое обновление ПО
	•	Автодеплой приложений
	•	Настройка облачной инфраструктуры (AWS, GCP)
	•	Интеграция в CI/CD

🔹 Как работает Ansible
[Local] ──(SSH)──► [Удалённый хост]
    |                   |
    |                   └── выполняется модуль, возвращается результат
    |
    └── читает inventory → запускает playbook → отправляет команды по SSH
Ansible берёт твой inventory, читает playbook, и отправляет модули на хосты. Эти модули исполняются, и результат возвращается назад.

 ## Конспект:

	•	Ansible = YAML + SSH + inventory + playbooks
	•	Push-модель (Control → Managed)
	•	Нет агентов (agentless)
	•	Главные команды:
	•	ansible — одиночная команда
	•	ansible-playbook — запуск сценария
	•	Файлы:
	•	inventory.ini — список хостов
	•	playbook.yml — набор задач

---

### Задание

1. 	•	Установи Ansible на macOS
	•	Создай inventory.ini с localhost
	•	Проверь соединение: ansible all -i inventory.ini -m ping

1. `Установи Ansible: brew install ansible`

```

```
2. `Создай inventory.ini`

```
[local]
localhost ansible_connection=local
```
3. `Проверь подключение`

```
ansible all -i inventory.ini -m ping
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`Ansible`" - `ANS-02 — Установка Ansible на macOS / Ubuntu + настройка подключения к удалённому серверу`

 ### 🎯 Цель урока
Установка Ansible локально и на удалённой машине (Vagrant Ubuntu)

---

 ## 📘 Теория (кратко)

Ansible устанавливается только на Control Node — это может быть:
	•	твоя локальная машина (macOS, Ubuntu);
	•	отдельный сервер (например, CI/CD runner);
	•	виртуалка или контейнер.

На управляемых хостах (Managed Nodes) — ничего устанавливать не нужно! Всё работает по SSH.

🖥 Установка на macOS

Ansible доступен через Homebrew:
brew install ansible
Проверь версию:
ansible --version

🐧 Установка на Ubuntu/Debian

Рекомендуемый способ:
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
Проверка:
ansible --version

🔐 Настройка SSH-доступа

Ansible подключается к хостам по SSH.

Шаги:
	1.	Сгенерируй ключ:
    ssh-keygen -t ed25519
    2.	Добавь публичный ключ на сервер:
    ssh-copy-id user@remote_ip
    3.	Убедись, что можешь подключиться без пароля:
    ssh user@remote_ip

📁 Inventory для удалённого хоста
[web]
192.168.1.100 ansible_user=ubuntu
Или в YAML (inventory.yml):
all:
  hosts:
    web1:
      ansible_host: 192.168.1.100
      ansible_user: ubuntu

🛠 Проверка соединения:
ansible all -i inventory.ini -m ping
Если всё настроено верно — получишь "ping": "pong".

 ## Ключевые команды:

	•	brew install ansible — macOS
	•	apt install ansible — Ubuntu
	•	Подключение: по SSH, лучше по ключу
	•	Команда для проверки: ansible -i inventory all -m ping
	•	Inventory указывает IP + пользователя

---

### Задание

1. 	•	Установи Ansible на Ubuntu (локально или в VM)
	•	Настрой SSH-доступ к другой машине (например, Docker-контейнер или сервер в сети)
	•	Создай inventory.ini с этим хостом
	•	Проверь ansible -i inventory.ini all -m ping

1. `Установи Ansible на Ubuntu (или Docker-контейнер с SSH)`

```

```
2. `Настрой SSH-ключ, передай его на целевой хост`

```

```
3. `Пропиши IP и логин в inventory.ini`

```

```
4. `Выполни ansible all -i inventory.ini -m ping`

```
[web]
web1 ansible_host=10.37.129.3 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-03 — Inventory-файлы: localhost, static, dynamic`

 ### 🎯 Цель урока
Что такое Inventory в Ansible?

---

 ## 📘 Теория (кратко)

Inventory — это файл, где Ansible узнаёт, какими хостами управлять.

📂 Поддерживаемые форматы:
	•	INI (inventory.ini)
	•	YAML (inventory.yml)
	•	Динамические скрипты/плагины (AWS, Docker, Kubernetes и др.)

⸻

🔸 Виды inventory

✅ 1. Локальный (localhost)

Используется для запуска задач на самой машине.
[local]
localhost ansible_connection=local
или YAML:
all:
  hosts:
    localhost:
      ansible_connection: local

✅ 2. Статический inventory

Жестко заданный список хостов. Можно указать IP, user, ключи и переменные.

INI-пример:
[web]
192.168.64.10 ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/parallels/private_key
YAML-пример:
all:
  children:
    web:
      hosts:
        web1:
          ansible_host: 192.168.64.10
          ansible_user: vagrant
          ansible_ssh_private_key_file: .vagrant/machines/default/parallels/private_key

✅ 3. Динамический inventory

Ansible умеет сам получать список хостов, например из:
	•	AWS (aws_ec2)
	•	Docker (community.docker.docker_host)
	•	Kubernetes (k8s inventory plugin)
	•	Скриптов (inventory.py)

📦 Пример (AWS):
ansible-inventory -i aws_ec2.yaml --graph
Форматы динамического inventory — YAML-файл + плагин или скрипт.

🧠 Полезные команды:
ansible-inventory -i inventory.ini --list
ansible-inventory -i inventory.yml --graph

 ## Конспект:

	•	Inventory описывает управляемые хосты
	•	Форматы: INI, YAML, Dynamic
	•	ansible_connection=local — для localhost
	•	Можно задавать группы: [web], [db]
	•	ansible_user, ansible_host, ansible_ssh_private_key_file — ключевые параметры

---

### Задание

1. Создай и протестируй три inventory:
	1.	Локальный — localhost с ansible_connection=local
	2.	Статический — к твоей виртуалке через Vagrant (как в ANS-02)
	3.	Динамический — на выбор (например, плагин community.docker или скрипт-заглушка)

1. `Создай 3 файла: •	inventory_local.ini •	inventory_static.ini •	inventory_dynamic.sh (или .py, .yaml)`

```
inventory_local.ini
[local]
localhost ansible_connection=local

inventory_static.ini
[web]
web1 ansible_host=10.37.129.3 ansible_user=vagrant ansible_password=vagrant ansible_ssh_common_args='-o StrictHostKeyChecking=no'

inventory_dynamic.sh
#!/usr/bin/env python3
import json

inventory = {
    "all": {
        "hosts": ["web1"],
        "vars": {},
    },
    "_meta": {
        "hostvars": {
            "web1": {
                "ansible_host": "10.37.129.3",
                "ansible_user": "vagrant",
                "ansible_password": "vagrant",
                "ansible_ssh_common_args": "-o StrictHostKeyChecking=no"
            }
        }
    }
}

print(json.dumps(inventory))


```
2. `Убедись, что ansible all -i <inventory> -m ping работает для всех (или имитирует)`

```

```
3. `Используй --list и --graph для отображения структур`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-04 - SSH-доступ и аутентификация для Ansible`

 ### 🎯 Цель урока
SSH-доступ и аутентификация для Ansible

---

 ## 📘 Теория (кратко)

🔹 Как Ansible подключается к удалённой машине?

Ansible использует обычный SSH для подключения к управляемым узлам:
ansible web -i inventory.ini -m ping
Эта команда делает то же самое, что ты бы сделал вручную:
ssh -i ~/.ssh/key.pem user@IP

🔹 Способы аутентификации
🔑 Private key (рекомендуется) Самый безопасный. Используется с ansible_ssh_private_key_file
🔐 Пароль Можно указать через --ask-pass, но это неудобно и небезопасно
🔐 SSH-агент Ключи заранее добавлены в ssh-agent, Ansible просто их использует
🔁 Ansible Vault Хранение паролей и ключей в зашифрованном виде

🔸 Как задаются параметры в inventory.ini
[web]
web1 ansible_host=10.37.129.4 ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/parallels/private_key
Дополнительно можно указать:
ansible_port=2222
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

🔸 Указание пароля (если нет ключа)
ansible web -i inventory.ini -m ping --ask-pass
📛 Лучше не использовать в продакшене. Только для тестов и отладки.

🔸 Проверка подключения вручную:
ssh -i .vagrant/machines/default/parallels/private_key vagrant@10.37.129.4

🔹 Возможные ошибки
Permission denied (publickey) Неправильный путь до приватного ключа
Connection refused SSH не запущен на удалённой машине
Host key verification failed Не добавлен ключ в known_hosts


 ## Конспект:

 Пример строки в inventory.ini
web1 ansible_host=10.37.129.4 ansible_user=vagrant ansible_ssh_private_key_file=.vagrant/machines/default/parallels/private_key

Проверка соединения вручную
ssh -i .vagrant/.../private_key vagrant@10.37.129.4

 Альтернатива: использовать ssh-agent или Vault

---

### Задание

1. Проверь SSH-доступ вручную

1. ` `

```

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-05 — Базовые модули Ansible: ping, command, copy, apt, service, и др.`

 ### 🎯 Цель урока
Модули

---

 ## 📘 Теория (кратко)

Модули — это строительные блоки Ansible. Каждый task в playbook использует один модуль для выполнения действия.

⸻

🔹 Основные модули, которые нужно знать:
ping - Проверка соединения - ansible all -m ping
command - Запуск команды (без оболочки) - command: uptime
shell - Запуск команд с использованием shell - shell: echo $HOME
copy - Копирует локальный файл на удалённый хост - copy: src=... dest=...
apt - Управление пакетами (Ubuntu/Debian) - apt: name=nginx state=present
yum - Управление пакетами (RHEL/CentOS) - yum: name=httpd state=latest
service - Управление службами (systemd, init) - service: name=nginx state=started
file - Работа с файлами и правами - file: path=/tmp/test mode=0755 state=touch
debug - Вывод значения переменной или текста - debug: msg="Deploy complete"

⚠️ Отличие command и shell
	•	command — безопаснее, но не поддерживает переменные окружения и конструкции оболочки (&&, >, |)
	•	shell — запускается через bash/sh, можно использовать всё как в обычном shell

⸻

🧠 Пример задачи с несколькими модулями
- name: Демонстрация модулей
  hosts: web
  become: true
  tasks:
    - name: Проверка соединения
      ping:

    - name: Вывод текущего пользователя
      command: whoami

    - name: Копирование index.html
      copy:
        src: ./files/index.html
        dest: /var/www/html/index.html

    - name: Установка NGINX
      apt:
        name: nginx
        state: present
        update_cache: yes

    - name: Запуск сервиса NGINX
      service:
        name: nginx
        state: started
        enabled: true

🔸 Обзор модулей

✅ ping

Проверяет доступность узла и Python-интерпретатора.
ansible all -m ping

✅ command

Запускает простую команду без shell.
	•	Без подстановки переменных, пайпов и перенаправлений.
ansible all -m command -a "uptime"
ansible all -m command -a "ls -l /home/vagrant"

✅ shell

Запускает команду в оболочке (/bin/sh), поддерживает пайпы, переменные, &&, | и т.п.
ansible all -m shell -a "echo $HOME && whoami"
ansible all -m shell -a "cat /etc/*release"

✅ copy

Копирует файл с локальной машины на удалённую.
ansible all -m copy -a "src=./test.txt dest=/home/vagrant/test.txt"

✅ apt

Менеджер пакетов для Ubuntu/Debian (аналог apt install ...)
ansible all -m apt -a "name=nginx state=present update_cache=yes" --become
	•	--become — используется для выполнения от root.
	•	state=present — установить пакет.
	•	state=absent — удалить пакет.

 ## Конспект:

	•	Модуль = действие (command, copy, apt, …)
	•	ping — тест соединения
	•	command vs shell: первый безопаснее, второй гибче
	•	copy требует src и dest
	•	apt/yum управляют пакетами
	•	service управляет процессами
   ping
ansible all -m ping

  command (без shell)
ansible all -m command -a "whoami"

  shell (можно пайпы, переменные и т.д.)
ansible all -m shell -a "echo $HOME"

  copy файл
ansible all -m copy -a "src=local.txt dest=/tmp/remote.txt"

  apt (установка пакета)
ansible all -m apt -a "name=curl state=present update_cache=yes" --become

---

### Задание

1. Создай плейбук, демонстрирующий работу основных модулей Ansible.
Задания должны быть выполнимы на твоей виртуалке Ubuntu (web1).

1. `Создай плейбук basic_modules.yml`

```

```
2. `Добавь задачи: •	ping •	command: uptime •	shell: echo $HOME •	copy: файл из ./files/hello.txt в /tmp/hello.txt •	apt: установка curl •	service: убедиться, что nginx запущен`

```

```
3. `Добавь вывод debug в конце: "Сценарий выполнен успешно"`

```
- name: Демонстрация модулей
  hosts: web
  become: true
  tasks:
    - name: Проверка соединения
      ping:

    - name: Вывод
      command: uptime

    - name: Вывод Home
      shell: echo $HOME

    - name: Копирование hello.txt
      copy:
        src: /Users/sergeylapshov/Documents/Devops/docker/Ansible/ANS-05/files/hello.txt
        dest: /tmp/hello.txt

    - name: Установка
      apt:
        name: curl
        state: present
        update_cache: yes

    - name: Запуск сервиса NGINX
      service:
        name: nginx
        state: started
        enabled: true

    - name: Вывод
      debug:
        msg: "Сценарий выполнен успешно"

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-06 — Переменные в Ansible: vars, host_vars, group_vars, vars_files`

 ### 🎯 Цель урока
Плейбуки: структура, hosts, tasks, vars, become

---

 ## 📘 Теория (кратко)

 🔹 Что такое playbook?

Playbook — это YAML-файл, содержащий один или несколько “плейов” (play), каждый из которых говорит Ansible, каким хостам что делать и как.

Это как скрипт, но декларативный — ты описываешь, что должно быть, а не как.

Ansible позволяет переиспользовать значения и управлять конфигурацией через переменные. Это основа масштабируемых инфраструктур.

⸻

🔸 Структура playbook’а
- name: Название плейа
  hosts: web
  become: true
  vars:
    package_name: htop
  tasks:
    - name: Установить пакет
      apt:
        name: "{{ package_name }}"
        state: present
        update_cache: yes
name Человеко-понятное название play или task
hosts На какие хосты применяется (all, web, db и т.п.)
become Нужно ли использовать sudo/root (аналог --become)
vars Локальные переменные, которые можно переиспользовать
tasks Список шагов-модулей, которые Ansible выполнит по очереди

🔸 Отличие от ansible -m
Ad-hoc (-m) - ansible all -m apt ... - Быстрое разовое действие
Playbook (YAML) - ansible-playbook playbook.yml - Сценарии, CI/CD, DevOps


🔹 Где можно определять переменные?
vars: внутри playbook - 🟢 низкий - Переменные прямо в playbook’е
host_vars/<hostname>.yml - 🟡 средний - Переменные для конкретного хоста
group_vars/<groupname>.yml - 🟡 средний - Переменные для всей группы из inventory
vars_files: - 🔵 выше - Внешние YAML-файлы, подключаемые в playbook
CLI (-e) - 🔴 высокий - Переопределение из командной строки

🧩 Пример: vars внутри playbook
- name: Установка nginx с переменной
  hosts: web
  become: true
  vars:
    web_package: nginx
  tasks:
    - name: Установить {{ web_package }}
      apt:
        name: "{{ web_package }}"
        state: present

📁 group_vars и host_vars

Структура:
inventory.ini
group_vars/
  web.yml
host_vars/
  web1.yml

Пример group_vars/web.yml:
web_package: nginx

Пример host_vars/web1.yml:
web_port: 8080
Ansible сам автоматически загрузит эти переменные на основе inventory.

🔸 vars_files
- name: Пример с vars_files
  hosts: web
  become: true
  vars_files:
    - vars/main.yml

А в vars/main.yml:
web_package: nginx

🧠 Использование переменных
	•	Всегда оборачивай в {{ variable }}
	•	Можно использовать в tasks, notify, templates, when, with_items, и др.

 ## Конспект:

	•	vars: — внутри playbook
	•	group_vars/ — для группы хостов (например, [web])
	•	host_vars/ — для конкретного хоста (web1)
	•	vars_files — внешние YAML-файлы с переменными
	•	Всё — в формате key: value
---

### Задание

1. Сделай так, чтобы playbook:
	•	устанавливал пакет (nginx, curl, или htop) из переменной
	•	порт для nginx задавался через переменную
	•	переменные брались:
	•	одна из vars в playbook
	•	одна из group_vars
	•	одна из host_vars
	•	одна из vars_files

1. `Создай playbook vars_demo.yml`

```

```
2. `Добавь: •	vars: в playbook •	файл group_vars/web.yml •	файл host_vars/web1.yml •	файл vars/main.yml и подключи через vars_files:`

```

```
3. `Выведи все переменные через debug:`

```
- name: Установка пакетов с использованием переменных
  hosts: web
  become: true
  vars:
    manual_package: nginx
  vars_files:
    - vars/main.yml

  tasks:
    - name: Установить пакет из переменной в vars (playbook)
      apt:
        name: "{{ manual_package }}"
        state: present

    - name: Установить пакет из group_vars
      apt:
        name: "{{ web_package }}"
        state: present

    - name: Установить пакет из vars_files
      apt:
        name: "{{ web2_package }}"
        state: present

    - name: Вывод всех переменных
      debug:
        msg: |
          From vars: {{ manual_package }}
          From group_vars: {{ web_package }}
          From vars_file: {{ web2_package }}

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-07 - Условия (when), циклы (loop), handlers`

 ### 🎯 Цель урока
Условия (when), циклы (loop), обработчики (handlers)

---

 ## 📘 Теория (кратко)

🔹 when: выполнение условий

Позволяет выполнять задачу только если условие истинно.
- name: Установить nginx, только если ОС — Ubuntu
  apt:
    name: nginx
    state: present
  when: ansible_facts['os_family'] == "Debian"

🔹 loop: выполнение задач по списку

Выполняет задачу несколько раз для разных значений.
- name: Создать директории
  file:
    path: "/opt/{{ item }}"
    state: directory
  loop:
    - app
    - logs
    - config

🔹 with_items: старый синтаксис
with_items:
  - user1
  - user2
✅ Поддерживается, но предпочтителен loop.

🔹 handlers: реакция на изменения

Если задача что-то изменила, можно “уведомить” обработчик, чтобы он, например, перезапустил сервис.
tasks:
  - name: Копировать nginx конфиг
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/sites-available/default
    notify: restart nginx

handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted
🔥 Обработчики запускаются один раз в конце плейбука, даже если уведомлены несколько раз.


 ## Ключевые команды:

  Условие
when: ansible_facts['distribution'] == "Ubuntu"

  Цикл
loop:
  - curl
  - htop
  - git

  Handler
notify: restart nginx

handlers:
  - name: restart nginx
    service:
      name: nginx
      state: restarted

---

### Задание

1. Создай multi_install.yml
Пусть он:
	•	работает на web
	•	устанавливает несколько пакетов (curl, htop, git) через loop
	•	использует when:
	•	установка выполняется только если ansible_facts['os_family'] == "Debian"
2. Создай template файл motd.j2 со следующим содержанием: Welcome to {{ inventory_hostname }}!
Managed by Ansible 🚀

1. `ansible-playbook -i inventory.ini vars_demo.yml`

```
ansible-playbook -i inventory.ini vars_demo.yml

PLAY [Установка пакетов с использованием переменных] ********************************************************************

TASK [Gathering Facts] **************************************************************************************************
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.10, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [web1]

TASK [Установка пакетов] ************************************************************************************************
ok: [web1] => (item=curl)
ok: [web1] => (item=htop)
ok: [web1] => (item=git)

TASK [Копировать файла] *************************************************************************************************
changed: [web1]

RUNNING HANDLER [restart nginx] *****************************************************************************************
changed: [web1]

PLAY RECAP **************************************************************************************************************
web1                       : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


- name: Установка пакетов с использованием переменных
  hosts: web
  become: true

  tasks:
    - name: Установка пакетов
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - curl
        - htop
        - git
      when: ansible_os_family == "Debian"

    - name: Копировать файла
      template:
        src: motd.j2
        dest: /etc/motd
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted

```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-08 - Работа с шаблонами Jinja2 и template`

 ### 🎯 Цель урока
Работа с шаблонами Jinja2 и модулем template

---

 ## 📘 Теория (кратко)

🔹 Что такое Jinja2?

Jinja2 — это шаблонизатор. Ansible использует его, чтобы:
	•	Вставлять переменные в конфиги ({{ var }})
	•	Условно включать/выключать фрагменты
	•	Использовать циклы, фильтры и условия в шаблонах

🔸 Примеры

✅ Переменные
server {
    listen {{ nginx_port }};
    server_name {{ inventory_hostname }};
}

✅ Условие (if)
{% if enable_ssl %}
ssl_certificate /etc/ssl/cert.pem;
ssl_certificate_key /etc/ssl/key.pem;
{% endif %}

✅ Цикл (for)
{% for user in users %}
- {{ user }}
{% endfor %}

✅ Фильтры (default, upper, lower, replace, join, length и др.)
Hello {{ username | default('Guest') | upper }}


 ## Конспект :

- `{{ variable }}              # переменная
{{ list | join(", ") }}    # фильтр
{% if condition %} ... {% endif %}
{% for item in list %} ... {% endfor %}`


---

### Задание

1. `Создай файл index.html.j2 со следующей логикой:`

```
<html>
  <body>
    <h1>Hello from {{ inventory_hostname }}</h1>
    <ul>
    {% for service in services %}
      <li>{{ service }}</li>
    {% endfor %}
    </ul>

    {% if show_footer %}
    <footer>Managed by Ansible — {{ ansible_date_time.date }}</footer>
    {% endif %}
  </body>
</html>
```
2. `В group_vars/web.yml добавь`

```
services:
  - nginx
  - docker
  - sshd
show_footer: true
```
3. `Напиши playbook под названием generate_page.yml, который: •	копирует шаблон в /home/vagrant/index.html •	использует template + переменные из group_vars`

```
- name: Запуск переменных
  hosts: web
  become: true

  tasks:
    - name: Копировать файла
      template:
        src: index.html.j2
        dest: /home/vagrant/index.html
      notify: restart nginx

  handlers:
    - name: restart nginx
      service:
        name: nginx
        state: restarted

ansible-playbook -i inventory.ini generate_page.yml

PLAY [Запуск переменных] ************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.10, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [web1]

TASK [Копировать файла] *************************************************************************************************
changed: [web1]

RUNNING HANDLER [restart nginx] *****************************************************************************************
changed: [web1]

PLAY RECAP **************************************************************************************************************
web1                       : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

cat /home/vagrant/index.html
<html>
  <body>
    <h1>Hello from web1</h1>
    <ul>
          <li>nginx</li>
          <li>docker</li>
          <li>sshd</li>
        </ul>

        <footer>Managed by Ansible — 2025-05-21</footer>
      </body>
</html>
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-9 - Управление несколькими хостами и группами`

 ### 🎯 Цель урока
Управление несколькими хостами и группами

---

 ## 📘 Теория (кратко)

🔹 Inventory с несколькими группами и хостами
[web]
web1 ansible_host=10.37.129.4 ansible_user=vagrant ansible_ssh_private_key_file=...

[db]
db1 ansible_host=10.37.129.5 ansible_user=vagrant ansible_ssh_private_key_file=...
Можно создавать иерархии:
[prod:children]
web
db

🔹 Плейбуки на группы
- name: Установка curl на web
  hosts: web
  tasks:
    - apt:
        name: curl
        state: present

- name: Установка PostgreSQL на db
  hosts: db
  tasks:
    - apt:
        name: postgresql
        state: present

🔹 Переменные на группу и хост
	•	group_vars/web.yml → общие переменные для всех web-серверов
	•	host_vars/db1.yml → специфичные для db1

⸻

🔹 Тестовая структура
inventory.ini
group_vars/
  web.yml
  db.yml
host_vars/
  web1.yml
  db1.yml


 ## Конспект:

- `[web]
web1 ansible_host=10.0.0.10

[db]
db1 ansible_host=10.0.0.20

[all:vars]
ansible_user=vagrant
ansible_ssh_private_key_file=...`

- `ansible web -i inventory.ini -m ping
ansible db -i inventory.ini -m ping`

---

### Задание

1. `Добавь в inventory.ini новую группу db, с хостом db1 (можно сделать ещё одну Vagrant-машину, если хочешь; или использовать тот же хост под другим именем)`

```
[web]
web1 ansible_host=10.37.129.5 ansible_user=vagrant ansible_ssh_private_key_file=/Users/sergeylapshov/Documents/Devops/docker/Ansible/.vagrant/machines/node1/parallels/private_key

[db]
web1 ansible_host=10.37.129.6 ansible_user=vagrant ansible_ssh_private_key_file=/Users/sergeylapshov/Documents/Devops/docker/Ansible/.vagrant/machines/node2/parallels/private_key

```
2. `Создай следующую структуру:`

```
group_vars/
  web.yml        → package_name: nginx
  db.yml         → package_name: postgresql
```
3. `Создай один playbook install_by_group.yml, который:`

```
	•	Устанавливает {{ package_name }} на соответствующую группу
	•	Делает это в одном файле — два play поочерёдно
```
4. `Вывод:`

```
	ansible-playbook -i inventory.ini install_by_group.yml

PLAY [Установка пакетов] ************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.10, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [web1]

TASK [Установка пакетов nginx] ******************************************************************************************
changed: [web1]

PLAY [Установка пакетов] ************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
ok: [web1]

TASK [Установка пакетов postgres] ***************************************************************************************
ok: [web1]

PLAY RECAP **************************************************************************************************************
web1                       : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


- name: Установка пакетов
  hosts: web
  become: true

  tasks:
    - name: Установка пакетов nginx
      apt:
        name: "{{ package_name }}"
        state: present

- name: Установка пакетов
  hosts: db
  become: true

  tasks:
    - name: Установка пакетов postgres
      apt:
        name: "{{ package_name }}"
        state: present

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-10 - Ansible Roles: структура и применение`

 ### 🎯 Цель урока
Научиться устанавливать Docker, запускать контейнеры, управлять ими и проверять их статус.

---

 ## 📘 Теория (кратко)

🔹 Что такое role?

Role (роль) — это способ структурировать плейбуки. В роли уже заложены:
	•	Плейбуки (tasks)
	•	Переменные (vars)
	•	Шаблоны (templates)
	•	Хендлеры (handlers)
	•	Файлы (files)
	•	Метаданные (meta)

🔹 Зачем нужны роли?
Один огромный плейбук - Модулируемая, переиспользуемая структура
Сложно переиспользовать - Легко импортировать и делиться
Неудобно поддерживать -Чёткая структура, масштабируется

🔹 Стандартная структура роли
roles/
  nginx/
    tasks/
      main.yml
    handlers/
      main.yml
    templates/
      nginx.conf.j2
    files/
      index.html
    vars/
      main.yml
    defaults/
      main.yml
    meta/
      main.yml
📦 Все main.yml — входные точки. Ansible будет их искать автоматически.

🔸 Как подключить роль в плейбуке
- name: Установка nginx через роль
  hosts: web
  become: true
  roles:
    - nginx

🔸 Создание роли вручную
ansible-galaxy init roles/nginx
Это создаст каркас роли.

🔸 Переменные в роли
	•	defaults/main.yml — наименее приоритетные (можно переопределить снаружи)
	•	vars/main.yml — выше приоритетом


 ## Ключевые команды:


---

### Задание

1. `Создай роль nginx:`

```
ansible-galaxy init roles/nginx
```
2. `•	roles/nginx/tasks/main.yml — установка nginx •	roles/nginx/handlers/main.yml — перезапуск nginx •	roles/nginx/templates/nginx.conf.j2 — твой шаблон конфига •	roles/nginx/defaults/main.yml — переменная nginx_port: 8080`

```
cat roles/nginx/tasks/main.yml
#SPDX-License-Identifier: MIT-0
---
# tasks file for roles/nginx
- name: Установка пакетов nginx
  apt:
    name: "{{ package_name }}"
    state: present
  when: ansible_os_family == "Debian"
  tags:
    - nginx
    - install
    - packages

cat roles/nginx/handlers/main.yml
#SPDX-License-Identifier: MIT-0
---
# handlers file for roles/nginx
- name: restart nginx
  service:
    name: nginx
    state: restarted

cat roles/nginx/templates/nginx.conf.j2
server {
    listen {{ nginx_port }};
    location / {
        return 200 'Hello from Ansible';
    }
}

cat roles/nginx/defaults/main.yml
#SPDX-License-Identifier: MIT-0
---
# defaults file for roles/nginx
nginx_port: 8089
```
3. `Напиши playbook install_nginx_role.yml:`

```
- name: Установка nginx через роль
  hosts: web
  become: true
  roles:
    - nginx
```
4. `Структура`

```
tree
.
├── install_nginx_role.yml
├── inventory.ini
└── roles
    └── nginx
        ├── defaults
        │   └── main.yml
        ├── files
        ├── handlers
        │   └── main.yml
        ├── meta
        │   └── main.yml
        ├── README.md
        ├── tasks
        │   └── main.yml
        ├── templates
        │   └── nginx.conf.j2
        ├── tests
        │   ├── inventory
        │   └── test.yml
        └── vars
            └── main.yml

11 directories, 11 files
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-11 - Ansible Galaxy: установка и использование community-ролей`

 ### 🎯 Цель урока
Ansible Galaxy — установка и использование community-ролей

---

 ## 📘 Теория (кратко)

🔹 Что такое Ansible Galaxy?

Это платформа и CLI-инструмент, через который можно:
	•	📦 Устанавливать готовые роли
	•	🚀 Публиковать собственные
	•	🔁 Подключать зависимости
	•	📁 Обновлять и управлять ролями как пакетами

🔹 Как работает?

Роли из Galaxy скачиваются в:
	•	~/.ansible/roles/ — глобально
	•	или в roles/ текущего проекта, если указать --roles-path

⸻

🔸 Установка роли из Galaxy

Пример:
ansible-galaxy install geerlingguy.docker
📦 Это скачает популярную роль docker от Jeff Geerling.

🔸 Использование в playbook
- name: Установка Docker через роль
  hosts: web
  become: true
  roles:
    - geerlingguy.docker
Все переменные роли можно посмотреть на Ansible Galaxy.

🔸 Файл requirements.yml

Можно явно указать роли и версии:
- src: geerlingguy.docker
  version: 6.0.1
  Затем:
  ansible-galaxy install -r requirements.yml


 ## Ключевые команды:



---

### Задание

1. `Установи роль:`

```
ansible-galaxy install geerlingguy.docker
```
2. `Создай файл install_docker.yml с использованием роли:`

```
- name: Установка Docker через роль Galaxy
  hosts: web
  become: true
  roles:
    - geerlingguy.docker
```
3. `Запусти playbook и убедись, что Docker установлен на удалённой машине`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`Ansible`" - `ANS-12 - Теги, флаги и выборочное выполнение задач`

 ### 🎯 Цель урока
Теги, флаги и выборочное выполнение задач

---

 ## 📘 Теория (кратко)

🔹 Что такое tags?

tags позволяют пометить задачи (или даже целые роли), чтобы затем запускать только их или пропускать.

🔸 Пример использования:
tasks:
  - name: Установить nginx
    apt:
      name: nginx
      state: present
    tags:
      - install
      - web

  - name: Скопировать конфиг
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
    tags:
      - config

🔸 Запуск только определённых тегов:
ansible-playbook -i inventory.ini playbook.yml --tags install

🔸 Пропуск задач по тегам:
ansible-playbook -i inventory.ini playbook.yml --skip-tags config

🔹 Как пометить всю роль тегом:
roles:
  - role: nginx
    tags: [nginx, web]

 ## Ключевые команды:


---

### Задание

1. `Возьми один из своих playbook’ов (например, install_nginx_role.yml) и пометь:`

```
Установка пакета install
Копирование шаблона config
Перезапуск nginx (handler) restart
```
2. `Запусти playbook:`

```
  •	Только --tags install
	•	Только --tags config
	•	Пропусти --skip-tags restart
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-13 - Файлы ansible.cfg, настройка поведения`

 ### 🎯 Цель урока
Файл ansible.cfg и настройка поведения

---

 ## 📘 Теория (кратко)

🔹 Где Ansible ищет конфиг?

Ansible ищет ansible.cfg в таком порядке:
	1.	Флаг CLI (--config)
	2.	Текущая директория (./ansible.cfg)
	3.	Переменная окружения (ANSIBLE_CONFIG)
	4.	Домашняя папка (~/.ansible.cfg)
	5.	Системный файл (/etc/ansible/ansible.cfg)

✅ Обычно мы создаём ansible.cfg в директории проекта.

⸻

🔸 Пример базового ansible.cfg
[defaults]
inventory = inventory.ini
remote_user = vagrant
private_key_file = .vagrant/machines/default/parallels/private_key
host_key_checking = False
retry_files_enabled = False
deprecation_warnings = False
timeout = 10

[privilege_escalation]
become = True
become_method = sudo
become_user = root

🔹 Популярные настройки
inventory По умолчанию использовать указанный inventory-файл
host_key_checking Не спрашивать подтверждение при первом SSH-подключении
remote_user Пользователь по умолчанию
private_key_file Путь к SSH-ключу
retry_files_enabled Не создавать retry-файлы
forks Количество параллельных хостов
timeout Время ожидания SSH
roles_path Где искать роли


 ## Ключевые команды:

---

### Задание

1. `Создай файл ansible.cfg в корне проекта`

```

```
2. `Пропиши в нём:s`

```
[defaults]
inventory = inventory.ini
remote_user = vagrant
private_key_file = .vagrant/machines/default/parallels/private_key
host_key_checking = False
retry_files_enabled = False
timeout = 10
deprecation_warnings = False
```
3. `Удали -i inventory.ini из запуска плейбука и убедись, что он работает:`

```
ansible-playbook install_nginx_role.yml
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-14 - Установка приложений через Ansible (nginx, docker, etc.)`

 ### 🎯 Цель урока
Установка приложений через Ansible (nginx, docker, etc.)

---

 ## 📘 Теория (кратко)

Ansible может устанавливать любые пакеты, сервисы, и даже настраивать их — главное использовать правильные модули и переменные.

⸻

🔹 Стандартные подходы:

✅ Использование apt/yum:
- name: Установить nginx
  apt:
    name: nginx
    state: present
    update_cache: yes

✅ Копирование конфигураций (template, copy):
- name: Копировать nginx конфиг
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf

✅ Перезапуск сервисов:
- name: Перезапуск nginx
  service:
    name: nginx
    state: restarted

✅ Установка Docker:
	•	Можно руками через apt
	•	Или через готовую роль: geerlingguy.docker

 ## Конспект:

tasks:
  - name: Установить nginx
    apt:
      name: nginx
      state: present

  - name: Копировать конфиг
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/sites-available/default

  - name: Перезапуск nginx
    service:
      name: nginx
      state: restarted

---

### Задание

1. `Создай playbook с двумя plays: web и docker`

```

```
2. `Пусть: •	В web устанавливается nginx, копируется конфиг, перезапускается •	В docker устанавливается docker.io через apt, и запускается тестовый контейнер (например, hello-world)`

```

```
3. `Можно использовать group_vars:`

```
group_vars/
  web.yml       → nginx_port: 8080
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-15 - CI/CD с Ansible (основа для будущей связки)`

 ### 🎯 Цель урока
CI/CD с Ansible (основа для будущей связки)

---

 ## 📘 Теория (кратко)

🔹 Что такое CI/CD с Ansible?

Это автоматическое выполнение playbook’ов:
	•	CI: тестирует плейбуки, проверяет синтаксис, idempotency
	•	CD: разворачивает инфраструктуру и приложения после push’а

⸻

🔸 Примеры использования
GitHub Actions ansible-playbook site.yml после пуша в main
GitLab CI/CD Автодеплой через ansible на staging
Jenkins Вызов плейбука через CLI с параметрами

🔸 Что нужно для CI/CD:
	1.	Репозиторий с ansible.cfg, inventory, playbooks, roles
	2.	Docker-образ или runner с Ansible
	3.	Доступ по SSH к целевым хостам
	4.	Переменные и ключи в Secrets

🔸 Типичный .github/workflows/deploy.yml
name: Deploy via Ansible

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Ansible
        run: sudo apt update && sudo apt install -y ansible

      - name: Run playbook
        run: ansible-playbook -i inventory.ini deploy.yml

 ## Конспект :

  Проверка playbook'а:
ansible-playbook playbook.yml --syntax-check

  Выполнение в CI:
ansible-playbook -i inventory.ini deploy.yml

---

### Задание

1. `Структурируй текущую директорию Ansible-проекта:`

```
project/
├── ansible.cfg
├── inventory.ini
├── playbooks/
│   └── deploy.yml
├── roles/
│   └── ...
└── .github/
    └── workflows/
        └── deploy.yml
```
2. `Напиши deploy.yml, который: •	Устанавливает nginx •	Копирует index.html •	Перезапускает nginx`

```

```
3. `Добавь .github/workflows/deploy.yml, в котором: 	•	Checkout •	Установка Ansible •	Выполнение ansible-playbook -i inventory.ini playbooks/deploy.yml`

```
Run ansible-playbook Ansible/ANS-15/deploy.yml
  ansible-playbook Ansible/ANS-15/deploy.yml
  shell: /usr/bin/bash -e {0}
Warning: : No inventory was parsed, only implicit localhost is available
Warning: : provided hosts list is empty, only localhost is available. Note that
the implicit localhost does not match 'all'
Warning: : Could not match supplied host pattern, ignoring: web

PLAY [Установка nginx через роль] **********************************************
skipping: no hosts matched

PLAY RECAP *********************************************************************

name: Deploy via Ansible

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Ansible
        run: sudo apt update && sudo apt install -y ansible

      - name: Run playbook
        run: ansible-playbook Ansible/ANS-15/deploy.yml

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-16 - Интеграция Ansible с Git`

 ### 🎯 Цель урока
Интеграция Ansible с Git
---

 ## 📘 Теория (кратко)

🔹 Что ты можешь делать через Ansible и Git:
Клонировать репозиторий Модуль git
Делать pull, переключаться git с параметрами (refspec, version)
Синхронизировать проекты git checkout + build + restart
Автоматизировать деплой clone + шаблоны + systemd +

🔸 Модуль git
- name: Клонировать приложение
  git:
    repo: 'https://github.com/example/project.git'
    dest: /opt/myapp
    version: main
    force: yes
  ✅ Работает через SSH или HTTPS
✅ Может делать update
✅ Поддерживает key_file, accept_hostkey, bare, и т.д.



 ## Конспект:

- - name: Deploy Git repo
    git:
      repo: git@github.com:user/repo.git
      dest: /srv/app
      version: main
      key_file: ~/.ssh/id_rsa

---

### Задание

1. `Создай playbook clone_repo.yml: •	Используй модуль git •	Клонируй репозиторий (можно любой публичный, например твой с nginx playbook’ом) •	Путь: /home/vagrant/app •	Ветка: main или master •	Проставь force: true, чтобы он перезаписывал`

```
- name: Установка nginx через роль
  hosts: web
  become: true

  tasks:
    - name: Клонировать приложение
      git:
        repo: 'https://github.com/DavyRoy/DevOps_practick.git'
        dest: /home/vagrant/app
        version: main
        force: yes

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-17 - Безопасность: работа с паролями, ansible-vault`

 ### 🎯 Цель урока
vault


---

 ## 📘 Теория (кратко)

Ansible Vault позволяет зашифровывать чувствительные данные, такие как:
	•	Пароли
	•	Токены доступа
	•	Переменные окружения
	•	Ключи API, приватные ключи

🔸 Как работает?
	•	Vault шифрует YAML-файл (или отдельную переменную)
	•	Файл остаётся YAML-совместимым, но его содержимое зашифровано
	•	Для выполнения playbook требуется пароль или ключ

⸻

🔐 Основные команды
ansible-vault create secrets.yml Создать новый зашифрованный файл
ansible-vault edit secrets.yml Отредактировать
ansible-vault view secrets.yml Просмотр (только с паролем)
ansible-vault encrypt file.yml Зашифровать существующий файл
ansible-vault decrypt file.yml Расшифровать
--ask-vault-pass Запросить пароль при запуске playbook
--vault-password-file Указать файл с паролем


 ## Конспект:

  Создание
ansible-vault create secrets.yml

  Использование
ansible-playbook playbook.yml --ask-vault-pass

  Альтернатива
ansible-playbook playbook.yml --vault-password-file ~/.vault_pass.txt

---

### Задание

1. `Создай зашифрованный файл:`

```
ansible-vault create secrets.yml
```
2. `Внутри пропиши переменную:`

```
dockerhub_password: mySuperSecret123
```
3. `Создай плейбук use_secret.yml:`

```
- name: Использование секрета
  hosts: localhost
  vars_files:
    - secrets.yml
  tasks:
    - name: Показать секрет (только в целях обучения)
      debug:
        msg: "DockerHub Password is {{ dockerhub_password }}"
```
4. `Запусти playbook с:`

```
ansible-playbook use_secret.yml --ask-vault-pass
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `ANS-18 - Логгирование, отладка и стратегия выполнения`

 ### 🎯 Цель урока
Логгирование, отладка и стратегия выполнения Ansible

---

 ## 📘 Теория (кратко)

🔹 Зачем это нужно?
	•	Отладка помогает понять, где и почему “падает” плейбук
	•	Логгирование — фиксировать, что происходило (особенно в CI/CD)
	•	Стратегии позволяют управлять порядком выполнения задач на множестве хостов

⸻

🔸 Уровни вывода (verbosity)
-v Базовая отладка (что делается)
-vvv Расширенная отладка модулей
-vvvv Полный SSH-отладочный вывод

ansible-playbook playbook.yml -vvv

🔸 debug: и pause: модули

Для встраиваемой отладки:
- name: Показать значение переменной
  debug:
    var: ansible_facts['os_family']

- name: Пауза для отладки
  pause:
    prompt: "Нажми Enter для продолжения"

🔸 Логгирование в файл (ansible.cfg)
[defaults]
log_path = logs/ansible.log
После этого каждый запуск плейбука будет записываться в файл.

⸻

🔸 Стратегии выполнения

Ansible по умолчанию использует стратегию linear:
	•	Один таск — на все хосты
	•	Затем следующий таск — на все хосты

Можно изменить:
strategy: free
	•	Позволяет хостам выполнять все задачи независимо друг от друга

 ## Ключевые команды:


---

### Задание

1. `В ansible.cfg добавь:`

```
[defaults]
log_path = logs/ansible.log
```
2. `В одном из плейбуков (например, install_nginx_role.yml) добавь: •	debug: → покажи ansible_hostname •	pause: → поставь паузу после установки •	strategy: free — опционально, если у тебя несколько хостов`

```

```
3. `Запусти playbook с -vvv`

```
- name: Установка nginx через роль
  hosts: web
  become: true
  roles:
    - role: nginx
      tags: [install, config]
  tasks:
    - name: Проверка значение переменной
      debug:
        var: ansible_hostname
    - name: Проверка значение переменной
      pause:
        prompt: "Проверить значение переменной ansible_hostname"

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `ANS-19 - Лучшая практика. Архитектура production playbook`

 ### 🎯 Цель урока
Лучшая практика. Архитектура production playbook

---

 ## 📘 Теория (кратко)

Создать масштабируемый, модульный, безопасный, поддерживаемый Ansible-проект.
Такой, который:
	•	Делится по ролям
	•	Работает с vault
	•	Использует переменные и теги
	•	Логирует и отлаживается
	•	Запускается из CI/CD
	•	Автоматизирует весь путь от кода до запущенного сервиса

⸻

🔸 Структура production-плейбука
project/
├── ansible.cfg
├── inventory.ini
├── group_vars/
│   ├── web.yml
│   └── docker.yml
├── secrets/
│   └── vault.yml
├── playbooks/
│   ├── deploy.yml
│   └── check.yml
├── roles/
│   ├── nginx/
│   └── docker/
├── templates/
│   └── nginx.conf.j2
├── logs/
│   └── ansible.log
├── .github/
│   └── workflows/
│       └── deploy.yml
└── README.md

🔹 Что включать в production playbook:
Роли nginx, docker, monitoring
Переменные group_vars, host_vars, defaults, vault
Безопасность ansible-vault для токенов и паролей
Условности when, tags, loop, handlers
CI/CD запуск из GitHub Actions, Jenkins или GitLab
Логирование log_path + -vvv + debug
Проверки check.yml — для dry-run перед деплоем (--check)


 ## Конспект :

- `ansible-playbook playbooks/deploy.yml --tags install --vault-password-file ~/.vault_pass.txt -vvv`


---

### Задание

1. `Создай структуру проекта, как выше`

```

```
2. `В playbooks/deploy.yml подключи: •	Роль nginx → установка + конфиг •	Роль docker → установка + запуск test-контейнера •	Загрузку vault.yml •	Используй tags (install, config, restart)`

```

```
3. `В ansible.cfg: •	inventory = inventory.ini •	log_path = logs/ansible.log •	remote_user = vagrant, private_key_file = ...`

```

```
4. `В group_vars/docker.yml:`

```
docker_test_image: hello-world
```
5. `В secrets/vault.yml:`

```
dockerhub_token: mySuperSecret
```
6. `В roles/nginx/tasks/main.yml и других ролях — добавь tags, handlers, debug, pause при необходимости`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `DOCKER-ANS-01 Развёртывание Docker через Ansible на удалённой машине`

 ### 🎯 Цель урока
Настроить и развернуть Docker Engine на удалённой машине (web1) через Ansible.

Ты автоматизируешь весь процесс установки Docker как DevOps-инженер.

---

### Задание

1. `Подключение •	Убедись, что инвентори файл правильно указывает:`

```
[web]
web1 ansible_host=10.37.129.4 ansible_user=vagrant ansible_ssh_private_key_file=/path/to/private_key
•	Проверь ansible -i inventory.ini -m ping all
```
2. `Плейбук: установка Docker •	Создай playbook install_docker.yml •	Внутри — шаги: •	Установка зависимостей (apt-transport-https, ca-certificates, curl, gnupg) •	Добавление GPG-ключа Docker •	Добавление репозитория Docker •	Установка docker-ce, docker-ce-cli, containerd.io •	Запуск и включение сервиса Docker`

```

```
3. `Проверка Docker •	Добавь задачу docker --version через command или shell •	Альтернатива: ping docker.sock или docker info`

```

```
4. `Inventory •	Убедись, что он в inventory.ini, не в playbook`

```

```
5. `Файл конфигурации •	Если нужно, можешь создать ansible.cfg рядом для удобства:`

```
[defaults]
inventory = inventory.ini
host_key_checking = False
```
6. `Вывдо`

```
ansible-playbook install_docker.yml

PLAY [Установка зависимостей] *******************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.10, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [web1]

TASK [Установка необходимых пакетов] ************************************************************************************
ok: [web1] => (item=apt-transport-https)
ok: [web1] => (item=ca-certificates)
ok: [web1] => (item=curl)
ok: [web1] => (item=gnupg)
ok: [web1] => (item=lsb-release)

TASK [Добавление ключа GPG Docker] **************************************************************************************
ok: [web1]

TASK [Добавление репозитория Docker] ************************************************************************************
changed: [web1]

TASK [Установка Docker и зависимостей] **********************************************************************************
changed: [web1]

TASK [Запуск и включение Docker] ****************************************************************************************
ok: [web1]

TASK [Проверка версии Docker] *******************************************************************************************
ok: [web1]

PLAY RECAP **************************************************************************************************************
web1                       : ok=7    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0



- name: Установка зависимостей
  hosts: web
  become: true
  tasks:
    - name: Установка необходимых пакетов
      apt:
        name: "{{ item }}"
        state: present
      loop:
        - apt-transport-https
        - ca-certificates
        - curl
        - gnupg
        - lsb-release

    - name: Добавление ключа GPG Docker
      apt_key:
        url: https://download.docker.com/linux/ubuntu/gpg
        state: present

    - name: Добавление репозитория Docker
      apt_repository:
        repo: deb https://download.docker.com/linux/ubuntu {{ ansible_lsb.codename }} stable
        state: present

    - name: Установка Docker и зависимостей
      apt:
        name:
          - docker-ce
          - docker-ce-cli
          - containerd.io
        state: present
        update_cache: true

    - name: Запуск и включение Docker
      service:
        name: docker
        state: started
        enabled: true

    - name: Проверка версии Docker
      command: docker --version
      register: docker_version
      changed_when: false

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `DOCKER-ANS-02 Запуск контейнера через Ansible (docker_container)`

 ### 🎯 Цель урока
Научиться использовать модуль community.docker.docker_container для управления контейнерами.

---

### Задание

1. `Установи коллекцию Ansible:`

```
ansible-galaxy collection install community.docker
```
2. `Проверь зависимости Python на удалённой машине: •	Установи python3-pip, если нужно •	Установи docker для Python:`

```
pip3 install docker
```
3. `Создай плейбук run_nginx.yml: •	Используй community.docker.docker_container •	Образ: nginx:latest •	Порты: проброс 8080:80 •	Название контейнера: nginx_ansible`

```

```
4. `Параметры контейнера: •	restart_policy: always •	state: started •	published_ports: 8080:80`

```

```
5. `Проверь запуск через Ansible •	Добавь команду curl http://localhost:8080 внутри задачи или подключись вручную`

```

```
6. `Вывод`

```
ansible-playbook run_nginx.yml

PLAY [Запуск контейнера nginx] ******************************************************************************************

TASK [Gathering Facts] **************************************************************************************************
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.10, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [web1]

TASK [Запуск контейнера nginx] ******************************************************************************************
ok: [web1]

TASK [Проверка, что контейнер запущен] **********************************************************************************
ok: [web1]

TASK [Показать результат] ***********************************************************************************************
ok: [web1] => {
    "result.content": "<!DOCTYPE html>\n<html>\n<head>\n<title>Welcome to nginx!</title>\n<style>\nhtml { color-scheme: light dark; }\nbody { width: 35em; margin: 0 auto;\nfont-family: Tahoma, Verdana, Arial, sans-serif; }\n</style>\n</head>\n<body>\n<h1>Welcome to nginx!</h1>\n<p>If you see this page, the nginx web server is successfully installed and\nworking. Further configuration is required.</p>\n\n<p>For online documentation and support please refer to\n<a href=\"http://nginx.org/\">nginx.org</a>.<br/>\nCommercial support is available at\n<a href=\"http://nginx.com/\">nginx.com</a>.</p>\n\n<p><em>Thank you for using nginx.</em></p>\n</body>\n</html>\n"
}

PLAY RECAP **************************************************************************************************************
web1                       : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


- name: Запуск контейнера nginx
  hosts: web
  become: true
  tasks:
    - name: Запуск контейнера nginx
      community.docker.docker_container:
        name: nginx
        image: nginx:latest
        state: started
        restart_policy: always
        published_ports:
          - "8082:80"

    - name: Проверка, что контейнер запущен
      uri:
        url: http://localhost:8082
        return_content: yes
      register: result
      ignore_errors: yes

    - name: Показать результат
      debug:
        var: result.content

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---



# Модуль "`Ansible`" - `DOCKER-ANS-03 Docker Compose с помощью Ansible`

 ### 🎯 Цель урока
Развернуть простой стек из двух контейнеров (nginx + backend) с использованием Docker Compose, но полностью через Ansible.

---


### Задание

1. `Создай docker-compose.yml В директории files/ проекта сделай простой Compose-файл:`

```
version: '3.8'
services:
  web:
    image: nginx
    ports:
      - "8083:80"
  backend:
    image: hashicorp/http-echo
    command: ["-text=Hello from backend!"]
    ports:
      - "5678:5678"
```
2. `Создай плейбук deploy_compose.yml: •	Цель: скопировать docker-compose.yml на сервер и запустить docker-compose up -d •	Используй следующие модули: •	copy — копируем файл •	community.docker.docker_compose — запускаем`

```

```
3. `Установи Docker Compose plugin (если нужно): На удалённой машине должен быть доступен docker compose. Можно установить пакет docker-compose-plugin.`

```
sudo apt install docker-compose-plugin
```
4. `Проверь работу •	Добавь задачу curl http://localhost:8083 — проверка nginx •	Добавь curl http://localhost:5678 — проверка backend`

```

```
5. `Вывод`

```
ansible-playbook deploy_compose.yml

PLAY [Запуск контейнера docker-compose] *********************************************************************************

TASK [Gathering Facts] **************************************************************************************************
[WARNING]: Platform linux on host web1 is using the discovered Python interpreter at /usr/bin/python3.10, but future
installation of another Python interpreter could change the meaning of that path. See https://docs.ansible.com/ansible-
core/2.18/reference_appendices/interpreter_discovery.html for more information.
ok: [web1]

TASK [Копирование файла docker-compose.yml на удаленный хост] ***********************************************************
ok: [web1]

TASK [Запуск контейнера с помощью docker-compose] ***********************************************************************
[WARNING]: Docker compose: unknown None: /home/vagrant/ubuntu/docker-compose.yml: the attribute `version` is obsolete,
it will be ignored, please remove it to avoid potential confusion
changed: [web1]

TASK [Проверка, что nginx запущен] **************************************************************************************
ok: [web1]

TASK [Проверка, что backend запущен] ************************************************************************************
ok: [web1]

TASK [Показать результат] ***********************************************************************************************
ok: [web1] => {
    "result.content": "Hello from backend!\n"
}

PLAY RECAP **************************************************************************************************************
web1                       : ok=6    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


- name: Запуск контейнера docker-compose
  hosts: web
  become: true
  tasks:

    - name: Копирование файла docker-compose.yml на удаленный хост
      ansible.builtin.copy:
        src: /Users/sergeylapshov/Documents/Devops/docker/Ansible/DOCKER-ANS-03/docker-compose.yml
        dest: /home/vagrant/ubuntu/docker-compose.yml

    - name: Запуск контейнера с помощью docker-compose
      community.docker.docker_compose_v2:
        project_src: /home/vagrant/ubuntu
        state: present
        pull: always

    - name: Проверка, что nginx запущен
      uri:
        url: http://localhost:8083
        return_content: yes
      register: result
      ignore_errors: yes

    - name: Проверка, что backend запущен
      uri:
        url: http://localhost:5678
        return_content: yes
      register: result
      ignore_errors: yes

    - name: Показать результат
      debug:
        var: result.content

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `DOCKER-ANS-04 Установка и настройка Nginx внутри контейнера`

 ### 🎯 Цель урока
	•	Запустить контейнер ubuntu
	•	Установить в него nginx
	•	Скопировать свой кастомный nginx.conf
	•	Проверить, что Nginx отвечает по нужному порту

---

### Задание

1. `Создай контейнер ubuntu_nginx •	Базовый образ: ubuntu:22.04 •	Название: ubuntu_nginx •	Порты: 8084:80 •	Укажи tty: true, command: sleep infinity — чтобы контейнер не завершался`

```

```
2. `Установи nginx внутри контейнера •	Используй community.docker.docker_exec для выполнения команд внутри: •	apt update •	apt install -y nginx •	systemctl start nginx (или просто nginx)`

```

```
3. `Скопируй конфигурацию nginx •	Создай файл files/nginx.conf со своей конфигурацией (можно взять за основу стандартный и изменить заголовок) •	Скопируй его в контейнер: /etc/nginx/nginx.conf •	Используй docker cp через community.docker.docker_cp или скопируй через docker exec с copy`

```
worker_processes 1;
events { worker_connections 1024; }

http {
  server {
    listen 80;
    location / {
      return 200 'Hello from custom nginx!';
    }
  }
}
```
4. `Перезапусти nginx •	Через docker_exec вызови nginx -s reload`

```


```
5. `Проверь ответ •	Добавь задачу uri: с http://localhost:8084 •	Проверь, что вернулся нужный текст`

```

```
6. `Вывод`

```
- name: Установка контейнера ubuntu с nginx
  hosts: web
  become: true
  tasks:
    - name: Установка контейнера ubuntu + nginx
      community.docker.docker_container:
        name: ubuntu_nginx
        image: ubuntu:22.04
        state: started
        published_ports:
          - "8081:80"
        command: sleep infinity
        tty: true

    - name: Установка nginx
      community.docker.docker_container_exec:
        container: ubuntu_nginx
        command: bash -c "apt update && apt install -y nginx && service nginx start"
        tty: true

    - name: Копирование конфигурации nginx
      copy:
        src: /Users/sergeylapshov/Documents/Devops/docker/Ansible/DOCKER-ANS-04/nginx.conf
        dest: /home/vagrant/ubuntu/nginx.conf

    - name: Копирование конфигурации nginx в контейнер
      ansible.builtin.shell: docker cp /home/vagrant/ubuntu/nginx.conf ubuntu_nginx:/etc/nginx/sites-available/default

    - name: Проверка работы nginx
      uri:
        url: http://localhost:8081
        return_content: yes
      register: nginx_response

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `DOCKER-ANS-05 Автодеплой приложения: clone git + docker build + run`

 ### 🎯 Цель урока
Автоматизировать через Ansible следующие шаги:
	1.	Клонирование приложения из Git
	2.	Сборка Docker-образа (docker build)
	3.	Запуск контейнера с пробросом порта
	4.	Проверка доступности приложения

---


### Задание

1. `Создай плейбук auto_deploy.yml`

```
- name: Клонирование репозитория
  hosts: web
  become: true
  tasks:
    - name: Клонировать приложение
      ansible.builtin.git:
        repo: "https://github.com/DavyRoy/DevOps_practick.git"
        dest: /home/vagrant/app

    - name: Сборка Docker-образа
      community.docker.docker_image:
        name: demo-backend
        source: build
        build:
          path: /home/vagrant/app/Ansible/DOCKER-ANS-05
        state: present

    - name: Запуск контейнера
      community.docker.docker_container:
        name: demo-backend
        image: demo-backend
        state: started
        restart_policy: always
        published_ports:
          - 8090:3000

    - name: Проверка состояния доступности
      uri:
        url: "http://localhost:8090"
        return_content: yes
      register: result

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `DOCKER-ANS-06 Настройка Ansible роли для Docker развертываний`

 ### 🎯 Цель урока
Создать универсальную Ansible роль для развертывания любого Docker-приложения из git-репозитория.

---

 ## 📘 Теория (кратко)

Ты создаёшь роль deploy_docker_app, которая:
	1.	Клонирует git-репозиторий
	2.	Собирает Docker-образ
	3.	Запускает контейнер с пробросом порта

Все параметры (имя образа, порт, имя контейнера, репозиторий) — через переменные.


### Задание

1. `Создай роль в структуре roles/deploy_docker_app/:`

```
roles/
└── deploy_docker_app/
    ├── defaults/
    │   └── main.yml
    ├── tasks/
    │   └── main.yml
    └── README.md
```
2. `defaults/main.yml — переменные:`

```
repo_url: "https://github.com/sergeylapshov/devops-demo-backend.git"
app_dir: "/home/vagrant/app"
image_name: "demo-backend"
container_name: "demo_backend"
container_port: "3000"
host_port: "8086"
```
3. `tasks/main.yml — логика:`

```
- name: Клонировать приложение
  ansible.builtin.git:
    repo: "{{ repo_url }}"
    dest: "{{ app_dir }}"
    force: yes

- name: Собрать Docker-образ
  community.docker.docker_image:
    name: "{{ image_name }}"
    build:
      path: "{{ app_dir }}"

- name: Запуск контейнера
  community.docker.docker_container:
    name: "{{ container_name }}"
    image: "{{ image_name }}"
    state: started
    restart_policy: always
    published_ports:
      - "{{ host_port }}:{{ container_port }}"
```
4. `Создай файл main.yml в корне:`

```
- name: Деплой приложения через роль
  hosts: web
  become: true
  roles:
    - role: deploy_docker_app
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `DOCKER-ANS-07 CI/CD пайплайн: Ansible + GitHub Actions + Docker`

 ### 🎯 Цель урока
Реализовать полный пайплайн, в котором:
	•	📥 GitHub Actions по пушу:
	1.	Клонирует репозиторий
	2.	Подключается к удалённому серверу (web1)
	3.	Запускает Ansible плейбук, который:
	•	Собирает Docker-образ
	•	Запускает контейнер

Ты выстраиваешь инфраструктурный CI/CD, где деплой управляется Ansible, а триггер — GitHub.
---

 ## 📘 Теория (кратко)

	•	Репозиторий на GitHub (например: yourname/ansible-docker-app)
	•	Удалённый сервер web1 уже доступен по SSH
	•	Есть файл inventory.ini с правильным путём к private_key

---

### Задание

1. `Создай проект на GitHub с такой структурой:`

```
ansible-cicd-app/
├── .github/
│   └── workflows/
│       └── deploy.yml
├── inventory.ini
├── deploy.yml           # Ansible плейбук
└── app/                 # Каталог с приложением и Dockerfile
```
2. `Ansible Playbook deploy.yml: Простой плейбук, вызывающий роль deploy_docker_app или обычные таски, как в DOCKER-ANS-05.`

```

```
3. `GitHub Actions workflow .github/workflows/deploy.yml:`

```
name: Deploy via Ansible

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Install Ansible
        run: sudo apt update && sudo apt install -y ansible

      - name: 📂 Добавить приватный ключ
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.ANSIBLE_SSH_KEY }}" > ~/.ssh/id_rsa
          chmod 600 ~/.ssh/id_rsa

      - name: Подключение к серверу и запуск Ansible
        env:
          ANSIBLE_HOST_KEY_CHECKING: "False"
        run: |
          ansible-playbook Ansible/DOCKER-ANS-07/deploy.yml --private-key .ssh/id_rsa
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `DOCKER-ANS-08 Мониторинг контейнеров через Ansible (установка Prometheus + exporters)`

 ### 🎯 Цель урока
Развернуть через Ansible:
	1.	Контейнер Prometheus
	2.	Контейнер Node Exporter
	3.	Настроить Prometheus так, чтобы он автоматически собирал метрики с Node Exporter
	4.	Проверить, что Prometheus UI доступен по localhost:9090

---


### Задание
s
1. `Подготовь проект:`

```
ansible-monitoring/
├── inventory.ini
├── deploy_monitoring.yml
├── files/
│   └── prometheus.yml          # конфигурация Prometheus
```
2. `prometheus.yml в files/`

```
global:
  scrape_interval: 5s

scrape_configs:
  - job_name: "node_exporter"
    static_configs:
      - targets: ["host.docker.internal:9100"]

⚠️ Важно:
Если host.docker.internal не работает внутри Linux-контейнера, используй IP хоста (например, 10.37.129.1) или задай network_mode: host
```
3. `Playbook deploy_monitoring.yml`

```
- name: Установка Prometheus и Node Exporter
  hosts: web
  become: true
  tasks:

    - name: Создать директорию для Prometheus конфигурации
      file:
        path: /home/vagrant/prometheus
        state: directory

    - name: Копировать конфиг Prometheus
      copy:
        src: files/prometheus.yml
        dest: /home/vagrant/prometheus/prometheus.yml

    - name: Запустить Node Exporter
      community.docker.docker_container:
        name: node_exporter
        image: prom/node-exporter:latest
        state: started
        restart_policy: always
        published_ports:
          - "9100:9100"

    - name: Запустить Prometheus
      community.docker.docker_container:
        name: prometheus
        image: prom/prometheus:latest
        state: started
        restart_policy: always
        published_ports:
          - "9090:9090"
        volumes:
          - /home/vagrant/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
```
4. `Проверка: •	Зайди на: http://<IP>:9090 •	Открой вкладку Targets → убедись, что node_exporter в статусе UP •	Можно запросить метрику node_cpu_seconds_total`

```

```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---

# Модуль "`Ansible`" - `DOCKER-ANS-09 Удаление/обновление контейнеров через Ansible`

 ### 🎯 Цель урока
Научиться через Ansible:
	1.	Останавливать и удалять старые контейнеры
	2.	Удалять старые образы
	3.	Обновлять образ с новым кодом
	4.	Запускать контейнер с обновлённой версией
---


### Задание

1. `Playbook redeploy.yml`

```
- name: Обновленный репозиторий
  hosts: web
  become: true
  tasks:

    - name: Остановка контейнера
      community.docker.docker_container:
        name: demo-backend
        state: absent
        force_kill: true

    - name: Удаление образа
      community.docker.docker_image:
        name: demo-backend
        state: absent
        force_absent: true

    - name: Клонировать приложение
      ansible.builtin.git:
        repo: "https://github.com/DavyRoy/DevOps_practick.git"
        dest: /home/vagrant/apps
        force: yes

    - name: Сборка Docker-образа
      community.docker.docker_image:
        name: demo-backend
        source: build
        build:
          path: /home/vagrant/app/Ansible/DOCKER-ANS-05
        state: present

    - name: Запуск контейнера
      community.docker.docker_container:
        name: demo-backend
        image: demo-backend
        state: started
        restart_policy: always
        published_ports:
          - 8093:3000

    - name: Очистить dangling-образы
      ansible.builtin.shell: docker image prune -f
```

`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---


# Модуль "`Ansible`" - `DOCKER-ANS-10 Развёртывание нескольких сервисов с переменными и ролями`

 ### 🎯 Цель урока
Создать мультисервисное развертывание через Ansible:
	•	Использовать переменные (имя образа, порты, путь)
	•	Организовать всё в Ansible роли
	•	Автоматически запускать 2+ контейнера:
Например:
	•	app (бэкенд-приложение)
	•	nginx (reverse proxy)

---


### Задание

1. [role: deploy_multi_service]
├── Устанавливает backend-приложение
├── Устанавливает nginx-контейнер
├── Все параметры — через defaults
├── Отдельные таски на каждый сервис

1. `Структура проекта:`

```
ansible-multiservice-deploy/
├── inventory.ini
├── site.yml
└── roles/
    └── deploy_multi_service/
        ├── tasks/
        │   └── main.yml
        ├── defaults/
        │   └── main.yml
        ├── files/
        │   └── nginx.conf
        └── README.md
```
2. `defaults/main.yml (переменные)`

```
backend_repo: "https://github.com/sergeylapshov/devops-demo-backend.git"
backend_dir: "/home/vagrant/app"
backend_image: "demo-backend"
backend_port: "3000"
backend_host_port: "8088"

nginx_image: "nginx:latest"
nginx_port: "80"
nginx_host_port: "8089"
```
3. `tasks/main.yml`

```
- name: Клонировать backend-приложение
  ansible.builtin.git:
    repo: "{{ backend_repo }}"
    dest: "{{ backend_dir }}"
    force: yes

- name: Собрать Docker-образ backend
  community.docker.docker_image:
    name: "{{ backend_image }}"
    build:
      path: "{{ backend_dir }}"

- name: Запустить backend-контейнер
  community.docker.docker_container:
    name: backend_app
    image: "{{ backend_image }}"
    state: started
    restart_policy: always
    published_ports:
      - "{{ backend_host_port }}:{{ backend_port }}"

- name: Скопировать конфиг Nginx
  copy:
    src: nginx.conf
    dest: /home/vagrant/nginx.conf

- name: Запустить nginx-контейнер
  community.docker.docker_container:
    name: nginx_frontend
    image: "{{ nginx_image }}"
    state: started
    restart_policy: always
    published_ports:
      - "{{ nginx_host_port }}:{{ nginx_port }}"
    volumes:
      - /home/vagrant/nginx.conf:/etc/nginx/conf.d/default.conf
```
4. `site.yml`

```
- name: Развёртывание бэкенда и nginx через роль
  hosts: web
  become: true
  roles:
    - role: deploy_multi_service
```
5. `Проверка:`

```
	•	curl http://localhost:8089 — должен проксировать на backend_app
	•	Посмотри nginx.conf, чтобы прокси работал (proxy_pass http://host.docker.internal:8088 или по IP)
```


`При необходимости прикрепитe сюда скриншоты
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
![Название скриншота 1](ссылка на скриншот 1)`
---
