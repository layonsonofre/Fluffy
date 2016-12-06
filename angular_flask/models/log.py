
class Log():
	def __init__(self, data):
		self.id = data[0]
		self.message = data[1]
		self.json = data[2]
		self.tabela = data[3]
		self.metodo = data[4]
		self.data_hora_cadastro = data[5]

	def toJSON(self):
		return {
			"id":self.id,
			"message":self.message,
			"json":self.json,
			"tabela":self.tabela,
			"metodo":self.metodo,
			"data_hora_cadastro":self.data_hora_cadastro
		}

	def fromJSON():
		print("")