
from datetime import datetime

class ServicoAgendado():
	def __init__(self, data):
		self.id = data[0]
		self.data_hora = data[1]
		self.servico_tem_porte = [[data[2], data[3], data[4]],[data[5], data[6]], float(data[7])]
		self.animal = [data[8], data[9]]
		self.servico_contratado_id = data[10]
		self.recorrente = False if data[11] == 0 else True
		self.executado = False if data[12] == 0 else True
		self.pago = False if data[13] == 0 else True
		self.observacao = data[14]
		self.data_hora_executado = data[15]
		self.pessoa_tem_funcao_funcionario = data[16]

	def toJSON(self):
		return {
			"id":self.id,
			"data_hora":self.data_hora,
			"servico_tem_porte": {
				"servico": {
					"id":self.servico_tem_porte[0][0],
					"servico_id":self.servico_tem_porte[0][1],
					"nome":self.servico_tem_porte[0][2]
				},
				"porte": {
					"id":self.servico_tem_porte[1][0],
					"nome":self.servico_tem_porte[1][1]
				},
				"preco": self.servico_tem_porte[2] 
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
			"pessoa_tem_funcao_funcionario_id":self.pessoa_tem_funcao_funcionario
		}

	def fromJSON():
		print("")