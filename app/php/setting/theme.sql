-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: 2015 年 01 月 16 日 17:22
-- 伺服器版本: 5.5.40-0ubuntu0.14.04.1
-- PHP 版本: 5.5.9-1ubuntu4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 資料庫: `triplebaby`
--

-- --------------------------------------------------------

--
-- 資料表結構 `theme`
--

CREATE TABLE IF NOT EXISTS `theme` (
  `theme_id` int(11) NOT NULL AUTO_INCREMENT,
  `theme_name` varchar(128) DEFAULT NULL,
  `active` int(1) DEFAULT '1',
  PRIMARY KEY (`theme_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- 資料表的匯出資料 `theme`
--

INSERT INTO `theme` (`theme_id`, `theme_name`, `active`) VALUES
(1, '紅線停車', 1),
(2, '黃線停車', 1),
(3, '公車站牌10公尺內停車', 1),
(4, '交叉路口10公尺內停車', 1),
(5, '行人穿越道10公尺內停車', 1),
(6, '黃線併排', 1),
(7, '紅線併排', 1),
(8, '消防栓前停車', 1),
(9, '彎道停車', 1),
(10, '人行道停車', 1),
(11, '停在殘障車位', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
