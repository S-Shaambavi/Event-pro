-- drop database event_management;
CREATE DATABASE IF NOT EXISTS event_management;
USE event_management;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    user_fname VARCHAR(50) NOT NULL,
    user_lname VARCHAR(50) NOT NULL,
    user_dob DATE NOT NULL,
    user_email VARCHAR(100) NOT NULL UNIQUE,
    user_phone VARCHAR(15),
    user_address VARCHAR(255),
    user_gender ENUM('Male', 'Female', 'Other') DEFAULT 'Male',
    password VARCHAR(255) NOT NULL,
    user_role ENUM('Customer', 'Organizer', 'Admin') DEFAULT 'Customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_profile VARCHAR(255) DEFAULT 'assets/default-avatar.webp'
);

INSERT INTO users (user_fname, user_lname, user_dob, user_email, user_phone, user_address, user_gender, password, user_role)
VALUES
('Kajaprathap', 'Sivakumar', '1990-01-01', 'Customer001@gmail.com', '0771234567', 'Nallur, Jaffna', 'Male', 'pass123', 'Customer'),
('Keerthanan', 'Raj', '1991-02-02', 'Customer002@gmail.com', '0772345678', 'Chundikuli, Jaffna', 'Female', 'pass123', 'Customer'),
('Jeyanash', 'Perera', '1992-03-03', 'Customer003@gmail.com', '0773456789', 'Kokuvil, Jaffna', 'Male', 'pass123', 'Customer'),
('Pakeerathan', 'Silva', '1993-04-04', 'Customer004@gmail.com', '0774567890', 'Thirunelveli, Jaffna', 'Female', 'pass123', 'Customer'),
('Ahsan', 'Fernando', '1994-05-05', 'Customer005@gmail.com', '0775678901', 'Ariyalai, Jaffna', 'Male', 'pass123', 'Customer'),
('Nivethika', 'Kumar', '1985-06-06', 'Organizer001@gmail.com', '0771234567', 'Nallur, Jaffna', 'Male', 'pass123', 'Organizer'),
('Shaambavi', 'Nadarajah', '1986-07-07', 'Organizer002@gmail.com', '0772345678', 'Chundikuli, Jaffna', 'Female', 'pass123', 'Organizer'),
('Vytheki', 'Sundaram', '1987-08-08', 'Organizer003@gmail.com', '0773456789', 'Kokuvil, Jaffna', 'Male', 'pass123', 'Organizer'),
('Royce', 'De Silva', '1980-09-09', 'Admin001@gmail.com', '0775678901', 'Ariyalai, Jaffna', 'Male', 'pass123', 'Admin'),
('Sivamsan', 'Jayasinghe', '1981-10-10', 'Admin002@gmail.com', '0774567890', 'Thirunelveli, Jaffna', 'Female', 'pass123', 'Admin');

CREATE TABLE event_venue (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(50) NOT NULL,
    venue_status ENUM('Booked', 'Available') NOT NULL DEFAULT 'Available',
    venue_capacity INT NOT NULL CHECK (venue_capacity > 50),
    venue_cost DECIMAL(10,2) NOT NULL CHECK (venue_cost >= 1000),
    venue_image VARCHAR(255)
);

INSERT INTO event_venue (venue_name, venue_status, venue_capacity, venue_cost, venue_image)
VALUES
('Nallur Hall', 'Available', 200, 50000.00, 'https://hallsforhire.com/images/featured/the-exclusive-beats-boutique.jpg?w=1000&h=800'),
('Jaffna Beach Resort', 'Available', 300, 75000.00, 'https://www.tagvenue.com/images/location-pages/1920x1080/4150.jpg'),
('Green Garden Hall', 'Available', 150, 40000.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH5yzjOcAAWABMi5hS841Qrmsx9v9uubwtwg&s'),
('Stanley Auditorium', 'Available', 500, 120000.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtOCMxtbsEaySE8HemtTZRDYej5Bqc17EZKw&s'),
('Cultural Centre Jaffna', 'Available', 100, 30000.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0iSCC-V7RTDN3B8UZrgRq2GGinKBBdhy_HQ&s');

CREATE TABLE event_service (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    service_description TEXT NOT NULL,
    service_price DECIMAL(10,2) NOT NULL CHECK (service_price >= 0.0),
    service_image VARCHAR(255)
);

INSERT INTO event_service (service_name, service_description, service_price, service_image)
VALUES
('Catering', 'Buffet menu with local and western dishes', 20000.00, 'https://www.warnacaterers.lk/wp-content/themes/turban/img/service-wedding.jpg'),
('Photography', 'Professional photography with album', 15000.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSinomHXdbagsRGooqI-JsyM_NZgQhlXFwnGw&s'),
('Decoration', 'Stage and hall decoration with flowers and lights', 10000.00, 'https://takerentpe.com/media/images/products/2024/03/PUNDECEND1584_1.webp'),
('Music Band', 'Live music band performance', 18000.00, 'https://www.brides.com/thmb/dSeHXyZQRzE-TYvw4XLcT_vzG7A=/1500x0/filters:no_upscale():max_bytes(200000):strip_icc()/RECIRC11-3fbff25df83a4860ab799eef1085a1da.jpg'),
('Lighting', 'Advanced lighting for stage and hall', 8000.00, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRZJ4v75wFMcFNASbEIKM8Jzp79pNXyV-jLw&s'),
('DJ Parties', 'Providing DJ facilities', 20000.00, 'https://www.ampmlimo.ca/hs-fs/hubfs/Imported_Blog_Media/wedding-DJ-Service.jpg?width=809&height=452&name=wedding-DJ-Service.jpg');

CREATE TABLE event_package (
    package_id INT AUTO_INCREMENT PRIMARY KEY,
    package_name VARCHAR(100) NOT NULL,
    attendee_count INT NOT NULL,
    venue_id INT,
    created_by INT,
    package_cost DECIMAL(10,2),
    FOREIGN KEY (venue_id) REFERENCES event_venue(venue_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO event_package (package_name, attendee_count, venue_id, created_by, package_cost)
VALUES
('Wedding Classic', 200, 1,6, 400000.00),
('Beach Party', 250, 2,7, 500000.00),
('Cultural Day', 150, 5,8, 300000.00),
('Corporate Gala', 300,4, 4, 600000.00),
('Birthday Bash', 100, 3,8, 200000.00);

CREATE TABLE booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    package_id INT,
    event_date DATE,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES users(user_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (package_id) REFERENCES event_package(package_id) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO booking (customer_id, package_id, event_date)
VALUES
(1, 1, '2025.5.1'),
(2, 2, '2025.5.1'),
(3, 3, '2025.5.1'),
(1, 5, '2025.5.1'),
(2, 4, '2025.5.1');

CREATE TABLE teams (
    team_id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(50) NOT NULL,
    no_of_workers INT NOT NULL,
    booking_id INT,
    assigned_by INT,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (assigned_by) REFERENCES users(user_id) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO teams (team_name, no_of_workers, booking_id, assigned_by)
VALUES
('Elite Crew', 10, 1, 6),
('Event Squad', 8, 2, 6),
('Gala Force', 6, 3, 6),
('Party Pros', 12, 4, 6),
('LightsUp Team', 7, 5, 6);

CREATE TABLE package_services (
    package_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (service_id, package_id),
    FOREIGN KEY (package_id) REFERENCES event_package(package_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (service_id) REFERENCES event_service(service_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO package_services (package_id, service_id)
VALUES
(1, 1), (1, 2), (1, 3),
(2, 2), (2, 4), (2, 5),
(3, 3), (3, 5),
(4, 1), (4, 4), (4, 6),
(5, 2), (5, 3), (5, 6);

CREATE TABLE complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    user_id INT NOT NULL,
    complaint_text TEXT NOT NULL,
    status ENUM('Pending', 'Resolved') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO complaints (booking_id, user_id, complaint_text)
VALUES
(1, 1, 'The decoration was not up to the mark.'),
(2, 2, 'Late arrival of the catering team.'),
(3, 3, 'Photography team missed key moments.'),
(4, 4, 'Venue was not cleaned properly.'),
(5, 5, 'Music band started late.');

CREATE TABLE complaint_replies (
    reply_id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL,
    replier_id INT NOT NULL,
    reply_text TEXT NOT NULL,
    replied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (replier_id) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO complaint_replies (complaint_id, replier_id, reply_text)
VALUES
(1, 9, 'We apologize. We will improve our decoration service.'),
(2, 10, 'Sorry for the delay. It won’t happen again.'),
(3, 9, 'We have taken disciplinary action against the photographer.'),
(4, 10, 'We’ve instructed the cleaning team to improve.'),
(5, 9, 'The delay was due to traffic. We’ll manage time better.');

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT NOT NULL,
    managed_by INT NOT NULL DEFAULT 7,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Pending', 'Complete') DEFAULT 'Pending',
    card_number varchar(16) NOT NULL,
    expiry_date varchar(6) NOT NULL,
    card_cvv varchar(5) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (managed_by) REFERENCES users(user_id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO payment (booking_id, managed_by, payment_amount, payment_status, card_number, expiry_date, card_cvv)
VALUES 
(1, 6, 55000.00, 'Complete', '9876543210987654', '11/27', '123'),
(2, 7, 80000.00, 'Pending', '5555444433332222', '08/26', '456'),
(3, 8, 80000.00, 'Complete', '9876543210987654', '05/26', '789'),
(4, 9, 80000.00, 'Pending', '5555444433332222', '08/27', '147'),
(5, 7, 80000.00, 'Complete', '9876543210987654', '10/30', '258');

CREATE OR REPLACE VIEW booking_details AS
SELECT 
    b.booking_id,
    CONCAT(u.user_fname, ' ', u.user_lname) AS customer_name,
    p.package_id,
    p.package_name,
    p.attendee_count,
    v.venue_name AS package_venue,
    pa.payment_status,
    b.booking_date
FROM booking b
JOIN event_package p ON b.package_id = p.package_id
JOIN event_venue v ON p.venue_id = v.venue_id
LEFT JOIN payment pa ON b.booking_id = pa.booking_id
JOIN users u ON b.customer_id = u.user_id;

CREATE OR REPLACE VIEW complaint_reply_details AS
SELECT 
    c.complaint_id,
    cr.reply_id,
    CONCAT(complainer.user_fname, ' ', complainer.user_lname) AS complaint_user,
    CONCAT(replier.user_fname, ' ', replier.user_lname) AS replied_user,
    c.status AS complaint_status,
    c.complaint_text,
    cr.reply_text
FROM complaints c
-- join user who made the complaint
JOIN users complainer ON c.user_id = complainer.user_id
-- include replies if available
LEFT JOIN complaint_replies cr ON c.complaint_id = cr.complaint_id
-- include replier info only if there's a reply
LEFT JOIN users replier ON cr.replier_id = replier.user_id;

DELIMITER //

CREATE TRIGGER update_complaint_status_after_reply
AFTER INSERT ON complaint_replies
FOR EACH ROW
BEGIN
    UPDATE complaints
    SET status = 'Resolved'
    WHERE complaint_id = NEW.complaint_id;
END;
//

DELIMITER ;


CREATE OR REPLACE VIEW transaction_details AS
SELECT
b.booking_id,
ep.package_name,
b.booking_date,
ep.package_cost,
p.payment_status
FROM booking b
JOIN event_package ep ON b.package_id = ep.package_id
JOIN payment p ON b.booking_id = p.booking_id;

CREATE VIEW user_details AS
SELECT 
    b.booking_id,
    u.user_email,
    b.booking_date,
    b.event_date,
    ep.package_name,
    ep.attendee_count,
    v.venue_name,
    GROUP_CONCAT(DISTINCT es.service_name SEPARATOR ', ') AS services,
    p.payment_date,
    p.payment_status,
    p.payment_amount,
    cr.reply_text,
    cr.replied_at
FROM booking b
JOIN users u ON b.customer_id = u.user_id
JOIN event_package ep ON b.package_id = ep.package_id
LEFT JOIN event_venue v ON ep.venue_id = v.venue_id
LEFT JOIN package_services ps ON ps.package_id = ep.package_id
LEFT JOIN event_service es ON ps.service_id = es.service_id
LEFT JOIN payment p ON p.booking_id = b.booking_id
LEFT JOIN complaints c ON c.booking_id = b.booking_id AND c.user_id = u.user_id
LEFT JOIN complaint_replies cr ON cr.complaint_id = c.complaint_id
GROUP BY 
    b.booking_id,
    u.user_email,
    b.booking_date,
    b.event_date,
    ep.package_name,
    ep.attendee_count,
    v.venue_name,
    p.payment_date,
    p.payment_status,
    p.payment_amount,
    cr.reply_text,
    cr.replied_at;
    
CREATE VIEW payment_details AS
SELECT
p.payment_id,
CONCAT(u.user_fname, ' ', u.user_lname) AS customer_name,
ep.package_name,
p.payment_amount,
p.payment_status,
b.booking_date,
p.payment_date
FROM payment p
JOIN booking b ON p.booking_id = b.booking_id
JOIN users u ON b.customer_id = u.user_id
JOIN event_package ep ON b.package_id = ep.package_id;

DELIMITER //
CREATE TRIGGER after_booking_insert
AFTER INSERT ON booking
FOR EACH ROW
BEGIN
    INSERT INTO payment (
        booking_id, 
        managed_by, 
        payment_amount, 
        payment_status, 
        card_number, 
        expiry_date, 
        card_cvv
    ) VALUES (
        NEW.booking_id,
        7,                     -- default manager
        10000.00,
        'Pending',
        '0000000000000000',    -- placeholder card info
        '00/00',               -- placeholder expiry
        '000'                  -- placeholder CVV
    );
END;
//
DELIMITER ;