-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 28 Des 2022 pada 12.23
-- Versi server: 10.4.25-MariaDB
-- Versi PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_spk`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_alternatif`
--

CREATE TABLE `tbl_alternatif` (
  `id_alter` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `c1` varchar(3) NOT NULL,
  `c2` varchar(3) NOT NULL,
  `c3` varchar(3) NOT NULL,
  `c4` varchar(3) NOT NULL,
  `c5` varchar(3) NOT NULL,
  `c6` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_alternatif_history`
--

CREATE TABLE `tbl_alternatif_history` (
  `id_alter` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `c1` varchar(3) NOT NULL,
  `c2` varchar(3) NOT NULL,
  `c3` varchar(3) NOT NULL,
  `c4` varchar(3) NOT NULL,
  `c5` varchar(3) NOT NULL,
  `c6` varchar(3) NOT NULL,
  `id_tgl` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_bobot`
--

CREATE TABLE `tbl_bobot` (
  `id_bobot` int(11) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `kriteria` varchar(5) NOT NULL,
  `bobot` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_bobot_history`
--

CREATE TABLE `tbl_bobot_history` (
  `id_bobot` int(11) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `kriteria` varchar(5) NOT NULL,
  `bobot` double NOT NULL,
  `id_tgl` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_ranking`
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
-- Struktur dari tabel `tbl_tanggal`
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
-- Indeks untuk tabel `tbl_alternatif`
--
ALTER TABLE `tbl_alternatif`
  ADD PRIMARY KEY (`id_alter`);

--
-- Indeks untuk tabel `tbl_alternatif_history`
--
ALTER TABLE `tbl_alternatif_history`
  ADD PRIMARY KEY (`id_alter`),
  ADD KEY `id_tgl` (`id_tgl`);

--
-- Indeks untuk tabel `tbl_bobot`
--
ALTER TABLE `tbl_bobot`
  ADD PRIMARY KEY (`id_bobot`);

--
-- Indeks untuk tabel `tbl_bobot_history`
--
ALTER TABLE `tbl_bobot_history`
  ADD PRIMARY KEY (`id_bobot`),
  ADD KEY `id_tgl` (`id_tgl`);

--
-- Indeks untuk tabel `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  ADD PRIMARY KEY (`id_rank`),
  ADD KEY `id_tgl` (`id_tgl`);

--
-- Indeks untuk tabel `tbl_tanggal`
--
ALTER TABLE `tbl_tanggal`
  ADD PRIMARY KEY (`id_tgl`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `tbl_alternatif`
--
ALTER TABLE `tbl_alternatif`
  MODIFY `id_alter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_alternatif_history`
--
ALTER TABLE `tbl_alternatif_history`
  MODIFY `id_alter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_bobot`
--
ALTER TABLE `tbl_bobot`
  MODIFY `id_bobot` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_bobot_history`
--
ALTER TABLE `tbl_bobot_history`
  MODIFY `id_bobot` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_ranking`
--
ALTER TABLE `tbl_ranking`
  MODIFY `id_rank` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `tbl_tanggal`
--
ALTER TABLE `tbl_tanggal`
  MODIFY `id_tgl` int(11) NOT NULL AUTO_INCREMENT;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_tanggal`
--
ALTER TABLE `tbl_tanggal`
  ADD CONSTRAINT `relasi1` FOREIGN KEY (`id_tgl`) REFERENCES `tbl_ranking` (`id_tgl`),
  ADD CONSTRAINT `relasi2` FOREIGN KEY (`id_tgl`) REFERENCES `tbl_bobot_history` (`id_tgl`),
  ADD CONSTRAINT `relasi3` FOREIGN KEY (`id_tgl`) REFERENCES `tbl_alternatif_history` (`id_tgl`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
