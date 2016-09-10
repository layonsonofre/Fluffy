
class Item():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.preco = float(data[2])
		self.quantidade = data[3]
		self.grupo = data[4]
		self.data_hora_cadastro = data[4]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"preco":self.preco,
			"quantidade":self.quantidade,
			"grupo":self.grupo,
			"data_hora_cadastro":self.data_hora_cadastro
		}

	def fromJSON():
		print("")