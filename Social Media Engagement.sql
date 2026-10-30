													-- Social Media using SQL
                                                    -- Class 1 - DDL commands
                                                    -- *Challenge 1 — Create Database*
													-- Create a database named SocialMediaDB


create database if not exists SocialMediaDB;
use SocialMediaDB;

														/**Challenge 2 — Create Table*
														Create a appusers table:*/


create table if not exists appusers(
userid int primary key,
username varchar(50),
fullname varchar(100),
email varchar(100),
createdate datetime);

desc appusers;

											-- create a temptable --tempid int datatype,tempname varchar(100)

create table if not exists temptable(
tempid int,
tempname varchar(100));

desc temptable;

											/**Challenge 3 — Alter Table*
											Add column bio (VARCHAR 255) to users.*/


alter table appusers add column bio varchar(255);

												/*Challenge 4 — Rename & Drop*
												Rename table appusers → users.*/

rename table appusers to users;
desc users;
											-- Drop a table named temp_table if it exists.

drop table temptable;

-- again check
desc temptable;

alter table users change createdate created_at datetime;

										-- Class 2 - KEYS, CONSTRAINTS, INSERT/UPDATE/DELETE
                                        
										-- *Challenge 1 — Posts Table with Constraints*



create table if not exists Posts(
	postid INT AUTO_INCREMENT,
    userid int,
    caption text,
    posted_at datetime default current_timestamp,
    
    primary key (postid),
    foreign key (userid) references users(userid)
    on delete cascade
    on update cascade);
    
    desc Posts;
    
										
										-- *Challenge 2 – Followers Table*
                                        
 create table if not exists Followers(
    followerid int,
    followingid int,
    follow_date datetime default current_timestamp,
    
    foreign key (followerid) references users(userid)
    on delete cascade
    on update cascade,
    foreign key (followingid) references users(userid)
    on delete cascade
    on update cascade);
    
      desc Followers;
    
											-- *Challenge 3 – Insert Sample Data*
                                            -- Insert 5 users and 5 posts
                                            
 insert into users (userid, username, fullname, email, created_at, bio)
 values
 (101,'Kala','Kala Ram','kala@gmail.com','2023-01-23 10:30:00','Cooking Blogger'),
 (102,'Mala','Mala Vel','mala@yahoo.com','2024-02-05 10:30:00','Yoga Trainer'),
 (103,'Varun','Varun Raj','varun@hotmail.com','2025-03-15 10:30:00','Singer'),
 (104,'Sri','Sri Ram','sri@gmail.com','2026-04-26 10:30:00','Health Coach'),
 (105,'Mathu','Mathu Sri','Mathu@hotmail.com','2026-05-25 10:30:00','Montessori Teacher');
 
 insert into posts (userid,caption,posted_at)
 values
 (101,'Creating memorable meals','2023-01-24 11:00:00'),
 (102,NULL,'2024-02-06 11:00:00'),
 (103,'Every song is a piece of my heart','2025-03-16 11:00:00'),
 (104,'Healthy habits, happy life','2026-04-27 11:00:00'),
 (105,NULL,'2026-05-26 11:00:00');
 
Select * from users;
Select * from posts;

                                -- Class 3 - DISTINCT, WHERE, IN, BETWEEN, NULL checks
                                
								-- Challenge 1 — Filter Users
                                -- Retrieve all users whose username starts with “m”
                                

 Select * from users where username like ('m%');          
 
								-- Challenge 2 — Posts Filter
								-- Get posts posted BETWEEN '2023-01-01' AND '2025-12-31'
                                
  Select * from posts where posted_at between '2023-01-01' AND '2025-12-31'; 
  
								-- Challenge 3 — NULL checks
								-- Find posts that have NULL captions
                                
 Select * from posts where caption IS NULL;   
 
								-- Challenge 4 — IN Clause
								-- Find users whose email domain is in:
								-- (@gmail.com, @hotmail.com, @yahoo.com)
                                
 Select * from users
 where email like '%@gmail.com'
	or email like '%@hotmail.com'
	or email like '%@yahoo.com';                           


											-- Class 4 social media project-ORDER BY, GROUP BY, LIMIT, HAVING
											/* Challenge 1 — Top Active Users
											• Sort users by number of posts (DESC) and LIMIT 5 */


 select * from followers;
 select * from posts;
 select * from users;
  

 
 select 
 userid,
 count(postid) as Total_Posts
 from posts
 group by userid
 order by Total_Posts DESC
 Limit 5;
 
 
 truncate table posts;
 

 insert into posts (userid,caption,posted_at)
 values
 (101,'Creating memorable meals','2023-01-24 11:00:00'),
 (102,NULL,'2024-02-06 11:00:00'),
 (103,'Every song is a piece of my heart','2025-03-16 11:00:00'),
 (104,'Healthy habits, happy life','2026-04-27 11:00:00'),
 (105,NULL,'2026-05-26 11:00:00'),
 (101,'deleciuos dinner','2023-01-25 11:00:00'),
 (103,'Melody hits','2025-03-17 11:00:00'),
 (103,'AR Rahman hits','2025-03-18 11:00:00');
 
												-- • Challenge 2 — Group by Posts Per YEAR,  Only show days with more than 1 posts (HAVING)


select
year(posted_at),
count(postid) as Total_Posts
from posts
group by
year(posted_at)
having Total_Posts>1;


-- check date wise

select
date(posted_at),
count(postid) as Total_Posts
from posts
group by date(posted_at);

																-- Class 5 -Joins
																/* challenge-JOINS, UNION, BUxILT-IN FUNCTIONS
																Challenge 1 — Comments and Likes Table */

 create table if not exists comments(
 commentid int auto_increment,
 postid int,
 userid int,
 commenttext varchar(100),
 commented_at datetime default current_timestamp,
 
 primary key (commentid),
 foreign key (postid) references posts(postid),
foreign key (userid) references users(userid)
);


 create table if not exists likes(
 likeid int auto_increment,
 postid int,
 userid int,
 liked_at datetime default current_timestamp,
 
 primary key (likeid),
 foreign key (postid) references posts(postid),
foreign key (userid) references users(userid)
);

-- insert values for comments and likes table

INSERT INTO comments (postid, userid, commenttext, commented_at)
VALUES
(1, 102, 'Looks delicious!', '2023-01-24 14:00:00'),
(1, 103, 'Amazing cooking!', '2023-01-24 14:30:00'),

(2, 101, 'Nice post!', '2024-02-06 14:00:00'),

(3, 102, 'Beautiful song!', '2025-03-16 14:00:00'),
(3, 104, 'Your voice is amazing!', '2025-03-16 14:30:00'),
(3, 105, 'Loved this song!', '2025-03-16 15:00:00'),

(4, 101, 'Great health tips!', '2026-04-27 14:00:00'),
(4, 103, 'Very useful information!', '2026-04-27 14:30:00'),

(5, 101, 'Interesting post!', '2026-05-26 14:00:00'),

(6, 102, 'The food looks tasty!', '2023-01-25 14:00:00'),
(6, 105, 'Great recipe!', '2023-01-25 14:30:00'),

(7, 104, 'Beautiful melody!', '2025-03-17 14:00:00'),
(7, 105, 'I love this song!', '2025-03-17 14:30:00'),

(8, 101, 'AR Rahman songs are amazing!', '2025-03-18 14:00:00'),
(8, 102, 'My favorite music!', '2025-03-18 14:30:00'),
(8, 105, 'Great collection!', '2025-03-18 15:00:00');

select * from comments;

INSERT INTO likes (postid, userid, liked_at)
VALUES
(1, 102, '2023-01-24 12:00:00'),
(1, 103, '2023-01-24 12:30:00'),
(1, 104, '2023-01-24 13:00:00'),

(2, 101, '2024-02-06 12:00:00'),
(2, 103, '2024-02-06 12:30:00'),

(3, 101, '2025-03-16 12:00:00'),
(3, 102, '2025-03-16 12:30:00'),
(3, 104, '2025-03-16 13:00:00'),
(3, 105, '2025-03-16 13:30:00'),

(4, 101, '2026-04-27 12:00:00'),
(4, 103, '2026-04-27 12:30:00'),

(5, 102, '2026-05-26 12:00:00'),

(6, 103, '2023-01-25 12:00:00'),
(6, 104, '2023-01-25 12:30:00'),

(7, 101, '2025-03-17 12:00:00'),
(7, 102, '2025-03-17 12:30:00'),
(7, 105, '2025-03-17 13:00:00'),

(8, 101, '2025-03-18 12:00:00'),
(8, 102, '2025-03-18 12:30:00'),
(8, 104, '2025-03-18 13:00:00');

select * from likes;

												/* Challenge 2 — JOIN Report
												Display:
												postid, username, caption, total likes, total comments. */

-- type 1
select 
p.postid,
u.username,
p.caption,
count(distinct l.likeid) as Total_likes,
count(distinct c.commentid) as Total_comments
from posts p
left join users u on u.userid = p.userid
left join likes l on l.postid = p.postid
left join comments c on c.postid = p.postid
group by
p.postid,
u.username,
p.caption;

select count(distinct likeid) as Total_likes from likes;
select count(distinct commentid) as Total_comments from comments;

-- type 2 [it ignores if any post did not receive any likes or comments row]

select 
p.postid,
u.username,
p.caption,
count(distinct l.likeid) as Total_likes,
count(distinct c.commentid) as Total_comments
from posts p
join users u on u.userid = p.userid
left join likes l on l.postid = p.postid
left join comments c on c.postid = p.postid
group by
p.postid,
u.username,
p.caption;


												-- Challenge 3 — Built-in Functions

												-- Show usernames in UPPER case.
-- method 1 [all in separate query]
select upper(username) from users;

-- Extract month name from posted_at

select posted_at,
monthname(posted_at) as Monthname
from posts;

-- Return the length of each caption

select caption,
length(caption) as captionlength
from posts;

-- method 2 [dispaly all in single query]

SELECT
    upper (u.username) AS usernameupper,
    Monthname(p.posted_at) AS monthname,
    LENGTH(p.caption) AS captionlength
FROM posts p
JOIN users u ON p.userid = u.userid;




												-- Challenge 4 — UNION
												-- Combine list of users who commented OR liked.
-- Type 1
SELECT u.userid, u.username
FROM users u
JOIN comments c
    ON u.userid = c.userid

UNION

SELECT u.userid, u.username
FROM users u
JOIN likes l
    ON u.userid = l.userid;

-- Type 2 [only display commented , liked userid]

SELECT userid
FROM comments

UNION

SELECT userid
FROM likes;

								-- Class 6 - Today's Challenge-FUNCTIONS, SUBQUERIES, STORED PROCEDURES
                          
								-- Challenge 1 — User Defined Function
                                
								/* Create a function:
								GetUserEngagement(user_id)
								Returns total likes + comments made by the user.*/


delimiter $$
create function GetUserEngagement (user_id int)
returns int
deterministic
Begin
	declare total_engagement int;
    set total_engagement = (SELECT COUNT(*) FROM likes WHERE userid = user_id)
        +
        (SELECT COUNT(*) FROM comments WHERE userid = user_id);
	RETURN total_engagement;
END $$

DELIMITER ;

-- To call

select userid, username, GetUserEngagement (userid) as total_likedandcommented_users  from users;



										/* Challenge 2 — Subquery
										Find users who have more followers than the average follower count */

insert into followers (followerid, followingid)
values
(101, 102),
(102, 105),
(103, 101),
(105, 101),
(104, 103);


										-- Find users who have more followers than the average follower count */
-- method 1
with follower_count as (
select followingid as userid, count(*) as totalcount from followers
group by followingid)
select u.username,fc.totalcount
from users u
join follower_count fc on fc.userid = u.userid
where fc.totalcount>
(
select avg(totalcount) from follower_count);


select followingid as userid, count(*) as totalcount from followers
group by followingid;

-- method 2

SELECT 
    u.userid,
    u.username,
    COUNT(f.followerid) AS follower_count
FROM users u
LEFT JOIN Followers f
    ON u.userid = f.followingid
GROUP BY u.userid, u.username
HAVING COUNT(f.followerid) > (
    SELECT AVG(follower_count)
    FROM (
        SELECT 
            followingid,
            COUNT(followerid) AS follower_count
        FROM Followers
        GROUP BY followingid
    ) AS follower_counts
);

-- method 3 correlated subquery

SELECT 
    u.userid,
    u.username
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM Followers f1
    WHERE f1.followingid = u.userid
) > (
    SELECT AVG(follower_count)
    FROM (
        SELECT COUNT(*) AS follower_count
        FROM Followers f2
        GROUP BY f2.followingid
    ) AS avg_followers
);

										-- Challenge 3 — Stored Procedure
										-- Stored procedure to retrieve all posts for a given username
                                        
                                        
delimiter //
create procedure GetPostsbyusername (IN user_name varchar(50))
Begin
	select p.postid, p.caption, u.username from posts p
	left join users u on u.userid = p.userid
	where username = user_name;

End //

delimiter ;


-- To call

call GetPostsbyusername('kala');

														--  Class 7 View & Triggers


														/* Today's challenge-VIEWS & TRIGGERS
														Challenge 1 — View
														Create a view postsummary showing:
														· postid
														· username
														· caption
														· total likes
														· total comments */



-- type 1

CREATE VIEW PostSummary AS
SELECT
    p.PostID,
    u.UserName,
    p.Caption,
    COUNT(DISTINCT l.LikeID) AS Total_Likes,
    COUNT(DISTINCT c.CommentID) AS Total_Comments
FROM posts p
JOIN users u
    ON p.UserID = u.UserID
LEFT JOIN likes l
    ON p.PostID = l.PostID
LEFT JOIN comments c
    ON p.PostID = c.PostID
GROUP BY
    p.PostID,
    u.UserName,
    p.Caption;

select * from postsummary;

-- type 2

CREATE VIEW PostSummary2 AS
SELECT
    p.PostID,
    u.UserName,
    p.Caption,
    COUNT(DISTINCT l.LikeID) AS Total_Likes,
    COUNT(DISTINCT c.CommentID) AS Total_Comments
FROM users u
JOIN posts p
    ON p.UserID = u.UserID
LEFT JOIN likes l
    ON p.PostID = l.PostID
LEFT JOIN comments c
    ON p.PostID = c.PostID
GROUP BY
    p.PostID,
    u.UserName,
    p.Caption;

select * from postsummary2;
select * from postsummary;

													/* Challenge 2 — Trigger
													Trigger on likes table:
													When a user likes a post, insert a row into a new table:
													notifications (userid, message, createdat) */


CREATE TABLE notifications (
    NotificationID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Message VARCHAR(255),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_like_notification
AFTER INSERT ON Likes
FOR EACH ROW
BEGIN
    INSERT INTO Notifications (UserID, Message, CreatedAt)
    VALUES (
        NEW.UserID,
        CONCAT('You liked Post ID ', NEW.PostID),
        NOW()
    );
END //

DELIMITER ;

-- To check
INSERT INTO likes
VALUES
(21, 2, 101, '2026-08-05'),
(22, 3, 102, '2026-08-05'),
(23, 4, 105, '2026-08-05');

select * from notifications;
















 
               
 

