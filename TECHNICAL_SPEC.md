
# 📘 Техническое задание: CryptoDash — Платформа мониторинга криптовалют

## 📌 Цель проекта

Разработка платформы для мониторинга и аналитики криптовалют в реальном 
времени. 

## 🧱 Задачи

В данном проекте должны быть реализованы следующие задачи:
- Предоставить пользователю визуализацию данных;
- Возможность управлять подписками на курс отслеживаемых монет;
- Предоставление пользователю аналитики как по его интересам, так и по криптоактивам.

---

## 📖 Архитектура проекта

```
                                 +----------------+
                                 |                |
                                 +   Django SPA   +  <--->  PostgreSQL
                                 |                |
                                 +--------+-------+
                                          |
                            +-------------v------------+
                            |      REST API Gateway    |  <-- FastAPI
                            +-------------+------------+
                                          |
                     +--------------------+----------------------+
                     |                                           |
              +------v--------+                          +-------v------+
              |   Redis       |                          |   RabbitMQ   |
              | (cache, pub)  |                          |   (queues)   |
              +------+--------+                          +------+-------+
                     |                                          |
              +------v--------+                          +------v-------+
              | Celery Worker |        SQLAlchemy        |  EventWorker |
              |(парсинг, агр.)| <----------------------> | (FastAPI/CH) |
              +------+--------+                          +------+-------+
                     |                                          |
              +------v------------------------------------------v------+
              |                 ClickHouse (history DB)                |
              +--------------------------------------------------------+
                                          |
                                 +--------v--------+
                                 |     Grafana     |
                                 |    Dashboards   |
                                 +-----------------+
```

---

## 🔧 Используемый стек

| Компонент      | Назначение                        |
|----------------|-----------------------------------|
| Django         | SPA, базовый API, frontend        |
| FastAPI        | API шлюз и внутренняя логика      |
| PostgreSQL     | Хранилище пользовательских данных |
| ClickHouse     | Историческое хранилище            |
| Redis          | Кеш, pub/sub                      |
| RabbitMQ       | Очереди задач                     |
| Celery         | Сбор и обработка данных           |
| SQLAlchemy     | Работа с БД, включая ClickHouse   |
| Grafana        | Визуализация графиков на странице |
| Docker         | Контейнеризация                   |

---

## ⚙️ Функциональность

### 1. **Django**
- Аутентификация и регистрация пользователей (на своей базе, без OAuth)
- API для управления пользователем, криптоподписками
- Отдача одностраничного интерфейса (или iframe с Grafana)

### 2. **FastAPI**
- REST API шлюз
- Обработка данных с воркеров
- Предоставление публичного API (например, `/prices`, `/history`)

### 3. **PostgreSQL**
- Хранение данных пользователей (Django Auth в связке с PostgreSQL)
- Хранение логики: пароли, настройки профиля, API-токены и т.п.
- Обеспечение связности данных: подписки на валюты, настройки уведомлений и т.п.

### 4. **ClickHouse**
- Быстрая аналитическая БД
- Хранение исторических данных и агрегаций

### 5. **Redis**
- Кэширование цен
- Pub/Sub для передачи обновлений в реальном времени

### 6. **RabbitMQ**
- Очереди задач на сбор данных и аналитическую обработку

### 7. **Celery Worker**
- Парсеры API (CoinGecko и др.)
- Ведение фоновых задач, обработка данных

### 8. **Grafana**
- Подключается к ClickHouse
- Строит дашборды для отображения графиков криптовалют

---

## 📊 Уровни аналитики

1. **Пользовательская аналитика:**
   - Какие монеты отслеживает
   - История активности
   - Частота посещений

2. **Аналитика по валютам:**
   - Рост/падение
   - Объёмы торгов
   - Популярность среди пользователей

---

## 🗂️ Структура репозитория (monorepo)

```
crypto-dash/
├── django_app/             # Django SPA
├── fastapi_service/        # FastAPI gateway
├── worker/                 # Celery воркеры
├── clickhouse/             # Миграции и схема
├── grafana/                # Dashboards и настройки
├── docker/                 # docker-compose и Dockerfile
├── .env                    # переменные окружения
├── README.md
└── requirements.txt
```

---

## 🚀 Этапы разработки

| Этап | Описание                                |
|------|-----------------------------------------|
| 1    | Инициализация GitHub и Docker окружения |
| 2    | Построение БД хранения PostgreSQL       |
| 3    | Django с базовой SPA                    |
| 4    | FastAPI-шлюз и API                      |
| 5    | Воркеры, Redis, RabbitMQ                |
| 6    | Интеграция ClickHouse                   |
| 7    | Настройка Grafana и Dashboard           |
| 8    | Отображение дашбордов на SPA            |
| 9    | Документация, деплой, тесты             |
