
DROP TABLE IF EXISTS movie CASCADE;


CREATE TABLE movie (
    movieid int unsigned NOT NULL AUTO_INCREMENT,
    movie_title varchar(70) NOT NULL,
    movie_runtime int unsigned NOT NULL,
    synopsis varchar(300) NOT NULL,
    avg_rating int NOT NULL,
    age_rating varchar(3) NOT NULL,
    directors varchar(100) NOT NULL,
    PRIMARY KEY(movieid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES movie WRITE;

INSERT INTO movie(movie_title,movie_runtime,synopsis,avg_rating,age_rating,directors) VALUES ('Captain America: The Winter Soldier', 136, 'As Steve Rogers adapts to the complexities of a contemporary world, he joins Natasha Romanoff and Sam Wilson in his mission to uncover the secret behind a deadly, mysterious assassin.', 70, '12a','Joe Russo, Anthony Russo');
INSERT INTO movie(movie_title,movie_runtime,synopsis,avg_rating,age_rating,directors) VALUES ('2001: A Space Odyssey', 139, 'After discovering a monolith on the lunar surface, the Discovery One and its revolutionary supercomputer set out to unravel its mysterious origin.', 84, '12a','Stanley Kubrik');
INSERT INTO movie(movie_title,movie_runtime,synopsis,avg_rating,age_rating,directors) VALUES ('Spider-man: Into the Spider-verse', 116, 'After gaining superpowers from a spider bite, Miles Morales protects the city as Spider-Man. Soon, he meets alternate versions of himself and gets embroiled in an epic battle to save the multiverse.', 87, 'PG','Peter Ramsey, Bob Persichetti, Rodney Rothman');
INSERT INTO movie(movie_title,movie_runtime,synopsis,avg_rating,age_rating,directors) VALUES ('Your Name (Subtitled)', 112, 'Two teenagers share a profound, magical connection upon discovering they are swapping bodies. Things manage to become even more complicated when the boy and girl decide to meet in person.', 76, '12a','Makoto Shinkai');
INSERT INTO movie(movie_title,movie_runtime,synopsis,avg_rating,age_rating,directors) VALUES ('Avengers: Infinity War', 149, "The Avengers must stop Thanos, an intergalactic warlord, from getting his hands on all the infinity stones. However, Thanos is prepared to go to any lengths to carry out his insane plan.", 68, '12a','Joe Russo, Anthony Russo');
INSERT INTO movie(movie_title,movie_runtime,synopsis,avg_rating,age_rating,directors) VALUES ('Thor: Ragnarok', 130, "Deprived of his mighty hammer Mjolnir, Thor must escape the other side of the universe to save his home, Asgard, from Hela, the goddess of death.", 74, '12a','Taika Waititi');

UNLOCK TABLES;

DROP TABLE IF EXISTS screen CASCADE;

CREATE TABLE screen (
    screenid int unsigned NOT NULL AUTO_INCREMENT,
    screen_type varchar(10) NOT NULL,
    capacity int unsigned NOT NULL,
    PRIMARY KEY(screenid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES screen WRITE;

INSERT INTO screen(screen_type, capacity) VALUES ('IMAX', 15);
INSERT INTO screen(screen_type, capacity) VALUES ('3D', 15);
INSERT INTO screen(screen_type, capacity) VALUES ('2D', 15);
INSERT INTO screen(screen_type, capacity) VALUES ('2D', 15);

UNLOCK TABLES;

DROP TABLE IF EXISTS showing CASCADE;

CREATE TABLE showing (
    showingid int unsigned NOT NULL AUTO_INCREMENT,
    movie_id int unsigned NOT NULL,
    movie_date date NOT NULL,
    movie_time time NOT NULL,
    screen_id int unsigned NOT NULL,
    PRIMARY KEY(showingid),
    FOREIGN KEY(movie_id) REFERENCES movie(movieid),
    FOREIGN KEY(screen_id) REFERENCES screen(screenid)

)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES showing WRITE;

INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-07', '10:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-07', '13:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-07', '16:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-07', '19:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-07', '11:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-07', '14:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-07', '17:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-07', '20:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-07', '11:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-07', '14:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-07', '17:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-07', '20:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-07', '11:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-07', '14:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-07', '17:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-07', '20:00:00',4);

INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-08', '11:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-08', '14:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-08', '17:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-08', '20:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-08', '10:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-08', '13:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-08', '16:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-08', '19:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-08', '10:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-08', '13:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-08', '16:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-08', '19:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-08', '10:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-08', '13:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-08', '16:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-08', '19:00:00',4);

INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-09', '10:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-09', '13:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-09', '16:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-09', '19:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-09', '11:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-09', '14:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-09', '17:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-09', '20:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-09', '11:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-09', '14:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-09', '17:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-09', '20:00:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-09', '11:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-09', '14:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-09', '17:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-09', '20:00:00',4);


INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-10', '11:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-10', '14:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-10', '17:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-10', '20:00:00',1);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-10', '10:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-10', '13:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-10', '16:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-10', '19:00:00',2);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-10', '10:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-10', '13:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (3,'2022-04-10', '16:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (6,'2022-04-10', '19:30:00',3);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (5,'2022-04-10', '10:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (1,'2022-04-10', '13:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (2,'2022-04-10', '16:00:00',4);
INSERT INTO showing( movie_id, movie_date, movie_time,screen_id) VALUES (4,'2022-04-10', '19:00:00',4);

UNLOCK TABLES;

DROP TABLE IF EXISTS seat CASCADE;

CREATE TABLE seat(
    seatid int unsigned NOT NULL AUTO_INCREMENT,
    seat_row varchar(1) NOT NULL,
    seat_number int NOT NULL,
    screen_id int unsigned NOT NULL,
    price float unsigned NOT NULL,
    PRIMARY KEY(seatid),
    FOREIGN KEY(screen_id) REFERENCES screen(screenid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES seat WRITE;

INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',1,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',2,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',3,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',4,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',5,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',1,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',2,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',3,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',4,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',5,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',1,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',2,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',3,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',5,1,9.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',1,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',2,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',3,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',4,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',5,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',1,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',2,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',3,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',4,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',5,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',1,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',2,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',3,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,2,7.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',1,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',2,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',3,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',4,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',5,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',1,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',2,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',3,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',4,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',5,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',1,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',2,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',3,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,3,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',1,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',2,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',3,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',4,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('A',5,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',1,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',2,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',3,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',4,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('B',5,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',1,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',2,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',3,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,4,5.50);
INSERT INTO seat(seat_row,seat_number,screen_id, price) VALUES ('C',4,4,5.50);


UNLOCK TABLES;


DROP TABLE IF EXISTS booking CASCADE;

CREATE TABLE booking(
    bookingid varchar(9) NOT NULL,
    showing_id int unsigned NOT NULL,
    booked boolean NOT NULL,
    paid boolean NOT NULL,
    active boolean NOT NULL,
    num_seats int unsigned NOT NULL,
    collected boolean NOT NULL,
    PRIMARY KEY(bookingid),
    FOREIGN KEY (showing_id) REFERENCES showing(showingid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS seat_booked CASCADE;

CREATE TABLE seat_booked(
    seatbookedid int unsigned NOT NULL AUTO_INCREMENT,
    seat_id int unsigned NOT NULL,
    booking_id varchar(9) NOT NULL,
    showing_id int unsigned NOT NULL,
    PRIMARY KEY (seatbookedid),
    FOREIGN KEY(seat_id) REFERENCES seat(seatid),
    FOREIGN KEY(booking_id) REFERENCES booking(bookingid),
    FOREIGN KEY(showing_id) REFERENCES showing(showingid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

