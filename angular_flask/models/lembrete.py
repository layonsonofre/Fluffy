
class Lembrete():
	def __init__(self, data = [None, None, None, None, None, None]):
		self.id = data[0]
		self.descricao = data[1]
		self.data_hora = data[2]
		self.visualizado = False if data[3] == 0 else True
		self.pessoa_id = data[4]
		self.pessoa = data[5]

	def toJSON(self):
		return {
			"id":self.id,
			"descricao":self.descricao,
			"data_hora":self.data_hora,
			"visualizado":self.visualizado,
			"pessoa":self.pessoa
		}

	def fromJSON(self, json):
		print("")