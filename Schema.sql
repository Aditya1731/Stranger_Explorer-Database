-- Stranger Explorer - Schema
-- MySQL 8.x

DROP DATABASE IF EXISTS stranger_explorer;
CREATE DATABASE stranger_explorer;
USE stranger_explorer;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    gender ENUM('Male','Female','Other') DEFAULT 'Other',
    age INT,
    location VARCHAR(100),
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE trips (
    trip_id INT PRIMARY KEY AUTO_INCREMENT,
    destination VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    estimated_cost DECIMAL(10,2),
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE trip_participants (
    participant_id INT PRIMARY KEY AUTO_INCREMENT,
    trip_id INT NOT NULL,
    user_id INT NOT NULL,
    joined_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE messages (
    message_id INT PRIMARY KEY AUTO_INCREMENT,
    trip_id INT NOT NULL,
    sender_id INT NOT NULL,
    text TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    trip_id INT NOT NULL,
    reviewer_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE matches (
    match_id INT PRIMARY KEY AUTO_INCREMENT,
    user1_id INT NOT NULL,
    user2_id INT NOT NULL,
    trip_id INT NOT NULL,
    match_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Pending','Accepted','Rejected') DEFAULT 'Pending',
    CHECK (user1_id <> user2_id),
    FOREIGN KEY (user1_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (user2_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE
);
