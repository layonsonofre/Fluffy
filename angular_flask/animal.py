from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app
from datetime import datetime

from fluffyModel import FluffyModel
from util import *

class Animal(FluffyModel):
	def __init__(self, data):
		FluffyModel.__init__(self, ["id","nome","sexo","data_hora_cadastro","data_nascimento","pessoa_tem_funcao_id","raca_id", "porte_id"], data)
		self.id = data[0]
		self.nome = data[1]
		self.sexo = data[2]
		self.data_hora_cadastro = data[3]
		self.data_nascimento = data[4].strftime("%B %d, %Y")
		self.pessoa_tem_funcao_id = data[5]
		self.raca_id = data[6]
		self.porte_id = data[7]

	def fromJSON():
		print("")

@app.route('/animal', methods=['GET'])
def get_animal(pessoa_id=None):

	pessoa_id = request.args.get('pessoa')

	data = Util.getData('getAnimal', [pessoa_id])
	list = []
	if len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhum animal cadastrado")
	for info in data:
		list.append(Animal(info))
	if len(data) == 1 :
		return jsonify(success=True,result=list[0].toJSON(),message="")
	else :
		return jsonify(success=True,result=[a.toJSON() for a in list],message="")