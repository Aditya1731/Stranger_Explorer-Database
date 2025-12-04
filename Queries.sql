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


-- JOIN DATA RETRIEVAL
1) List all records showing every trip and its related owner/creator.
==  SELECT T.*,U.USER_ID,U.FULL_NAME 
FROM TRIPS T INNER JOIN USERS U 
ON U.USER_ID=T.CREATOR_ID;




2) Show all trips along with any associated participants.
SELECT TP.*,TR.DESTINATION,U.FULL_NAME 
FROM TRIP_PARTICIPANTS TP INNER JOIN TRIPS TR 
ON TP.TRIP_ID=TR.TRIP_ID 
INNER JOIN USERS U ON 
U.USER_ID=TP.USER_ID;




3)Find all trips that have no associated participants.
=SELECT TR.* 
FROM TRIPS TR 
WHERE TRIP_ID NOT IN(SELECT TRIP_ID FROM TRIP_PARTICIPANTS);




4) List all records with their related messages.
=SELECT TP.TRIP_ID,U.FULL_NAME,TR.DESTINATION,M.*
 FROM TRIP_PARTICIPANTS TP
 INNER JOIN MESSAGES M
 ON TP.TRIP_ID=M.TRIP_ID
INNER JOIN USERS U
ON M.SENDER_ID=U.USER_ID
INNER JOIN TRIPS TR
ON TR.TRIP_ID=M.TRIP_ID





5)Show all messages along with the sender details.
=SELECT M.*,U.*
FROM MESSAGES M INNER JOIN USERS U
ON M.SENDER_ID=U.USER_ID;





6)Find all TRIPS that have no messages.
 SELECT TR.*
 FROM TRIPS TR
 WHERE TRIP_ID NOT IN(SELECT TRIP_ID FROM MESSAGES);




7)List all TRIPS along with reviews, if any.
=SELECT TR.*,R.*
FROM TRIPS TR LEFT OUTER JOIN REVIEWS R
ON TR.TRIP_ID=R.TRIP_ID;





8)Show reviews along with the reviewer details.
=SELECT R.COMMENTS,U.*
FROM REVIEWS R INNER JOIN USERS U
ON R.REVIEWER_ID=U.USER_ID;




9)Find TRIPS that have no reviews.
=SELECT T.* 
FROM TRIPS T
WHERE TRIP_ID NOT IN(SELECT TRIP_ID FROM REVIEWS);



10)Count the number of participants for each TRIP.
=SELECT COUNT(*),TP.TRIP_ID,TR.DESTINATION
FROM TRIP_PARTICIPANTS TP INNER JOIN TRIPS TR
ON TP.TRIP_ID=TR.TRIP_ID
GROUP BY TP.TRIP_ID,TR.DESTINATION



11)Count the number of messages for each TRIP.
= SELECT COUNT(*),M.TRIP_ID,TR.DESTINATION
 FROM MESSAGES M INNER JOIN TRIPS TR
 ON M.TRIP_ID=TR.TRIP_ID
 GROUP BY M.TRIP_ID,TR.DESTINATION;



12)Count the number of reviews for each TRIP.
= SELECT COUNT(*),R.TRIP_ID,TR.DESTINATION
 FROM REVIEWS R INNER JOIN TRIPS TR
 ON R.TRIP_ID=TR.TRIP_ID
 GROUP BY R.TRIP_ID,TR.DESTINATION




13)List all TRIPS along with their participants and messages.
= SELECT TR.DESTINATION,U.FULL_NAME,M.MESSAGE_TEXT
 FROM TRIP_PARTICIPANTS TP INNER JOIN TRIPS TR
 ON TP.TRIP_ID=TR.TRIP_ID
 INNER JOIN USERS U ON U.USER_ID=TP.USER_ID
 INNER JOIN MESSAGES M ON M.TRIP_ID=TP.TRIP_ID




14)Show all TRIPS with participants and reviews.
= SELECT
 TR.TRIP_ID,TR.DESTINATION,TR.ESTIMATED_COST,AVG(R.RATING),COUNT(DISTINCT TP.USER_ID) AS TOTAL_COUNT
 FROM TRIPS TR
 INNER JOIN REVIEWS R ON TR.TRIP_ID=R.TRIP_ID
 INNER JOIN TRIP_PARTICIPANTS TP ON TP.TRIP_ID=TR.TRIP_ID
 GROUP BY TR.TRIP_ID,TR.DESTINATION,TR.ESTIMATED_COST






15) Show all TRIPS with messages and reviews.
= SELECT TR.TRIP_ID,TR.DESTINATION,TR.ESTIMATED_COST,M.MESSAGE_TEXT,R.COMMENTS,AVG(R.RATING)
FROM TRIPS TR
INNER JOIN MESSAGES M ON TR.TRIP_ID=M.TRIP_ID
INNER JOIN REVIEWS R ON TR.TRIP_ID=R.TRIP_ID
GROUP BY TR.TRIP_ID,TR.DESTINATION,TR.ESTIMATED_COST,M.MESSAGE_TEXT,R.COMMENTS




16)Display all TRIPS along with participants, messages, and reviews.
= SELECT TR.TRIP_ID,TR.DESTINATION,TP.USER_ID,M.MESSAGE_TEXT,R.COMMENTS
 FROM TRIPS TR
 LEFT OUTER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID
 LEFT OUTER JOIN MESSAGES M ON M.TRIP_ID=TR.TRIP_ID
 LEFT OUTER JOIN REVIEWS R ON R.TRIP_ID=TR.TRIP_ID
 GROUP BY TR.TRIP_ID,TR.DESTINATION,TP.USER_ID,M.MESSAGE_TEXT,R.COMMENTS;





17)List all records showing TRIPS and the number of participants who joined.
=SELECT TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE,COUNT(DISTINCT TP.USER_ID) AS TOTOAL_COUNT 
FROM TRIPS TR 
INNER JOIN TRIP_PARTICIPANTS TP 
ON TR.TRIP_ID=TP.TRIP_ID 
GROUP BY TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE;






18)List all records showing TRIPS and the number of messages sent.
=SELECT TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE,COUNT(M.MESSAGE_TEXT)
FROM TRIPS TR LEFT OUTER JOIN MESSAGES M
ON TR.TRIP_ID=M.TRIP_ID
GROUP BY TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE
ORDER BY TR.TRIP_ID



19)Show all TRIPS with the total rating and average rating of reviews.
= SELECT TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE,SUM(R.RATING) AS TOTAL_RATING,AVG(R.
 FROM TRIPS TR LEFT OUTER JOIN REVIEWS R
 ON TR.TRIP_ID=R.TRIP_ID
 GROUP BY TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE
 ORDER BY TR.TRIP_ID;




20)List all participants along with the TRIPS they joined.
= SELECT TP.PARTICIPANT_ID,TP.TRIP_ID,TR.DESTINATION,U.FULL_NAME
 FROM TRIP_PARTICIPANTS TP INNER JOIN TRIPS TR ON TP.TRIP_ID=TR.TRIP_ID
 INNER JOIN USERS U ON TP.USER_ID=U.USER_ID
 ORDER BY TP.TRIP_ID;



21)Show all participants who have not joined any TRIPS.
=SELECT U.FULL_NAME,U.USER_ID 
FROM USERS U 
WHERE USER_ID NOT IN(SELECT USER_ID FROM TRIP_PARTICIPANTS);



22)Find all participants and trips where certain conditions are met (e.g., cost > X).
= SELECT TP.*,TR.DESTINATION,TR.START_DATE,TR.END_DATE,TR.ESTIMATED_COST
 FROM TRIP_PARTICIPANTS TP INNER JOIN TRIPS TR
 ON TP.TRIP_ID=TR.TRIP_ID
 WHERE TR.ESTIMATED_COST>1800;




23)List all records showing matches and the related individuals.
= SELECT 
    U.USER_ID,
    U.FULL_NAME,
    COUNT(DISTINCT M.MATCH_ID) AS TOTAL_MATCHES
FROM USERS U
LEFT JOIN MATCHES M 
    ON U.USER_ID IN (M.USER1_ID, M.USER2_ID)
GROUP BY U.USER_ID, U.FULL_NAME
ORDER BY U.USER_ID;





24)Count the number of matches each individual is involved in.
=SELECT U.USER_ID,U.FULL_NAME,COUNT(M.MATCH_ID)
 FROM USERS U 
LEFT OUTER JOIN MATCHES M 
ON U.USER_ID IN (M.USER1_ID,M.USER2_ID) 
GROUP BY U.USER_ID,U.FULL_NAME 
ORDER BY U.USER_ID;





25)Show all matches along with related TRIPs.

= SELECT M.*,TR.DESTINATION,TR.START_DATE,TR.END_DATE
 FROM MATCHES M INNER JOIN TRIPS TR ON M.TRIP_ID=TR.TRIP_ID
 ORDER BY M.TRIP_ID;





26)Display all records showing messages with TRIP details and sender details.
=SELECT M.*,TR.DESTINATION,TR.START_DATE,TR.END_DATE,U.FULL_NAME
FROM MESSAGES M INNER JOIN TRIPS TR ON M.TRIP_ID=TR.TRIP_ID
INNER JOIN USERS U ON M.SENDER_ID = U.USER_ID;





27)List TRIPS along with creator, participants, and highest-rated review.
=  1  SELECT TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE,TR.CREATOR_ID,TP.USER_ID,U.FULL_NAME
  2  FROM TRIPS TR INNER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID
  3  INNER JOIN REVIEWS R ON TR.TRIP_ID=R.TRIP_ID
  4  INNER JOIN USERS U ON TR.CREATOR_ID=U.USER_ID
  5  GROUP BY TR.TRIP_ID,TR.DESTINATION,TR.START_DATE,TR.END_DATE,TR.CREATOR_ID,TP.USER_ID,U.FULL_NA
  6* ORDER BY TR.TRIP_ID
SQL> /

   TRIP_ID DESTINATION                    START_DAT END_DATE  CREATOR_ID    USER_ID FULL_NAME                           MAX(R.RATING)
---------- ------------------------------ --------- --------- ---------- ---------- ----------------
         1 Paris                          01-JUL-25 10-JUL-25          1          1 Alice Johnson                                   9
         1 Paris                          01-JUL-25 10-JUL-25          1          2 Alice Johnson                                   9
         1 Paris                          01-JUL-25 10-JUL-25          1          3 Alice Johnson                                   9
         2 London                         05-AUG-25 12-AUG-25          2          1 Bob Smith                                       7
         2 London                         05-AUG-25 12-AUG-25          2          2 Bob Smith                                       7
         3 Tokyo                          10-SEP-25 20-SEP-25          3          3 Carol Davis                                    10
         3 Tokyo                          10-SEP-25 20-SEP-25          3          5 Carol Davis                                    10
         4 Rome                           01-OCT-25 08-OCT-25          1          1 Alice Johnson                                   6
         4 Rome                           01-OCT-25 08-OCT-25          1          5 Alice Johnson                                   6

9 rows selected.










28)Find TRIPS and participants where certain TRIPS have no reviews.
=    SELECT 
     TR.TRIP_ID,
     TR.DESTINATION,
     TP.USER_ID,
     R.RATING
 FROM REVIEWS R
 LEFT OUTER JOIN TRIPS TR ON R.TRIP_ID = TR.TRIP_ID
 LEFT OUTER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID = TP.TRIP_ID;






29)List all TRIPS along with messages and participants, but only for a specific condition.
=
 SELECT TR.*,M.MESSAGE_TEXT,TP.USER_ID,U.FULL_NAME
 FROM TRIPS TR INNER JOIN MESSAGES M ON TR.TRIP_ID=M.TRIP_ID
 INNER JOIN TRIP_PARTICIPANTS TP ON TP.TRIP_ID=TR.TRIP_ID
 INNER JOIN USERS U ON U.USER_ID=TP.USER_ID
 WHERE ESTIMATED_COST>1800;



30)Show all TRIPS along with participants who joined, including TRIPS with no participants.
= SELECT TR.*,TP.USER_ID
 FROM TRIPS TR LEFT OUTER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID;





31)List all records where a participant and creator are the same person.
	=SELECT TR.*,TP.TRIP_ID,U.USER_ID
 FROM TRIPS TR INNER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID
 INNER JOIN USERS U ON TP.USER_ID=U.USER_ID
 WHERE TR.CREATOR_ID=TP.USER_ID;






32)Display all TRIPS where messages were sent by participants only.
= SELECT TP.TRIP_ID,TR.DESTINATION,M.MESSAGE_TEXT
 FROM TRIPS TR INNER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID
 INNER JOIN MESSAGES M ON TP.TRIP_ID=M.TRIP_ID;




33)Find all TRIPS that have participants but no reviews.
=33RD SELECT TR.*,TP.USER_ID 
FROM TRIPS TR 
INNER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID
 WHERE TR.TRIP_ID NOT IN(SELECT TRIP_ID FROM REVIEWS);





34)List all TRIPS along with reviews and participants, including items with no participants.
=SELECT 
    TR.TRIP_ID,
    TR.DESTINATION,
    TR.START_DATE,
    TR.END_DATE,
    TR.ESTIMATED_COST,
    R.RATING,
    TP.USER_ID
FROM TRIPS TR
LEFT OUTER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID = TP.TRIP_ID
LEFT OUTER JOIN REVIEWS R ON TR.TRIP_ID = R.TRIP_ID;




35)Show all TRIPS and messages including TRIPS with no messages or participants.
= SELECT TR.*,M.*,TP.USER_ID
 FROM TRIPS TR
 LEFT OUTER JOIN MESSAGES M ON TR.TRIP_ID=M.TRIP_ID
 LEFT OUTER JOIN TRIP_PARTICIPANTS TP ON TR.TRIP_ID=TP.TRIP_ID;





