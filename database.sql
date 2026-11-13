-- ========================================================
-- Game Item Shop Database Schema & Initial Data
-- Character Set: utf8mb4, Collation: utf8mb4_unicode_ci
-- ========================================================

-- --------------------------------------------------------

-- --------------------------------------------------------
CREATE TABLE `settings` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `setting_key` VARCHAR(100) NOT NULL UNIQUE,
  `setting_value` TEXT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `settings` (`setting_key`, `setting_value`) VALUES
('web_name', 'GAMESTORE.TH'),
('web_title', 'GAMESTORE.TH - ร้านจำหน่ายโค้ดเกมและไอดีเกมครบวงจร'),
('truemoney_phone', '0812345678'),
('contact_url', 'https://facebook.com');

-- --------------------------------------------------------
-- Table structure for `users`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('user', 'admin') NOT NULL DEFAULT 'user',
  `credit` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `total_topup` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `avatar` VARCHAR(255) DEFAULT 'assets/images/default-avatar.png',
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Initial users:
-- admin / admin1234 (Password hashed with BCRYPT)
-- user1 / user1234  (Password hashed with BCRYPT)
INSERT INTO `users` (`id`, `username`, `password`, `role`, `credit`, `total_topup`, `avatar`) VALUES
(1, 'admin', '$2y$10$wKqKzMekM4W9Z73h7JkRyeE42L062D71wD1V9d5gqgGzCfqGfT2eC', 'admin', 500.00, 500.00, 'assets/images/default-avatar.png'),
(2, 'user1', '$2y$10$LgA0Y876jB5L2n3pTfK07eI8yF43s9Vb1P5qL7hX2n8jV6cM4yqOu', 'user', 150.00, 200.00, 'assets/images/default-avatar.png');

-- --------------------------------------------------------
-- Table structure for `sliders` (Support 1300x400 px)
-- --------------------------------------------------------
DROP TABLE IF EXISTS `sliders`;
CREATE TABLE `sliders` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(255) NOT NULL,
  `image_url` VARCHAR(255) NOT NULL,
  `link_url` VARCHAR(255) DEFAULT '#',
  `sort_order` INT NOT NULL DEFAULT 1,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sliders` (`id`, `title`, `image_url`, `link_url`, `sort_order`, `status`) VALUES
(1, 'Grand Opening Special', 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=1300&h=400&q=80', '#', 1, 1),
(2, 'Steam Summer Sale Cards & Keys', 'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=1300&h=400&q=80', '#', 2, 1),
(3, 'Valorant Points & Skins Instant Delivery', 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?auto=format&fit=crop&w=1300&h=400&q=80', '#', 3, 1);

-- --------------------------------------------------------
-- Table structure for `categories`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(255) DEFAULT '',
  `image_url` VARCHAR(255) DEFAULT '',
  `is_recommended` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `description`, `image_url`, `is_recommended`) VALUES
(1, 'Steam Wallet & Keys', 'คีย์เกม Steam แท้และบัตรเติมเงิน Steam Wallet', 'https://images.unsplash.com/photo-1618193139062-2c5bf4f935b7?auto=format&fit=crop&w=300&h=300&q=80', 1),
(2, 'Valorant Points (VP)', 'บัตรเติมพอยต์เกม Valorant รับโค้ดทันที 24 ชม.', 'https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?auto=format&fit=crop&w=300&h=300&q=80', 1),
(3, 'RoV (Arena of Valor)', 'คูปองและแพ็กเกจสกินเกม RoV ราคาพิเศษ', 'https://images.unsplash.com/photo-1560253023-3ec5d502959f?auto=format&fit=crop&w=300&h=300&q=80', 1),
(4, 'Roblox Robux & Gift Cards', 'บัตรเติม Robux แท้ 100% ปลอดภัย ไม่โดนแบน', 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&w=300&h=300&q=80', 0);

-- --------------------------------------------------------
-- Table structure for `products`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `category_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `image_url` VARCHAR(255) DEFAULT '',
  `is_recommended` TINYINT(1) NOT NULL DEFAULT 0,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`id`, `category_id`, `name`, `description`, `price`, `image_url`, `is_recommended`) VALUES
(1, 1, 'Steam Wallet 200 บาท (THB)', 'บัตรเติมเงิน Steam Wallet 200 THB สำหรับบัญชีไทย รับรหัสทันทีหลังชำระเงิน', 200.00, 'https://images.unsplash.com/photo-1612287233207-6b45139c8742?auto=format&fit=crop&w=600&h=400&q=80', 1),
(2, 1, 'Steam Wallet 500 บาท (THB)', 'บัตรเติมเงิน Steam Wallet 500 THB คุ้มสุดๆ เติมเกมโปรดของคุณได้ทันที', 495.00, 'https://images.unsplash.com/photo-1612287233207-6b45139c8742?auto=format&fit=crop&w=600&h=400&q=80', 1),
(3, 2, 'Valorant Points 625 VP', 'โค้ดเติมเงิน Valorant 625 VP สำหรับเซิร์ฟเวอร์ประเทศไทย (TH/SEA)', 150.00, 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=600&h=400&q=80', 1),
(4, 2, 'Valorant Points 1,650 VP', 'โค้ดเติมเงิน Valorant 1,650 VP นำไปซื้อสกินปืนที่คุณชื่นชอบได้ทันที', 380.00, 'https://images.unsplash.com/photo-1542751371-adc38448a05e?auto=format&fit=crop&w=600&h=400&q=80', 1),
(5, 3, 'RoV 340 คูปอง', 'แพ็กเกจคูปอง RoV เติมได้ทันที รับรหัสบัตรการีน่าเชลล์', 100.00, 'https://images.unsplash.com/photo-1560253023-3ec5d502959f?auto=format&fit=crop&w=600&h=400&q=80', 1),
(6, 4, 'Roblox Digital Gift Card 400 Robux', 'บัตรของขวัญ Roblox รับ 400 Robux เข้าสู่บัญชีของคุณทันที', 180.00, 'https://images.unsplash.com/photo-1563089145-599997674d42?auto=format&fit=crop&w=600&h=400&q=80', 0);

-- --------------------------------------------------------
-- Table structure for `stocks` (Sub-items e.g. codes, accounts)
-- --------------------------------------------------------
DROP TABLE IF EXISTS `stocks`;
CREATE TABLE `stocks` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `product_id` INT NOT NULL,
  `item_data` TEXT NOT NULL,
  `is_sold` TINYINT(1) NOT NULL DEFAULT 0,
  `sold_to_user_id` INT NULL,
  `sold_at` DATETIME NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`sold_to_user_id`) REFERENCES `users`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample stock codes
INSERT INTO `stocks` (`product_id`, `item_data`, `is_sold`) VALUES
(1, 'STEAM-WALLET-200-ABCD-1111', 0),
(1, 'STEAM-WALLET-200-EFGH-2222', 0),
(1, 'STEAM-WALLET-200-IJKL-3333', 0),
(2, 'STEAM-WALLET-500-MNOP-4444', 0),
(2, 'STEAM-WALLET-500-QRST-5555', 0),
(3, 'VAL-625VP-SEA-AAAA-1234', 0),
(3, 'VAL-625VP-SEA-BBBB-5678', 0),
(4, 'VAL-1650VP-SEA-CCCC-9999', 0),
(5, 'GARENA-SHELL-100-THB-12345678', 0),
(5, 'GARENA-SHELL-100-THB-87654321', 0),
(6, 'ROBUX-400-CODE-XXXX-YYYY-ZZZZ', 0);

-- --------------------------------------------------------
-- Table structure for `orders`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(255) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `item_data` TEXT NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Sample completed orders
INSERT INTO `orders` (`user_id`, `product_id`, `product_name`, `price`, `item_data`, `created_at`) VALUES
(2, 5, 'RoV 340 คูปอง', 100.00, 'GARENA-SHELL-100-SAMPLE-USED-001', DATE_SUB(NOW(), INTERVAL 2 DAY));

-- --------------------------------------------------------
-- Table structure for `topup_logs`
-- --------------------------------------------------------
DROP TABLE IF EXISTS `topup_logs`;
CREATE TABLE `topup_logs` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `voucher_hash` VARCHAR(255) NOT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  `response_raw` TEXT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `topup_logs` (`user_id`, `voucher_hash`, `amount`, `status`, `created_at`) VALUES
(1, 'TEST-ADMIN-INITIAL-VOUCHER', 500.00, 'SUCCESS', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(2, 'TEST-USER1-INITIAL-VOUCHER', 200.00, 'SUCCESS', DATE_SUB(NOW(), INTERVAL 3 DAY));
