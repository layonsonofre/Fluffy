from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app

from fluffyModel import FluffyModel
from util import *
# routing for API endpoints, generated from the models designated as API_MODELS

class Pessoa(FluffyModel):

	def __init__(self, data):
		FluffyModel.__init__(self, ["id","nome","data_hora_cadastro","email","registro","logradouro","numero", "complemento", "cep", "ponto_de_referencia", "cidade_id"], data)
		self.id = data[0]
		self.nome = data[1]
		self.data_hora_cadastro = data[2]
		self.email = data[3]
		self.registro = data[4]
		self.logradouro = data[5]
		self.numero = data[6]
		self.complemento = data[7]
		self.cep = data[8]
		self.ponto_de_referencia = data[9]
		self.cidade_id = data[10]

	def toJSON(self):
		return FluffyModel.toJSON(self)

	def fromJSON():
		print("")


@app.route('/pessoa', methods=['GET'])
def get(pessoa_id=None):

	pessoa_id = request.args.get('pessoa')

	data = Util.getData('getPessoa', [pessoa_id])
	list = []
	if len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhuma pessoa cadastrada")
	for info in data:
		list.append(Pessoa(info))
	if len(data) == 1 :
		return jsonify(success=True,result=list[0].toJSON(),message="")
	else :
		return jsonify(success=True,result=[p.toJSON() for p in list],message="")

@app.route('/pessoa')
@app.route('/pessoa/<pessoa_id>', methods=['POST'])
def post(pessoa_id=None):
	print("")
	