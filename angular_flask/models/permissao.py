
class Permissao():
	def __init__(self, data):
		self.id = data[0]
		self.modulo = data[1]

	def toJSON(self):
		return {
			"id":self.id,
			"modulo":self.modulo
		}

	def fromJSON():
		print("")