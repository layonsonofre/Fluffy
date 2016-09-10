
class Telefone():
	def __init__(self, data):
		self.id = data[0]
		self.codigo_pais = data[1]
		self.codigo_area = data[2]
		self.numero = data[3]
		self.pessoa = data[4]

	def toJSON(self):
		return {
			"id":self.id,
			"codigo_pais":self.codigo_pais,
			"codigo_area":self.codigo_area,
			"numero":self.numero,
			"pessoa":self.pessoa
		}

	def fromJSON():
		print("")