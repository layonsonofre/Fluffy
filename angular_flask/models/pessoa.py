
class Pessoa():

	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.data_hora_cadastro = data[2]
		self.email = data[3]
		self.registro = data[4]
		self.logradouro = data[5]
		self.numero = data[6]
		self.complemento = data[7]
		self.cep = data[8]
		self.ponto_de_referencia = data[9]
		self.cidade = data[10]
		self.estado = data[11]
		self.pais = data[12]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"data_hora_cadastro":self.data_hora_cadastro,
			"email":self.email,
			"registro":self.registro,
			"logradouro":self.logradouro,
			"numero":self.numero,
			"complemento":self.complemento,
			"cep":self.cep,
			"ponto_de_referencia":self.ponto_de_referencia,
			"cidade":self.cidade,
			"estado":self.estado,
			"pais":self.pais
		}

	def fromJSON():
		print("")
	