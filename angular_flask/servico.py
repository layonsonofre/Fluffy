from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app
from datetime import datetime

class Servico():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.porte = data[2]
		self.preco = data[3]

	def toJSON(self):
		return {
			"id":		self.id,
			"nome":		self.nome,
			"porte":	self.porte,
			"preco":	self.preco
		}

	def fromJSON():
		print("")