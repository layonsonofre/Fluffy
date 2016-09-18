
class AnimalTemRestricao():
	def __init__(self, data):
		self.id = data[0]
		self.animal = [data[1], data[2]]
		self.restricao = [data[3], data[4], data[5]]

	def toJSON(self):
		return {
			"id":self.id,
			"animal": {
				"id":self.animal[0],
				"nome":self.animal[1]
			},
			"restricao": {
				"id":self.restricao[0],
				"nome":self.restricao[1],
				"descricao":self.restricao[2],
			}
		}

	def fromJSON():
		print("")