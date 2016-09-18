
from datetime import datetime

class Vacina():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.total_doses = data[2]
		self.intervalo = data[3]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"total_doses":self.total_doses,
			"intervalo":self.intervalo
		}

	def fromJSON():
		print("")