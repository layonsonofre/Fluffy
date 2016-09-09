
class Raca():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.porte = data[2]
		self.especie = data[3]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"porte":self.porte,
			"especie":self.especie
		}

	def fromJSON():
		print("")