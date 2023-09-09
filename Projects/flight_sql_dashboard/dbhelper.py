import mysql.connector

class DB:
    def __init__(self):
        try:
            self.conn = mysql.connector.connect(host='localhost', user='root', password='root', database='flights')
            self.mycursor = self.conn.cursor()
            print('Connection Established Successfully')
        except Exception as e:
            print(f'Connection Failed with error :- {e}')

    def fetch_city_names(self):
        self.mycursor.execute("""
            SELECT distinct(Source) FROM flights.flights UNION 
            SELECT distinct(Destination) FROM flights.flights;
            """)
        data=self.mycursor.fetchall()
        city=[]
        for item in data:
            city.append(item[0])
        return city
    def fetch_all_flights(self,source,destination):
        self.mycursor.execute(f"""
        SELECT airline,route,Dep_Time,Duration,Price FROM flights.flights 
        WHERE source= '{source}' and destination= '{destination}'
        """)
        data=self.mycursor.fetchall()
        return data
    def fetch_airline_freq(self):
        airline=[]
        freq=[]
        self.mycursor.execute("""
            SELECT AIRLINE,count(*) FROM flights.flights
            GROUP BY AIRLINE;
        """)
        data=self.mycursor.fetchall()
        for item in data:
            airline.append(item[0])
            freq.append(item[1])
        return airline,freq
    def busy_airport(self):
        city=[]
        freq=[]
        self.mycursor.execute("""
           SELECT SOURCE,count(*) FROM
							(SELECT source FROM flights.flights
							UNION ALL SELECT destination FROM flights.flights) t
						GROUP BY t.source; 
           """)
        data=self.mycursor.fetchall()
        for item in data:
            city.append(item[0])
            freq.append(item[1])

        return city,freq
    def flights_per_day(self):
        date=[]
        freq=[]
        self.mycursor.execute("""
        SELECT date_of_journey,count(*) FROM flights.flights
        GROUP BY date_of_journey;
        """)
        data=self.mycursor.fetchall()
        for item in data:
            date.append(item[0])
            freq.append(item[1])

        return date,freq


