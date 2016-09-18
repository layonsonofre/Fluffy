
class PessoaTemRedeSocial():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = [data[1], data[2]]
		self.perfil = data[3]
		self.redeSocial = [data[4], data[5]]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa": {
				"id":self.pessoa[0],
				"nome":self.pessoa[1]
			},
			"perfil":self.perfil,
			"redeSocial": {
				"id":self.redeSocial[0],
				"nome":self.redeSocial[1]
			}
		}

	def fromJSON():
		print("")