from flask import Flask, request, Response, jsonify
from flask import render_template, url_for, redirect, send_from_directory
from flask import send_file, make_response, abort

from angular_flask import app

class FluffyModel:

	atributos = []
	data = []
	json = {}

	def __init__(self, atributos, data):
		self.atributos = atributos
		self.data = data

		if len(data) == 1 :
			for atributo in atributos :
				json[atributo] = data[atributos.index(atributo)]

	def toJSON(self):
		return self.json

	def fromJSON():
		print("AQUI EH O PY")