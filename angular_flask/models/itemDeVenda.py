
class ItemDeVenda():
	def __init__(self, data):
		self.id = data[0]
		self.preco = float(data[1])
		self.quantidade = data[2]
		self.item = [data[3], data[4]]

	def toJSON(self):
		return {
			"id":self.id,
			"preco":self.preco,
			"quantidade":self.quantidade,
			"item": {
				"id":self.item[0],
				"nome":self.item[1]
			}
		}

	def fromJSON():
		print("")