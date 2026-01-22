/* Write an SQL query to find for each seller, 
whether the brand of the item(by date) they sold is their favourite brand.
If a seller sold less than two items, report the answer for that seller as 'No'
Output:-
seller_id 2nd_item_fav_brand
1              yes/no
2              yes/no
*/

USE DaysOfSQL;

DROP TABLE IF EXISTS users;
create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

DROP TABLE IF EXISTS orders;
 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);

 SELECT * FROM orders;
 SELECT * FROM users;
 SELECT * FROM items;



WITH ranked_orders AS(
    SELECT  
    order_id, order_date, item_id, seller_id,
    RANK() OVER(PARTITION BY seller_id ORDER BY order_date) AS rn
    FROM orders 
)

    SELECT 
    s.user_id as seller_id,
    CASE WHEN s.favorite_brand = i.item_brand THEN 'Yes' ELSE 'No' END AS second_item_fav_brand
    FROM users s
    LEFT JOIN ranked_orders ro ON  s.user_id = ro.seller_id AND rn=2
    LEFT JOIN items i ON ro.item_id = i.item_id









