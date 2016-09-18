
class PessoaTemFuncao():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = [data[1], data[2], data[3], data[4]]
		self.funcao = [data[5], data[6]]
		self.password = data[7]
		self.oauth = [data[8], data[9], data[10]]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa": {
				"id":self.pessoa[0],
				"nome":self.pessoa[1],
				"email":self.pessoa[2],
				"registro":self.pessoa[3]
			},
			"funcao": {
				"id":self.funcao[0],
				"nome":self.funcao[1]
			},
			"password":self.password,
			"oauth": {
				"id":self.oauth[0],
				"token":self.oauth[1],
				"valido":self.oauth[2]
			}
		}

	def fromJSON():
		print("")