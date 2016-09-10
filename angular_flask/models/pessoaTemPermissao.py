
class PessoaTemPermissao():
	def __init__(self, data):
		self.id = data[0]
		self.animal = data[1]
		self.restricao = data[2]
		self.descricao = data[3]

	def toJSON(self):
		return {
			"id":self.id,
			"animal":self.animal,
			"restricao":self.restricao,
			"descricao":self.descricao
		}

	def fromJSON():
		print("")