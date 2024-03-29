#!/usr/bin/env python
# -*- coding: utf-8 -*-

from angular_flask.core import mysql
from flask import Flask, request

class Util:

    @staticmethod
    def getData(proc, args):
        try:
    	   conn = mysql.connect()
    	   cursor = conn.cursor()
    	   cursor.callproc(proc, args)
    	   data = cursor.fetchall()
           return data
        except:
    	    raise 

    @staticmethod
    def postData(proc, args):
        print proc
        print args
        try:
           conn = mysql.connect()
           cursor = conn.cursor()
           cursor.callproc(proc, args)
           data = cursor.fetchone()
           cursor.close()
           conn.commit()
           return data
        except:
            raise

    @staticmethod
    def requestFormArgs(modelo, json):
        args = {}
        args["anamnese"] = ["id","peso","tamanho","temperatura","servico_agendado_id", "queixa", "tempo_evolucao", "tratamento", "medicacao_continua", "alimentacao", "fezes_normais", "urina_normal", "convulsao", "desmaio", "tosse", "espirro", "cansaco_facil", "ambiente_vive", "contato_animais", "acesso_rua", "castrado", "doencas_anteriores", "pulga", "carrapato"]
        args["animal"] = ["id","nome","sexo","data_nascimento","pessoa_tem_funcao_cliente_id","raca_id","porte_id"]
        args["animalTemRestricao"] = ["id","restricao_id", "animal_id"]
        args["aplicacao"] = ["id","data_hora","aplicado","dose","vacina_id","servico_agendado_id"]
        args["configuracao"] = ["quantidade_animais","periodos_dia"]
        args["especie"] = ["id","nome"]
        args["funcao"] = ["id","nome"]
        args["grupoDeItem"] = ["id","nome"]
        args["item"] = ["id","nome","preco","quantidade","grupo_de_item_id"]
        args["itemDeVenda"] = ["id","preco","quantidade","item_id","pedido_id"]
        args["lembrete"] = ["id","descricao","data_hora","executado","pessoa_id"]
        args["lote"] = ["id","numero","vencimento","preco"]
        args["oAuth"] = ["id", "token", "refresh_token"]
        args["pedido"] = ["id","valor","desconto","transacao_id","pessoa_tem_funcao_cliente_id","pessoa_tem_funcao_funcionario_id", "pago"]
        args["permissao"] = ["id","modulo"]
        args["pessoa"] = ["id","nome","email","registro","logradouro","numero","complemento","cep","ponto_de_referencia","cidade", "estado", "uf", "pais", "rg", "inscricao", "orgao_expedidor","bairro"]
        args["pessoaTemFuncao"] = ["id","pessoa_id","funcao_id","password","oauth_id"]
        args["pessoaTemPermissao"] = ["id","pessoa_id","permissao_id"]
        args["pessoaTemRedeSocial"] = ["id","perfil", "rede_social_id", "pessoa_id",]
        args["porte"] = ["id", "nome", "tamanho_minimo", "tamanho_maximo", "peso_minimo", "peso_maximo"]
        args["raca"] = ["id","nome","especie_id","porte_id"]
        args["redeSocial"] = ["id","nome"]
        args["restricao"] = ["id", "nome", "descricao"]
        args["servico"] = ["id","nome"]
        args["servicoAgendado"] = ["id", "preco", "recorrente", "data_hora", "servico_id", "animal_id", "servico_contratado_id", "executado", "pago", "observacao", "data_hora_executado", "pessoa_tem_funcao_funcionario_executa_id", "cancelado"]
        args["servicoContratado"] = ["id", "pessoa_tem_funcao_funcionario_id", "preco", "transacao_id"]
        args["servicoTemPorte"] = ["id","servico_id","porte_id","preco"]
        args["telefone"] = ["id", "numero", "codigo_area", "codigo_pais", "pessoa_id"]
        args["transacao"] = ["id","tipo","valor", "comentario"]
        args["vacina"] = ["id", "nome", "dose", "intervalo"]
        args["vacinaTemLote"] = ["id", "vacina_id", "lote_id", "quantidade"]

        return [(json[arg] if arg in json else None) for arg in args[modelo]]

    @staticmethod
    def requestGetArgs(modelo):
    	args = {}
        args["anamnese"] = ["id", "servico_agendado_id", "servico_contratado_id", "animal_id", "tempo_evolucao", "tratamento", "medicacao_continua", "fezes_normais", "urina_normal", "convulsao", "desmaio", "tosse", "espirro", "cansaco_facil", "acesso_rua", "contato_animais", "castrado", "pulga", "carrapato"]
    	args["animal"] = ["id", "nome", "pessoa_tem_funcao_id", "raca", "porte", "pessoa_id"]
        args["animalTemRestricao"] = ["id","animal_id","restricao_id"]
        args["aplicacao"] = ["id", "data_hora_inicio", "data_hora_fim", "vacina_tem_lote_id", "servico_agendado_id", "servico_contratado_id", "animal_id"]
        args["configuracao"] = []
        args["especie"] = ["id", "nome"]
        args["funcao"] = ["id", "nome"]
        args["grupoDeItem"] = ["id", "nome"]
        args["item"] = ["id", "nome", "grupo_de_item_id"]
        args["itemDeVenda"] = ["id", "item_id"]
        args["lembrete"] = ["id", "data_hora_inicio", "data_hora_fim", "executado", "pessoa_id"]
        args["lote"] = ["id", "numero", "vencimento_inicio", "vencimento_fim"]
        args["oAuth"] = ["id", "token", "refresh_token"]
        args["pedido"] = ["id", "pessoa_tem_funcao_cliente_id", "cliente_id", "pessoa_tem_funcao_funcionario_id", "funcionario_id", "pago"]
        args["permissao"] = ["id", "modulo"]
    	args["pessoa"] = ["id", "nome", "registro", "email", "cidade", "estado", "uf", "pais", "rg", "inscricao_estadual","orgao_expedidor","bairro", "cliente", "cliente_especial", "funcionario", "administrador"]
        args["pessoaTemFuncao"] = ["id", "pessoa_id", "funcao_id", "pessoa_registro", "pessoa_email", "password", "oauth_id", "oauth_token"]
        args["pessoaTemPermissao"] = ["id", "pessoa_id", "permissao_id"]
        args["pessoaTemRedeSocial"] = ["id", "perfil", "pessoa_id", "rede_social_id"]
        args["porte"] = ["id", "nome"]
        args["raca"] = ["id","nome","especie_id","porte_id"]
        args["redeSocial"] = ["id", "nome"]
        args["restricao"] = ["id", "nome"]
    	args["servico"] = ["id","nome"]
    	args["servicoAgendado"] = ["id", "servico_contratado_id", "data_inicio", "data_fim", "recorrente", "executado", "pago", "data_executado_inicio", "data_executado_fim", "animal_id", "servico_id", "cancelado", "funcionario_id"]
        args["servicoContratado"] = ["id", "data_hora_inicio", "data_hora_fim", "funcionario_id"]
        args["servicoTemPorte"] = ["id","servico_id","porte_id"]
        args["telefone"] = ["id", "pessoa_id", "codigo_pais", "codigo_area"]
        args["transacao"] = ["id","tipo","data_inicio","data_fim"]
        args["vacina"] = ["id", "nome"]
        args["vacinaTemLote"] = ["id", "vacina_id", "vacina_nome", "lote_id", "lote_numero", "lote_vencimento_inicio", "lote_vencimento_fim"]

    	return [request.args.get(arg) for arg in args[modelo]]
