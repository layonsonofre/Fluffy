
from datetime import datetime

class Lote():
	def __init__(self, data):
		self.id = data[0]
		self.numero = data[1]
		self.vencimento = data[2].strftime("%B %d, %Y")
		self.preco = float(data[3])

	def toJSON(self):
		return {
			"id":self.id,
			"numero":self.numero,
			"vencimento":self.vencimento,
			"preco":self.preco
		}

	def fromJSON():
		print("")