
class Aplicacao():
	def __init__(self, data):
		self.id = data[0]
		self.data_hora = data[1]
		self.aplicado = False if data[2] == 0 else True
		self.dose_aplicada = data[3]
		self.doses_totais = data[4]
		self.vacina = [data[5], data[6]]
		self.animal = [data[7], data[8]]

	def toJSON(self):
		return {
			"id":self.id,
			"data_hora":self.data_hora,
			"aplicado":self.aplicado,
			"dose_aplicada":self.dose_aplicada,
			"doses_totais":self.doses_totais,
			"vacina": {
				"id":self.vacina[0],
				"nome":self.vacina[1]
			},
			"animal": {
				"id":self.animal[0],
				"nome":self.animal[1]
			}
		}

	def fromJSON():
		print("")