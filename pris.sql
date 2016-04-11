-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2016 at 04:58 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `komentar`
--

INSERT INTO `komentar` (`KOMENTARID`, `KURSID`, `USERID`, `OPIS`) VALUES
(1, 1, 1, 'Ovo je sjajno!'),
(2, 1, 1, 'Moze to mnogo bolje'),
(3, 1, 1, 'Zezanje je pravo!'),
(4, 2, 1, 'Moze i ovde'),
(5, 1, 1, 'Da ne kazem divno!'),
(6, 2, 1, 'Kako ne'),
(7, 2, 1, 'Ovde samo i moze :D'),
(8, 1, 2, 'Aj i ja da kazem koju pametnu'),
(9, 2, 2, 'I ovde hocu.'),
(10, 1, 1, 'Ne moze'),
(11, 2, 1, 'Pali decko'),
(12, 1, 3, 'lozite se previse'),
(13, 2, 3, 'I ovde'),
(14, 2, 2, 'ajoj'),
(15, 5, 2, 'Prvi komentar!');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `kurs`
--

INSERT INTO `kurs` (`KURSID`, `NAZIV`, `OPIS`, `ISHOD`) VALUES
(1, 'Engleski jezik', 'Engleski je to\r\nda\r\nda', 'Naucicu ga\r\nbre'),
(2, 'Italijanski jezik', 'Mafija\r\nsve\r\nto', 'sve\r\nu\r\nzatvor'),
(3, 'Spanski jezik', 'spanci\r\nnadal\r\nitd', 'spanske\r\nserije'),
(4, 'Ruski jezik', 'braca\r\nrusi', 'vodka\r\njeste'),
(5, 'Nemacki jezik', 'zezanje\r\nje\r\ntaj jezik', 'sve\r\nte duge\r\nreci'),
(6, 'Kineski jezik', 'Neam pojma \r\nsta je to', 'boze\r\nmili'),
(7, 'Svedski jezik', 'kao nemacki\r\nslicno', 'nesto\r\nbas\r\nslicno'),
(8, 'Bugarski jezik', 'Noz u\r\nledja', 'nam zaboli\r\nuvek'),
(9, 'Madjarski jezik', 'par psovki\r\nznam', 'i to \r\nje to'),
(10, 'Portugalski jezik', 'pljunes\r\ni\r\nafrika tu', 'kafic\r\nbleja');

-- --------------------------------------------------------

--
-- Table structure for table `lekcija`
--

CREATE TABLE IF NOT EXISTS `lekcija` (
  `LEKCIJAID` int(11) NOT NULL AUTO_INCREMENT,
  `KURSID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  `TEXT` text NOT NULL,
  `TIPLEKCIJE` int(11) NOT NULL,
  PRIMARY KEY (`LEKCIJAID`),
  KEY `FK_RELATIONSHIP_19` (`USERID`),
  KEY `FK_RELATIONSHIP_5` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USERID`, `ROLEID`, `IME`, `PREZIME`, `USERNAME`, `PASSWORD`) VALUES
(1, 1, 'Pris', 'Pris', 'admin', 'admin'),
(2, 3, 'Rajko', 'Radonic', 'rayche', '123'),
(3, 2, 'Neki', 'Lik', 'neki_lik', '123'),
(4, 2, 'Jeste', 'Onje', 'predavac', '123'),
(5, 3, 'dobar', 'lik', 'dobar_lik', '123');

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
