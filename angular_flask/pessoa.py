from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app

# routing for API endpoints, generated from the models designated as API_MODELS

class Pessoa():

	def __init__(self, data):
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
		return {
			"id": 					self.id,
			"nome": 				self.nome,
			"data_hora_cadastro":	self.data_hora_cadastro,
			"email":				self.email,
			"registro":				self.registro,
			"logradouro":			self.logradouro,
			"numero":				self.numero,
			"complemento":			self.complemento,
			"cep":					self.cep,
			"ponto_de_referencia":	self.ponto_de_referencia,
			"cidade_id":			self.cidade_id
		}

	def fromJSON():
		print("")
	