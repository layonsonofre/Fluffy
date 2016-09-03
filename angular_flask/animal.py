from datetime import datetime

class Animal:
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.sexo = data[2]
		self.data_hora_cadastro = data[3]
		self.data_nascimento = data[4].strftime("%B %d, %Y")
		self.pessoa_tem_funcao_id = data[5]
		self.raca_id = data[6]
		self.porte_id = data[7]

	def toJSON(self):
		return {
			'id':self.id,
			'nome':self.nome,
			'sexo':self.sexo,
			'data_hora_cadastro':self.data_hora_cadastro,
			'data_nascimento': self.data_nascimento,
			'pessoa_tem_funcao_id':self.pessoa_tem_funcao_id,
			'raca_id':self.raca_id,
			'porte_id':self.porte_id,
		}