DROP TABLE City
CREATE TABLE City
(
    city_No tinyint NOT NULL,
    city_Name nvarchar(15) NOT NULL PRIMARY KEY
)

DROP TABLE Seat
CREATE TABLE Seat
(
    seat_ID int PRIMARY KEY NOT NULL,
    seat_Number int
)

DROP TABLE DeparturePoint
CREATE TABLE DeparturePoint
(
    dStationLocation tinyint PRIMARY KEY NOT NULL,
    city_Name nvarchar(15) NOT NULL,
    CONSTRAINT fk_departure_Name FOREIGN KEY (city_Name) REFERENCES City(city_Name)

)

DROP TABLE ArrivalPoint
CREATE TABLE ArrivalPoint
(
    aStationLocation tinyint PRIMARY KEY NOT NULL,
    city_Name nvarchar(15) NOT NULL,
    CONSTRAINT fk_arrival_Name FOREIGN KEY (city_Name) REFERENCES City(city_Name)
)

DROP TABLE Bus
CREATE TABLE Bus
(
    plate_Number nvarchar(8) PRIMARY KEY NOT NULL,
    bus_Model nvarchar(10) NOT NULL,
    driver_ID int NOT NULL,
    helper_ID int NOT NULL,
    CONSTRAINT fk_driver_ID FOREIGN KEY (driver_ID) REFERENCES Driver(driver_ID),
    CONSTRAINT fk_helper_ID FOREIGN KEY (helper_ID) REFERENCES Helper(helper_ID)

)

DROP TABLE Driver
CREATE TABLE Driver
(
    driver_ID int PRIMARY KEY NOT NULL,
    driver_FName nvarchar(15) NOT NULL,
    driver_LName nvarchar(15) NOT NULL,
    driver_Card_No int NOT NULL,
    salary money NOT NULL,
    plate_Number nvarchar(8) NOT NULL,
    CONSTRAINT fk_plate_Number FOREIGN KEY (plate_Number) REFERENCES Bus(plate_Number)
)

DROP TABLE Helper
CREATE TABLE Helper
(
    helper_ID int PRIMARY KEY NOT NULL,
    helper_FName nvarchar(15) NOT NULL,
    helper_LName nvarchar(15) NOT NULL,
    helper_Card_No int NOT NULL,
    plate_Number nvarchar(8) NOT NULL,
    salary money NOT NULL,
    Payment_ID int,
    CONSTRAINT fk_plate_Number1 FOREIGN KEY (plate_Number) REFERENCES Bus(plate_Number)
)

DROP TABLE Cards
CREATE TABLE Cards
(
    cards_No int PRIMARY KEY NOT NULL,
    expiryDate date,
    CVV int,
    customer_ID int,
    driver_Card_No int NOT NULL,
    helper_Card_No int NOT NULL,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)

)

DROP TABLE Customer
CREATE TABLE Customer
(
    customer_ID int PRIMARY KEY NOT NULL,
    customer_Phone nvarchar(15),
    customer_Status nvarchar(8) NOT NULL,
    customer_Email nvarchar(MAX) NOT NULL,
    customer_Gender char(1),
    customer_FName nvarchar(30),
    customer_LName nvarchar(30),
    customer_CardNo int NOT NULL,
    CONSTRAINT chk_customerGender CHECK (customer_Gender IN ('M', 'W')),
    CONSTRAINT chk_customerStatus_Code CHECK (customer_Status IN ('Active','Inactive')),
    CONSTRAINT fk_customer_card_no FOREIGN KEY (customer_CardNo) REFERENCES Cards(cards_No)
)

DROP TABLE Bill
CREATE TABLE Bill
(
    bill_ID nvarchar(23) PRIMARY KEY NOT NULL,
    bill_Date datetime,
    city_Name nvarchar(15),
    dStationLocation tinyint,
    aStationLocation tinyint,
    customer_ID int NOT NULL,
    payment_ID int DEFAULT 'NONE',
    driver_FName nvarchar(15) NOT NULL,
    driver_LName nvarchar(15) NOT NULL,
    helper_FName nvarchar(15) NOT NULL,
    helper_LName nvarchar(15) NOT NULL,
    CONSTRAINT fk_customer_ID3 FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID),
    CONSTRAINT fk_dStationLocation FOREIGN KEY (dStationLocation) REFERENCES DeparturePoint(dStationLocation),
    CONSTRAINT fk_aStationLocation FOREIGN KEY (aStationLocation) REFERENCES ArrivalPoint(aStationLocation)
)

INSERT INTO Seat (seat_ID,seat_Number)
VALUES (1237,1), (1243,15), (1253,12), (1290,4), (1299,10)
INSERT INTO Seat (seat_ID)
VALUES (1212), (1213), (1245), (1264), (1288)

INSERT INTO ArrivalPoint(aStationLocation, city_Name)
VALUES (6, 'Ankara'), (7 ,'Antalya')
(16, 'Bursa'), (21, 'Diyarbakir'),
(34, 'Istanbul'), (35,'Izmir'),
(42, 'Konya'), (44,'Malatya'), (53,'Rize'), (49, 'Muş')

INSERT INTO DeparturePoint(dStationLocation, city_Name)
VALUES (6, 'Ankara'), (7,'Antalya')
(16, 'Bursa'), (21, 'Diyarbakir'),
(34, 'Istanbul'), (35,'Izmir'), (42, 'Konya'),
(44,'Malatya'), (53,'Rize')

INSERT INTO City (city_No, city_Name)
VALUES (6,'Ankara'), (7, 'Antalya'),
(16, 'Bursa'), (21, 'Diyarbakır'),
(34, 'İstanbul'), (35, 'İzmir'), (42, 'Konya'),
(44, 'Malatya'), (53, 'Rize'), (61, 'Rize'), (49, 'Muş')

INSERT INTO Bus (plate_Number, bus_Model, driver_ID, helper_ID)
VALUES ('12AS89', 'Tek Katlı', 12, 01),
('13QW89', 'Çift Katlı', 12, 02),
('14ER09', 'Tek Katlı', 13, 03),
('15OV87', 'Çift Katlı', 13, 04),
('12PS87', 'Tek Katlı', 15, 06),
('15OJ67', 'Çift Katlı', 15,07),
('18VQ45', 'Minibüs', 00, 00),
('17SKHG', 'Çift Katlı', 16, 08),
('21FP90', 'Tek Katlı', 17,09),
('21FK90', 'Tek Katlı', 13, 10), ('45TS23', NULL, 19,99)

INSERT INTO Driver(driver_ID, driver_FName, driver_LName, driver_Card_No, salary, plate_Number, Payment_ID)
VALUES (12, 'Mehmet', 'Acıkgoz', 20118967, $1000, '12AS89', 131),
(15, 'Salime', 'Derin', 20179074, $1250, '12PS87', 121),
(13, 'Osman', 'Mert', 19774589, $1100, '14ER09', 141),
(16, 'Cumali', 'Bartık', 45671998, $1000, '17SKHG', 151),
(17, 'Saruman', 'Ak', 66666666, $1250, '21FP90', 161),
(0, 'Dündar', 'Sargılı', 12397354, $750, '18VQ45', NULL)

INSERT INTO Helper(helper_ID,helper_FName, helper_LName, helper_Card_No, plate_Number, salary, Payment_ID)
VALUES (0,'Mücahit', 'Durgun', 34258765,'18VQ45', $500, 201),
(1 , 'Aliye', 'Turkan', 12896745, '12AS89', $750, 202),
(3, 'Gayri', 'Bey', 32894022, '14ER09', $750, 203),
(2, 'Behlül', 'Kurtaran', 44998866, '13QW89', $700, 204),
(4, 'Can', 'Mirket', 56980062, '15OV87', $720, 205),
(6, 'Adnan', 'Kablo', 44992266, '12PS87', $800, 206),
(7, 'Ayse', 'Celil', 33977443, '15OJ67', $800, 207),
(8, 'Elif', 'Yenilmez', 54970345, '17SKHG', $720, 208),
(9, 'Zehra', 'Yevrek', 34349898, '21FP90', $720, 209),
(10, 'Firdevs', 'Yöre', 11009876, '21FK90', $800, 210)

INSERT INTO Cards(cards_No, customer_ID, expiryDate, CVV, driver_Card_No, helper_Card_No)
VALUES (12127887, 91, '2029-01-01', 505, 12397354, 34258765),
(90908080, 92, '2028-12-12', 504, 20118967, 12896745),
(78787878, 93, '2029-01-01', 503, 19774589, 44998866),
(56566565, 94, '2024-01-01', 502, 20179074, 32894022),
(45349876, 95, '2028-12-12', 501, 45671998, 56980062),
(21215656, 96, '2022-12-12', 500, 66666666, 44992266),
(88886666, 97, '2021-12-12', 507, 20118967, 33977443),
(67674545, 98, '2023-01-01', 508, 19774589, 54970345),
(34343434, 99, '2027-12-12', 509, 20179074, 34349898),
(34560922, NULL, NULL, 103, 4546484, 44008832)


INSERT INTO Customer(customer_ID, customer_Phone, customer_Status, customer_Email, customer_Gender, customer_FName, customer_LName, customer_CardNo)
VALUES (91, 04327264422, 'Active', 'durdahne@gmail.com', 'W', 'Dürdane', 'Saymaz', 12127887),
(92, 3456769900, 'Inactive', 'dogus@gmail.com', 'M', 'Doğuş', 'Günar', 90908080),
(93, 8084568840, 'Inactive', 'where@gmail.com', 'M', 'Alihan', 'Can', 78787878),
(94, 9095653944, 'Active', 'yoruldum@gmail.com', 'W', 'Zeynep', 'Gürsoy', 56566565),
(95, 4545344353, 'Active', 'durilfhotmailcom', 'M', 'Dursun Ali', 'Özcan', 45349876),
(96, 2124567890, 'Inactive', 'stoper@hotmail.com',NULL,  NULL, NULL, 21215656),
(101, 8768784455, 'Inactive', 'antihero@gmailcom', NULL, NULL, NULL, 12345678),
(97, 4255550123, 'Active', 'heriyar@hotmail.com', NULL, NULL, 'W', 88886666),
(98, 9867896655, 'Inactive', 'ggtery@gmailcom', 'M', 'Feriha', 'Kurnaz', 67674545),
(99, 5457879454, 'Active', 'suderak@gmail.com', 'W', 'Emily', 'Kargo', 34343434)

INSERT INTO Bill(bill_ID, bill_Date, city_Name, dStationLocation, aStationLocation, customer_ID, driver_FName, driver_LName, helper_FName, helper_LName)
VALUES ('23th78TYH', '2023-12-30', 'Ankara', 06, 53, 91, 'Dündar', 'Sargili', 'Mücahit', 'Durgun'),
('45tyUY78', '2023-01-28', 'Bursa', 16, 34, 92, 'Mehmet','Acikgoz','Aliye', 'Turkan'),
('467RTG66', '2023-01-20', 'İzmir', 35, 34, 93, 'Osman', 'Mert', 'Behlül', 'Kurtaran'),
('WQ456Thf', '2023-01-18', 'Konya', 42, 7, 94, 'Salime', 'Derin', 'Gayri', 'Bey'),
('QTY678cdg', '2023-01-16', 'Diyarbakır', 21, 35, 95, 'Cumali','Bartik', 'Can', 'Mirket'),
('GDJ856txcv', '2023-01-16', 'Diyarbakır', 21, 35, 96, 'Cumali','Bartik', 'Can', 'Mirket'),
('GSrbdkf67', '2023-01-16', 'Diyarbakır', 21, 35, 97, 'Cumali','Bartik', 'Can', 'Mirket'),
('YThdlfe98', '2023-01-04', 'Rize', 53, 7, 98, 'Saruman','Ak','Adnan','Kablo'),
('FGr585df', '2023-01-04', 'Malatya', 44, 42, 99, 'Osman', 'Mert', 'Ayse', 'Celil')
