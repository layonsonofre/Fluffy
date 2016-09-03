
from angular_flask.core import mysql

class Util:
    @staticmethod
    def getData(proc, args):
    	conn = mysql.connect()
    	cursor = conn.cursor()
    	cursor.callproc(proc, args)
    	data = cursor.fetchall()
    	return data