#!/bin/bash

echo "**********Iniciando Instalação do Sistema Fluffy*********"
echo "-Atualizando Instalador"
echo "--Apt-Get"
sudo apt-get -qq -y update
sudo apt-get -qq -y upgrade
echo "-Instalando Compilador"
echo "--Python"
sudo apt-get install -qq -y python
echo "--Python-Pip"
sudo apt-get install -qq -y python-pip
echo "-Instalando Módulos"
echo "--Flask"
echo "--MySql"
echo "--Cors"
sudo pip -q install -r requirements.txt
echo "-Instalando Banco de Dados"
echo "--Servidor Mysql"
sudo apt-get install -qq -y mysql-server-core-5.6
echo "-Inicializando Banco de Dados"
sudo service mysql stop
sudo service mysql start
echo "-Criando Banco de Dados"
echo "--Criando Tabelas"
echo "--Criando Funções"
echo "--Criando Procedimentos"
echo "--Configurando Triggers"
sudo mysql -u root -p < db/createDB.sql
echo "--Adicionando Dados"
sudo mysql -u root -p < db/seedDB.sql
echo "-Inicializando Sistema"
sudo nohup python runserver.py > log.out
echo "**********Fim da Instalação do Sistema Fluffy*********"