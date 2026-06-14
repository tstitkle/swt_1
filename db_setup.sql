-- 1. Create Database
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TicketSystemDB')
BEGIN
    ALTER DATABASE TicketSystemDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TicketSystemDB;
END
GO

CREATE DATABASE TicketSystemDB COLLATE Vietnamese_100_CI_AI;
GO

USE TicketSystemDB;
GO

-- 2. Create Tables
IF OBJECT_ID('Reviews', 'U') IS NOT NULL DROP TABLE Reviews;
IF OBJECT_ID('TicketDetails', 'U') IS NOT NULL DROP TABLE TicketDetails;
IF OBJECT_ID('Bookings', 'U') IS NOT NULL DROP TABLE Bookings;
IF OBJECT_ID('Events', 'U') IS NOT NULL DROP TABLE Events;
IF OBJECT_ID('Venues', 'U') IS NOT NULL DROP TABLE Venues;
IF OBJECT_ID('Categories', 'U') IS NOT NULL DROP TABLE Categories;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
IF OBJECT_ID('Roles', 'U') IS NOT NULL DROP TABLE Roles;

CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY(1,1),
    RoleName NVARCHAR(20) NOT NULL
);

CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100),
    Email NVARCHAR(100),
    IsActive BIT NOT NULL DEFAULT 1,
    RoleId INT FOREIGN KEY REFERENCES Roles(RoleId)
);

CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL
);

CREATE TABLE Venues (
    VenueId INT PRIMARY KEY IDENTITY(1,1),
    VenueName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200),
    Capacity INT
);

CREATE TABLE Events (
    EventId INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    EventDate DATETIME,
    VenueId INT FOREIGN KEY REFERENCES Venues(VenueId),
    CategoryId INT FOREIGN KEY REFERENCES Categories(CategoryId),
    Price DECIMAL(10, 2),
    Status NVARCHAR(20)
);

CREATE TABLE Bookings (
    BookingId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT FOREIGN KEY REFERENCES Users(UserId),
    BookingDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2),
    Status NVARCHAR(20)
);

CREATE TABLE TicketDetails (
    TicketId INT PRIMARY KEY IDENTITY(1,1),
    BookingId INT FOREIGN KEY REFERENCES Bookings(BookingId),
    EventId INT FOREIGN KEY REFERENCES Events(EventId),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

CREATE TABLE Reviews (
    ReviewId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT FOREIGN KEY REFERENCES Users(UserId),
    EventId INT FOREIGN KEY REFERENCES Events(EventId),
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE()
);

-- 3. Mock Data
-- Use N'' for all text literals to preserve Vietnamese Unicode.
INSERT INTO Roles (RoleName) VALUES (N'ADMIN'), (N'USER');
INSERT INTO Users (Username, Password, FullName, Email, RoleId) VALUES 
('admin', '123', N'Administrator', 'admin@ticket.com', 1),
('user', '123', N'John Doe', 'user@example.com', 2);

INSERT INTO Categories (CategoryName) VALUES (N'Music'), (N'Cinema'), (N'Sports'), (N'Educational');
INSERT INTO Venues (VenueName, Address, Capacity) VALUES 
(N'SVĐ Mỹ Đình', N'Hà Nội', 40000), 
(N'Lotte Cinema', N'TP.HCM', 200),
(N'Trung tâm Hội nghị', N'Đà Nẵng', 1000);

INSERT INTO Events (Title, Description, EventDate, VenueId, CategoryId, Price, Status) 
VALUES (N'Sơn Tùng M-TP Concert', N'Đêm nhạc bùng nổ của Sky', '2024-12-25 20:00:00', 1, 1, 1500000, N'UPCOMING'),
       (N'Avatar 3', N'Phim bom tấn thế kỷ', '2024-12-30 18:00:00', 2, 2, 120000, N'UPCOMING'),
       (N'Giải chạy Marathon', N'Sự kiện thể thao cộng đồng', '2025-01-10 06:00:00', 1, 3, 200000, N'UPCOMING');

GO

-- 4. Migration for existing databases:
IF COL_LENGTH('Users', 'IsActive') IS NULL
BEGIN
    ALTER TABLE Users ADD IsActive BIT NOT NULL CONSTRAINT DF_Users_IsActive DEFAULT 1;
    UPDATE Users SET IsActive = 1 WHERE IsActive IS NULL;
END
GO
