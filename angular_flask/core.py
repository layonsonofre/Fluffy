from angular_flask import app
from flask.ext.mysql import MySQL

mysql = MySQL()

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'Charm&Fluffy@2016'
app.config['MYSQL_DATABASE_DB'] = 'pet_shop'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)
