-- phpMyAdmin SQL Dump
-- version 3.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 20, 2011 at 08:59 PM
-- Server version: 5.1.53
-- PHP Version: 5.3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dbmain`
--
DROP DATABASE `dbmain`;
CREATE DATABASE `dbmain` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `dbmain`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_GetUserFriends`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_GetUserFriends`(IN userID INT)
BEGIN
       SELECT * FROM user where user_id IN(SELECT friend_ID AS one FROM friend WHERE (user_ID=userID) AND (friend_status='A')
				    UNION
				    SELECT user_ID AS one FROM friend WHERE friend_ID=userID AND (friend_status='A'))
				    ORDER BY user_username;
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `CAT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CAT_NAME` varchar(20) NOT NULL,
  `CAT_Description` varchar(200) NOT NULL,
  PRIMARY KEY (`CAT_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`CAT_ID`, `CAT_NAME`, `CAT_Description`) VALUES
(1, 'Arts', 'Need some inspiration...sad guy?'),
(2, 'Business', 'Suit up!'),
(3, 'Computers', 'Home for the nerds...'),
(4, 'Games', 'Stop searching for cheats!'),
(5, 'Health', 'Your home doctor hurt you?'),
(6, 'Home', 'From shacks to mansions'),
(7, 'Kids and Teens', 'You can not buy them, well sometimes'),
(8, 'News', 'Google not working?'),
(9, 'Recreation', 'Re-create yourself'),
(10, 'Reference', 'Referencing this is not a valid reference'),
(11, 'Science', 'See category -Get a life-'),
(12, 'Shopping', 'To scared to go out?'),
(13, 'Society', 'Sucks'),
(14, 'Sports', 'Please dont mention RWC 2011');

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMMENT_DESC` varchar(500) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `LINK_ID` int(11) NOT NULL,
  PRIMARY KEY (`COMMENT_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `comment`
--

INSERT INTO `comment` (`COMMENT_ID`, `COMMENT_DESC`, `USER_ID`, `LINK_ID`) VALUES
(6, 'WOW it works', 36, 21);

-- --------------------------------------------------------

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
CREATE TABLE IF NOT EXISTS `friend` (
  `USER_ID` int(11) NOT NULL,
  `FRIEND_ID` int(11) NOT NULL,
  `FRIEND_STATUS` varchar(1) NOT NULL,
  PRIMARY KEY (`USER_ID`,`FRIEND_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `friend`
--

INSERT INTO `friend` (`USER_ID`, `FRIEND_ID`, `FRIEND_STATUS`) VALUES
(35, 39, 'P'),
(36, 40, 'P'),
(36, 38, 'P'),
(36, 35, 'A');

-- --------------------------------------------------------

--
-- Table structure for table `link`
--

DROP TABLE IF EXISTS `link`;
CREATE TABLE IF NOT EXISTS `link` (
  `LINK_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LINK_URL` varchar(200) NOT NULL,
  `LINK_DESC` varchar(500) NOT NULL,
  `LINK_CAT_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `LINK_NAME` varchar(200) NOT NULL,
  PRIMARY KEY (`LINK_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `link`
--

INSERT INTO `link` (`LINK_ID`, `LINK_URL`, `LINK_DESC`, `LINK_CAT_ID`, `USER_ID`, `LINK_NAME`) VALUES
(22, 'http://digg.com/story/r/16_common_household_items_with_secret_uses', 'The Great Blondin began his Niagara show by crossing the Falls on a tightrope three inches in diameter. Although the cable spanned 1,100-foot and w... 5 hr ', 2, 36, 'The Blondin Test Will Ensure'),
(21, 'http://www.google.co.za/', 'You can find anything through google!', 3, 36, 'Google'),
(18, 'http://www.zeropaid.com/links/bittorrent/games/', 'Want to download games? Check these sites out.', 4, 38, 'Gaming Torrent Sites'),
(19, 'http://www.zeropaid.com/links/bittorrent/movies/', 'Download movies from these torrent sites.', 6, 38, 'Movie Torrent Sites'),
(17, 'http://www.zeropaid.com/links/tvlinks/', 'TV Links are sites that allow you to stream movies, watch tv shows and sports directly from your computer. There are tons of sites that do just that, we have sifted through the junk to give you the best Online TV sites on the web. If you donâ€™t see your favorite site listed', 6, 37, 'TV Links'),
(15, 'http://localhost/IMY_project', 'This project has truly been the most time consuming of my studies thus far', 3, 35, 'Greatest headache ever');

-- --------------------------------------------------------

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
CREATE TABLE IF NOT EXISTS `rating` (
  `RATING_ID` int(11) NOT NULL,
  `RATING_SCORE` decimal(11,2) NOT NULL,
  `RATING_TOTAL` int(11) NOT NULL,
  PRIMARY KEY (`RATING_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rating`
--

INSERT INTO `rating` (`RATING_ID`, `RATING_SCORE`, `RATING_TOTAL`) VALUES
(22, '0.00', 0),
(21, '0.00', 0),
(19, '0.00', 0),
(18, '0.00', 0),
(17, '0.00', 0),
(15, '0.00', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_USERNAME` varchar(100) NOT NULL,
  `USER_EMAIL` varchar(200) NOT NULL,
  `USER_PASSWORD` varchar(100) NOT NULL,
  `USER_FN` varchar(200) NOT NULL,
  `USER_LN` varchar(200) NOT NULL,
  `USER_GENDER` char(1) NOT NULL,
  `USER_BIRTH` date NOT NULL,
  `USER_TYPE` varchar(1) NOT NULL,
  `USER_PIC_LOCATION` varchar(300) DEFAULT NULL,
  UNIQUE KEY `USER_USERNAME` (`USER_USERNAME`,`USER_EMAIL`),
  UNIQUE KEY `USER_PIC_LOCATION` (`USER_PIC_LOCATION`),
  KEY `USER_ID` (`USER_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=46 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USER_ID`, `USER_USERNAME`, `USER_EMAIL`, `USER_PASSWORD`, `USER_FN`, `USER_LN`, `USER_GENDER`, `USER_BIRTH`, `USER_TYPE`, `USER_PIC_LOCATION`) VALUES
(39, 'Carla', 'Carla@thePlace.net', 'a', 'Carla', 'Prinsloo', 'F', '1991-06-23', 'U', NULL),
(38, 'Andrew', 'Andrew@thePlace.net', 'a', 'Andrew', 'Andrew', 'M', '1991-06-23', 'U', NULL),
(37, 'Ricus', 'ricus@thePlace.net', 'a', 'Ricus', 'Ricus', 'M', '1991-06-23', 'U', NULL),
(36, 'Franna', 'me@thePlace.net', 'a', 'Franna', 'Strijdom', 'M', '1991-06-23', 'U', NULL),
(35, 'Admin', 'admin@spiderweb.co.za', '761943', 'Hendrik', 'Prinsloo', 'M', '1991-06-23', 'A', NULL),
(40, 'Jaris', 'Jaris@thePlace.net', 'a', 'Jaris', 'Kruger', 'M', '1991-06-23', 'U', NULL),
(41, 'Piet', 'Piet@thePlace.net', 'a', 'Piet', 'Pompies', 'M', '1991-06-23', 'U', NULL),
(42, 'Koos', 'Koos@thePlace.net', 'a', 'Koos', 'De beer', 'M', '1991-06-23', 'U', NULL),
(44, 'Pierre', 'Pierre@thePlace.net', 'a', 'Pierre', 'Spies', 'M', '1991-06-23', 'U', NULL),
(45, 'andre', 'andre@thePlace.net', 'a', 'Andre', 'Pieterse', 'M', '1991-06-23', 'U', NULL);
