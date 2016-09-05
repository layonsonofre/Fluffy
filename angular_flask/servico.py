from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app
from datetime import datetime

from fluffyModel import FluffyModel
from util import *

class Servico(FluffyModel):
	def __init__(self, data):
		FluffyModel.__init__(self, ["id","nome","porte","preco"], data)
		self.id = data[0]
		self.nome = data[1]
		self.porte = data[2]
		self.preco = data[3]

	def fromJSON():
		print("")

@app.route('/servico/', methods=['GET'])
def get_servico(servico_id=None, porte_id=None):

	servico_id = request.args.get('servico')
	porte_id = request.args.get('porte')

	data = Util.getData('getServico', [servico_id, porte_id])
	list = []
	if len(data) == 0 :
		return jsonify(success=True,result=list,message="Nenhum servico cadastrado")
	for info in data:
		list.append(Servico(info))
	if len(data) == 1 :
		return jsonify(success=True,result=list[0].toJSON(),message="")
	else :
		return jsonify(success=True,result=[s.toJSON() for s in list],message="")