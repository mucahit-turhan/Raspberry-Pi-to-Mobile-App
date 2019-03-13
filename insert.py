import mysql.connector
from mysql.connector import Error
from mysql.connector import errorcode
import time
import datetime
from time import strftime

def read_temperature():
	print("code of sensor read will be added")

while True:
	#temperature = read_temperature()
	#print temperature
	datetime = (time.strftime("%Y-%m-%d ") + time.strftime("%H:%M:%S"))
    	print datetime
	try:
		connection = mysql.connector.connect(host='localhost',
                             database='temp_database',
                             user='root',
                             password='mucahit')
		insert_query = ("INSERT INTO tempLog "
               			"(datetime, temperature) "
               			"VALUES (%s, %s)")
		
		values = (datetime,50);
		cursor = connection.cursor()
		result = cursor.execute(insert_query,values)
		connection.commit()
		print("Record is inserted succesfully")
	except mysql.connector.Error as error:
		connection.rollback()
		print("Inserting Failed")
	finally:
		if(connection.is_connected()):
			cursor.close()
			connection.close()
			print("Connection is closed")
	break



