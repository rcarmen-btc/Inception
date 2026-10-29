# Inception

Стек веб-сервисов на Docker Compose: у каждого сервиса свой Dockerfile, данные базы и сайта лежат на томах хоста. Учебный проект [Школы 21](https://21-school.ru) (задание Inception).

*English: a multi-service Docker Compose stack: Nginx with TLS, WordPress + PHP-FPM, MariaDB, Redis, vsftpd, Adminer. School 21 project.*

## Что внутри

| Сервис | Основа образа | Что делает |
|---|---|---|
| `nginx` | Alpine 3.13 | единственный вход по HTTPS (порт 443): TLS 1.2 и 1.3, самоподписанный сертификат создаётся при сборке образа; PHP передаёт в WordPress по FastCGI |
| `wordpress` | Alpine 3.13, PHP 7 FPM | при старте через WP-CLI скачивает WordPress, ждёт базу, создаёт конфиг и пользователей, ставит тему Zakra и плагин Redis Object Cache |
| `mariadb` | Debian Buster | база WordPress; база и пользователь создаются при первом запуске |
| `redis-cache` | Alpine 3.15 | кэш объектов для WordPress |
| `ftp-server` | Alpine 3.15 | vsftpd, к нему подключены тома сайта и базы |
| `adminer` | Debian Buster | веб-интерфейс к базе данных (порт 8000) |
| `static_site` | Debian Buster | статическая страница на Apache (порт 80) |
| `stats` | образ [docker-container-stats](https://github.com/virtualzone/docker-container-stats) | веб-интерфейс со статистикой контейнеров (порт 8080); чужой проект, лежит в `srcs/requirements/docker-container-stats` как есть |

Все сервисы в одной сети `docker-network`, перезапускаются сами (`restart: always`). Настройки вынесены в `srcs/.env`.

## Как запустить

Нужны Docker, docker-compose, `make` и `sudo` (для записи в `/etc/hosts` и создания каталогов томов).

1. В `srcs/.env` поправьте `DOMAIN_NAME`, `MARIADB_VOLUME_PATH` и `WORDPRESS_VOLUME_PATH`: по умолчанию там каталоги автора. Путь тома `stats` в `srcs/docker-compose.yml` тоже указывает на домашний каталог автора.
2. `make prep` добавляет домен в `/etc/hosts` и создаёт каталоги томов.
3. `make buildup` собирает образы и поднимает стек.
4. Откройте `https://<DOMAIN_NAME>` (браузер предупредит о самоподписанном сертификате).

Остальное: `make logs` — логи, `make stop` — остановить, `make rmprep` — убрать запись в `/etc/hosts` и каталоги томов.

Пароли в `srcs/.env` — учебные значения для локального запуска; нигде больше их использовать не надо.

## Стек

Docker, Docker Compose, Nginx, WordPress, PHP-FPM, MariaDB, Redis, vsftpd, Apache, Adminer, Make, Bash, Alpine Linux, Debian.
