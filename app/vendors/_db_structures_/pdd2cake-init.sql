-- phpMyAdmin SQL Dump
-- version 3.3.2deb1ubuntu1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 16, 2013 at 12:02 PM
-- Server version: 5.1.70
-- PHP Version: 5.3.2-1ubuntu4.20

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pddcake`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(64) COLLATE ascii_bin NOT NULL,
  `username4m` varchar(48) COLLATE ascii_bin NOT NULL DEFAULT '000',
  `password` varbinary(48) NOT NULL,
  `originalpwd` varchar(48) COLLATE ascii_bin NOT NULL,
  `role` tinyint(4) NOT NULL COMMENT '0-admin,1-company,2-agent',
  `regtime` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '-1-unapproved,0-suspended,1-activated',
  `online` int(11) NOT NULL DEFAULT '-1' COMMENT '-1 offline, >0 online id in "online_logs"',
  `lastlogintime` datetime DEFAULT NULL,
  `level` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `username4m` (`username4m`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=1547 ;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(128) COLLATE ascii_bin NOT NULL,
  `notes` mediumtext COLLATE ascii_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE IF NOT EXISTS `agents` (
  `id` int(11) unsigned NOT NULL,
  `name` varchar(64) COLLATE ascii_bin NOT NULL,
  `paytoname` varchar(64) COLLATE ascii_bin NOT NULL,
  `keystring` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `companyid` int(11) NOT NULL,
  `ag1stname` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `aglastname` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `email` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `street` varchar(256) COLLATE ascii_bin DEFAULT NULL COMMENT 'street name & number',
  `city` varchar(256) COLLATE ascii_bin DEFAULT NULL,
  `state` varchar(256) COLLATE ascii_bin DEFAULT NULL COMMENT 'state & zip',
  `country` varchar(2) COLLATE ascii_bin DEFAULT NULL,
  `im` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `cellphone` varchar(32) COLLATE ascii_bin DEFAULT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `companyid` (`companyid`),
  KEY `countryabbr` (`country`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COLLATE=ascii_bin;

-- --------------------------------------------------------

--
-- Table structure for table `agent_site_mappings`
--

CREATE TABLE IF NOT EXISTS `agent_site_mappings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteid` int(11) NOT NULL,
  `agentid` int(11) NOT NULL,
  `campaignid` varchar(64) COLLATE ascii_bin NOT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'the value 0 is only useful for site "iml", and all the other sites should be 1 as default',
  PRIMARY KEY (`id`),
  KEY `agentid` (`agentid`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=4090 ;

-- --------------------------------------------------------

--
-- Table structure for table `bulletins`
--

CREATE TABLE IF NOT EXISTS `bulletins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `archdate` datetime DEFAULT NULL,
  `title` int(11) DEFAULT NULL,
  `info` mediumtext COLLATE ascii_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Table structure for table `chat_logs`
--

CREATE TABLE IF NOT EXISTS `chat_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agentid` int(11) NOT NULL,
  `clientusername` varchar(64) COLLATE ascii_bin NOT NULL,
  `submittime` datetime NOT NULL,
  `conversation` text COLLATE ascii_bin NOT NULL,
  `siteid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

--
-- Table structure for table `clickouts`
--

CREATE TABLE IF NOT EXISTS `clickouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `linkid` int(11) DEFAULT NULL,
  `agentid` int(11) DEFAULT NULL,
  `clicktime` datetime NOT NULL,
  `fromip` varchar(15) COLLATE ascii_bin NOT NULL,
  `siteid` int(11) DEFAULT NULL,
  `typeid` int(11) DEFAULT NULL,
  `link` varchar(256) COLLATE ascii_bin DEFAULT NULL,
  `url` varchar(256) COLLATE ascii_bin DEFAULT NULL,
  `referer` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clicktime` (`clicktime`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=287461 ;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) unsigned NOT NULL,
  `officename` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `man1stname` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `manlastname` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `manemail` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `mancellphone` varchar(32) COLLATE ascii_bin DEFAULT NULL,
  `street` varchar(128) COLLATE ascii_bin NOT NULL COMMENT 'street name & number',
  `city` varchar(128) COLLATE ascii_bin NOT NULL,
  `state` varchar(128) COLLATE ascii_bin NOT NULL COMMENT 'state & zip',
  `country` varchar(2) COLLATE ascii_bin NOT NULL,
  `contactname` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `payeename` varchar(64) COLLATE ascii_bin DEFAULT NULL COMMENT 'for the company',
  `payeeaddr1` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `payeeaddr2` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `payeecity` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `payeestate` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `payeezipcode` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `payeecountry` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `payeeemail` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `payouttype` tinyint(4) DEFAULT NULL COMMENT '0-pay by check, 1-pay by webstern uion, 2-pay by wire',
  `pps` decimal(8,2) NOT NULL DEFAULT '10.00',
  `paymentinfo` text COLLATE ascii_bin,
  `agentnotes` text COLLATE ascii_bin,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COLLATE=ascii_bin;

-- --------------------------------------------------------

--
-- Table structure for table `com_fees`
--

CREATE TABLE IF NOT EXISTS `com_fees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feeid` int(11) NOT NULL,
  `companyid` int(11) NOT NULL,
  `ownprice` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `feeid` (`feeid`,`companyid`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `fullname` varchar(64) COLLATE ascii_bin NOT NULL,
  `abbr` varchar(2) COLLATE ascii_bin NOT NULL,
  KEY `abbr` (`abbr`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COLLATE=ascii_bin;

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE IF NOT EXISTS `fees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typeid` int(11) NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `earning` decimal(8,2) NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteid` int(11) NOT NULL,
  `agentid` int(11) NOT NULL,
  `url` varchar(768) COLLATE ascii_bin NOT NULL,
  `typeid` int(11) NOT NULL,
  `remark` varchar(768) COLLATE ascii_bin NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '0 means suspended, 1 means activated',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `online_logs`
--

CREATE TABLE IF NOT EXISTS `online_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountid` int(11) NOT NULL,
  `intime` datetime NOT NULL,
  `inip` varchar(15) COLLATE ascii_bin DEFAULT NULL,
  `terminalcookieid` int(11) DEFAULT NULL,
  `outtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `accountid` (`accountid`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=86559 ;

-- --------------------------------------------------------

--
-- Table structure for table `run_stats`
--

CREATE TABLE IF NOT EXISTS `run_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `runtime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=70567 ;

-- --------------------------------------------------------

--
-- Table structure for table `sites`
--

CREATE TABLE IF NOT EXISTS `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hostname` varchar(128) COLLATE ascii_bin NOT NULL COMMENT 'for admin only',
  `sitename` varchar(128) COLLATE ascii_bin NOT NULL COMMENT 'for company & agent',
  `abbr` varchar(5) COLLATE ascii_bin DEFAULT NULL COMMENT 'for admin only',
  `srcdriver` varchar(64) COLLATE ascii_bin DEFAULT NULL COMMENT 'php fille name which fecthing & saving rss feed data src',
  `url` varchar(128) COLLATE ascii_bin NOT NULL,
  `contactname` varchar(64) COLLATE ascii_bin NOT NULL,
  `email` varchar(64) COLLATE ascii_bin NOT NULL,
  `phonenums` varchar(64) COLLATE ascii_bin NOT NULL,
  `type` varchar(64) COLLATE ascii_bin NOT NULL,
  `payouts` decimal(8,2) NOT NULL,
  `notes` text COLLATE ascii_bin NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sitename` (`hostname`),
  UNIQUE KEY `abbr` (`abbr`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `site_excludings`
--

CREATE TABLE IF NOT EXISTS `site_excludings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `companyid` int(11) NOT NULL,
  `agentid` int(11) NOT NULL,
  `siteid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `site_manuals`
--

CREATE TABLE IF NOT EXISTS `site_manuals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteid` int(11) NOT NULL,
  `html` text COLLATE ascii_bin,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE IF NOT EXISTS `stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agentid` int(11) NOT NULL,
  `companyid` int(11) NOT NULL,
  `raws` int(11) NOT NULL,
  `uniques` int(11) NOT NULL,
  `chargebacks` int(11) NOT NULL,
  `signups` int(11) DEFAULT NULL,
  `frauds` int(11) DEFAULT NULL,
  `sales_number` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `siteid` int(11) NOT NULL,
  `campaignid` varchar(64) COLLATE ascii_bin DEFAULT NULL,
  `trxtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agentid` (`agentid`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=4632598 ;

-- --------------------------------------------------------

--
-- Table structure for table `stats_abandoned`
--

CREATE TABLE IF NOT EXISTS `stats_abandoned` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agentid` int(11) NOT NULL,
  `raws` int(11) NOT NULL,
  `uniques` int(11) NOT NULL,
  `chargebacks` int(11) NOT NULL,
  `signups` int(11) DEFAULT NULL,
  `frauds` int(11) DEFAULT NULL,
  `sales_number` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `siteid` int(11) NOT NULL,
  `campaignid` varchar(64) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `trxtime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `agentid` (`agentid`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii AUTO_INCREMENT=605089 ;

-- --------------------------------------------------------

--
-- Table structure for table `terminal_cookies`
--

CREATE TABLE IF NOT EXISTS `terminal_cookies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cookie` char(32) COLLATE ascii_bin DEFAULT NULL,
  `time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=104381 ;

-- --------------------------------------------------------

--
-- Table structure for table `tmp_com_fees`
--

CREATE TABLE IF NOT EXISTS `tmp_com_fees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feeid` int(11) NOT NULL,
  `companyid` int(11) NOT NULL,
  `ownprice` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=55 ;

-- --------------------------------------------------------

--
-- Table structure for table `tmp_stats`
--

CREATE TABLE IF NOT EXISTS `tmp_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `runid` int(11) NOT NULL,
  `bygroup` tinyint(4) DEFAULT NULL COMMENT '1 by date, 2 by company, 3 by agent, 4 by agent detail',
  `trxtime` datetime DEFAULT NULL,
  `companyid` int(11) NOT NULL,
  `officename` varchar(64) COLLATE ascii_bin NOT NULL,
  `comscount` int(11) NOT NULL,
  `agentid` int(11) NOT NULL,
  `username` varchar(64) COLLATE ascii_bin NOT NULL,
  `username4m` varchar(48) COLLATE ascii_bin DEFAULT NULL,
  `agscount` int(11) NOT NULL,
  `siteid` int(11) NOT NULL,
  `sitename` varchar(64) COLLATE ascii_bin NOT NULL,
  `sitescount` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `typename` varchar(64) COLLATE ascii_bin NOT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `earning` decimal(8,2) DEFAULT NULL,
  `typescount` int(11) NOT NULL,
  `raws` int(11) NOT NULL,
  `uniques` int(11) NOT NULL,
  `chargebacks` int(11) NOT NULL,
  `signups` int(11) DEFAULT NULL,
  `frauds` int(11) DEFAULT NULL,
  `sales_type1` int(11) DEFAULT NULL,
  `sales_type2` int(11) DEFAULT NULL,
  `sales_type3` int(11) DEFAULT NULL,
  `sales_type4` int(11) DEFAULT NULL,
  `net` int(11) DEFAULT NULL,
  `payouts` decimal(8,2) DEFAULT NULL,
  `earnings` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `runid` (`runid`)
) ENGINE=MEMORY DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `tmp_tmp`
--
CREATE TABLE IF NOT EXISTS `tmp_tmp` (
`companyid` int(11) unsigned
,`officename` varchar(128)
,`agentid` int(11)
,`username` varchar(64)
,`clicktime` datetime
,`fromip` varchar(15)
,`referer` varchar(128)
,`siteid` int(11)
,`sitename` varchar(128)
,`typeid` int(11)
,`typename` varchar(64)
,`url` varchar(256)
);
-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteid` int(11) NOT NULL,
  `typename` varchar(64) COLLATE ascii_bin NOT NULL,
  `url` varchar(128) COLLATE ascii_bin DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `typename` (`typename`)
) ENGINE=MyISAM  DEFAULT CHARSET=ascii COLLATE=ascii_bin AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `t_stats`
--

CREATE TABLE IF NOT EXISTS `t_stats` (
  `trxtime` date NOT NULL,
  `agentid` int(11) NOT NULL,
  `companyid` int(11) NOT NULL,
  `siteid` int(11) NOT NULL,
  `typeid` int(11) NOT NULL,
  `raws` int(11) NOT NULL,
  `uniques` int(11) NOT NULL,
  `chargebacks` int(11) NOT NULL,
  `signups` int(11) NOT NULL,
  `frauds` int(11) NOT NULL,
  `sales_type1` int(11) NOT NULL,
  `sales_type2` int(11) NOT NULL,
  `sales_type3` int(11) NOT NULL,
  `sales_type4` int(11) NOT NULL,
  `run_id` int(11) NOT NULL,
  `group_by` tinyint(4) NOT NULL,
  KEY `run_id` (`run_id`,`group_by`)
) ENGINE=InnoDB DEFAULT CHARSET=ascii COLLATE=ascii_bin;

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_admins`
--
CREATE TABLE IF NOT EXISTS `view_admins` (
`id` int(11) unsigned
,`username` varchar(64)
,`password` varbinary(48)
,`originalpwd` varchar(48)
,`role` tinyint(4)
,`regtime` datetime
,`status` tinyint(4)
,`online` int(11)
,`level` tinyint(4)
,`email` varchar(128)
,`notes` mediumtext
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_agents`
--
CREATE TABLE IF NOT EXISTS `view_agents` (
`id` int(11) unsigned
,`username` varchar(64)
,`username4m` varchar(48)
,`originalpwd` varchar(48)
,`regtime` datetime
,`lastlogintime` datetime
,`logintimes` bigint(21)
,`status` tinyint(4)
,`online` int(11)
,`companyid` int(11) unsigned
,`officename` varchar(128)
,`name` varchar(64)
,`paytoname` varchar(64)
,`keystring` varchar(64)
,`ag1stname` varchar(64)
,`aglastname` varchar(64)
,`email` varchar(128)
,`street` varchar(256)
,`city` varchar(256)
,`state` varchar(256)
,`country` varchar(64)
,`im` varchar(128)
,`cellphone` varchar(32)
,`campaigns` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_chat_logs`
--
CREATE TABLE IF NOT EXISTS `view_chat_logs` (
`companyid` int(11)
,`officename` varchar(128)
,`agentid` int(11)
,`username` varchar(64)
,`username4m` varchar(48)
,`clientusername` varchar(64)
,`conversation` varchar(505)
,`submittime` datetime
,`siteid` int(11)
,`sitename` varchar(128)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_clickouts`
--
CREATE TABLE IF NOT EXISTS `view_clickouts` (
`companyid` int(11) unsigned
,`officename` varchar(128)
,`agentid` int(11)
,`username` varchar(64)
,`clicktime` datetime
,`fromip` varchar(15)
,`referer` varchar(128)
,`siteid` int(11)
,`sitename` varchar(128)
,`typeid` int(11)
,`typename` varchar(64)
,`url` varchar(256)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_companies`
--
CREATE TABLE IF NOT EXISTS `view_companies` (
`agenttotal` bigint(21)
,`companyid` int(11)
,`officename` varchar(128)
,`username` varchar(64)
,`username4m` varchar(48)
,`originalpwd` varchar(48)
,`regtime` datetime
,`status` tinyint(4)
,`online` int(11)
,`street` varchar(128)
,`city` varchar(128)
,`state` varchar(128)
,`counrty` varchar(64)
,`payeename` varchar(64)
,`contactname` varchar(64)
,`man1stname` varchar(64)
,`manlastname` varchar(64)
,`manemail` varchar(128)
,`mancellphone` varchar(32)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_links`
--
CREATE TABLE IF NOT EXISTS `view_links` (
`id` int(11)
,`agentid` int(11) unsigned
,`agusername` varchar(64)
,`url` varchar(768)
,`remark` varchar(768)
,`status` tinyint(4)
,`companyid` int(11) unsigned
,`officename` varchar(128)
,`siteid` int(11)
,`hostname` varchar(128)
,`sitename` varchar(128)
,`srcdriver` varchar(64)
,`typeid` int(11)
,`typename` varchar(64)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_mappings`
--
CREATE TABLE IF NOT EXISTS `view_mappings` (
`id` int(11)
,`siteid` int(11)
,`agentid` int(11)
,`campaignid` varchar(64)
,`flag` tinyint(4)
,`hostname` varchar(128)
,`abbr` varchar(5)
,`sitename` varchar(128)
,`username` varchar(64)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_online_logs`
--
CREATE TABLE IF NOT EXISTS `view_online_logs` (
`id` int(11)
,`accountid` int(11)
,`username` varchar(64)
,`username4m` varchar(48)
,`intime` datetime
,`inip` varchar(15)
,`outtime` datetime
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_sites`
--
CREATE TABLE IF NOT EXISTS `view_sites` (
`id` int(11)
,`hostname` varchar(128)
,`sitename` varchar(128)
,`sitenametype` varchar(195)
,`abbr` varchar(5)
,`srcdriver` varchar(64)
,`url` varchar(128)
,`contactname` varchar(64)
,`email` varchar(64)
,`phonenums` varchar(64)
,`type` varchar(64)
,`payouts` decimal(8,2)
,`notes` text
,`status` tinyint(4)
,`linkstotal` bigint(21)
,`typestotal` bigint(21)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_stats`
--
CREATE TABLE IF NOT EXISTS `view_stats` (
`trxtime` datetime
,`companyid` int(11)
,`officename` varchar(128)
,`agentid` int(11)
,`username` varchar(64)
,`username4m` varchar(48)
,`status` tinyint(4)
,`siteid` int(11)
,`sitename` varchar(128)
,`typeid` int(11)
,`typename` varchar(64)
,`price` decimal(8,2)
,`earning` decimal(8,2)
,`raws` int(11)
,`uniques` int(11)
,`chargebacks` int(11)
,`signups` int(11)
,`frauds` int(11)
,`sales_number` int(11)
,`net` bigint(12)
,`payouts` decimal(19,2)
,`earnings` decimal(19,2)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_types`
--
CREATE TABLE IF NOT EXISTS `view_types` (
`hostname` varchar(128)
,`sitename` varchar(128)
,`id` int(11)
,`siteid` int(11)
,`typename` varchar(64)
,`url` varchar(128)
,`status` tinyint(4)
,`price` decimal(8,2)
,`earning` decimal(8,2)
,`start` datetime
,`end` datetime
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_t_stats`
--
CREATE TABLE IF NOT EXISTS `view_t_stats` (
`trxtime` date
,`agentid` int(11)
,`siteid` int(11)
,`typeid` int(11)
,`raws` int(11)
,`uniques` int(11)
,`chargebacks` int(11)
,`signups` int(11)
,`frauds` int(11)
,`sales_type1` int(11)
,`sales_type2` int(11)
,`sales_type3` int(11)
,`sales_type4` int(11)
,`run_id` int(11)
,`group_by` tinyint(4)
,`companyid` int(11)
,`officename` varchar(128)
,`username` varchar(64)
,`username4m` varchar(48)
,`ag1stname` varchar(64)
,`aglastname` varchar(64)
,`sitename` varchar(128)
,`typename` varchar(64)
,`net` bigint(15)
,`payouts` decimal(22,2)
,`earnings` decimal(22,2)
);
-- --------------------------------------------------------

--
-- Structure for view `tmp_tmp`
--
DROP TABLE IF EXISTS `tmp_tmp`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `tmp_tmp` AS select `c`.`id` AS `companyid`,`c`.`officename` AS `officename`,`a`.`agentid` AS `agentid`,`d`.`username` AS `username`,`a`.`clicktime` AS `clicktime`,`a`.`fromip` AS `fromip`,`a`.`referer` AS `referer`,`a`.`siteid` AS `siteid`,`e`.`sitename` AS `sitename`,`a`.`typeid` AS `typeid`,`f`.`typename` AS `typename`,`a`.`url` AS `url` from (((((`clickouts` `a` join `agents` `b`) join `companies` `c`) join `accounts` `d`) join `sites` `e`) join `types` `f`) where ((`a`.`agentid` = `b`.`id`) and (`b`.`id` = `d`.`id`) and (`b`.`companyid` = `c`.`id`) and (`a`.`siteid` = `e`.`id`) and (`a`.`typeid` = `f`.`id`));

-- --------------------------------------------------------

--
-- Structure for view `view_admins`
--
DROP TABLE IF EXISTS `view_admins`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`localhost` SQL SECURITY DEFINER VIEW `view_admins` AS select `a`.`id` AS `id`,`a`.`username` AS `username`,`a`.`password` AS `password`,`a`.`originalpwd` AS `originalpwd`,`a`.`role` AS `role`,`a`.`regtime` AS `regtime`,`a`.`status` AS `status`,`a`.`online` AS `online`,`a`.`level` AS `level`,`b`.`email` AS `email`,`b`.`notes` AS `notes` from (`accounts` `a` join `admins` `b`) where (`a`.`id` = `b`.`id`);

-- --------------------------------------------------------

--
-- Structure for view `view_agents`
--
DROP TABLE IF EXISTS `view_agents`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `view_agents` AS select `agents`.`id` AS `id`,`accounts`.`username` AS `username`,`accounts`.`username4m` AS `username4m`,`accounts`.`originalpwd` AS `originalpwd`,`accounts`.`regtime` AS `regtime`,`accounts`.`lastlogintime` AS `lastlogintime`,(select count(`online_logs`.`id`) AS `count(online_logs.id)` from `online_logs` where (`online_logs`.`accountid` = `accounts`.`id`)) AS `logintimes`,`accounts`.`status` AS `status`,`accounts`.`online` AS `online`,`companies`.`id` AS `companyid`,`companies`.`officename` AS `officename`,`agents`.`name` AS `name`,`agents`.`paytoname` AS `paytoname`,`agents`.`keystring` AS `keystring`,`agents`.`ag1stname` AS `ag1stname`,`agents`.`aglastname` AS `aglastname`,`agents`.`email` AS `email`,`agents`.`street` AS `street`,`agents`.`city` AS `city`,`agents`.`state` AS `state`,`countries`.`fullname` AS `country`,`agents`.`im` AS `im`,`agents`.`cellphone` AS `cellphone`,(select count(`agent_site_mappings`.`id`) AS `count(id)` from `agent_site_mappings` where ((`agent_site_mappings`.`siteid` > 0) and (`agent_site_mappings`.`agentid` = `agents`.`id`))) AS `campaigns` from (((`agents` join `companies`) join `accounts`) join `countries`) where ((`agents`.`id` = `accounts`.`id`) and (`agents`.`companyid` = `companies`.`id`) and (`agents`.`country` = `countries`.`abbr`));

-- --------------------------------------------------------

--
-- Structure for view `view_chat_logs`
--
DROP TABLE IF EXISTS `view_chat_logs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`localhost` SQL SECURITY DEFINER VIEW `view_chat_logs` AS select `b`.`companyid` AS `companyid`,`c`.`officename` AS `officename`,`a`.`agentid` AS `agentid`,`d`.`username` AS `username`,`d`.`username4m` AS `username4m`,`a`.`clientusername` AS `clientusername`,concat(left(`a`.`conversation`,500),_ascii'\r\n...') AS `conversation`,`a`.`submittime` AS `submittime`,`a`.`siteid` AS `siteid`,`e`.`sitename` AS `sitename` from ((((`chat_logs` `a` join `agents` `b`) join `companies` `c`) join `accounts` `d`) join `sites` `e`) where ((`a`.`agentid` = `b`.`id`) and (`b`.`companyid` = `c`.`id`) and (`b`.`id` = `d`.`id`) and (`a`.`siteid` = `e`.`id`));

-- --------------------------------------------------------

--
-- Structure for view `view_clickouts`
--
DROP TABLE IF EXISTS `view_clickouts`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `view_clickouts` AS select `c`.`id` AS `companyid`,`c`.`officename` AS `officename`,`a`.`agentid` AS `agentid`,`d`.`username` AS `username`,`a`.`clicktime` AS `clicktime`,`a`.`fromip` AS `fromip`,`a`.`referer` AS `referer`,`a`.`siteid` AS `siteid`,`e`.`sitename` AS `sitename`,`a`.`typeid` AS `typeid`,`f`.`typename` AS `typename`,`a`.`url` AS `url` from (((((`clickouts` `a` join `agents` `b`) join `companies` `c`) join `accounts` `d`) join `sites` `e`) join `types` `f`) where ((`a`.`agentid` = `b`.`id`) and (`b`.`id` = `d`.`id`) and (`b`.`companyid` = `c`.`id`) and (`a`.`siteid` = `e`.`id`) and (`a`.`typeid` = `f`.`id`));

-- --------------------------------------------------------

--
-- Structure for view `view_companies`
--
DROP TABLE IF EXISTS `view_companies`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`localhost` SQL SECURITY DEFINER VIEW `view_companies` AS select count(`a`.`id`) AS `agenttotal`,`a`.`companyid` AS `companyid`,`b`.`officename` AS `officename`,`c`.`username` AS `username`,`c`.`username4m` AS `username4m`,`c`.`originalpwd` AS `originalpwd`,`c`.`regtime` AS `regtime`,`c`.`status` AS `status`,`c`.`online` AS `online`,`b`.`street` AS `street`,`b`.`city` AS `city`,`b`.`state` AS `state`,`d`.`fullname` AS `counrty`,`b`.`payeename` AS `payeename`,`b`.`contactname` AS `contactname`,`b`.`man1stname` AS `man1stname`,`b`.`manlastname` AS `manlastname`,`b`.`manemail` AS `manemail`,`b`.`mancellphone` AS `mancellphone` from (((`agents` `a` join `companies` `b`) join `accounts` `c`) join `countries` `d`) where ((`a`.`companyid` = `b`.`id`) and (`b`.`id` = `c`.`id`) and (`b`.`country` = `d`.`abbr`)) group by `a`.`companyid` union select 0 AS `0`,`b`.`id` AS `companyid`,`b`.`officename` AS `officename`,`c`.`username` AS `username`,`c`.`username4m` AS `username4m`,`c`.`originalpwd` AS `originalpwd`,`c`.`regtime` AS `regtime`,`c`.`status` AS `status`,`c`.`online` AS `online`,`b`.`street` AS `street`,`b`.`city` AS `city`,`b`.`state` AS `state`,`d`.`fullname` AS `counrty`,`b`.`payeename` AS `payeename`,`b`.`contactname` AS `contactname`,`b`.`man1stname` AS `man1stname`,`b`.`manlastname` AS `manlastname`,`b`.`manemail` AS `manemail`,`b`.`mancellphone` AS `mancellphone` from ((`companies` `b` join `accounts` `c`) join `countries` `d`) where ((`b`.`id` = `c`.`id`) and (`b`.`country` = `d`.`abbr`) and (not(`b`.`id` in (select distinct `agents`.`companyid` AS `companyid` from `agents`))));

-- --------------------------------------------------------

--
-- Structure for view `view_links`
--
DROP TABLE IF EXISTS `view_links`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_links` AS select `a`.`id` AS `id`,`b`.`id` AS `agentid`,`f`.`username` AS `agusername`,`a`.`url` AS `url`,`a`.`remark` AS `remark`,`a`.`status` AS `status`,`c`.`id` AS `companyid`,`c`.`officename` AS `officename`,`d`.`id` AS `siteid`,`d`.`hostname` AS `hostname`,`d`.`sitename` AS `sitename`,`d`.`srcdriver` AS `srcdriver`,`e`.`id` AS `typeid`,`e`.`typename` AS `typename` from (((((`links` `a` join `agents` `b`) join `companies` `c`) join `sites` `d`) join `types` `e`) join `accounts` `f`) where ((`a`.`agentid` = `b`.`id`) and (`b`.`companyid` = `c`.`id`) and (`a`.`siteid` = `d`.`id`) and (`a`.`typeid` = `e`.`id`) and (`a`.`siteid` = `e`.`siteid`) and (`b`.`id` = `f`.`id`));

-- --------------------------------------------------------

--
-- Structure for view `view_mappings`
--
DROP TABLE IF EXISTS `view_mappings`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`localhost` SQL SECURITY DEFINER VIEW `view_mappings` AS select `a`.`id` AS `id`,`a`.`siteid` AS `siteid`,`a`.`agentid` AS `agentid`,`a`.`campaignid` AS `campaignid`,`a`.`flag` AS `flag`,`b`.`hostname` AS `hostname`,`b`.`abbr` AS `abbr`,`b`.`sitename` AS `sitename`,`c`.`username` AS `username` from ((`agent_site_mappings` `a` join `sites` `b`) join `accounts` `c`) where ((`a`.`siteid` = `b`.`id`) and (`a`.`agentid` = `c`.`id`));

-- --------------------------------------------------------

--
-- Structure for view `view_online_logs`
--
DROP TABLE IF EXISTS `view_online_logs`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `view_online_logs` AS select `a`.`id` AS `id`,`a`.`accountid` AS `accountid`,`b`.`username` AS `username`,`b`.`username4m` AS `username4m`,`a`.`intime` AS `intime`,`a`.`inip` AS `inip`,`a`.`outtime` AS `outtime` from (`online_logs` `a` join `accounts` `b`) where (`a`.`accountid` = `b`.`id`);

-- --------------------------------------------------------

--
-- Structure for view `view_sites`
--
DROP TABLE IF EXISTS `view_sites`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `view_sites` AS select `s`.`id` AS `id`,`s`.`hostname` AS `hostname`,`s`.`sitename` AS `sitename`,concat(`s`.`sitename`,' (',`s`.`type`,')') AS `sitenametype`,`s`.`abbr` AS `abbr`,`s`.`srcdriver` AS `srcdriver`,`s`.`url` AS `url`,`s`.`contactname` AS `contactname`,`s`.`email` AS `email`,`s`.`phonenums` AS `phonenums`,`s`.`type` AS `type`,`s`.`payouts` AS `payouts`,`s`.`notes` AS `notes`,`s`.`status` AS `status`,(select count(`links`.`id`) AS `count(id)` from `links` where (`links`.`siteid` = `s`.`id`)) AS `linkstotal`,(select count(`types`.`id`) AS `count(id)` from `types` where (`types`.`siteid` = `s`.`id`)) AS `typestotal` from `sites` `s`;

-- --------------------------------------------------------

--
-- Structure for view `view_stats`
--
DROP TABLE IF EXISTS `view_stats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `view_stats` AS select `a`.`trxtime` AS `trxtime`,`b`.`companyid` AS `companyid`,`c`.`officename` AS `officename`,`a`.`agentid` AS `agentid`,`d`.`username` AS `username`,`d`.`username4m` AS `username4m`,`d`.`status` AS `status`,`a`.`siteid` AS `siteid`,`e`.`sitename` AS `sitename`,`a`.`typeid` AS `typeid`,`f`.`typename` AS `typename`,`g`.`price` AS `price`,`g`.`earning` AS `earning`,`a`.`raws` AS `raws`,`a`.`uniques` AS `uniques`,`a`.`chargebacks` AS `chargebacks`,`a`.`signups` AS `signups`,`a`.`frauds` AS `frauds`,`a`.`sales_number` AS `sales_number`,(`a`.`sales_number` - `a`.`chargebacks`) AS `net`,((`a`.`sales_number` - `a`.`chargebacks`) * `h`.`ownprice`) AS `payouts`,((`a`.`sales_number` - `a`.`chargebacks`) * `g`.`earning`) AS `earnings` from (((((((`stats` `a` join `agents` `b`) join `companies` `c`) join `accounts` `d`) join `sites` `e`) join `types` `f`) join `fees` `g`) join `tmp_com_fees` `h`) where ((`a`.`agentid` = `b`.`id`) and (`b`.`companyid` = `c`.`id`) and (`a`.`agentid` = `d`.`id`) and (`a`.`siteid` = `e`.`id`) and (`a`.`typeid` = `f`.`id`) and (`f`.`id` = `g`.`typeid`) and (`a`.`trxtime` >= `g`.`start`) and (`a`.`trxtime` <= `g`.`end`) and (`g`.`id` = `h`.`feeid`) and (`c`.`id` = `h`.`companyid`));

-- --------------------------------------------------------

--
-- Structure for view `view_types`
--
DROP TABLE IF EXISTS `view_types`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`localhost` SQL SECURITY DEFINER VIEW `view_types` AS select `b`.`hostname` AS `hostname`,`b`.`sitename` AS `sitename`,`a`.`id` AS `id`,`a`.`siteid` AS `siteid`,`a`.`typename` AS `typename`,`a`.`url` AS `url`,`a`.`status` AS `status`,`c`.`price` AS `price`,`c`.`earning` AS `earning`,`c`.`start` AS `start`,`c`.`end` AS `end` from ((`types` `a` join `sites` `b`) join `fees` `c`) where ((`a`.`siteid` = `b`.`id`) and (`a`.`id` = `c`.`typeid`));

-- --------------------------------------------------------

--
-- Structure for view `view_t_stats`
--
DROP TABLE IF EXISTS `view_t_stats`;

CREATE ALGORITHM=UNDEFINED DEFINER=`marijana`@`%` SQL SECURITY DEFINER VIEW `view_t_stats` AS select `t`.`trxtime` AS `trxtime`,`t`.`agentid` AS `agentid`,`t`.`siteid` AS `siteid`,`t`.`typeid` AS `typeid`,`t`.`raws` AS `raws`,`t`.`uniques` AS `uniques`,`t`.`chargebacks` AS `chargebacks`,`t`.`signups` AS `signups`,`t`.`frauds` AS `frauds`,`t`.`sales_type1` AS `sales_type1`,`t`.`sales_type2` AS `sales_type2`,`t`.`sales_type3` AS `sales_type3`,`t`.`sales_type4` AS `sales_type4`,`t`.`run_id` AS `run_id`,`t`.`group_by` AS `group_by`,`b`.`companyid` AS `companyid`,`c`.`officename` AS `officename`,`a`.`username` AS `username`,`a`.`username4m` AS `username4m`,`b`.`ag1stname` AS `ag1stname`,`b`.`aglastname` AS `aglastname`,`s`.`sitename` AS `sitename`,`p`.`typename` AS `typename`,((((`t`.`sales_type1` + `t`.`sales_type2`) + `t`.`sales_type3`) + `t`.`sales_type4`) - `t`.`chargebacks`) AS `net`,(((((`t`.`sales_type1` + `t`.`sales_type2`) + `t`.`sales_type3`) + `t`.`sales_type4`) - `t`.`chargebacks`) * `h`.`ownprice`) AS `payouts`,(((((`t`.`sales_type1` + `t`.`sales_type2`) + `t`.`sales_type3`) + `t`.`sales_type4`) - `t`.`chargebacks`) * `f`.`earning`) AS `earnings` from (((((((`t_stats` `t` join `accounts` `a`) join `agents` `b`) join `companies` `c`) join `sites` `s`) join `types` `p`) join `fees` `f`) join `tmp_com_fees` `h`) where ((`t`.`agentid` = `a`.`id`) and (`a`.`id` = `b`.`id`) and (`b`.`companyid` = `c`.`id`) and (`t`.`siteid` = `s`.`id`) and (`t`.`typeid` = `p`.`id`) and (`p`.`id` = `f`.`typeid`) and (`f`.`id` = `h`.`feeid`) and (`h`.`companyid` = `c`.`id`) and (`t`.`trxtime` >= `f`.`start`) and (`t`.`trxtime` <= `f`.`end`));

-- Data import
INSERT INTO `accounts` (`id`, `username`, `username4m`, `password`, `originalpwd`, `role`, `regtime`, `status`, `online`, `lastlogintime`, `level`) VALUES
(1, 'superadmin', 'superadmin00000000000000000000000000000000000000', 'bbcabdb0219d4d14e2418ff65e1aa0de', 'Open54321A', 0, '1970-01-01 00:00:00', 1, 86343, '2013-10-16 02:48:00', 1),
(2, 'adminuser', 'adminuser000000000000000000000000000000000000000', '5123f93adcefc4fef656f822923a3fa8', 'open123', 0, '2010-01-06 12:23:00', 1, 86308, '2013-10-16 02:39:07', NULL),
(3, 'admin', 'admin0000000000000000000000000000000000000000000', '1b21c786d86b5b2e12447ba181dd63d7', 'PDD54321A', 0, '2012-08-25 00:00:00', 1, 77675, '2013-10-07 00:20:42', NULL),
(4, 'Generalmanager', 'Generalmanager0000000000000000000000000000000000', '1b21c786d86b5b2e12447ba181dd63d7', 'PDD54321A', 0, '2012-10-14 00:00:00', 1, 82699, '2013-10-10 23:36:52', NULL);

INSERT INTO `admins` (`id`, `email`) VALUES
(1, 'sales@paydirtdollars.com'),
(2, 'admin@paydirtdollars.com'),
(3, 'ancy.zydian@yahoo.com'),
(4, 'markelvin.synergy@gmail.com');
