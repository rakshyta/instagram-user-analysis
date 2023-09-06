select * from comments;
select * from follows;
select * from likes;
select * from photo_tags;
select * from photos;
select * from tags;
select * from users;

# A) Marketing: The marketing team wants to launch some campaigns, and they need your help with the following

# 1. Rewarding Most Loyal Users: People who have been using the platform for the longest time.

SELECT id, created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;

# 2. Remind Inactive Users to Start Posting: By sending them promotional emails to post their 1st photo.

SELECT id, username
FROM users
WHERE id NOT IN (SELECT DISTINCT user_id FROM photos);

select * from likes order by photo_id desc;

# 3. Declaring Contest Winner: The team started a contest and the user who gets the most likes on a single photo will win the contest now they wish to declare the winner.

SELECT p.user_id, p.id, COUNT(l.user_id) AS like_count
FROM photos AS p
JOIN likes AS l ON p.id = l.photo_id
GROUP BY p.user_id, p.id
ORDER BY like_count DESC
LIMIT 1;

# 4. Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.

SELECT t.id, t.tag_name, COUNT(pt.tag_id) AS tag_count
FROM tags AS t
JOIN photo_tags AS pt ON t.id = pt.tag_id
GROUP BY t.tag_name
ORDER BY tag_count DESC
LIMIT 5;

# 5. Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.

SELECT DAYNAME(u.created_at) AS registration_day, COUNT(*) AS registration_count
FROM users AS u
JOIN follows AS f ON u.id = f.follower_id
GROUP BY registration_day
ORDER BY registration_count DESC
LIMIT 1;

# B) Investor Metrics: Our investors want to know if Instagram is performing well and is not becoming redundant like Facebook, they want to assess the app on the following grounds

# 1. User Engagement: Are users still as active and post on Instagram or they are making fewer posts

SELECT COUNT(*) AS total_photos, COUNT(DISTINCT user_id) AS total_users, 
COUNT(*) / COUNT(DISTINCT user_id) AS average_photos_per_user
FROM photos;

# 2. Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts

SELECT user_id, COUNT(DISTINCT photo_id) AS liked_photos_count
FROM likes
GROUP BY user_id
HAVING liked_photos_count = (SELECT COUNT(DISTINCT id) FROM photos);
