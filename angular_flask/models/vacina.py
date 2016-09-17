
from datetime import datetime

class Vacina():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.total_doses = data[2]
		self.intervalo = data[3]
		self.lote = [data[4], data[5], data[6].strftime("%B %d, %Y")]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"total_doses":self.total_doses,
			"intervalo":self.intervalo,
			"lote": {
				"id":self.lote[0],
				"numero":self.lote[1],
				"vencimento":self.lote[2]
			}
		}

	def fromJSON():
		print("")