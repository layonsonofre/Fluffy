
class Porte():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.tamanho_minimo = data[2]
		self.tamanho_maximo = data[3]
		self.peso_minimo = data[4]
		self.peso_maximo = data[5]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"tamanho_minimo":self.tamanho_minimo,
			"tamanho_maximo":self.tamanho_maximo,
			"peso_minimo":self.peso_minimo,
			"peso_maximo":self.peso_maximo
		}

	def fromJSON():
		print("")