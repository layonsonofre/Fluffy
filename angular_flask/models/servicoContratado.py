
from datetime import datetime

class ServicoContratado():
	def __init__(self, data):
		self.id = data[0]
		self.pessoa_tem_funcao = [data[1], data[2], data[3]]
		self.data_hora = data[4]
		self.preco = float(data[5])
		self.transacao = data[6]

	def toJSON(self):
		return {
			"id":self.id,
			"pessoa_tem_funcao": {
				"id":self.pessoa_tem_funcao[0],
				"pessoa_id":self.pessoa_tem_funcao[1],
				"nome":self.pessoa_tem_funcao[2]
			},
			"data_hora":self.data_hora,
			"preco":self.preco,
			"transacao_id":self.transacao
		}

	def fromJSON():
		print("")