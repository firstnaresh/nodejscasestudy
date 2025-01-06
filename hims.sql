-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 06, 2025 at 10:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hims`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('male','female','other') NOT NULL,
  `speciality` varchar(200) NOT NULL,
  `dob` date NOT NULL,
  `salary` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `doj` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `first_name`, `last_name`, `age`, `gender`, `speciality`, `dob`, `salary`, `status`, `createdAt`, `updatedAt`, `doj`) VALUES
(6, 'Subham', 'Singh', 52, '', 'pediatric', '1997-01-01', 100000, 1, '2025-01-06 08:32:00', '2025-01-06 08:32:00', '2016-01-01'),
(7, 'Radha', 'Singh', 52, '', 'pediatric', '1997-01-01', 100000, 1, '2025-01-06 08:32:42', '2025-01-06 08:32:42', '2016-01-01'),
(8, 'Radha', 'jabal', 52, '', 'pediatric', '1997-01-01', 100000, 1, '2025-01-06 08:33:32', '2025-01-06 08:33:32', '2016-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `specialties`
--

CREATE TABLE `specialties` (
  `id` int(11) NOT NULL,
  `speciality` varchar(200) NOT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `specialties`
--

INSERT INTO `specialties` (`id`, `speciality`, `status`, `createdAt`, `updatedAt`) VALUES
(1, 'medicine', '1', '2025-01-06 05:39:23', '2025-01-06 05:39:23'),
(2, 'cardio', '1', '2025-01-06 05:39:23', '2025-01-06 05:39:23'),
(3, 'gayne', '1', '2025-01-06 05:49:16', '2025-01-06 05:49:16'),
(4, 'pediatrics', '1', '2025-01-06 05:49:16', '2025-01-06 05:49:16');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `specialties`
--
ALTER TABLE `specialties`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `specialties`
--
ALTER TABLE `specialties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
