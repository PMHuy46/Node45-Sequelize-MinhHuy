CREATE TABLE users (
	user_id int PRIMARY KEY AUTO_INCREMENT ,
	full_name VARCHAR(255) NOT NULL,
	emaiil VARCHAR(255) NOT NULL,
	pass_word VARCHAR(255),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE restaurent (
	res_id int PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(255) NOT NULL,
	Image VARCHAR(255),
	descs VARCHAR(255),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE food_type (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(255),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE foods (
	food_id INT PRIMARY KEY AUTO_INCREMENT,
	food_name VARCHAR(255),
	image VARCHAR(255),
	price FLOAT,
	descs VARCHAR(255),
	type_id INT,
	
	FOREIGN KEY (type_id) REFERENCES food_type(type_id),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
	
CREATE TABLE sub_food (
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	sub_name VARCHAR(255),
	sub_price FLOAT,
	food_id INT,
	
	FOREIGN KEY (food_id) REFERENCES foods(food_id),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
	
CREATE TABLE rate_res (
	rate_res_id int PRIMARY KEY AUTO_INCREMENT ,
	user_id INT,
	res_id INT,
	amount INT,
	date_rate DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	FOREIGN KEY (res_id) REFERENCES restaurent (res_id),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

CREATE TABLE like_res (
	like_res_id INT PRIMARY KEY AUTO_INCREMENT,
		user_id INT,
	res_id INT,
	date_rate DATETIME DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY (user_id) REFERENCES users (user_id),
	FOREIGN KEY (res_id) REFERENCES restaurent (res_id),

	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP

)

CREATE TABLE orders (
	order_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	food_id INT,
	amount INT,
	code VARCHAR(255),
	arr_sub_id VARCHAR(255),

	FOREIGN KEY (user_id) REFERENCES users (user_id),
	FOREIGN KEY (food_id) REFERENCES foods (food_id),
	
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)

INSERT INTO users (full_name, emaiil, pass_word) VALUES
("a1", "a1@gmail.com",1234),
("a2", "a2@gmail.com",1234),
("a3", "a3@gmail.com",1234),
("a4", "a4@gmail.com",1234),
("a5", "a5@gmail.com",1234),
("a6", "a6@gmail.com",1234),
("a7", "a7@gmail.com",1234)

INSERT INTO restaurent (res_name, Image, descs) VALUES
("res1" , "image1", "res1"),
("res2" , "image2", "res2"),
("res3" , "image3", "res3"),
("res4" , "image4", "res4"),
("res5" , "image5", "res5")

INSERT INTO rate_res (user_id,res_id,amount) VALUES
(1,1,10),
(1,2,10),
(1,3,10),
(2,2,10),
(3,3,10),
(4,2,10),
(3,2,10),
(2,3,10),
(3,5,10)

INSERT INTO like_res (user_id,res_id) VALUES
(1,1),
(1,2),
(7,3),
(2,2),
(3,3),
(4,2),
(3,2),
(6,3),
(5,5)

INSERT INTO food_type ( type_name) VALUES
("cơm"),
("bún"),
("phở"),
("nhậu")

INSERT INTO foods ( food_name, image,price,descs,type_id) VALUES
("cơm tấm","cơm tấm",10,"cơm tấm",1 ),
("cơm chiên","cơm chiên",10,"cơm chiên",1 ),
("cơm niêu","cơm niêu",10,"cơm niêu",1 ),
("bún bò","bún bò",10,"bún bò",2),
("bún riẻu","bún riẻu",10,"bún riẻu",2),
("bún thịt nướng","bún thịt nướng",10,"bún thịt nướng",2),
("phở bò" , "phở bò",10, "phở bò",3),
("nhậu 1","nhậu 1",10,"nhậu 1",4),
("nhậu 2","nhậu 2",10,"nhậu 2",4)

INSERT INTO sub_food (sub_name,sub_price,food_id) VALUES
("cơm tấm",10,1),
("cơm chiên",10,2),
("cơm niêu",10,3),
("bún bò",10,4),
("bún riẻu",10,5),
("bún thịt nướng",10,6),
("phở bò",10,7),
("nhậu 1",10,8),
("nhậu 2",10,9)

INSERT INTO orders (user_id, food_id, amount,code,arr_sub_id) VALUES
(1,1,2,"a111","a111"),
(2,1,2,"a112","a112"),
(1,2,2,"a113","a113"),
(1,3,2,"a114","a114"),
(3,4,2,"a115","a115"),
(4,2,2,"a116","a116"),
(5,1,2,"a117","a117"),
(2,2,2,"a118","a118"),
(3,7,2,"a119","a119")

SELECT users.user_id, users.full_name,COUNT(users.user_id) as "Số lượt like"
FROM users
INNER JOIN like_res on like_res.user_id = users.user_id
GROUP BY users.user_id 
ORDER BY `Số lượt like` DESC
LIMIT 5

SELECT restaurent.res_id , restaurent.res_name, COUNT(restaurent.res_id) as `Số lượt like`
FROM restaurent
INNER JOIN like_res on like_res.res_id = restaurent.res_id
GROUP BY restaurent.res_id
ORDER BY `Số lượt like` DESC
LIMIT 2

SELECT users.user_id, users.full_name, SUM(amount) as `Số lượng đặt`
FROM users
INNER JOIN orders on orders.user_id = users.user_id
GROUP BY users.user_id 
ORDER BY `Số lượng đặt` DESC
LIMIT 1

SELECT users.user_id,users.full_name,like_res.user_id,rate_res.amount,orders.amount
FROM users
LEFT JOIN like_res on like_res.user_id = users.user_id
LEFT JOIN rate_res on rate_res.user_id = users.user_id
LEFT JOIN orders on orders.user_id = users.user_id
WHERE orders.amount is NULL AND like_res.user_id is NULL AND rate_res.amount is NULL

