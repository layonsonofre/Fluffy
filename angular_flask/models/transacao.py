
class Transacao():
	def __init__(self, data):
		self.id = data[0]
		self.tipo = data[1]
		self.data_hora = data[2]
		self.valor = float(data[3])

	def toJSON(self):
		return {
			"id":self.id,
			"tipo":self.tipo,
			"data_hora":self.data_hora,
			"valor":self.valor
		}

	def fromJSON():
		print("")