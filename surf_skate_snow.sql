-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 25, 2019 at 08:11 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `surf_skate_snow`
--
CREATE DATABASE IF NOT EXISTS `surf_skate_snow` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `surf_skate_snow`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categoryID` int(255) NOT NULL,
  `categoryName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categoryID`, `categoryName`) VALUES
(1, 'Skateboards'),
(2, 'Snowboards'),
(3, 'Surfboards');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productID` int(255) NOT NULL,
  `categoryID` int(255) NOT NULL,
  `productCode` varchar(10) NOT NULL,
  `productName` varchar(300) NOT NULL,
  `listPrice` double(255,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productID`, `categoryID`, `productCode`, `productName`, `listPrice`) VALUES
(1, 1, 'DGTWNM80', 'Dogtown Skateboards Scott Oster M80 Transparent Blue Cruiser', 119.99),
(2, 1, 'GBSTEVO', 'Globe Bantam ST Evo Hawaiian Mint Cup Cruiser ', 99.99),
(3, 1, 'GBG1WC', 'Globe G1 Alight Off White Cruiser', 84.99),
(4, 1, 'DGTWNOG', 'Dogtown Skateboards OG Rider Bull Dog White / Red', 119.99),
(5, 1, 'GLBPINW', 'Globe Pinner Classic White / Mustard Longboard', 149.95),
(6, 1, 'ENJPANP', 'Enjoi Skateboards Faded Panda Pink', 79.99),
(7, 1, 'ELMNTBM', 'Element Skateboards Bam Margera Heartagram Black', 64.99),
(8, 1, 'ALMSTFF', 'Almost Skateboards Fat Font', 79.99),
(9, 1, 'DRKSTRCS', 'Darkstar Skateboards Cosmic Silver', 69.95),
(10, 1, 'DRKSTRSS', 'Darkstar Skateboards Sure Shot Matte Ice Blue Micro', 64.99),
(11, 1, 'DGKTRIP', 'DGK Skateboards Trippy', 89.99),
(12, 1, 'ELMNTSYL', 'Element Skateboards Sylvan', 89.99),
(13, 1, 'AWSVIDL', 'Alien Workshop Videolog White / Rainbow', 89.95),
(14, 1, 'PNYCOLBC', 'Penny Skateboards Cobalt Classic 22\" Cruiser', 79.99),
(15, 1, 'PNYRDCM', 'Penny Skateboards Red Comet 27\" Cruiser', 89.99),
(16, 1, 'PWPTASKS', 'Powell Peralta Skull & Sword Mini', 79.99),
(17, 1, 'SCT9H95', 'Sector 9 Howl Ninety Five Cruiser', 139.96),
(18, 2, 'ROSSTMPS', 'Rossignol Templar Snowboard', 399.95),
(19, 2, 'BATBLWS', 'Bataleon Blow Snowboard', 379.95),
(20, 2, 'NVRSMRART', 'Never Summer Artist Edition Snowtrooper X Snowboard', 519.99),
(21, 2, 'RSSSLGWL', 'Rossignol XV Sashimi LG White Label Snowboard', 599.95),
(22, 2, 'LBTCBC2', 'Lib Tech Cold Brew C2 Snowboard', 459.95),
(23, 2, 'GNUAIRC3', 'GNU x Airblaster SPAM C3 Snowboard', 539.96),
(24, 2, 'BRTNFTRR', 'Burton Family Tree Speed Date Retro Snowboard', 649.95),
(25, 2, 'RMEWINTS', 'Rome Winterland Snowboard', 539.99),
(26, 2, 'NTRWDCS', 'Nitro Woodcarver Snowboard', 509.96),
(27, 3, 'CTCHSRFL', 'Catch Surf Log 6\'0\" Surfboard', 324.95),
(28, 3, 'LBTLSTRD', 'Lib Tech x Lost Round Nose Fish Redux Surfboard', 739.99),
(29, 3, 'SFTCHHND', 'Softech Handshaped SB 6\'6\'\' Surfboard', 279.95),
(30, 3, 'CTCHSRFRNF', 'Catch Surf Odysea x Lost RNF 5\'5\" Surfboard', 324.99),
(31, 3, 'MDRNBBSB', 'Modern Blackbird PU 7\'6\" Longboard', 449.95),
(32, 3, 'SFTCHDSS', 'Softech DSS TC Comp 6\'6\'\' Surfboard', 344.95),
(33, 3, 'CRARHPU', 'Creative Army Huevo PU 6\'10\" Funboard', 694.99),
(34, 3, 'CTSRFB48', 'Catch Surf Beater Original 48\" Twin Fin Board', 179.95),
(35, 3, 'ALMNDLJ', 'Almond Surfboards 9\'6\" Lumberjack Surfboard', 1339.95);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
