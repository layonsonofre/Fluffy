import os

from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *

# routing for basic pages (pass routing onto the Angular app)
@app.route('/')
@app.route('/about')
@app.route('/blog')
def basic_pages(**kwargs):
    return make_response(open('angular_flask/templates/index.html').read())

@app.route('/<modelo>')
def get_modelo(modelo=None):

	args =Util.requestArgs(modelo) 
	try:
		data = Util.getData("get"+modelo[0].upper()+modelo[1:], args)
	except Exception as e:
		return jsonify(success=False, result=[], message=e.__str__())

	class_name = globals()[modelo[0].upper()+modelo[1:]]

	list = []
	if len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhum registro cadastrado")
	for info in data:
		list.append(class_name(info))

	if full_list is True:
		get_list(modelo, list)

	if len(data) == 1 :
		return jsonify(success=True,result=list[0].toJSON(),message="")
	else :
		return jsonify(success=True,result=[p.toJSON() for p in list],message="")

@app.route('/<modelo>/insert', methods=['POST'])
def insert_modelo(modelo = None):
	
	args =Util.requestInsertArgs(modelo)
	args.pop(0) 
	args.append(None)

	try:
		data = Util.getData("ins"+modelo[0].upper()+modelo[1:], args)
		print(data)
		print(args)
		return jsonify(success=True, result=[], message="")
	except Exception as e:
		return jsonify(success=False, result=[], message=e.__str__())

@app.route('/<modelo>/update')
def update_modelo(modelo = None):
	
	args =Util.requestInsertArgs(modelo)

	try:
		data = Util.getData("teste_insert", args)
	except Exception as e:
		return jsonify(success=False, result=[], message=e.__str__())



# special file handlers and error handlers
@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'img/favicon.ico')


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404
