
class Cidade():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.estado = [data[2], data[3], data[4]]
		self.pais = [data[5], data[6]]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"estado": {
				"id":self.estado[0],
				"nome":self.estado[1],
				"iuf":self.estado[2]
			},
			"pais": {
				"id":self.pais[0],
				"nome":self.pais[1]
			}
		}

	def fromJSON():
		print("")