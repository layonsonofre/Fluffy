#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

import smtplib
import hashlib

from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort
from flask_cors import cross_origin
from uuid import uuid4

from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS
from util import *
from angular_flask.core import mysql
from angular_flask.models import *
from views import *
from inserts import *

# routing for basic pages (pass routing onto the Angular app)
@app.route('/')
@cross_origin()
def basic_pages(**kwargs):
    return make_response(open('angular_flask/templates/index.html').read())

@app.route('/api/<modelo>', methods=['GET'])
def get_modelo(modelo=None):

    authorization = str(request.headers["Authorization"])
    try:
        auth_type, auth_token = authorization.split(" ")
    except Exception as e:
        return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    if auth_type != "Bearer":
        return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    data = Util.getData("getOAuth", [None, str(auth_token), None])

    if len(data) != 1:
        return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    oauth = OAuth(data[0])

    if oauth.time_left < 0:
        if oauth.time_left > - (3*60*60):
            return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)
        else :
            return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    args = []
    args = Util.requestGetArgs(modelo)

    print("get"+modelo[0].upper()+modelo[1:])
    print(args)

    try:
        data = Util.getData("get"+modelo[0].upper()+modelo[1:], args)
        print(data)
    except Exception as e:
    	message = e.args
        try: message = e.args[1]
        except Exception as e: message = " ".join(message)
    	table = modelo
    	json = request.json
    	method = request.method

    	data = Util.postData("insLog", [message, json, table, method])
    	print(data)
    	return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)

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


@app.route('/api/<modelo>', methods=['POST','PUT','DELETE'])
def form_modelo(modelo = None):

    authorization = str(request.headers["Authorization"])
    try:
        auth_type, auth_token = authorization.split(" ")
    except Exception as e:
        return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    if auth_type != "Bearer":
        return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    data = Util.getData("getOAuth", [None, str(auth_token), None])

    if len(data) != 1:
        return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

    oauth = OAuth(data[0])

    if oauth.time_left < 0:
        if oauth.time_left > - (3*60*60):
            return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)
        else :
            return jsonify(success=False, result={}, message="Sua Sessao Expirou", code=401)

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
        return jsonify(success=True, result={"id":data[0]}, message="")
    except Exception as e:
        message = e.args
        try: message = e.args[1]
        except Exception as e: message = " ".join(message)
        table = modelo
        json = str(request.json)
        method = request.method

        data = Util.postData("insLog", [message, json, table, method])
        return jsonify(success=False, result={}, message=message, tabela=table, json = json, metodo=method)

@app.route('/api/login', methods=['POST'])
def login():
    CLIENT_ID = "FLUFFY_1234"
    CLIENT_SECRET = ""

    json = request.json

    username = json['usuario'] if 'usuario' in json else None
    passwd = json['senha'] if 'senha' in json else None
    client_id = json['client_id'] if 'client_id' in json else None

    m = hashlib.md5()
    m.update(passwd)

    print([username, m.hexdigest(), client_id])
    try:

    	data = Util.getData('getPessoaTemFuncao', [None, None, None, None, username, m.hexdigest(), None, None])
    	if len(data) == 1 and client_id == CLIENT_ID:
            ptf = PessoaTemFuncao(data[0])
            token = str(uuid4())
            refresh_token = str(uuid4())
            id = Util.postData('insOAuth',[token, refresh_token])

            result = Util.postData('altPessoaTemFuncao', [ptf.id, ptf.pessoa[0], ptf.funcao[0], None, id[0]])

            print(result)
            return jsonify(success=True, result={"token":token, "refresh_token":refresh_token, "pessoa_tem_funcao":{"id": ptf.id, "pessoa_id": ptf.pessoa[0],"nome": ptf.pessoa[1]}}, message="")
    	else:
    		return jsonify(success=False, result={}, message="Usuario e/ou Senha incorretos")
    except Exception as e:
        message = ""
        try: message = e.args[1]   
        except Exception as e: message = " ".join(e.args)
    	return jsonify(success=False, result={}, message=message)

@app.route('/api/email', methods=["POST"])
def sendEmail():

    try:
        x = uuid4()
        x = str(x)[:8]

        m = hashlib.md5()
        m.update(x)

        ptf = PessoaTemFuncao(Util.getData('getPessoaTemFuncao', [None, None, None, None, request.json["email"], None, None, None])[0])

        print(ptf)

        if ptf.funcao[0] == 1 or ptf.funcao[0] == 2:
            raise Exception("Falha em Renovação: Pessoa não é funcionário!")

        Util.postData('altPessoaTemFuncao', [ptf.id,None,None,m.hexdigest(),None])

        to = request.json["email"]

        fromaddr = "fluffy.uepg.2016@gmail.com"
        toaddr = to
        msg = MIMEMultipart()
        msg['From'] = fromaddr
        msg['To'] = toaddr
        msg['Subject'] = "Recuperacao de Senha"
 
        body = "Caro usuario do Fluffy,\n\nUma nova senha foi requisitada em nosso sistema, segue seu novo Login:\n\nEmail: "
        body = body + to + "\nNova senha: " + x
        body = body + "\n\nLembre-se de alterar esta senha o mais rapido possivel."
        body = body + "\n\nAtenciosamente,\n FLUFFY"
        msg.attach(MIMEText(body, 'plain'))
 
        server = smtplib.SMTP('smtp.gmail.com', 587, None, 30)
        server.starttls()
        server.login(fromaddr, "Charm&Fluffy@2016")
        text = msg.as_string()
        server.sendmail(fromaddr, toaddr, text)
        server.quit()

        return jsonify(status=True, message = "Renovação enviada com Sucesso!")
    except Exception as e:
        message = e.args
        try: message = e.args[1]
        except Exception as e: message = " ".join(message)
        return jsonify(status=False, message = message)


# special file handlers and error handlers
@app.route('/favicon.ico')
def favicon():
    return send_from_directory(os.path.join(app.root_path, 'static'),
                               'img/favicon.ico')

@app.errorhandler(404)
def page_not_found(e):
    return jsonify(success=False, result={}, message="Rota Inexistente!")
