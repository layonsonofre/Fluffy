
from datetime import datetime

class OAuth():
	def __init__(self, data):
		self.id = data[0]
		self.data_hora = data[1]
		self.vencimento = data[2]
		self.token = data[3]
		self.refresh_token = data[4]
		self.time_left = int(data[5])

	def toJSON(self):
		return {
			"id":self.id,
			"data_hora":self.data_hora,
			"vencimento":self.vencimento,
			"token":self.token,
			"refresh_token":self.refresh_token,
			"tempo_restante": self.time_left
		}

	def fromJSON():
		print("")