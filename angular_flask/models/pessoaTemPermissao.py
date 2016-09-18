
class PessoaTemPermissao():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa = [data[1], data[2], data[3]]
		self.permissao = [data[4], data[5]]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa": {
				"pessoa_tem_funcao_id":self.pessoa[0],
				"pessoa_id":self.pessoa[1],
				"nome":self.pessoa[2],
			},
			"permissao": {
				"id":self.permissao[0],
				"nome":self.permissao[1]
			}
		}

	def fromJSON():
		print("")