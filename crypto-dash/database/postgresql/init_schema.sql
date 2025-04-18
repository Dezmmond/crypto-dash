-- Начало файла init_schema.sql

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    login VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT true -- Промежуток активности: шесть месяцев
);

-- Таблица хранения аутентификационных токенов
CREATE TABLE IF NOT EXISTS api_tokens (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    token VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expired_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS crypto_tokens (
    id SERIAL PRIMARY KEY,
    crypto_name VARCHAR(255),
    crypto_symbol VARCHAR(10), -- Сокращение (BTC | ETH)
    usd_cost DECIMAL(20, 10) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Дата регистрации токена на сервисе CryptoDash
);

CREATE TABLE IF NOT EXISTS tracked_cryptocurrencies (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    crypto_id INTEGER REFERENCES crypto_tokens(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS alerts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    crypto_id INTEGER REFERENCES crypto_tokens(id),
    threshold_price DECIMAL(20, 10), -- Пороговое значение цены токена для алерта
    direction BOOLEAN DEFAULT true, -- В какую сторону падение цены
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT true
);
