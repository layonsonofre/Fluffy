
class Aplicacao():
	def __init__(self, data):
		self.id = data[0]
		self.data_hora = data[1]
		self.aplicado = False if data[2] == 0 else True
		self.dose_aplicada = data[3]
		self.doses_totais = data[4]
		self.vacina = data[5]
		self.animal = data[6]

	def toJSON(self):
		return {
			"id":self.id,
			"data_hora":self.data_hora,
			"aplicado":self.aplicado,
			"dose_aplicada":self.dose_aplicada,
			"doses_totais":self.doses_totais,
			"vacina":self.vacina,
			"animal":self.animal
		}

	def fromJSON():
		print("")