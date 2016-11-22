
class Pedido():
	def __init__(self, data):
		self.id = data[0]
		self.valor = float(data[1])
		self.desconto = float(data[2])
		self.cliente = [data[3], data[4], data[5]]
		self.funcionario = [data[6], data[7], data[8]]
		self.pago = False if data[9] == 0 else True

	def toJSON(self):
		return {
			"id":self.id,
			"valor":self.valor,
			"desconto":self.desconto,
			"cliente": {
				"pessoa_tem_funcao":self.cliente[0],
				"pessoa_id":self.cliente[1],
				"nome":self.cliente[2]
			},
			"funcionario": {
				"pessoa_tem_funcao":self.funcionario[0],
				"pessoa_id":self.funcionario[1],
				"nome":self.funcionario[2]
			},
			"pago": self.pago
		}

	def fromJSON():
		print("")