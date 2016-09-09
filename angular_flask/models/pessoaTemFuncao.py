
class PessoaTemFuncao():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = data[1]
		self.funcao = data[2]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa":self.pessoa,
			"funcao":self.funcao
		}

	def fromJSON():
		print("")