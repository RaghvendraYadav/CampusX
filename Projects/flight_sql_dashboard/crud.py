import  mysql.connector

#Connect to the database server
try:
    conn=mysql.connector.connect(host='localhost',user='root',password='root',database='indigo')
    mycursor=conn.cursor()

    print('Connection Established Successfully')
except Exception as e:
    print(f'Connection Failed with error :- {e}')
#CREATE A DATABASE on db server'
#mycursor.execute('CREATE DATABASE indigo')
#conn.commit()
#create a table in INDIGO database
#airport -> airport_id | code |  name | city
#try:
    #mycursor.execute("""
    #CREATE TABLE airport(
    #airport_id INT PRIMARY KEY,
        #code VARCHAR(10) NOT NULL,
        #name VARCHAR(255) NOT NULL,
        #city VARCHAR(255) NOT NULL )
    #""")
   # conn.commit()
    #print('Table Created Successfully ')
#except Exception as e:
    #print(f'Table creation failed with the issue : {e}')

#INSERT DATA INTO THE TABLE
#try:
#    mycursor.execute("""INSERT INTO airport values(1,'DEL','NEW DELHI','IGIA'),
#                    (2,'CCU','KOLKATA','NSCBA'),
#                    (3,'BOB','Mumbai','CSIA')
#                     """)
#    conn.commit()
#    print('Data Inserted successfully in Table')
#except Exception as e:
#    print(f'Data Insertion  failed with the issue : {e}')

# SEARCH / Retrieve
#RETRIEVE DATA where Airport ID is greate than one
mycursor.execute('SELECT * FROM airport where airport_id > 1')
data=mycursor.fetchall()
print(data)
for i in data:
    print(f'name is {i[2]}')
conn.commit()

#Update
mycursor.execute("""UPDATE airport 
SET name= 'Bombay'
WHERE airport_id=3
""")
conn.commit()

# SEARCH / Retrieve
#RETRIEVE DATA where Airport ID is greate than one
mycursor.execute('SELECT * FROM airport where airport_id > 1')
data=mycursor.fetchall()
print(data)
for i in data:
    print(f'name is {i[2]}')
conn.commit()

#DELETE
mycursor.execute('DELETE  FROM airport WHERE airport_id=3')
conn.commit()

# SEARCH / Retrieve
#RETRIEVE DATA where Airport ID is greate than one
mycursor.execute('SELECT * FROM airport where airport_id > 1')
data=mycursor.fetchall()
print(data)
for i in data:
    print(f'name is {i[2]}')
conn.commit()
