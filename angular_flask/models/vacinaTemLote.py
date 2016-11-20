
class VacinaTemLote():
	def __init__(self, data):
		self.id = data[0]
		self.vacina = [data[1], data[2]]
		# self.lote = [data[3], data[4], data[5].strftime("%B %d, %Y")]
		self.lote = [data[3], data[4], data[5], data[6]]
		self.quantidade = data[7]

	def toJSON(self):
		return {
			"id":self.id,
			"vacina": {
				"id":self.vacina[0],
				"nome":self.vacina[1]
			},
			"lote": {
				"id":self.lote[0],
				"numero":self.lote[1],
				"vencimento":self.lote[2],
				"preco":self.lote[3]
			},
			"quantidade": self.quantidade
		}

	def fromJSON():
		print("")
