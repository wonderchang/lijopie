-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 建立日期: 2015 年 01 月 16 日 17:11
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
-- 資料表結構 `region`
--

CREATE TABLE IF NOT EXISTS `region` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `region_name` varchar(12) DEFAULT NULL,
  `active` int(1) DEFAULT '1',
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- 資料表的匯出資料 `region`
--

INSERT INTO `region` (`region_id`, `region_name`, `active`) VALUES
(1, '東區', 1),
(2, '北區', 1),
(3, '南區', 1),
(4, '中西區', 1),
(5, '安南區', 1),
(6, '安平區', 1),
(7, '七股區', 1),
(8, '下營區', 1),
(9, '仁德區', 1),
(10, '佳里區', 1),
(11, '六甲區', 1),
(12, '北門區', 1),
(13, '南化區', 1),
(14, '善化區', 1),
(15, '大內區', 1),
(16, '學甲區', 1),
(17, '安定區', 1),
(18, '官田區', 1),
(19, '將軍區', 1),
(20, '山上區', 1),
(21, '左鎮區', 1),
(22, '後壁區', 1),
(23, '新化區', 1),
(24, '新市區', 1),
(25, '新營區', 1),
(26, '東山區', 1),
(27, '柳營區', 1),
(28, '楠西區', 1),
(29, '歸仁區', 1),
(30, '永康區', 1),
(31, '玉井區', 1),
(32, '白河區', 1),
(33, '西港區', 1),
(34, '關廟區', 1),
(35, '鹽水區', 1),
(36, '麻豆區', 1),
(37, '龍崎區', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
