from angular_flask import app
from datetime import datetime

class ServicoContratado():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.data_hora = data[2]
		self.preco = float(data[3])

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"data_hora":self.data_hora,
			"preco":self.preco
		}

	def fromJSON():
		print("")