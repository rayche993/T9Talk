-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2016 at 05:50 PM
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
  `KOMENTARID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USERID` bigint(20) NOT NULL,
  `LEKCIJAID` bigint(20) NOT NULL,
  `OPIS` varchar(255) NOT NULL,
  PRIMARY KEY (`KOMENTARID`),
  KEY `FK_RELATIONSHIP_6` (`USERID`),
  KEY `FK_RELATIONSHIP_7` (`LEKCIJAID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `kurs`
--

CREATE TABLE IF NOT EXISTS `kurs` (
  `KURSID` bigint(20) NOT NULL AUTO_INCREMENT,
  `NAZIV` varchar(255) NOT NULL,
  `OPIS` varchar(255) NOT NULL,
  `ISHOD` varchar(255) NOT NULL,
  PRIMARY KEY (`KURSID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `kurs`
--

INSERT INTO `kurs` (`KURSID`, `NAZIV`, `OPIS`, `ISHOD`) VALUES
(1, 'Engleski jezik', 'Naucite engleski \r\njezik povoljno bla bla', 'Naucicete engleski \r\njezik ''nako'),
(2, 'Italijanski jezik', 'italijano\r\nmafija\r\nju ju', 'pucace\r\nse\r\nmnogo'),
(3, 'Spanski jezik', 'Spanci\r\nkorida\r\novo ono', 'bezacemo\r\nod\r\nbikova');

-- --------------------------------------------------------

--
-- Table structure for table `lekcija`
--

CREATE TABLE IF NOT EXISTS `lekcija` (
  `LEKCIJAID` bigint(20) NOT NULL AUTO_INCREMENT,
  `KURSID` bigint(20) NOT NULL,
  `USERID` bigint(20) NOT NULL,
  `TEXT` text NOT NULL,
  `TIPLEKCIJE` int(11) NOT NULL,
  PRIMARY KEY (`LEKCIJAID`),
  KEY `FK_POSTAVLJA` (`USERID`),
  KEY `FK_RELATIONSHIP_5` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `odgovor`
--

CREATE TABLE IF NOT EXISTS `odgovor` (
  `ODGOVORID` bigint(20) NOT NULL AUTO_INCREMENT,
  `PITANJEID` bigint(20) NOT NULL,
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
  `PITANJEID` bigint(20) NOT NULL AUTO_INCREMENT,
  `TESTID` bigint(20) NOT NULL,
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
  `USERID` bigint(20) NOT NULL,
  `TESTID` bigint(20) NOT NULL,
  `BROJBODOVA` float NOT NULL,
  PRIMARY KEY (`USERID`,`TESTID`),
  KEY `FK_RELATIONSHIP_13` (`TESTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `predaje`
--

CREATE TABLE IF NOT EXISTS `predaje` (
  `USERID` bigint(20) NOT NULL,
  `KURSID` bigint(20) NOT NULL,
  PRIMARY KEY (`USERID`,`KURSID`),
  KEY `FK_PREDAJE2` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prijavljen`
--

CREATE TABLE IF NOT EXISTS `prijavljen` (
  `USERID` bigint(20) NOT NULL,
  `KURSID` bigint(20) NOT NULL,
  PRIMARY KEY (`USERID`,`KURSID`),
  KEY `FK_PRIJAVLJEN2` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `TESTID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LEKCIJAID` bigint(20) NOT NULL,
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
  `USERID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ROLEID` bigint(20) NOT NULL,
  `IME` varchar(255) NOT NULL,
  `PREZIME` varchar(255) NOT NULL,
  `USERNAME` varchar(255) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  PRIMARY KEY (`USERID`),
  KEY `FK_RELATIONSHIP_1` (`ROLEID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USERID`, `ROLEID`, `IME`, `PREZIME`, `USERNAME`, `PASSWORD`) VALUES
(1, 1, 'PrisIme', 'PrisPrezime', 'admin', 'admin'),
(2, 3, 'Rajko', 'Radonic', 'rayche', '123');

-- --------------------------------------------------------

--
-- Table structure for table `userrole`
--

CREATE TABLE IF NOT EXISTS `userrole` (
  `ROLEID` bigint(20) NOT NULL AUTO_INCREMENT,
  `OPIS` varchar(255) NOT NULL,
  PRIMARY KEY (`ROLEID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `userrole`
--

INSERT INTO `userrole` (`ROLEID`, `OPIS`) VALUES
(1, 'Admin'),
(2, 'Polaznik'),
(3, 'Predavac');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `komentar`
--
ALTER TABLE `komentar`
  ADD CONSTRAINT `FK_RELATIONSHIP_6` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_7` FOREIGN KEY (`LEKCIJAID`) REFERENCES `lekcija` (`LEKCIJAID`);

--
-- Constraints for table `lekcija`
--
ALTER TABLE `lekcija`
  ADD CONSTRAINT `FK_POSTAVLJA` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
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
  ADD CONSTRAINT `FK_PREDAJE` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_PREDAJE2` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `prijavljen`
--
ALTER TABLE `prijavljen`
  ADD CONSTRAINT `FK_PRIJAVLJEN` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_PRIJAVLJEN2` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

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
