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
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password pa$
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_ag$
sudo apt-get install -qq -y mysql-server-5.6
echo "-Inicializando Banco de Dados"
sudo service mysql stop
sudo service mysql start
echo "-Criando Banco de Dados"
sudo mysql --defaults-extra-file=db/.mysql < db/createDB.sql
echo "--Criando Tabelas"
echo "--Criando Funções"
echo "--Criando Procedimentos"
echo "--Configurando Triggers"
sudo mysql --defaults-extra-file=db/.mysql pet_shop < db/createTABLES.sql
echo "--Adicionando Dados"
sudo mysql  --defaults-extra-file=db/.mysql pet_shop < db/seedDB.sql
echo "-Inicializando Sistema"
pid=$!
sudo nohup python runserver.py > log.out &
kill $pid
echo "**********Fim da Instalação do Sistema Fluffy*********"
