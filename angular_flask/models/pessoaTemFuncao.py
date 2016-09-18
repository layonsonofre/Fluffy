
class PessoaTemFuncao():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = [data[1], data[2]]
		self.funcao = [data[3], data[4]]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa": {
				"id":self.pessoa[0],
				"nome":self.pessoa[1]
			},
			"funcao": {
				"id":self.funcao[0],
				"nome":self.funcao[1]
			}
		}

	def fromJSON():
		print("")