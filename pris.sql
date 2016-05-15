-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2016 at 12:22 AM
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `kurs`
--

INSERT INTO `kurs` (`KURSID`, `NAZIV`, `OPIS`, `ISHOD`) VALUES
(1, 'Engleski jezik', 'englezi', 'premijer liga'),
(2, 'Spanski jezik', 'spanci\r\nkomunjare', 'evropska\r\nunija ovo ono');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `lekcija`
--

INSERT INTO `lekcija` (`LEKCIJAID`, `KURSID`, `USERID`, `NAZIV`, `TEXT`, `TIPLEKCIJE`) VALUES
(1, 1, 2, 'Prva Lekcija', '<p>Jeste</p>\r\n<p>ona je prva&nbsp;<img src="http://cdn.tinymce.com/4/plugins/emoticons/img/smiley-tongue-out.gif" alt="tongue-out" /></p>', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `ocena`
--

INSERT INTO `ocena` (`OCENAID`, `USERID`, `KURSID`, `OPIS`, `DATUM`) VALUES
(1, 4, 2, '3', '2016-04-27'),
(2, 3, 1, '3.5', '2016-04-27'),
(3, 3, 2, '1.75', '2016-04-27');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Dumping data for table `odgovor`
--

INSERT INTO `odgovor` (`ODGOVORID`, `PITANJEID`, `TEXT`, `TACAN`) VALUES
(1, 1, 'Jeste', 1),
(2, 1, 'Nije', 0),
(3, 2, 'Da', 1),
(4, 2, 'Ne', 0),
(5, 3, 'Da', 1),
(6, 3, 'Ne', 0),
(7, 4, 'Da', 1),
(8, 4, 'Ne', 0),
(9, 5, 'Moze', 1),
(10, 5, 'Kako ne', 0),
(11, 5, 'Uvek', 0),
(12, 5, 'Jok bre', 0),
(13, 6, 'kako ne bre', 1),
(14, 6, 'jok', 0),
(15, 6, 'ma da bre', 0),
(16, 7, 'dg', 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `pitanje`
--

INSERT INTO `pitanje` (`PITANJEID`, `TESTID`, `TEXT`, `TIPODGOVORA`) VALUES
(1, 1, 'Jel Rajko car?', 2),
(2, 2, 'Jel radi i ovo?', 3),
(3, 3, 'Ma samo jako, zar ne?', 2),
(4, 4, 'Jel idem da spavam?', 2),
(5, 5, 'Vise tacnih?', 3),
(6, 6, 'Vise tacnih?', 3),
(7, 7, 'dshfdsif?', 2),
(8, 7, 'pitanje', 1);

-- --------------------------------------------------------

--
-- Table structure for table `polozio`
--

CREATE TABLE IF NOT EXISTS `polozio` (
  `POLOZIOID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` int(11) NOT NULL,
  `KURSID` int(11) NOT NULL,
  `PROSEK` float NOT NULL,
  `OCENA` int(11) NOT NULL,
  PRIMARY KEY (`POLOZIOID`),
  KEY `FK_RELATIONSHIP_24` (`USERID`),
  KEY `FK_RELATIONSHIP_25` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `predaje`
--

CREATE TABLE IF NOT EXISTS `predaje` (
  `PREDAJEID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` int(11) NOT NULL,
  `KURSID` int(11) NOT NULL,
  PRIMARY KEY (`PREDAJEID`),
  KEY `FK_RELATIONSHIP_15` (`USERID`),
  KEY `FK_RELATIONSHIP_16` (`KURSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `prijava`
--

CREATE TABLE IF NOT EXISTS `prijava` (
  `PRIJAVAID` int(11) NOT NULL AUTO_INCREMENT,
  `KURSID` int(11) NOT NULL,
  `USERID` int(11) NOT NULL,
  PRIMARY KEY (`PRIJAVAID`),
  KEY `FK_RELATIONSHIP_17` (`KURSID`),
  KEY `FK_RELATIONSHIP_18` (`USERID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `prijava`
--

INSERT INTO `prijava` (`PRIJAVAID`, `KURSID`, `USERID`) VALUES
(1, 1, 3),
(2, 1, 4),
(3, 2, 4),
(4, 2, 3);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`TESTID`, `LEKCIJAID`, `NASLOV`, `OPIS`) VALUES
(1, 1, 'Test', 'Hehe'),
(2, 1, 'Onako', 'sta znam'),
(3, 1, 'Treci', 'primer'),
(4, 1, 'Cetvrti', 'Primer'),
(5, 1, 'Peti', 'Primer'),
(6, 1, 'Sesti', 'PR'),
(7, 1, 'naslov', 'sdogosdg');

-- --------------------------------------------------------

--
-- Table structure for table `uradio`
--

CREATE TABLE IF NOT EXISTS `uradio` (
  `URADIOID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` int(11) NOT NULL,
  `TESTID` int(11) NOT NULL,
  `BROJBODOVA` float NOT NULL,
  PRIMARY KEY (`URADIOID`),
  KEY `FK_RELATIONSHIP_22` (`USERID`),
  KEY `FK_RELATIONSHIP_23` (`TESTID`)
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`USERID`, `ROLEID`, `IME`, `PREZIME`, `USERNAME`, `PASSWORD`) VALUES
(1, 1, 'Pris', 'Pris', 'admin', 'admin'),
(2, 2, 'Rajko', 'Radonic', 'rayche', '123'),
(3, 3, 'Bojan', 'Piljak', 'boki', '123'),
(4, 3, 'Maksim', 'Lalic', 'maksa', '123');

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
-- Constraints for table `polozio`
--
ALTER TABLE `polozio`
  ADD CONSTRAINT `FK_RELATIONSHIP_24` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_25` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `predaje`
--
ALTER TABLE `predaje`
  ADD CONSTRAINT `FK_RELATIONSHIP_15` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_16` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`);

--
-- Constraints for table `prijava`
--
ALTER TABLE `prijava`
  ADD CONSTRAINT `FK_RELATIONSHIP_17` FOREIGN KEY (`KURSID`) REFERENCES `kurs` (`KURSID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_18` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `FK_RELATIONSHIP_4` FOREIGN KEY (`LEKCIJAID`) REFERENCES `lekcija` (`LEKCIJAID`);

--
-- Constraints for table `uradio`
--
ALTER TABLE `uradio`
  ADD CONSTRAINT `FK_RELATIONSHIP_22` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_RELATIONSHIP_23` FOREIGN KEY (`TESTID`) REFERENCES `test` (`TESTID`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `FK_RELATIONSHIP_1` FOREIGN KEY (`ROLEID`) REFERENCES `userrole` (`ROLEID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
