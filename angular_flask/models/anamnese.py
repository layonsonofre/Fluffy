
class Anamnese():
	def __init__(self, data):
		self.id = data[0]
		self.peso = data[1]
		self.tamanho = data[2]
		self.temperatura = data[3]
		self.animal = [data[4], data[5]]
		self.servico_agendado_id = data[6]
		self.servico_contratado_id = data[7]

	def toJSON(self):
		return {
			"id":self.id,
			"peso":self.peso,
			"tamanho":self.tamanho,
			"temperatura":self.temperatura,
			"animal": {
				"id":self.animal[0],
				"nome":self.animal[1]
			},
			"servico_agendado_id": self.servico_agendado_id,
			"servico_contratado_id": self.servico_contratado_id
		}

	def fromJSON():
		print("")