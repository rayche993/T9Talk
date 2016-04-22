-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 22, 2016 at 07:25 PM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pris`
--

-- --------------------------------------------------------

--
-- Table structure for table `komentar`
--

CREATE TABLE IF NOT EXISTS `komentar` (
  `KOMENTARID` int(11) NOT NULL AUTO_INCREMENT,
  `KURSID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `OPIS` varchar(255) NOT NULL,
  PRIMARY KEY (`KOMENTARID`),
  KEY `FK_RELATIONSHIP_11` (`USERID`),
  KEY `FK_RELATIONSHIP_14` (`KURSID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`KOMENTARID`, `KURSID`, `USERID`, `OPIS`) VALUES
(1, 1, 1, 'koMentar NEKI'),
(2, 1, 4, 'Dodajem komentar'),
(3, 1, 4, 'Komentarcic'),
(4, 1, 4, 'hehe'),
(5, 1, 4, 'idemo radimoooo');

-- --------------------------------------------------------

--
-- Table structure for table `kurs`
--

CREATE TABLE IF NOT EXISTS `kurs` (
  `KURSID` int(11) NOT NULL AUTO_INCREMENT,
  `NAZIV` varchar(255) NOT NULL,
  `OPIS` varchar(255) NOT NULL,
  `ISHOD` varchar(255) NOT NULL,
  PRIMARY KEY (`KURSID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `kurs`
--

INSERT INTO `kurs` (`KURSID`, `NAZIV`, `OPIS`, `ISHOD`) VALUES
(1, 'Engleski jezik', 'englezi\r\nbarabe', 'i te\r\nkako');

-- --------------------------------------------------------

--
-- Table structure for table `lekcija`
--

CREATE TABLE IF NOT EXISTS `lekcija` (
  `LEKCIJAID` int(11) NOT NULL AUTO_INCREMENT,
  `KURSID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `NAZIV` varchar(255) NOT NULL,
  `TEXT` text NOT NULL,
  `TIPLEKCIJE` int(11) NOT NULL,
  PRIMARY KEY (`LEKCIJAID`),
  KEY `FK_RELATIONSHIP_19` (`USERID`),
  KEY `FK_RELATIONSHIP_5` (`KURSID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `lekcija`
--

INSERT INTO `lekcija` (`LEKCIJAID`, `KURSID`, `USERID`, `NAZIV`, `TEXT`, `TIPLEKCIJE`) VALUES
(1, 1, 2, 'Prva lekcija', '<p>hehe ovo ono</p>\r\n<p><em><strong>fancy</strong></em></p>\r\n<p style="text-align: center;">i ovo&nbsp;<img src="http://cdn.tinymce.com/4/plugins/emoticons/img/smiley-laughing.gif" alt="laughing" /></p>\r\n<p style="text-align: center;">&nbsp;</p>\r\n<p style="text-align: center;">&nbsp;</p>\r\n<p style="text-align: right;"><img src="http://cdn.tinymce.com/4/plugins/emoticons/img/smiley-cool.gif" alt="cool" /></p>\r\n<p style="text-align: center;"><iframe src="//www.youtube.com/embed/gnR6UCO09Eo" width="560" height="316" allowfullscreen="allowfullscreen"></iframe></p>\r\n<p style="text-align: left;">Maksa car</p>', 0),
(2, 1, 2, 'Druga lekcija', '<p style="text-align: center;">JESTE</p>\r\n<p style="text-align: left;"><iframe src="//www.youtube.com/embed/gnR6UCO09Eo" width="560" height="316" allowfullscreen="allowfullscreen"></iframe> hehe</p>', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ocena`
--

CREATE TABLE IF NOT EXISTS `ocena` (
  `OCENAID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` int(11) NOT NULL,
  `KURSID` int(11) NOT NULL,
  `OPIS` varchar(255) NOT NULL,
  `DATUM` date NOT NULL,
  PRIMARY KEY (`OCENAID`),
  KEY `FK_RELATIONSHIP_20` (`USERID`),
  KEY `FK_RELATIONSHIP_21` (`KURSID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `ocena`
--

INSERT INTO `ocena` (`OCENAID`, `USERID`, `KURSID`, `OPIS`, `DATUM`) VALUES
(1, 3, 1, '5', '2016-04-14'),
(3, 3, 1, '3.5', '2016-04-16'),
(12, 4, 1, '2.75', '2016-04-17'),
(13, 5, 1, '2.5', '2016-04-19'),
(14, 6, 1, '4.5', '2016-04-20'),
(15, 7, 1, '1.5', '2016-04-20');

-- --------------------------------------------------------

--
-- Table structure for table `odgovor`
--

CREATE TABLE IF NOT EXISTS `odgovor` (
  `ODGOVORID` int(11) NOT NULL AUTO_INCREMENT,
  `PITANJEID` int(11) NOT NULL,
  `TEXT` text NOT NULL,
  `TACAN` tinyint(1) NOT NULL,
  PRIMARY KEY (`ODGOVORID`),
  KEY `FK_RELATIONSHIP_2` (`PITANJEID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `pitanje`
--

CREATE TABLE IF NOT EXISTS `pitanje` (
  `PITANJEID` int(11) NOT NULL AUTO_INCREMENT,
  `TESTID` int(11) NOT NULL,
  `TEXT` text NOT NULL,
  `TIPODGOVORA` int(11) NOT NULL,
  PRIMARY KEY (`PITANJEID`),
  KEY `FK_RELATIONSHIP_3` (`TESTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `polaze`
--

CREATE TABLE IF NOT EXISTS `polaze` (
  `USERID` int(11) NOT NULL,
  `TESTID` int(11) NOT NULL,
  `BROJBODOVA` float NOT NULL,
  PRIMARY KEY (`USERID`,`TESTID`),
  KEY `FK_RELATIONSHIP_13` (`TESTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `predaje`
--

CREATE TABLE IF NOT EXISTS `predaje` (
  `USERID` int(11) NOT NULL,
  `KURSID` int(11) NOT NULL,
  PRIMARY KEY (`USERID`,`KURSID`),
  KEY `FK_RELATIONSHIP_16` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prijavljen`
--

CREATE TABLE IF NOT EXISTS `prijavljen` (
  `USERID` int(11) NOT NULL,
  `KURSID` int(11) NOT NULL,
  PRIMARY KEY (`USERID`,`KURSID`),
  KEY `FK_RELATIONSHIP_18` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `prijavljen`
--

INSERT INTO `prijavljen` (`USERID`, `KURSID`) VALUES
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `TESTID` int(11) NOT NULL AUTO_INCREMENT,
  `LEKCIJAID` int(11) NOT NULL,
  `NASLOV` varchar(255) NOT NULL,
  `OPIS` varchar(255) NOT NULL,
  PRIMARY KEY (`TESTID`),
  KEY `FK_RELATIONSHIP_4` (`LEKCIJAID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `USERID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLEID` int(11) NOT NULL,
  `IME` varchar(255) NOT NULL,
  `PREZIME` varchar(255) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  PRIMARY KEY (`USERID`),
  KEY `FK_RELATIONSHIP_1` (`ROLEID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USERID`, `ROLEID`, `IME`, `PREZIME`, `USERNAME`, `PASSWORD`) VALUES
(1, 1, 'Pris', 'Pris', 'admin', 'admin'),
(2, 2, 'Rajko', 'Radonic', 'rayche', '123'),
(3, 3, 'Marko', 'Ljubic', 'rouz', '123'),
(4, 3, 'Neki', 'Lik', 'neki_lik', '123'),
(5, 3, 'Bojan', 'Pijak', 'boki', '123'),
(6, 3, 'Maksim', 'Lalic', 'maksa', '123'),
(7, 3, 'Milan', 'Gataric', 'mico', '123');

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE IF NOT EXISTS `userrole` (
  `ROLEID` int(11) NOT NULL AUTO_INCREMENT,
  `OPIS` varchar(255) NOT NULL,
  PRIMARY KEY (`ROLEID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`ROLEID`, `OPIS`) VALUES
(1, 'Admin'),
(2, 'Predavac'),
(3, 'Polaznik');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `FK_RELATIONSHIP_11` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_14` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `lekcija`
--
ALTER TABLE `lekcija`
  ADD CONSTRAINT `FK_RELATIONSHIP_19` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_5` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `ocena`
--
ALTER TABLE `ocena`
  ADD CONSTRAINT `FK_RELATIONSHIP_20` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_21` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `odgovor`
--
ALTER TABLE `odgovor`
  ADD CONSTRAINT `FK_RELATIONSHIP_2` FOREIGN KEY (`PITANJEID`) REFERENCES `pitanje` (`PITANJEID`);

--
-- Constraints for table `pitanje`
--
ALTER TABLE `pitanje`
  ADD CONSTRAINT `FK_RELATIONSHIP_3` FOREIGN KEY (`TESTID`) REFERENCES `test` (`TESTID`);

--
-- Constraints for table `polaze`
--
ALTER TABLE `polaze`
  ADD CONSTRAINT `FK_RELATIONSHIP_12` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_13` FOREIGN KEY (`TESTID`) REFERENCES `test` (`TESTID`);

--
-- Constraints for table `predaje`
--
ALTER TABLE `predaje`
  ADD CONSTRAINT `FK_RELATIONSHIP_15` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_16` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `prijavljen`
--
ALTER TABLE `prijavljen`
  ADD CONSTRAINT `FK_RELATIONSHIP_17` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_18` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`LEKCIJAID`) REFERENCES `lekcija` (`LEKCIJAID`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_RELATIONSHIP_1` FOREIGN KEY (`ROLEID`) REFERENCES `userrole` (`ROLEID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
