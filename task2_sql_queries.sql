-- create Receipt table
CREATE TABLE Receipt (
    _id VARCHAR(50) PRIMARY KEY,
    bonusPointsEarned INT,
    bonusPointsEarnedReason VARCHAR(255),
    createDate TIMESTAMP,
    dateScanned TIMESTAMP,
    finishedDate TIMESTAMP,
    modifyDate TIMESTAMP,
    pointsAwardedDate TIMESTAMP,
    pointsEarned DECIMAL(10,2),
    purchaseDate TIMESTAMP,
    purchasedItemCount INT,
    rewardsReceiptStatus VARCHAR(50),
    totalSpent DECIMAL(10,2),
    userId VARCHAR(50)
);

-- create ReceiptItem table (corresponds to rewardsReceiptItemList field)
CREATE TABLE ReceiptItem (
    receipt_id VARCHAR(50), -- Foreign key from the Receipt table
    barcode VARCHAR(50),
    description VARCHAR(255),
    finalPrice DECIMAL(10,2),
    itemPrice DECIMAL(10,2),
    quantityPurchased INT,
    partnerItemId VARCHAR(50),
    userFlaggedPrice DECIMAL(10,2),
    userFlaggedBarcode VARCHAR(255),
    preventTargetGapPoints INT,
    needsFetchReview BOOLEAN,
    needsFetchReviewReason VARCHAR(255),
    userFlaggedQuantity INT,
    userFlaggedNewItem BOOLEAN,
    userFlaggedDescription VARCHAR(255),
    pointsNotAwardedReason VARCHAR(255),
    pointsPayerID VARCHAR(50),
    rewardsGroup VARCHAR(255),
    rewardsProductPartnerID VARCHAR(50),
    partnerID VARCHAR(50),
    
    FOREIGN KEY (receipt_id) REFERENCES Receipt(_id) -- Identifying relationship
);

-- create Brands table
CREATE TABLE Brands (
	_id VARCHAR(50) PRIMARY KEY,
    barcode VARCHAR(255),
    brandCode VARCHAR(255),
    category VARCHAR(255),
    categoryCode VARCHAR(255),
    cpg_ref VARCHAR(255),
    cpg_id VARCHAR(50),
    topBrand BOOLEAN,
    name VARCHAR(255)
);

-- create Users table
CREATE TABLE Users (
	_id VARCHAR(50) PRIMARY KEY,
    state VARCHAR(255),
    createdDate TIMESTAMP,
    lastLogin TIMESTAMP,
    signupSource VARCHAR(255),
    role VARCHAR(255) DEFAULT "CONSUMER",
    active BOOLEAN
);


-- Insert into Receipt table
INSERT INTO Receipt (_id, bonusPointsEarned, bonusPointsEarnedReason, createDate, dateScanned, finishedDate, modifyDate, pointsAwardedDate, pointsEarned, purchaseDate, purchasedItemCount, rewardsReceiptStatus, totalSpent, userId)
VALUES
('5ff1e1bb0a720f052300056c', 150, 'Receipt number 5 completed, bonus point schedule DEFAULT (5cefdcacf3693e0b50e83a36)', '2021-01-03 00:24:43', '2021-01-03 00:24:43', '2021-01-03 00:24:43', '2021-01-03 00:24:48', '2021-01-03 00:24:43', 150.0, '2021-01-02 00:11:23', 2, 'Rejected', 12.00, '5ff1e194b6a9d73a3a9f1052'),
('5ff1e1bb0a720f052300056d', 150, 'Receipt number 5 completed, bonus point schedule DEFAULT (5cefdcacf3693e0b50e83a36)', '2021-01-03 00:24:43', '2021-01-03 00:24:43', '2021-01-03 00:24:43', '2021-01-03 00:24:48', '2021-01-03 00:24:43', 150.0, '2021-01-02 00:11:23', 2, 'Accepted', 11.00, '5ff1e194b6a9d73a3a9f1052'),
('5ff1e1bb0a720f052300056b', 150, 'Receipt number 5 completed, bonus point schedule DEFAULT (5cefdcacf3693e0b50e83a36)', '2021-01-03 00:24:43', '2021-01-03 00:24:43', '2021-01-03 00:24:43', '2021-01-03 00:24:48', '2021-01-03 00:24:43', 150.0, '2021-01-02 00:11:23', 2, 'FINISHED', 11.00, '5ff1e194b6a9d73a3a9f1052'),
('5ff1e1f10a720f052300057a', 5, 'All-receipts receipt bonus', '2021-01-03 00:25:37', '2021-01-03 00:25:37', NULL, '2021-01-03 00:25:42', NULL, 5.0, '2021-01-02 00:00:00', 1, 'REJECTED', 10.00, '5ff1e1f1cfcf6c399c274b0b'),
('5ff1e1ee0a7214ada100056f', 5, 'All-receipts receipt bonus', '2021-01-03 00:25:34', '2021-01-03 00:25:34', '2021-01-03 00:25:34', '2021-01-03 00:25:39', '2021-01-03 00:25:34', 5.0, '2021-01-02 00:00:00', 4, 'FINISHED', 28.00, '5ff1e1eacfcf6c399c274ae6'),
('5ff1e1d20a7214ada1000561', 5, 'All-receipts receipt bonus', '2021-01-03 00:25:06', '2021-01-03 00:25:06', '2021-01-03 00:25:11', '2021-01-03 00:25:11', '2021-01-03 00:25:06', 5.0, '2021-01-02 00:11:46', 2, 'FINISHED', 1.00, '5ff1e194b6a9d73a3a9f1052');


-- Insert into ReceiptItem table (linked to the respective receipt via `receipt_id`)

INSERT INTO ReceiptItem (receipt_id, barcode, description, finalPrice, itemPrice, partnerItemId, quantityPurchased, needsFetchReview, needsFetchReviewReason, pointsNotAwardedReason, pointsPayerId, rewardsGroup, rewardsProductPartnerId, userFlaggedBarcode, userFlaggedDescription, userFlaggedNewItem, userFlaggedPrice, userFlaggedQuantity)
VALUES
('5ff1e1bb0a720f052300056b', '4011', 'ITEM NOT FOUND', 1.00, 1.00, '1', 1, false, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL, NULL),
('5ff1e1bb0a720f052300056b', '028400642255', 'DORITOS TORTILLA CHIP SPICY SWEET CHILI REDUCED FAT BAG 1 OZ', 10.00, 10.00, '2', 1, true, 'USER_FLAGGED', 'Action not allowed for user and CPG', '5332f5fbe4b03c9a25efd0ba', 'DORITOS SPICY SWEET CHILI SINGLE SERVE', '5332f5fbe4b03c9a25efd0ba', '028400642255', 'DORITOS TORTILLA CHIP SPICY SWEET CHILI REDUCED FAT BAG 1 OZ', true, 10.00, 1),
('5ff1e1f10a720f052300057a', NULL, NULL, NULL, NULL, '1', 3, false, NULL, NULL, NULL, NULL, NULL, '4011', NULL, true, 26.00, 3),
('5ff1e1ee0a7214ada100056f', '4011', 'ITEM NOT FOUND', 28.00, 28.00, '1', 4, false, NULL, NULL, NULL, NULL, NULL, '4011', NULL, true, 28.00, 4),
('5ff1e1d20a7214ada1000561', '4011', 'ITEM NOT FOUND', 1.00, 1.00, '1', 1, false, NULL, NULL, NULL, NULL, NULL, '4011', NULL, true, 1.00, 1),
('5ff1e1d20a7214ada1000561', '1234', NULL, 2.56, 2.56, '2', 3, true, 'USER_FLAGGED', NULL, NULL, NULL, NULL, '1234', '', true, 2.56, 3);


-- Insert into Users table
INSERT INTO Users (_id, active, createdDate, lastLogin, role, signUpSource, state)
VALUES
('5ff1e194b6a9d73a3a9f1052', true, '2021-01-03 00:24:04', '2021-01-03 00:25:37', 'consumer', 'Email', 'WI'),
('5ff1e1eacfcf6c399c274ae6', true, '2021-01-03 00:25:30', '2021-01-03 00:25:30', 'consumer', 'Email', 'WI'),
('5ff1e1e8cfcf6c399c274ad9', true, '2021-01-03 00:25:28', '2021-01-03 00:25:28', 'consumer', 'Email', 'WI'),
('5ff1e1b7cfcf6c399c274a5a', true, '2021-01-03 00:24:40', '2021-01-03 00:24:40', 'consumer', 'Email', 'WI'),
('5ff1e1f1cfcf6c399c274b0b', true, '2021-01-03 00:25:37', '2021-01-03 00:25:37', 'consumer', 'Email', 'WI'),
('5ff1e1e4cfcf6c399c274ac3', true, '2021-01-03 00:25:24', '2021-01-03 00:25:24', 'consumer', 'Email', 'WI'),
('5ff1e1b4cfcf6c399c274a54', true, '2021-01-03 00:24:36', '2021-01-03 00:24:36', 'consumer', 'Email', 'WI');



-- Insert into Brands table
INSERT INTO Brands (_id, barcode, brandCode, category, categoryCode, cpg_ref, cpg_id, name, topBrand)
VALUES
('601ac115be37ce2ead437551', '511111019862', NULL, 'Baking', 'BAKING', 'Cogs', '601ac114be37ce2ead437550', 'test brand @1612366101024', false),
('601c5460be37ce2ead43755f', '511111519928', 'STARBUCKS', 'Beverages', 'BEVERAGES', 'Cogs', '5332f5fbe4b03c9a25efd0ba', 'Starbucks', false),
('601ac142be37ce2ead43755d', '511111819905', 'TEST BRANDCODE @1612366146176', 'Baking', 'BAKING', 'Cogs', '601ac142be37ce2ead437559', 'test brand @1612366146176', false),
('601ac142be37ce2ead43755a', '511111519874', 'TEST BRANDCODE @1612366146051', 'Baking', 'BAKING', 'Cogs', '601ac142be37ce2ead437559', 'test brand @1612366146051', false),
('601ac142be37ce2ead43755e', '511111319917', 'TEST BRANDCODE @1612366146827', 'Candy & Sweets', 'CANDY_AND_SWEETS', 'Cogs', '5332fa12e4b03c9a25efd1e7', 'test brand @1612366146827', false),
('601ac142be37ce2ead43755b', '511111719885', 'TEST BRANDCODE @1612366146091', 'Baking', 'BAKING', 'Cogs', '601ac142be37ce2ead437559', 'test brand @1612366146091', false),
('601ac142be37ce2ead43755c', '511111219897', 'TEST BRANDCODE @1612366146133', 'Baking', 'BAKING', 'Cogs', '601ac142be37ce2ead437559', 'test brand @1612366146133', false),
('5cdad0f5166eb33eb7ce0faa', '511111104810', 'J.L. KRAFT', 'Condiments & Sauces', NULL, 'Cogs', '559c2234e4b06aca36af13c6', 'J.L. Kraft', NULL),
('5ab15636e4b0be0a89bb0b07', '511111504412', 'CAMPBELLS HOME STYLE', 'Canned Goods & Soups', NULL, 'Cogs', '5a734034e4b0d58f376be874', 'Campbell\'s Home Style', false),
('5c408e8bcd244a1fdb47aee7', '511111504788', 'TEST', 'Baking', NULL, 'Cogs', '59ba6f1ce4b092b29c167346', 'test', NULL),
('5f4bf556be37ce0b4491554d', '511111516354', 'TEST BRANDCODE @1598813526777', 'Baking', 'BAKING', 'Cogs', '5f4bf556be37ce0b44915549', 'test brand @1598813526777', false),
('57c08106e4b0718ff5fcb02c', '511111102540', NULL, 'Baking', NULL, 'Cogs', '5332f5f2e4b03c9a25efd0aa', 'MorningStar', NULL),
('588ba07be4b02187f85cdadd', '511111201076', 'CALUMET', 'Baking', NULL, 'Cogs', '559c2234e4b06aca36af13c6', 'Calumet', false),
('5d6413156d5f3b23d1bc790a', '511111205012', '511111205012', 'Magazines', NULL, 'Cogs', '5d5d4fd16d5f3b23d1bc7905', 'Entertainment Weekly', NULL),
('585a9611e4b03e62d1ce0e74', '511111801801', 'AUNT JEMIMA SYRUP', 'Breakfast & Cereal', NULL, 'Cogs', '5332f5fbe4b03c9a25efd0ba', 'AUNT JEMIMA Syrup', false),
('57e5820ce4b0ac389136a311', '511111202233', 'MOLSON', 'Beer Wine Spirits', NULL, 'Cogs', '5332f709e4b03c9a25efd0f1', 'Molson Canadian', false),
('5fb6adb8be37ce522e165cb8', '511111817376', 'LOTRIMIN', 'Health & Wellness', 'HEALTHY_AND_WELLNESS', 'Cogs', '5d9b4f591dda2c6225a284aa', 'Lotrimin®', false),
('5f358338be37ce443bf9d55a', '511111515319', 'TEST BRANDCODE @1597342520277', 'Baking', 'BAKING', 'Cogs', '5f358338be37ce443bf9d557', 'test brand @1597342520277', false),
('5fb28549be37ce522e165cb5', '511111317364', NULL, 'Baking', 'BAKING', 'Cogs', '5fb28549be37ce522e165cb4', 'test brand @1605535049181', false),
('592486bfe410d61fcea3d139', '511111300700', 'ST IVES', 'Beauty', NULL, 'Cogs', '5332f5f6e4b03c9a25efd0b4', 'ST. IVES', false);

-- Task 2, Q1

-- Q: Top 5 brands by receipts scanned for most recent month
SELECT sq2.name
FROM 
	(SELECT sq.barcode, b.name, RANK() OVER(ORDER BY num_purchases) as purchase_rank
	FROM 
		(SELECT receipt_id, barcode, COUNT(*) AS num_purchases 
		FROM ReceiptItem ri
		JOIN Receipt r
		ON ri.receipt_id = r._id
		WHERE r.dateScanned >= (SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH))
		GROUP BY barcode) sq
	JOIN Brands b 
	ON b.barcode = sq.barcode) sq2
WHERE purchase_rank <= 5;


-- Q: Comparing top 5 scanned brands from 1 month and 2 months ago
SELECT sq2.name
FROM 
	(SELECT sq.barcode, b.name, RANK() OVER(PARTITION BY sq.scanMonth ORDER BY num_purchases) as purchase_rank
	FROM 
		(SELECT receipt_id, barcode, EXTRACT(MONTH FROM dateScanned) as scanMonth, COUNT(*) AS num_purchases 
		FROM ReceiptItem ri
		JOIN Receipt r
		ON ri.receipt_id = r._id
		WHERE r.dateScanned >= (SELECT DATE_SUB(CURDATE(), INTERVAL 2 MONTH)) 
        AND r.dateScanned <= (SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) 
		GROUP BY barcode) sq
	JOIN Brands b 
	ON b.barcode = sq.barcode) sq2
WHERE purchase_rank <= 5;


-- Q: Average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’
SELECT 
	rewardsReceiptStatus,
	AVG(totalSpent) as avgSpend
FROM Receipt
WHERE rewardsReceiptStatus IN ("Accepted", "Rejected")
GROUP BY rewardsReceiptStatus
ORDER BY avgSpend DESC;


-- Q: Total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’ 
SELECT
	rewardsReceiptStatus,
	COUNT(*) as totalNumItems
FROM Receipt r 
JOIN ReceiptItem ri
WHERE rewardsReceiptStatus IN ("Accepted", "Rejected")
GROUP BY rewardsReceiptStatus
ORDER BY totalNumItems DESC;


-- Q: Brand with highest spend amongst users who created their profile within the last 6 months
SELECT
	b.name as brandName,
	SUM(itemPrice) as totalBrandSpend
FROM Receipt r
JOIN ReceiptItem ri ON r._id = ri.receipt_id
JOIN Brands b ON b.barcode = ri.barcode
JOIN Users u ON r.userId = u._id
WHERE u.createdDate >= (SELECT DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
GROUP BY b.name
ORDER BY totalBrandSpend DESC
LIMIT 1;


-- Q: Brand with most transactions amongst users who created their profile within the last 6 months
SELECT 
	b.name as brandName,
	COUNT(b.barcode) as numTransactions
FROM Receipt r 
JOIN ReceiptItem ri ON r._id = ri.receipt_id
JOIN Brands b ON b.barcode = ri.barcode
JOIN Users u ON r.userId = u._id
WHERE u.createdDate >= (SELECT DATE_SUB(CURDATE(), INTERVAL 6 MONTH))
GROUP BY b.name
ORDER BY numTransactions DESC
LIMIT 1;








