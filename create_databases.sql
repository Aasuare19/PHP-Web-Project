/***********************************************************
* Create the database named murach, its tables, and a user
************************************************************/

DROP DATABASE IF EXISTS murach;

CREATE DATABASE murach;

USE murach;

CREATE TABLE User (
  UserID INT NOT NULL AUTO_INCREMENT,
  Email VARCHAR(50),
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  
  PRIMARY KEY(UserID) 
);

INSERT INTO User 
  (Email, FirstName, LastName)
VALUES 
  ('jsmith@gmail.com', 'John', 'Smith'),
  ('andi@murach.com', 'Andrea', 'Steelman'), 
  ('joelmurach@yahoo.com', 'Joel', 'Murach');

CREATE TABLE Download (
  DownloadID INT NOT NULL AUTO_INCREMENT,
  UserID INT NOT NULL,
  DownloadDate DATETIME NOT NULL,
  DownloadFilename VARCHAR(30) NOT NULL,
  ProductCode VARCHAR(10) NOT NULL,

  PRIMARY KEY (DownloadID), 
  FOREIGN KEY (UserID) REFERENCES User (UserID)
);

INSERT INTO Download 
  (UserID, DownloadDate, DownloadFilename, ProductCode)
VALUES 
  (1, '2014-02-01', 'jr01_so_long.mp3', 'jr01'), 
  (1, NOW(), 'jr01_filter.mp3', 'jr01'),
  (2, NOW(), 'jr01_filter.mp3', 'jr01'),
  (3, NOW(), 'jr01_so_long.mp3', 'jr01');
  
  
CREATE TABLE UserPass (
  Username varchar(15) NOT NULL PRIMARY KEY,
  Password varchar(15) NOT NULL
);
  
INSERT INTO UserPass VALUES ('andrea', 'sesame'),
                            ('joel', 'sesame'),
                            ('anne', 'sesame');
                          
CREATE TABLE UserRole (   
  Username VARCHAR(15) NOT NULL,
  Rolename VARCHAR(15) NOT NULL,

  PRIMARY KEY (Username, Rolename)
);
  
INSERT INTO UserRole VALUES ('andrea', 'service'),
                            ('andrea', 'programmer'),
                            ('joel', 'programmer');


-- Create murach_user and grant privileges

DELIMITER //
CREATE PROCEDURE drop_user_if_exists()
BEGIN
    DECLARE userCount BIGINT DEFAULT 0 ;

    SELECT COUNT(*) INTO userCount FROM mysql.user
    WHERE User = 'murach_user' and  Host = 'localhost';

    IF userCount > 0 THEN
        DROP USER murach_user@localhost;
    END IF;
END ; //
DELIMITER ;

CALL drop_user_if_exists() ;

CREATE USER murach_user@localhost IDENTIFIED BY 'sesame';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP
ON murach.*
TO murach_user@localhost;

/************************************************************
* Create the database named music, its tables, and a user
************************************************************/
  
DROP DATABASE IF EXISTS music;
  
CREATE DATABASE music;
  
USE music;
  
CREATE TABLE User (
    UserID INT NOT NULL AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    CompanyName VARCHAR(50),
    Address1 VARCHAR(50),
    Address2 VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip VARCHAR(50),
    Country VARCHAR(50),
    CreditCardType VARCHAR(50),
    CreditCardNumber VARCHAR(50),
    CreditCardExpirationDate VARCHAR(50),
  
    PRIMARY KEY (UserID)
);
  
CREATE TABLE Invoice(
    InvoiceID INT NOT NULL AUTO_INCREMENT,
    UserID INT NOT NULL,
    InvoiceDate DATETIME NOT NULL DEFAULT '1900-01-01 00:00:00',
    TotalAmount FLOAT NOT NULL DEFAULT '0',
    IsProcessed enum('y','n') DEFAULT NULL,
  
    PRIMARY KEY (InvoiceID),
    FOREIGN KEY (UserID) REFERENCES User (UserID)
);
  
CREATE TABLE LineItem(
    LineItemID INT NOT NULL AUTO_INCREMENT,
    InvoiceID INT NOT NULL DEFAULT '0',
    ProductID INT NOT NULL DEFAULT '0',
    Quantity INT NOT NULL DEFAULT '0',
  
    PRIMARY KEY (LineItemID),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice (InvoiceID)
);
  
  
CREATE TABLE Download (
    DownloadID INT NOT NULL AUTO_INCREMENT,
    UserID INT NOT NULL,
    DownloadDate DATETIME NOT NULL,
    ProductCode VARCHAR(10)  NOT NULL,
  
    PRIMARY KEY (DownloadID), 
    FOREIGN KEY (UserID) REFERENCES User (UserID)
);
  
-- Create music_user and grant privileges

DELIMITER //
CREATE PROCEDURE drop_user_if_exists()
BEGIN
    DECLARE userCount BIGINT DEFAULT 0 ;

    SELECT COUNT(*) INTO userCount FROM mysql.user
    WHERE User = 'music_user' and  Host = 'localhost';

    IF userCount > 0 THEN
        DROP USER music_user@localhost;
    END IF;
END ; //
DELIMITER ;

CALL drop_user_if_exists() ;

CREATE USER music_user@localhost IDENTIFIED BY 'sesame';

GRANT SELECT, INSERT, UPDATE, DELETE
ON music.*
TO music_user@localhost;

/***********************************************************
* Create the database named murach_jpa
************************************************************/

DROP DATABASE IF EXISTS murach_jpa;

CREATE DATABASE murach_jpa;

/***********************************************************
* Create the database named music_jpa
************************************************************/

DROP DATABASE IF EXISTS music_jpa;

CREATE DATABASE music_jpa;

USE music_jpa;

-- The follow tables were generated by the JPA version of the Music Store website 
-- and exported from MySQL into this script

CREATE TABLE user (
  USERID bigint(20) NOT NULL,
  ADDRESS1 varchar(255) DEFAULT NULL,
  ADDRESS2 varchar(255) DEFAULT NULL,
  CITY varchar(255) DEFAULT NULL,
  COMPANYNAME varchar(255) DEFAULT NULL,
  COUNTRY varchar(255) DEFAULT NULL,
  CREDITCARDEXPIRATIONDATE varchar(255) DEFAULT NULL,
  CREDITCARDNUMBER varchar(255) DEFAULT NULL,
  CREDITCARDTYPE varchar(255) DEFAULT NULL,
  EMAIL varchar(255) DEFAULT NULL,
  FIRSTNAME varchar(255) DEFAULT NULL,
  LASTNAME varchar(255) DEFAULT NULL,
  ST varchar(255) DEFAULT NULL,
  ZIP varchar(255) DEFAULT NULL,
  PRIMARY KEY (USERID)
);

CREATE TABLE product (
  PRODUCTID bigint(20) NOT NULL,
  CODE varchar(255) DEFAULT NULL,
  DESCRIPTION varchar(255) DEFAULT NULL,
  PRICE double DEFAULT NULL,
  PRIMARY KEY (PRODUCTID)
);

CREATE TABLE download (
  DOWNLOADID bigint(20) NOT NULL,
  DOWNLOADDATE date DEFAULT NULL,
  PRODUCTCODE varchar(255) DEFAULT NULL,
  USER_USERID bigint(20) DEFAULT NULL,
  PRIMARY KEY (DOWNLOADID),
  KEY FK_DOWNLOAD_USER_USERID (USER_USERID),
  CONSTRAINT FK_DOWNLOAD_USER_USERID FOREIGN KEY (USER_USERID) REFERENCES user (USERID)
);

CREATE TABLE invoice (
  INVOICENUMBER bigint(20) NOT NULL,
  INVOICEDATE date DEFAULT NULL,
  ISPROCESSED tinyint(1) DEFAULT '0',
  USER_USERID bigint(20) DEFAULT NULL,
  PRIMARY KEY (INVOICENUMBER),
  KEY FK_INVOICE_USER_USERID (USER_USERID),
  CONSTRAINT FK_INVOICE_USER_USERID FOREIGN KEY (USER_USERID) REFERENCES user (USERID)
);

CREATE TABLE lineitem (
  LINEITEMID bigint(20) NOT NULL,
  QUANTITY int(11) DEFAULT NULL,
  PRODUCT_PRODUCTID bigint(20) DEFAULT NULL,
  PRIMARY KEY (LINEITEMID),
  KEY FK_LINEITEM_PRODUCT_PRODUCTID (PRODUCT_PRODUCTID),
  CONSTRAINT FK_LINEITEM_PRODUCT_PRODUCTID FOREIGN KEY (PRODUCT_PRODUCTID) REFERENCES product (PRODUCTID)
);

CREATE TABLE invoice_lineitem (
  Invoice_INVOICENUMBER bigint(20) NOT NULL,
  lineItems_LINEITEMID bigint(20) NOT NULL,
  PRIMARY KEY (Invoice_INVOICENUMBER,lineItems_LINEITEMID),
  KEY FK_INVOICE_LINEITEM_lineItems_LINEITEMID (lineItems_LINEITEMID),
  CONSTRAINT FK_INVOICE_LINEITEM_Invoice_INVOICENUMBER FOREIGN KEY (Invoice_INVOICENUMBER) REFERENCES invoice (INVOICENUMBER),
  CONSTRAINT FK_INVOICE_LINEITEM_lineItems_LINEITEMID FOREIGN KEY (lineItems_LINEITEMID) REFERENCES lineitem (LINEITEMID)
);

CREATE TABLE sequence (
  SEQ_NAME varchar(50) NOT NULL,
  SEQ_COUNT decimal(38,0) DEFAULT NULL,
  PRIMARY KEY (SEQ_NAME)
);

INSERT INTO sequence VALUES ('SEQ_GEN',1);

-- The following data was originally inserted by the music.data.PopulateDatabase class that's included with the JPA version of the website

INSERT INTO product VALUES 
(1,'8601','86 (the band) - True Life Songs and Pictures',14.95),
(2,'pf01','Paddlefoot - The first CD',12.95),
(3,'pf02','Paddlefoot - The second CD',14.95),
(4,'jr01','Joe Rut - Genuine Wood Grained Finish',14.95);

USE music;


CREATE TABLE Product(
    ProductID INT NOT NULL AUTO_INCREMENT,
    ProductCode VARCHAR(10) NOT NULL DEFAULT '',
    ProductDescription VARCHAR(100) NOT NULL DEFAULT '',
    ProductPrice DECIMAL(7,2) NOT NULL DEFAULT '0.00',
  
    PRIMARY KEY (ProductID)
);

INSERT INTO Product VALUES 
(1, 'DGTWNM80', 'Dogtown Skateboards Scott Oster M80 Transparent Blue Cruiser', 119.99),
(2, 'GBSTEVO', 'Globe Bantam ST Evo Hawaiian Mint Cup Cruiser ', 99.99),
(3, 'GBG1WC', 'Globe G1 Alight Off White Cruiser', 84.99),
(4, 'DGTWNOG', 'Dogtown Skateboards OG Rider Bull Dog White / Red', 119.99),
(5, 'GLBPINW', 'Globe Pinner Classic White / Mustard Longboard', 149.95),
(6, 'ENJPANP', 'Enjoi Skateboards Faded Panda Pink', 79.99),
(7, 'ELMNTBM', 'Element Skateboards Bam Margera Heartagram Black', 64.99),
(8, 'ALMSTFF', 'Almost Skateboards Fat Font', 79.99),
(9, 'DRKSTRCS', 'Darkstar Skateboards Cosmic Silver', 69.95),
(10, 'DRKSTRSS', 'Darkstar Skateboards Sure Shot Matte Ice Blue Micro', 64.99),
(11, 'DGKTRIP', 'DGK Skateboards Trippy', 89.99),
(12, 'ELMNTSYL', 'Element Skateboards Sylvan', 89.99),
(13, 'AWSVIDL', 'Alien Workshop Videolog White / Rainbow', 89.95),
(14, 'PNYCOLBC', 'Penny Skateboards Cobalt Classic 22\" Cruiser', 79.99),
(15, 'PNYRDCM', 'Penny Skateboards Red Comet 27\" Cruiser', 89.99),
(16, 'PWPTASKS', 'Powell Peralta Skull & Sword Mini', 79.99),
(17, 'SCT9H95', 'Sector 9 Howl Ninety Five Cruiser', 139.96),
(18, 'ROSSTMPS', 'Rossignol Templar Snowboard', 399.95),
(19, 'BATBLWS', 'Bataleon Blow Snowboard', 379.95),
(20, 'NVRSMRART', 'Never Summer Artist Edition Snowtrooper X Snowboard', 519.99),
(21, 'RSSSLGWL', 'Rossignol XV Sashimi LG White Label Snowboard', 599.95),
(22, 'LBTCBC2', 'Lib Tech Cold Brew C2 Snowboard', 459.95),
(23, 'GNUAIRC3', 'GNU x Airblaster SPAM C3 Snowboard', 539.96),
(24, 'BRTNFTRR', 'Burton Family Tree Speed Date Retro Snowboard', 649.95),
(25, 'RMEWINTS', 'Rome Winterland Snowboard', 539.99),
(26, 'NTRWDCS', 'Nitro Woodcarver Snowboard', 509.96),
(27, 'CTCHSRFL', 'Catch Surf Log 6\'0\" Surfboard', 324.95),
(28, 'LBTLSTRD', 'Lib Tech x Lost Round Nose Fish Redux Surfboard', 739.99),
(29, 'SFTCHHND', 'Softech Handshaped SB 6\'6\'\' Surfboard', 279.95),
(30, 'CTCHSRFRNF', 'Catch Surf Odysea x Lost RNF 5\'5\" Surfboard', 324.99),
(31, 'MDRNBBSB', 'Modern Blackbird PU 7\'6\" Longboard', 449.95),
(32, 'SFTCHDSS', 'Softech DSS TC Comp 6\'6\'\' Surfboard', 344.95),
(33, 'CRARHPU', 'Creative Army Huevo PU 6\'10\" Funboard', 694.99),
(34, 'CTSRFB48', 'Catch Surf Beater Original 48\" Twin Fin Board', 179.95),
(35, 'ALMNDLJ', 'Almond Surfboards 9\'6\" Lumberjack Surfboard', 1339.95),
(36, 'CHNLIEK', 'CHANNEL ISLANDS EVEN KEEL SURFBOARD', 895.99),
(37, 'BLCKRMB', 'BLACK ROSE MFG. BENEDICT SURFBOARD', 1045.94),
(38, 'WLDNMMS', 'WALDEN MAGIC MODEL SURFBOARD X2\'', 820.99),
(39, 'CTHSFOS', 'CATCH SURF ODYSEA SPECIAL 5\'4\' THRUSTER SOFT SURFBOARD', 284.99),
(40, 'LRPERSB', 'LOST RAD RIPPER SURFBOARD', 770.99),
(41, 'TRQPGSB', 'TORQ PG-R SURFBOARD - TEC', 510.99),
(42, 'KCHLMMS', 'KECHELE MINI MALIBU SURFBOARD', 639.95),
(43, 'SHRPSSP', 'SHARP EYE SOLE SOFTOP PC SURFBOARD', 499.95),
(44, 'GNUFBHSAS', 'GNU FB Head Space Asym C3 Snowboard 2020', 459.99),
(45, 'GNUMC3S', 'GNU Mullair C3 Snowboard 2020', 599.99),
(46, 'JONEHSW', 'Jones Hovercraft Snowboard - Womens', 499.97),
(47, 'LTJLPDC2', 'Lib Tech JL Phoenix Dagmar C2 Snowboard - Blem 2019', 439.96),
(48, 'EPAEARSB', 'Endeavor Patrol Early Release Splitboard 2019', 490.00),
(49, 'LTJLXLMC3', 'Lib Tech Jamie Lynn x Lost Mayhem C3 Snowboard - Blem 2019', 439.96),
(50, 'RSBSBBW', 'Roxy Sugar Banana Snowboard - Blem - Women', 349.95),
(51, 'ROSALSB', 'Rossignol Alias Snowboard - Kids', 187.46),
(52, 'ROSSWBSB', 'Rossignol Sawblade Snowboard 2019', 244.96);




