
from datetime import datetime

class ServicoAgendado():
	def __init__(self, data):
		self.id = data[0]
		self.data_hora = data[1]
		self.servico_tem_porte = [data[2], float(data[3]), [data[4], data[5]],[data[6], data[7]]]
		self.animal = [data[8], data[9]]
		self.servico_contratado_id = data[10]
		self.recorrente = False if data[11] == 0 else True
		self.executado = False if data[12] == 0 else True
		self.pago = False if data[13] == 0 else True
		self.observacao = data[14]
		self.data_hora_executado = data[15]
		self.pessoa_tem_funcao_funcionario = [data[16], data[17], data[18]]
		self.preco = float(data[19])
		self.cancelado = False if data[20] == 0 else True

	def toJSON(self):
		return {
			"id":self.id,
			"data_hora":self.data_hora,
			"servico_tem_porte": {
				"id": self.servico_tem_porte[0],
				"preco": self.servico_tem_porte[1],
				"servico": {
					"servico_id":self.servico_tem_porte[2][0],
					"nome":self.servico_tem_porte[2][1]
				},
				"porte": {
					"id":self.servico_tem_porte[3][0],
					"nome":self.servico_tem_porte[3][1]
				}
			},
			"animal": {
				"id":self.animal[0],
				"nome":self.animal[1]
			},
			"servico_contratado":self.servico_contratado_id,
			"recorrente":self.recorrente,
			"executado":self.executado,
			"pago":self.pago,
			"observacao":self.observacao,
			"data_hora_executado":self.data_hora_executado,
			"pessoa_tem_funcao_funcionario_id": {
				"id":self.pessoa_tem_funcao_funcionario[0],
				"pessoa_id":self.pessoa_tem_funcao_funcionario[1],
				"pessoa_nome":self.pessoa_tem_funcao_funcionario[2]
			},
			"preco": self.preco,
			"cancelado": self.cancelado
		}

	def fromJSON():
		print("")