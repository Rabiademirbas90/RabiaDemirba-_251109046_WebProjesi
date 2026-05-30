-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 30 May 2026, 18:16:35
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `node_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `251109046_classes`
--

CREATE TABLE `251109046_classes` (
  `id` int(11) NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `trainer_id` int(11) DEFAULT NULL,
  `price` varchar(50) NOT NULL,
  `quota` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `251109046_classes`
--

INSERT INTO `251109046_classes` (`id`, `class_name`, `trainer_id`, `price`, `quota`) VALUES
(2, 'pilates', NULL, '1.500 TL', '3 Kişi'),
(3, 'Crossfit', NULL, '1.000 TL', '15 Kişi'),
(4, 'Zumba', 3, '3.100 TL', '5 Kişi'),
(5, 'Spinning', 4, '', ''),
(6, 'Yoga', 3, '3.000 TL', '7 Kişi'),
(13, 'kickboks', 1, '1.500 TL', '20 Kişi'),
(17, 'Kardiyo', 2, '1.500 TL', '5 Kişi'),
(20, 'Animal Flow', 2, '2.000 TL', '5 Kişi');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `251109046_trainers`
--

CREATE TABLE `251109046_trainers` (
  `id` int(11) NOT NULL,
  `trainer_name` varchar(100) NOT NULL,
  `expertise` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `251109046_trainers`
--

INSERT INTO `251109046_trainers` (`id`, `trainer_name`, `expertise`) VALUES
(1, 'Boran Akar', ''),
(2, 'Ahmet Kaya', ''),
(3, 'Zeynep Çelik', ''),
(4, 'Ali Öztürk', ''),
(5, 'Ayşe Kapar', ''),
(6, 'Banu Keskin ', '');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `251109046_users`
--

CREATE TABLE `251109046_users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `251109046_users`
--

INSERT INTO `251109046_users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(10, 'melisa çelik ', 'melisaCk12@gmail.com', 'm12345', 'user', '2026-05-30 15:46:57');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `251109046_classes`
--
ALTER TABLE `251109046_classes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `trainer_id` (`trainer_id`);

--
-- Tablo için indeksler `251109046_trainers`
--
ALTER TABLE `251109046_trainers`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `251109046_users`
--
ALTER TABLE `251109046_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `251109046_classes`
--
ALTER TABLE `251109046_classes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Tablo için AUTO_INCREMENT değeri `251109046_trainers`
--
ALTER TABLE `251109046_trainers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Tablo için AUTO_INCREMENT değeri `251109046_users`
--
ALTER TABLE `251109046_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `251109046_classes`
--
ALTER TABLE `251109046_classes`
  ADD CONSTRAINT `251109046_classes_ibfk_1` FOREIGN KEY (`trainer_id`) REFERENCES `251109046_trainers` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
