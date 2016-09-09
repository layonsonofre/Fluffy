
from datetime import datetime

class Animal():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.sexo = data[2]
		self.data_hora_cadastro = data[3]
		self.data_nascimento = data[4].strftime("%B %d, %Y")
		self.pessoa = data[5]
		self.raca = data[6]
		self.porte = data[7]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"sexo":self.sexo,
			"data_hora_cadastro":self.data_hora_cadastro,
			"data_nascimento":self.data_nascimento,
			"pessoa":self.pessoa,
			"raca":self.raca,
			"porte":self.porte
		}

	def fromJSON():
		print("")