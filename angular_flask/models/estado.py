
class Estado():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.uf = data[2]
		self.pais = data[3]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"uf":self.uf,
			"pais":self.pais
		}

	def fromJSON():
		print("")