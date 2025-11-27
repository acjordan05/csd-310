"""
Author: Aysa Jordan
Date: November 27, 2025
Assignment: Module 8.2
"""

"""
This program connects to a MySQL movies database and demonstrates how to display, insert, update, and delete records.
It shows the films before and after each operation, highlighting changes to the genre and removal of a film.
"""

import mysql.connector
from dotenv import dotenv_values

# Load .env values
secrets = dotenv_values(r"C:\csd\csd-310\module-6\.env")

config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": True
}

db = mysql.connector.connect(**config)
cursor = db.cursor()

# Function to display films
def show_films(cursor, title):
    query = """
            SELECT
                film_name AS Name,
                film_director AS Director,
                genre_name AS Genre,
                studio_name AS 'Studio Name'
            FROM film
                     INNER JOIN genre ON film.genre_id = genre.genre_id
                     INNER JOIN studio ON film.studio_id = studio.studio_id
            ORDER BY film_id ASC \
            """
    cursor.execute(query)
    films = cursor.fetchall()

    print(f"\n-- {title} --")
    for film in films:
        print("Film Name: {}\nDirector: {}\nGenre Name ID: {}\nStudio Name: {}\n".format(
            film[0], film[1], film[2], film[3]
        ))

# 1. Display current films
show_films(cursor, "DISPLAYING FILMS")

# 2. Insert Star Wars
insert_query = """
               INSERT INTO film (film_name, film_director, studio_id, genre_id, film_releaseDate, film_runtime)
               VALUES ('Star Wars', 'George Lucas', 1, 2, '1977', 121) \
               """
cursor.execute(insert_query)
db.commit()

# 3. Display films after insert
show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

# 4. Update 'Alien' to Horror
update_query = """
               UPDATE film
               SET genre_id = 1
               WHERE film_name = 'Alien' \
               """
cursor.execute(update_query)
db.commit()

# 5. Display films after update
show_films(cursor, "DISPLAYING FILMS AFTER UPDATE- Changed Alien to Horror")

# 6. Delete 'Gladiator'
delete_query = """
               DELETE FROM film
               WHERE film_name = 'Gladiator' \
               """
cursor.execute(delete_query)
db.commit()

# 7. Display films after delete
show_films(cursor, "DISPLAYING FILMS AFTER DELETE")

cursor.close()
db.close()

# SOURCES
# 11.3 Keywords and reserved words. (n.d.). MySQL. https://dev.mysql.com/doc/refman/8.0/en/keywords.html#keywords-8-0-detailed-I
# Comeau, A. (2017). MySQL explained: Your Step by Step Guide to Database Design.
# Forta, B. (2019). SQL in 10 minutes a day, Sams teach yourself. Sams Publishing.