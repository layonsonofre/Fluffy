
class PessoaTemRedeSocial():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = data[1]
		self.perfil = data[2]
		self.redeSocial = data[3]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa":self.pessoa,
			"perfil":self.perfil,
			"redeSocial":self.redeSocial
		}

	def fromJSON():
		print("")