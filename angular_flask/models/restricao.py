
class Restricao():
	def __init__(self, data):
		self.id = data[0]
		self.restricao = data[1]
		self.descricao = data[2]

	def toJSON(self):
		return {
			"id":self.id,
			"restricao":self.restricao,
			"descricao":self.descricao
		}

	def fromJSON():
		print("")