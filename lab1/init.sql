CREATE TABLE Subscriber (
    subscriber_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT
);

CREATE TABLE Phone_number (
    phone_number_id SERIAL PRIMARY KEY,
    number CHAR(12) NOT NULL UNIQUE,
    subscriber_id INT NOT NULL,
    FOREIGN KEY (subscriber_id) REFERENCES Subscriber(subscriber_id) ON DELETE CASCADE
);

CREATE TABLE Dialing_code (
    country_code CHAR(3) PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE Payphone (
    payphone_id SERIAL PRIMARY KEY,
    location VARCHAR(255) NOT NULL
);

CREATE TABLE Credit_token (
    token_id SERIAL PRIMARY KEY,
    token_type VARCHAR(50) NOT NULL
);

CREATE TABLE Call (
    call_id SERIAL PRIMARY KEY,
    to_number CHAR(12) NOT NULL,
    dialing_code CHAR(3) NOT NULL,
    payphone_id INT NULL,  -- Если звонок из автомата
    token_id INT NULL,  -- Если использован жетон
    call_duration INT NOT NULL,  -- Длительность в секундах
    FOREIGN KEY (dialing_code) REFERENCES Dialing_code(country_code),
    FOREIGN KEY (payphone_id) REFERENCES Payphone(payphone_id) ON DELETE SET NULL,
    FOREIGN KEY (token_id) REFERENCES Credit_token(token_id) ON DELETE SET NULL
);

CREATE TABLE Subscriber_credit_token (
    subscriber_id INT,
    token_id INT,
    PRIMARY KEY (subscriber_id, token_id),
    FOREIGN KEY (subscriber_id) REFERENCES Subscriber(subscriber_id) ON DELETE CASCADE,
    FOREIGN KEY (token_id) REFERENCES Credit_token(token_id) ON DELETE CASCADE
);
