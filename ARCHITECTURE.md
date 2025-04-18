
# 📘 CryptoDash — Финальная архитектура и ключевые решения

---

## ✅ Основная концепция

- **Одностраничный веб-сайт (SPA)**, пока без полноценного фронтенда.
- Интерфейс будет реализован позднее — тестирование через Postman/Swagger.
- Пользователь может **подписаться на отслеживание криптовалют**.
- Платформа показывает **живую и историческую аналитику** через встроенную **Grafana**, работающую с **ClickHouse**.
- Архитектура микросервисная и разворачивается **полностью в Docker**.

---

## 🧩 Основные модули

1. **Django**
   - Аутентификация и регистрация пользователей (на своей базе, без OAuth)
   - API для управления пользователем, криптоподписками
   - Отдача одностраничного интерфейса (или iframe с Grafana)

2. **FastAPI**
   - REST API шлюз
   - Обработка данных с воркеров
   - Предоставление публичного API (например, `/prices`, `/history`)

3. **PostgreSQL**
   - Хранение данных пользователей (Django Auth в связке с PostgreSQL)
   - Хранение логики: пароли, настройки профиля, API-токены и т.п.
   - Обеспечение связности данных: подписки на валюты, настройки уведомлений и т.п.

4. **ClickHouse**
   - Быстрая аналитическая БД
   - Хранение исторических данных и агрегаций

5. **Redis**
   - Кэширование цен
   - Pub/Sub для передачи обновлений в реальном времени

6. **RabbitMQ**
   - Очереди задач на сбор данных и аналитическую обработку

7. **Celery Worker**
   - Парсеры API (CoinGecko и др.)
   - Ведение фоновых задач, обработка данных

8. **Grafana**
   - Подключается к ClickHouse
   - Строит дашборды для отображения графиков криптовалют

---

## 📊 Основной функционал

- Регистрация и вход по email/паролю (через Django)
- Подписка на интересующие криптовалюты
- Отображение:
  - Текущих цен
  - Истории изменений
  - Глобальной аналитики
- Публичный REST API (для тестирования через Postman)
- Живые графики через Grafana (доступ по iframe или ссылке)
- В будущем — реализация полноценного фронтенда

---

## 🔒 Решения по ключевым вопросам

| Вопрос              | Решение                                                             |
|---------------------|---------------------------------------------------------------------|
| **Фронтенд**        | Пока нет. Тестирование API через Postman. Планируется SPA в будущем |
| **Авторизация**     | На своих мощностях, через Django (email + password) и PostgreSQL    |
| **Графики**         | Через Grafana, подключённую к ClickHouse, встроенную в интерфейс    |
| **Источник данных** | CoinGecko API                                                       |
| **Запуск**          | Локально, в Docker, через docker-compose                            |

