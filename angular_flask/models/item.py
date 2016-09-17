
class Item():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.preco = float(data[2])
		self.quantidade = data[3]
		self.grupo = [data[4], data[5]]
		self.data_hora_cadastro = data[6]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"preco":self.preco,
			"quantidade":self.quantidade,
			"grupo_de_item": {
				"id":self.grupo[0],
				"nome":self.grupo[1]
			},
			"data_hora_cadastro":self.data_hora_cadastro
		}

	def fromJSON():
		print("")