
class Lembrete():
	def __init__(self, data):
		self.id = data[0]
		self.descricao = data[1]
		self.data_hora = data[2]
		self.executado = False if data[3] == 0 else True
		self.pessoa = data[4]

	def toJSON(self):
		return {
			"id":self.id,
			"descricao":self.descricao,
			"data_hora":self.data_hora,
			"executado":self.executado,
			"pessoa":self.pessoa
		}

	def fromJSON():
		print("")
