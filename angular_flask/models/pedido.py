
class Pedido():
	def __init__(self, data):
		self.id = data[0]
		self.valor = float(data[1])
		self.desconto = float(data[2])
		self.cliente = data[3]
		self.funcionario = data[4]

	def toJSON(self):
		return {
			"id":self.id,
			"valor":self.valor,
			"desconto":self.desconto,
			"cliente":self.cliente,
			"funcionario":self.funcionario
		}

	def fromJSON():
		print("")