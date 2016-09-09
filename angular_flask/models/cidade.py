
class Cidade():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.estado = data[2]
		self.uf = data[3]
		self.pais = data[4]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"estado":self.estado,
			"uf":self.uf,
			"pais":self.pais
		}

	def fromJSON():
		print("")