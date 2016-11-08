from flask import Flask, request, Response, jsonify

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *

@app.route('/api/getPessoa', methods=['GET'])
def getPessoa() :

	data = request.args
	print(data)
	return jsonify(result="OK")
