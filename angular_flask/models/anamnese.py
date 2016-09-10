
class Anamnese():
	def __init__(self, data):
		self.id = data[0]
		self.peso = data[1]
		self.tamanho = data[2]
		self.temperatura = data[3]
		self.nome = data[4]

	def toJSON(self):
		return {
			"id":self.id,
			"peso":self.peso,
			"tamanho":self.tamanho,
			"temperatura":self.temperatura,
			"nome":self.nome
		}

	def fromJSON():
		print("")