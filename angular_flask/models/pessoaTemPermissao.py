
class PessoaTemPermissao():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = data[1]
		self.modulo = data[2]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa":self.pessoa,
			"modulo":self.modulo
		}

	def fromJSON():
		print("")