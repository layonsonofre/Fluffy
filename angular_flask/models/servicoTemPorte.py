
class ServicoTemPorte():
	def __init__(self, data):
		self.id = data[0]
		self.servico = [data[1], data[2]]
		self.porte = [data[3], data[4]]
		self.preco = data[5]

	def toJSON(self):
		return {
			"id":self.id,
			"servico": {
				"id":self.nome[0],
				"nome":self.nome[1]
			},
			"porte": {
				"id":self.porte[0],
				"nome":self.porte[1]
			},
			"preco":self.preco
		}

	def fromJSON():
		print("")