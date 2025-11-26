"""
Author: Aysa Jordan
Date: November 26, 2025
Assignment: Module 7.2
"""

"""
This program connects to the movies MySQL database, retrieves data from studio, genre, movies under 2 hours,
and lists movies grouped by director, printing all results.
"""

import mysql.connector
from mysql.connector import errorcode
from dotenv import dotenv_values

# Load .env values from full path
secrets = dotenv_values(r"C:\csd\csd-310\module-6\.env")

config = {
    "user": secrets["USER"],
    "password": secrets["PASSWORD"],
    "host": secrets["HOST"],
    "database": secrets["DATABASE"],
    "raise_on_warnings": True
}

try:
    db = mysql.connector.connect(**config)
    print("\nDatabase user {} connected to MySQL on host {} with database {}".format(
        config["user"], config["host"], config["database"]
    ))

    # You can now create a cursor and execute queries
    cursor = db.cursor()

    # Example: Query all studios
    cursor.execute("SELECT * FROM studio;")
    studios = cursor.fetchall()
    print("\n--- Studios ---")
    for studio in studios:
        print(studio)

    # Example: Query all genres
    cursor.execute("SELECT * FROM genre;")
    genres = cursor.fetchall()
    print("\n--- Genres ---")
    for genre in genres:
        print(genre)

    # Example: Movies with runtime < 2 hours
    cursor.execute("SELECT movie_name FROM movie WHERE runtime < 120;")
    short_movies = cursor.fetchall()
    print("\n--- Movies under 2 hours ---")
    for movie in short_movies:
        print(movie[0])

    # Example: Movies grouped by director
    cursor.execute("SELECT director, GROUP_CONCAT(movie_name) FROM movie GROUP BY director;")
    director_movies = cursor.fetchall()
    print("\n--- Movies by Director ---")
    for director, movies in director_movies:
        print(f"{director}: {movies}")

except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print("The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("The specified database does not exist")
    else:
        print(err)
finally:
    if 'db' in locals() and db.is_connected():
        db.close()

# SOURCES
# Comeau, A. (2017). MySQL explained: Your Step by Step Guide to Database Design.
# Forta, B. (2019). SQL in 10 minutes a day, Sams teach yourself. Sams Publishing.