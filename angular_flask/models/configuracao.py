
class Configuracao():
	def __init__(self, data):
		self.quantidade_animais = data[0]
		self.periodos_dia = data[1]

	def toJSON(self):
		return {
			"quantidade_animais":self.quantidade_animais,
			"periodos_dia":self.periodos_dia
		}

	def fromJSON():
		print("")