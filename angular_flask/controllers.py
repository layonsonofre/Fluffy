import os

from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort
from flask_cors import cross_origin

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *

# routing for basic pages (pass routing onto the Angular app)
@app.route('/')
@app.route('/index')
@cross_origin()
def basic_pages(**kwargs):
    return make_response(open('angular_flask/templates/index.html').read())

@app.route('/<modelo>', methods=['GET'])
def get_modelo(modelo=None):

	args = []
	args = Util.requestGetArgs(modelo)
	
	print("get"+modelo[0].upper()+modelo[1:])
	print(args)
	
	try:
		data = Util.getData("get"+modelo[0].upper()+modelo[1:], args)
		print(data)
	except Exception as e:
		return jsonify(success=False, result=[], message=e.__str__())

	class_name = globals()[modelo[0].upper()+modelo[1:]]

	list = []
	if data is None or len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhum registro cadastrado")
	for info in data:
		list.append(class_name(info))

	if len(data) == 1 :
		return jsonify(success=True,result=list[0].toJSON(),message="")
	else :
		return jsonify(success=True,result=[p.toJSON() for p in list],message="")


@app.route('/<modelo>/', methods=['POST','PUT','DELETE'])
def form_modelo(modelo = None):
	args = []
	
	args = Util.requestFormArgs(modelo, request.json)
	proc = ""

	print(args)

	if request.method == 'POST':
		args.pop(0)
		proc = "ins"+modelo[0].upper()+modelo[1:]
	elif request.method == 'PUT':
		proc = "alt"+modelo[0].upper()+modelo[1:]
	elif request.method == 'DELETE':
		proc = "del"+modelo[0].upper()+modelo[1:]
		args = [args.pop(0)]

	print(proc)
	print(args)

	try:
		data = Util.postData(proc, args)
		data = []
		return jsonify(success=True, result={"id":data[0]}, message="")
	except Exception as e:
		return jsonify(success=False, result={}, message=e.__str__())

# special file handlers and error handlers
@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'img/favicon.ico')


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404
