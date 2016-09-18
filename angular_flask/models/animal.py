
from datetime import datetime

class Animal():
	def __init__(self, data):
		self.id = data[0]
		self.nome = data[1]
		self.sexo = data[2]
		self.data_hora_cadastro = data[3]
		self.data_nascimento = data[4].strftime("%B %d, %Y")
		self.pessoa_tem_funcao_cliente = [data[5], data[6], data[7]]
		self.raca = [data[8], data[9]]
		self.porte = [data[10], data[11]]

	def toJSON(self):
		return {
			"id":self.id,
			"nome":self.nome,
			"sexo":self.sexo,
			"data_hora_cadastro":self.data_hora_cadastro,
			"data_nascimento":self.data_nascimento,
			"pessoa_tem_funcao": {
				"id":self.pessoa_tem_funcao_cliente[0],
				"pessoa_id":self.pessoa_tem_funcao_cliente[1],
				"nome":self.pessoa_tem_funcao_cliente[2]
			},
			"raca": {
				"id":self.raca[0],
				"nome":self.raca[1]
			},
			"porte": {
				"id":self.porte[0],
				"nome":self.porte[1]
			}
		}

	def fromJSON():
		print("")