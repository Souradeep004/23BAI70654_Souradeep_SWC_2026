----Q1

CREATE TABLE transactions
(
transaction_id INT PRIMARY KEY,
merchant_id INT,
credit_card_id INT,
amount INT,
transaction_timestamp TIMESTAMP
);
INSERT INTO transactions
VALUES
(1, 101, 1, 100, '2022-09-25 12:00:00'),
(2, 101, 1, 100, '2022-09-25 12:08:00'),
(3, 101, 1, 100, '2022-09-25 12:28:00'),
(4, 102, 2, 300, '2022-09-25 12:00:00'),
(6, 102, 2, 400, '2022-09-25 14:00:00');


select * from transactions;

select
count(*) as payment_count
from transactions t INNER JOIN transactions c
ON 
	t.merchant_id = c.merchant_id
	AND t.credit_card_id = c.credit_card_id
	AND t.amount = c.amount
	AND t.transaction_timestamp > c.transaction_timestamp
WHERE
	t.transaction_timestamp :: TIME - c.transaction_timestamp :: TIME <= '00:10:00' :: TIME
GROUP BY 
	t.merchant_id
;





-----Q2

CREATE TABLE user_actions
(
user_id INT,
event_id INT,
event_type VARCHAR(20),
event_date TIMESTAMP
);
INSERT INTO user_actions
VALUES
(445, 7765, 'sign-in', '2022-06-05 12:00:00'),
(742, 6458, 'sign-in', '2022-06-10 12:00:00'),
(648, 3124, 'like', '2022-06-18 12:00:00'),
(445, 3634, 'like', '2022-07-05 12:00:00'),
(742, 1374, 'comment', '2022-07-15 12:00:00'),
(999, 5555, 'sign-in', '2022-07-20 12:00:00');



select * from user_actions;


select
*,
count(*) as monthly_active_user
from user_actions u 
WHERE
	u.user_id in (
		select
		ui.user_id
		from user_actions ui
		WHERE
			ui.user_id = u.user_id
			AND ui.event_type :: DATE <= '2026-07-01'
	)
GROUP BY user_id, event_type, event_date, event_id
;




-----Q3

CREATE TABLE Submissions (
sub_id INT,
parent_id INT
);
INSERT INTO Submissions (sub_id, parent_id) VALUES
(1, NULL),
(2, NULL),
(1, NULL),
(12, NULL),
(3, 1),
(5, 2),
(3, 1),
(4, 1),
(9, 1),
(10, 2),
(6, 7);


select * from Submissions;


select
s.sub_id post_id,
count(*) number_of_comments
from submissions s INNER JOIN submissions p
ON s.sub_id = p.parent_id
GROUP BY s.sub_id 
ORDER BY number_of_comments
;





