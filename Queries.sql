USE stranger_explorer;

-- 1. All trips created by a user
SELECT * FROM trips WHERE user_id = 1;

-- 2. All users in a trip
SELECT u.full_name
FROM trip_participants tp
JOIN users u ON tp.user_id = u.user_id
WHERE tp.trip_id = 1;

-- 3. All trips a user joined
SELECT DISTINCT t.destination
FROM trips t
JOIN trip_participants tp ON t.trip_id = tp.trip_id
WHERE tp.user_id = 1;

-- 4. All messages in a trip with sender
SELECT u.full_name, m.text, m.sent_at
FROM messages m
JOIN users u ON m.sender_id = u.user_id
WHERE m.trip_id = 1
ORDER BY m.sent_at;

-- 5. Reviews for a trip
SELECT u.full_name, r.rating, r.comments
FROM reviews r
JOIN users u ON r.reviewer_id = u.user_id
WHERE r.trip_id = 1;

-- 6. All reviews written by a user
SELECT r.*, t.destination
FROM reviews r
JOIN trips t ON r.trip_id = t.trip_id
WHERE r.reviewer_id = 1;

-- 7. Trip popularity
SELECT t.destination, COUNT(tp.user_id) AS participants
FROM trips t
LEFT JOIN trip_participants tp ON t.trip_id = tp.trip_id
GROUP BY t.destination
ORDER BY participants DESC;

-- 8. Top rated trips
SELECT t.destination, AVG(r.rating) AS avg_rating
FROM trips t
JOIN reviews r ON t.trip_id = r.trip_id
GROUP BY t.trip_id, t.destination
ORDER BY avg_rating DESC;

-- 9. Matches for a user
SELECT u2.full_name, m.status, t.destination
FROM matches m
JOIN users u1 ON m.user1_id = u1.user_id
JOIN users u2 ON m.user2_id = u2.user_id
JOIN trips t ON m.trip_id = t.trip_id
WHERE u1.user_id = 1 OR u2.user_id = 1;
