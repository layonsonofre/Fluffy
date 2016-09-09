
class RedeSocial():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome
		}

	def fromJSON():
		print("")