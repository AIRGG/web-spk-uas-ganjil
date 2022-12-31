-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 31, 2022 at 02:40 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_spk_uas_2022`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_alternatif`
--

CREATE TABLE `tbl_alternatif` (
  `id_alter` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `c1` varchar(10) NOT NULL,
  `c2` varchar(10) NOT NULL,
  `c3` varchar(10) NOT NULL,
  `c4` varchar(10) NOT NULL,
  `c5` varchar(10) NOT NULL,
  `c6` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_alternatif`
--

INSERT INTO `tbl_alternatif` (`id_alter`, `nama`, `c1`, `c2`, `c3`, `c4`, `c5`, `c6`) VALUES
(21, 'k1', '6.0', '4.0', '26.0', '48.0', '24.0', '55.0'),
(22, 'k2', '5.0', '3.0', '21.0', '24.0', '8.0', '60.0'),
(23, 'k3', '2.0', '5.0', '27.0', '36.0', '12.0', '55.0'),
(24, 'k4', '4.0', '1.0', '24.0', '36.0', '8.0', '65.0'),
(25, 'k5', '7.0', '3.0', '28.0', '60.0', '24.0', '65.0'),
(26, 'k6', '5.0', '4.0', '23.0', '24.0', '8.0', '55.0'),
(27, 'k7', '9.0', '3.0', '22.0', '60.0', '8.0', '65.0'),
(28, 'k8', '6.0', '2.0', '26.0', '48.0', '24.0', '60.0'),
(29, 'k9', '4.0', '5.0', '22.0', '24.0', '8.0', '50.0'),
(30, 'k10', '3.0', '2.0', '22.0', '24.0', '6.0', '60.0');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_alternatif_history`
--

CREATE TABLE `tbl_alternatif_history` (
  `id_alter` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `c1` varchar(10) NOT NULL,
  `c2` varchar(10) NOT NULL,
  `c3` varchar(10) NOT NULL,
  `c4` varchar(10) NOT NULL,
  `c5` varchar(10) NOT NULL,
  `c6` varchar(10) NOT NULL,
  `id_tgl` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bobot`
--

CREATE TABLE `tbl_bobot` (
  `id_bobot` int(11) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `kriteria` varchar(5) NOT NULL,
  `bobot` double NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_bobot`
--

INSERT INTO `tbl_bobot` (`id_bobot`, `deskripsi`, `kriteria`, `bobot`, `keterangan`) VALUES
(19, 'Jumlah karyawan', 'c1', 0.1, 'PROFIT'),
(20, 'Kualitas kaos', 'c2', 0.25, 'PROFIT'),
(21, 'Jangka waktu pembuatan', 'c3', 0.2, 'COST'),
(22, 'Estimasi pembuatan dalam sehari', 'c4', 0.2, 'PROFIT'),
(23, 'Jumlah mesin', 'c5', 0.1, 'PROFIT'),
(24, 'Harga kaos', 'c6', 0.15, 'COST');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_bobot_history`
--

CREATE TABLE `tbl_bobot_history` (
  `id_bobot` int(11) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `kriteria` varchar(5) NOT NULL,
  `bobot` double NOT NULL,
  `id_tgl` int(11) NOT NULL,
  `keterangan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ranking`
--

CREATE TABLE `tbl_ranking` (
  `id_rank` int(11) NOT NULL,
  `id_tgl` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `angka` varchar(20) NOT NULL,
  `rank` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tanggal`
--

CREATE TABLE `tbl_tanggal` (
  `id_tgl` int(11) NOT NULL,
  `tgl` varchar(2) NOT NULL,
  `blm` varchar(2) NOT NULL,
  `thn` varchar(4) NOT NULL,
  `jmd` varchar(6) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_alternatif`
--
ALTER TABLE `tbl_alternatif`
  ADD PRIMARY KEY (`id_alter`);

--
-- Indexes for table `tbl_alternatif_history`
--
ALTER TABLE `tbl_alternatif_history`
  ADD PRIMARY KEY (`id_alter`),
  ADD KEY `id_tgl` (`id_tgl`);

--
-- Indexes for table `tbl_bobot`
--
ALTER TABLE `tbl_bobot`
  ADD PRIMARY KEY (`id_bobot`);

--
-- Indexes for table `tbl_bobot_history`
--
ALTER TABLE `tbl_bobot_history`
  ADD PRIMARY KEY (`id_bobot`),
  ADD KEY `id_tgl` (`id_tgl`);

--
-- Indexes for table `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  ADD PRIMARY KEY (`id_rank`),
  ADD KEY `id_tgl` (`id_tgl`);

--
-- Indexes for table `tbl_tanggal`
--
ALTER TABLE `tbl_tanggal`
  ADD PRIMARY KEY (`id_tgl`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_alternatif`
--
ALTER TABLE `tbl_alternatif`
  MODIFY `id_alter` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tbl_alternatif_history`
--
ALTER TABLE `tbl_alternatif_history`
  MODIFY `id_alter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_bobot`
--
ALTER TABLE `tbl_bobot`
  MODIFY `id_bobot` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `tbl_bobot_history`
--
ALTER TABLE `tbl_bobot_history`
  MODIFY `id_bobot` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  MODIFY `id_rank` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_tanggal`
--
ALTER TABLE `tbl_tanggal`
  MODIFY `id_tgl` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tbl_tanggal`
--
ALTER TABLE `tbl_tanggal`
  ADD CONSTRAINT `relasi1` FOREIGN KEY (`id_tgl`) REFERENCES `tbl_ranking` (`id_tgl`),
  ADD CONSTRAINT `relasi2` FOREIGN KEY (`id_tgl`) REFERENCES `tbl_bobot_history` (`id_tgl`),
  ADD CONSTRAINT `relasi3` FOREIGN KEY (`id_tgl`) REFERENCES `tbl_alternatif_history` (`id_tgl`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
