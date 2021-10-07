import psycopg2

url = "postgres://jktxrada:SGx8MK5pz0SOak1FWRjRYJboDXtuy81v@tai.db.elephantsql.com/jktxrada"
connection = psycopg2.connect(url)

cursor = connection.cursor()
cursor.execute("SELECT * FROM users;")
first_user = cursor.fetchone()

print(first_user)

conection.close()