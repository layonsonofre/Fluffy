from angular_flask import app
from datetime import datetime

class ServicoAgendado():
	def __init__(self, data):
		self.id = data[0]
		self.nome_servico = data[1]
		self.data_hora = data[2]
		self.preco = float(data[3])
		self.nome_animal = data[4]
		self.servico_contratado_id = data[5]
		self.recorrente = False if data[6] == 0 else True
		self.executado = False if data[7] == 0 else True
		self.pago = False if data[8] == 0 else True
		self.observacao = data[9]
		self.data_hora_executado = data[10]

	def toJSON(self):
		return {
			"id":self.id,
			"servico":self.nome_servico,
			"data_hora":self.data_hora,
			"preco":self.preco,
			"animal":self.nome_animal,
			"servico_contratado":self.servico_contratado_id,
			"recorrente":self.recorrente,
			"executado":self.executado,
			"pago":self.pago,
			"observacao":self.observacao,
			"data_hora_executado":self.data_hora_executado
		}

	def fromJSON():
		print("")