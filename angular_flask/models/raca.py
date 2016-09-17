
class Raca():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.porte = [data[2], data[3]]
		self.especie = [data[4], data[5]]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"porte": {
				"id":self.porte[0],
				"nome":self.porte[1]
			},
			"especie": {
				"id":self.especie[0],
				"nome":self.especie[1]
			}
		}

	def fromJSON():
		print("")