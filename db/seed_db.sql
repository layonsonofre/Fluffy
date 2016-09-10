
INSERT INTO `configuracao` VALUES (25,2);


INSERT INTO `pessoa` VALUES (1,'Andre Cadamuro Garcia',NOW(),'andre@gmail.com','12766576177','Rua Jośe Luis Lopez',910,'Apartamento 31','33009440','Farmácia',2948),
							(2,'Alessandra Bitobrovec',NOW(),'alessandra@gmail.com','79488137134','Rua das Rosas',13,NULL,'76017920',NULL,357),
							(3,'Layon de Souza Onofre',NOW(),'layon@gmail.com','85548552724','Rua Hermito Pascoal',1609,NULL,'16018900',NULL,1986),
							(4,'Cesar dos Santos',NOW(),'cesar@gmail.com','14076987454','Rua Luterana dos Sétimos Dias',302,'Centro Comercial','01113892',NULL,21),
							(5,'Aurelio Hiroshi Ozawa',NOW(),'aurelio@gmail.com','99285047505','Rua Gerundina',1,NULL,'95768291',NULL,5000),
							(6,'Janaína Clock',NOW(),'janaina@gmail.com','50976701081','Rua Estevan Suarez',1,NULL,'11293451',NULL,4886);

INSERT INTO `lembrete` VALUES 	(1,'Confirmar Retorno Meg(1)','2016-09-06',true,3),
								(2,'Confirmar Retorno Dolly(6)','2016-09-12',false,3),
								(3,'Retirar Lixo','2016-09-15',false,3),
								(4,'Reunião Sócios','2016-09-15',false,6);

INSERT INTO `telefone` VALUES 	(1,'33229933','22','055',1),
								(2,'999883213','22','055',1),
								(3,'92335421','16','055',2),
								(4,'77475928','78','055',3),
								(5,'11987483','78','055',3),
								(6,'938474373','08','055',4),
								(7,'66647347','31','055',5),
								(8,'551437141','31','055',5),
								(9,'12312465','99','055',6);

INSERT INTO `funcao` VALUES (1,'cliente'),
							(2,'cliente-especial'),
							(3,'funcionario'),
							(4,'administrador');

INSERT INTO `pessoa_tem_funcao` VALUES	(1,1,1),
										(2,2,1),
										(3,3,3),
										(4,4,2),
										(5,5,2),
										(6,6,4);

INSERT INTO `permissao` VALUES 	(1,'Cadastro'),
								(2,'Venda'),
								(3,'Servico'),
								(4,'Consulta');

INSERT INTO `pessoa_tem_permissao` VALUES	(1,3,1),
											(2,3,2),
											(3,3,3),
											(4,3,4);

INSERT INTO `rede_social` VALUES 	(1,'Facebook'),
									(2,'WhatsApp'),
									(3,'Instagram');

INSERT INTO `pessoa_tem_rede_social` VALUES (1,'Andre Garcia',1,1),
											(2,'(22)99831123',2,1),
											(3,'Alessandra Bitobrovec',1,2),
											(4,'Cesar Santos',1,4);		

INSERT INTO `especie` VALUES	(1,'cachorro'),
								(2,'gato');

INSERT INTO `porte` VALUES 	(1,'Mini',1,28,0,6),
							(2,'Mini Peludo',1,28,0,6),
							(3,'Pequeno',29,35,7,15),
							(4,'Médio',36,49,16,25),
							(5,'Médio Peludo',36,49,16,25),
							(6,'Grande',50,69,26,45),
							(7,'Grande Peludo',50,69,26,45),
							(8,'Extra',70,100,46,60),
							(9,'Pelo Curto',1,100,0,100),
							(10,'Pelo Longo',1,100,0,100),
							(11,'Todos',1,100,0,100);

INSERT INTO `raca` VALUES 	(1,'Affenpinscher',1,2),
							(2,'Airedale Terrier',1,7),
							(3,'Akita',1,7),
							(4,'Akita Americano',1,7),
							(5,'American Staffordshire Terrier',1,5),
							(6,'Australian Shepherd',1,7),
							(7,'Basenji',1,4),
							(8,'Basset Fulvo da Bretanha',1,3),
							(9,'Basset Hound',1,3),
							(10,'Beagle',1,4),
							(11,'Beagle-Harrier',1,4),
							(12,'Bearded Collie',1,7),
							(13,'Bedlington Terrier',1,5),
							(14,'Bichon Bolonhês',1,2),
							(15,'Bichon Frisé',1,2),
							(16,'Bichon Havanês',1,2),
							(17,'Blue Heeler',1,5),
							(18,'Boerboel',1,6),
							(19,'Boiadeiro Bernês',1,8),
							(20,'Boiadeiro de Entlebuch',1,4),
							(21,'Boiadeiro da Flandres',1,7),
							(22,'Border Collie',1,7),
							(23,'Border Terrier',1,4),
							(24,'Borzoi',1,7),
							(25,'Boston Terrier',1,4),
							(26,'Boxer',1,6),
							(27,'Braco Alemão Pelo Curto',1,6),
							(28,'Braco Alemão Pelo Duro',1,6),
							(29,'Braco Húngaro de Pelo Curto',1,6),
							(30,'Braco Italiano',1,6),
							(31,'Buldogue Americano',1,4),
							(32,'Buldogue Francês',1,3),
							(33,'Buldogue Inglês',1,5),
							(34,'Bull Terrier',1,4),
							(35,'Bulmastife',1,6),
							(36,'Cairn Terrier',1,2),
							(37,'Cane Corso',1,6),
							(38,'Cão de Água Português',1,5),
							(39,'Cão de Crista Chinês',1,2),
							(40,'Cão de Santo Humberto',1,6),
							(41,"Cão D'água Espanhol",1,5),
							(42,"Cão D'água Português",1,7),
							(43,"Cão Lobo Checoslovaco",1,7),
							(44,"Cão Pelado Mexicano",1,3),
							(45,"Cão Pelado Peruano",1,4),
							(46,'Cavalier King Charles Spaniel',1,3),
							(47,'Cesky Terrier',1,3),
							(48,'Chesapeake Bay Retriever',1,6),
							(49,'Chihuahua',1,1),
							(50,'Chow-chow Pelo Curto',1,7),
							(51,'Chow-chow Pelo Longo',1,7),
							(52,'Cirneco do Etna',1,4),
							(53,'Clumber Spaniel',1,5),
							(54,'Cocker Spaniel Americano',1,5),
							(55,'Cocker Spaniel Inglês',1,5),
							(56,'Collie',1,7),
							(57,'Coton de Tuléar',1,3),
							(58,'Dachshund',1,3),
							(59,'Dálmata',1,6),
							(60,'Dandie Dinmont Terrier',1,2),
							(61,'Dobermann',1,6),
							(62,'Dogue Argentino',1,6),
							(63,'Dogue Canárop',1,6),
							(64,'Dogue Alemão',1,8),
							(65,'Dogue de Bordeaux',1,6),
							(66,'Elkhound Norueguês Cinza',1,4),
							(67,'Fila Brasileiro',1,6),
							(68,'Flat-Coated Retriever',1,7),
							(69,'Fox Terrier Pelo Duro',1,5),
							(70,'Fox Terrier Pelo Liso',1,4),
							(71,'Foxhound Inglês',1,5),
							(72,'Galgo Afegão',1,7),
							(73,'Galgo Espanhol',1,6),
							(74,'Galgo Escocês',1,8),
							(75,'Galgo Irlandês',1,8),
							(76,'Galgo Italiano',1,3),
							(77,'Golden Retriever',1,7),
							(78,'Grande Boiadeiro Suiço',1,7),
							(79,'Grande Münsterländer',1,7),
							(80,'Greyhound',1,8),
							(81,'Grifo da Bélgica',1,2),
							(82,'Grifo de Bruxelas',1,2),
							(83,'Husky Siberiano',1,7),
							(84,'Ibizan Hound',1,6),
							(85,'Irish Soft Coated Wheaten Terrier',1,5),
							(86,'Irish Wolfhound',1,8),
							(87,'Jack Russell Terrier',1,3),
							(88,'Kerry Blue Terrier',1,5),
							(89,'King Charles',1,3),
							(90,'Komondor',1,7),
							(91,'Kuvasz',1,7),
							(92,'Labradoodle',1,5),
							(93,'Labrador Retriever',1,6),
							(94,'Lagotto Romagnolo',1,5),
							(95,'Lakeland Terrier',1,3),
							(96,'Leonberger',1,8),
							(97,'Lhasa Apso',1,3),
							(98,'Malamute do Alasca',1,7),
							(99,'Maltês',1,2),
							(100,'Mastim Espanhol',1,8),
							(101,'Mastim Inglês',1,8),
							(102,'Mastim Tibetano',1,7),
							(103,'Mastim Napolitano',1,6),
							(104,'Mudi',1,5),
							(105,'Nordic Spitz',1,5),
							(106,'Norfolk Terrier',1,2),
							(107,'Norwich Terrier',1,2),
							(108,'Old English Sheepdog',1,7),
							(109,'Papillon',1,2),
							(110,'Parson Russell Terrier',1,3),
							(111,'Pastor Alemão',1,7),
							(112,'Pastor Australiano',1,7),
							(113,'Pastor-de-Beauce',1,7),
							(114,'Pastor Belga',1,7),
							(115,'Pastor Bergamasco',1,7),
							(116,'Pastor Branco Suiço',1,7),
							(117,'Pastor Briard',1,7),
							(118,'Pastor da Ásia Central',1,7),
							(119,'Pastor de Shetland',1,5),
							(120,'Pastor dos Pirineus',1,8),
							(121,'Pastor Maremano Abruzês',1,7),
							(122,'Pastor Polonês',1,5),
							(123,'Pequeno Basset Griffon da Vendéia',1,3),
							(124,'Pequeno Cão Leão',1,3),
							(125,'Pequinês',1,2),
							(126,'Perdigueiro Português',1,6),
							(127,'Pharaoh Hound',1,6),
							(128,'Pinscher Miniatura',1,1),
							(129,'Pit Bul',1,6),
							(130,'Podengo Canário',1,6),
							(131,'Podengo Português',1,5),
							(132,'Pointer Inglês',1,6),
							(133,'Poodle Anão',1,3),
							(134,'Poodle Médio',1,5),
							(135,'Poodle Standard',1,7),
							(136,'Poodle Toy',1,2),
							(137,'Pug',1,3),
							(138,'Puli',1,5),
							(139,'Pumi',1,5),
							(140,'Rhodesian Ridgeback',1,6),
							(141,'Rottweiler',1,6),
							(142,'Saluki',1,8),
							(143,'Samoieda',1,7),
							(144,'São Bernardo',1,8),
							(145,'Schipperke',1,3),
							(146,'Schnauzer',1,5),
							(147,'Schnauzer Gigante',1,7),
							(148,'Schnauzer Miniatura',1,3),
							(149,'Scottish Terrier',1,2),
							(150,'Sealyham Terrier',1,2),
							(151,'Sem Raça Definida Mini',1,1),
							(152,'Sem Raça Definida Mini Peludo',1,2),
							(153,'Sem Raça Definida Pequeno',1,3),
							(154,'Sem Raça Definida Médio',1,4),
							(155,'Sem Raça Definida Médio Peludo',1,5),
							(156,'Sem Raça Definida Grande',1,6),
							(157,'Sem Raça Definida Grande Peludo',1,7),
							(158,'Sem Raça Definida Extra',1,8),
							(159,'Setter Inglês',1,7),
							(160,'Setter Irlandês',1,7),
							(161,'Shar-pei',1,4),
							(162,'Shiba',1,5),
							(163,'Shih-Tzu',1,2),
							(164,'Silky Terrier Australuano',1,2),
							(165,'Skye Terrier',1,2),
							(166,'Smoushond Holandês',1,5),
							(167,'Spaniel Bretão',1,5),
							(168,'Spinone Italiano',1,7),
							(169,'Spitz Alemão Anão',1,2),
							(170,'Spitz Finlandês',1,5),
							(171,'Spitz Japonês Anão',1,2),
							(172,'Springer Spaniel Inglês',1,5),
							(173,'Stabyhoun',1,5),
							(174,'Staffordshire Bull Terrier',1,4),
							(175,'Terra Nova',1,8),
							(176,'Terrier Alemão de Caça Jagd',1,3),
							(177,'Terrier Brasileiro',1,4),
							(178,'Terrier Escocês',1,2),
							(179,'Terrier Irlandês de Glen do Imaal',1,3),
							(180,'Terrier Preto da Rússia',1,7),
							(181,'Terrier Tibetano',1,7),
							(182,'Tosa Inu',1,5),
							(183,'Vulpino Italiano',1,3),
							(184,'Weimaraner',1,6),
							(185,'Welsh Corgi Cardigan',1,2),
							(186,'Welsh Corgi Pembroke',1,1),
							(187,'Welsh Springer Spaniel',1,5),
							(188,'Welsh Terrier',1,5),
							(189,'West Highland White Terrier',1,2),
							(190,'Whippet',1,6),
							(191,'Xoloitzcuintli',1,4),
							(192,'Yorkshire Terrier',1,2);

INSERT INTO `animal` VALUES (1,'Meg','F',NOW(),'2009-05-09 00:00:00',1,154,4),
							(2,'Nina','F',NOW(),'2013-05-11 00:00:00',2,163,3),
							(3,'Luna','F',NOW(),'2015-12-21 00:00:00',2,192,2),
							(4,'Suzy','F',NOW(),'2006-10-03 00:00:00',2,55,5),
							(5,'Pucca','F',NOW(),'2006-10-03 00:00:00',2,55,5),
							(6,'Dolly','F',NOW(),'2013-11-22 00:00:00',2,192,3),
							(7,'Ivie','F',NOW(),'2010-02-27 00:00:00',2,146,5),
							(8,'Kika','F',NOW(),'2007-03-07 00:00:00',2,55,3),
							(9,'Téo','M',NOW(),'2014-07-13 00:00:00',2,97,3),
							(10,'CF','F',NOW(),'2013-05-11 00:00:00',4,128,1),
							(11,'CM','M',NOW(),'2013-05-11 00:00:00',4,128,1),
							(12,'Funny','M',NOW(),'2013-05-11 00:00:00',5,17,5);
							
INSERT INTO `restricao` VALUES 	(1,'Pelagem Clara','Animal não pode ficar exposto ao sol'),
								(2,'Alergia Água quente','Animal apresenta manchas quando lavado com água quente'),
								(3,'Não Cortar Unhas','Animal não deve ter as unhas cortadas');

INSERT INTO `animal_tem_restricao` VALUES 	(1,3,1),
											(2,1,2),
											(3,2,3),
											(4,3,4),
											(5,3,5),
											(6,2,6);

INSERT INTO `servico` VALUES	(1,'Banho'),
							 	(2,'Tosa'),
							 	(3,'Pacote'),
							 	(4,'Remoção de Pelo Morto'),
							 	(5,'Taxa de Desembolo'),
							 	(6,'Tosa Higiênica'),
							 	(7,'Hidratação'),
							 	(8,'Adicional Toalha'),
							 	(9,'Escovação de Dentes'),
							 	(10,'Consulta');

INSERT INTO `servico_tem_porte` VALUES 	(1,1,1,'21.00'),
										(2,3,1,'75.00'),
										(3,4,1,'7.00'),
										(4,5,1,'10.00'),
										(5,6,1,'7.00'),
										(6,7,1,'15.00'),
										(7,1,2,'26.00'),
										(8,2,2,'50.00'),
										(9,3,2,'95.00'),
										(10,4,2,'7.00'),
										(11,5,2,'10.00'),
										(12,6,2,'7.00'),
										(13,7,2,'15.00'),
										(14,1,3,'28.00'),
										(15,2,3,'55.00'),
										(16,3,3,'95.00'),
										(17,4,3,'7.00'),
										(18,5,3,'10.00'),
										(19,6,3,'7.00'),
										(20,7,3,'15.00'),
										(21,1,4,'31.00'),
										(22,2,4,'55.00'),
										(23,3,4,'100.00'),
										(24,4,4,'10.00'),
										(25,5,4,'15.00'),
										(26,6,4,'7.00'),
										(27,7,4,'20.00'),
										(28,1,5,'36.00'),
										(29,2,5,'65.00'),
										(30,3,5,'120.00'),
										(31,4,5,'10.00'),
										(32,6,5,'7.00'),
										(33,7,5,'20.00'),
										(34,2,6,'75.00'),
										(35,3,6,'140.00'),
										(36,4,6,'15.00'),
										(37,5,6,'30.00'),
										(38,6,6,'10.00'),
										(39,7,6,'30.00'),
										(40,1,7,'50.00'),
										(41,2,7,'85.00'),
										(42,3,7,'160.00'),
										(43,4,7,'15.00'),
										(44,5,7,'30.00'),
										(45,6,7,'10.00'),
										(46,7,7,'30.00'),
										(47,1,8,'72.00'),
										(48,2,8,'100.00'),
										(49,3,8,'250.00'),
										(50,4,8,'25.00'),
										(51,5,8,'30.00'),
										(52,6,8,'10.00'),
										(53,7,8,'30.00'),
										(54,1,9,'27.00'),
										(55,2,9,'55.00'),
										(56,3,9,'86.00'),
										(57,1,10,'30.00'),
										(58,2,10,'60.00'),
										(59,3,10,'100.00'),
										(60,8,11,'2.00'),
										(61,9,11,'3.00'),
										(62,10,11,'100.00');

INSERT INTO `transacao` VALUES 	(1,'C',NOW(),'156.00'),
								(2,'C',NOW(),'203.00'),
								(3,'C',NOW(),'201.00'),
								(4,'D',NOW(),'0.00');

INSERT INTO `servico_contratado` VALUES	(1,3,'156.00',NOW(),1),
										(2,3,'113.00',NOW(),2),
										(3,3,'171.00',NOW(),3),
										(4,3,'0.00',NOW(),4);

INSERT INTO `servico_agendado` VALUES 	(1,'28.00',false,'2016-09-06 09:00:00',14,2,1,true,true,NULL,'2016-09-06 10:31:00',3),
										(2,'28.00',false,'2016-09-06 10:00:00',14,3,1,true,true,NULL,'2016-09-06 11:00:00',3),
										(3,'100.00',false,'2016-09-06 10:00:00',62,2,1,true,true,NULL,'2016-09-06 11:00:00',3),
										(4,'50.00',false,'2016-09-12 09:00:00',8,3,2,false,true,NULL,NULL,NULL),
										(5,'20.00',false,'2016-09-12 10:00:00',33,4,2,false,true,NULL,NULL,NULL),
										(6,'36.00',false,'2016-09-12 13:00:00',28,5,2,false,true,NULL,NULL,NULL),
										(7,'7.00',false,'2016-09-12 14:00:00',19,6,2,false,true,NULL,NULL,NULL),
										(8,'171.00',false,'2016-09-15 11:00:00',62,1,3,false,true,NULL,NULL,NULL);

INSERT INTO `anamnese` VALUES	(1,7,26,22,3),
								(2,10,33,20,8);

INSERT INTO `lote` VALUES 	(1,'F423222','2015-12-23','22.00'),
							(2,'F423423','2016-12-23','22.00'),
							(3,'G421615','2028-07-11','71.00');

INSERT INTO `vacina` VALUES	(1,'V8',2,12,2),
							(2,'Gripe Canina',10,36,3);

INSERT INTO `aplicacao` VALUES 	(1,'2016-09-06 11:00:00',true,1,1,3),
								(2,'2016-09-15 11:00:00',false,2,2,3);


INSERT INTO `grupo_de_item` VALUES	(1,'Petisco'),
									(2,'Brinquedo Morder'),
									(3,'Roupa'),
									(4,'Brinquedo Pular');

INSERT INTO `item` VALUES 	(1,'Bolacha com Carne Pct 10un','23.00',3,NOW(),1),
							(2,'Bolacha com Vegetais Pct 10un','21.00',5,NOW(),1),
							(3,'Osso Pequeno','5.00',10,NOW(),1),
							(4,'Osso Borracha','8.00',15,NOW(),2),
							(5,'Roupa Flor Pequena','15.00',1,NOW(),3),
							(6,'Roupa Bolinha Amarela Media ','25.00',3,NOW(),3),
							(7,'Roupa Vermelha Grande','30.00',5,NOW(),3),
							(8,'Roupa Verde Pequena','17.00',8,NOW(),3),
							(9,'Bola Verde','3.00',32,NOW(),4),
							(10,'Bola Vermelha com Espinhos','3.50',21,NOW(),4),
							(11,'Bola Apito','4.50',12,NOW(),4);

INSERT INTO `pedido` VALUES (1,'22.00','2.00',3,1,3),
							(2,'95.00','5.00',2,2,3);

INSERT INTO `item_de_venda` VALUES 	(1,'10.00',2,3,1),
									(2,'8.00',1,4,1),
									(3'4.50',1,11,1),
									(4'50.00',2,6,2),
									(5,'45.00',3,5,2);

							
						




