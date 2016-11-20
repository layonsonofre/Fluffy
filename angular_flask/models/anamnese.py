
class Anamnese():
	def __init__(self, data):
		self.id = data[0]
		self.peso = data[1]
		self.tamanho = data[2]
		self.temperatura = data[3]
		self.animal = [data[4], data[5]]
		self.servico_agendado_id = data[6]
		self.servico_contratado_id = data[7]
		self.queixa = data[8]
		self.tempo_evolucao = data[9]
		self.tratamento = data[10]
		self.medicacao_continua = data[11]
		self.alimentacao = data[12]
		self.fezes_normais = data[13]
		self.urina_normal = data[14]
		self.convulsao = data[15]
		self.desmaio = data[16]
		self.tosse = data[17]
		self.espirro = data[18]
		self.cansaco_facil = data[19]
		self.ambiente_vive = data[20]
		self.contato_animais = data[21]
		self.acesso_rua = data[22]
		self.castrado = data[23]
		self.doencas_anteriores = data[24]
		self.pulga = data[25]
		self.carrapato = data[26]

	def toJSON(self):
		return {
			"id":self.id,
			"peso":self.peso,
			"tamanho":self.tamanho,
			"temperatura":self.temperatura,
			"animal": {
				"id":self.animal[0],
				"nome":self.animal[1]
			},
			"servico_agendado_id": self.servico_agendado_id,
			"servico_contratado_id": self.servico_contratado_id,
			"queixa": self.queixa,
			"tempo_evolucao": self.tempo_evolucao,
			"tratamento": self.tratamento,
			"medicacao_continua": self.medicacao_continua,
			"alimentacao": self.alimentacao,
			"fezes_normais": self.fezes_normais,
			"urina_normal": self.urina_normal,
			"convulsao": self.convulsao,
			"desmaio": self.desmaio,
			"tosse": self.tosse,
		 	"espirro": self.espirro,
			"cansaco_facil": self.cansaco_facil,
			"ambiente_vive": self.ambiente_vive,
			"contato_animais": self.contato_animais,
			"acesso_rua": self.acesso_rua,
			"castrado": self.castrado,
			"doencas_anteriores": self.doencas_anteriores,
			"pulga": self.pulga,
			"carrapato": self.carrapato,
		}

	def fromJSON():
		print("")