# Considere a seguinte tabela que mostra as restrições que existem entre viagens para alguns pares de países. Cada linha deve ser lida como um “ou” lógico. Por exemplo:
# • Alguém que viaja entre Portugal e Espanha tem obrigatoriamente que apresentar um Teste PCR negativo para poder entrar no país (independentemente de se já foi ou não vacinado, ou se já recuperou de uma infeção).
# • Alguém que viaja entre Portugal e França pode entrar por qualquer método: seja mostrando um Teste PCR negativo, já tendo sido vacinado, ou já tendo recuperado de uma infeção. Mas tem que ter pelo menos uma destas condições.
# • Alguém que viaja de Espanha para Portugal pode entrar no país sem qualquer restrição

# Modele, em Prolog, a informação que consta na tabela acima

#viagem(de, para, PRC, vacina, recuperado)
viagem("portugal", "espanha", 1, 0, 0).
viagem(_, "portugal", 0, 0, 0).
viagem("portugal", "reino unido", 1, 1, 0).
viagem("portugal", "franca", 1, 1, 1).


#Implemente, em Prolog, o predicado pode_entrar(origem, destino, pcr, vacina, recuperado) que determina se um alguém que viaja entre origem e destino pode entrar no país de destino, tendo ou não um teste PCR negativo, tendo ou não sido vacinado, e tendo ou não já recuperado de uma infeção.
#Por exemplo, para pode_entrar(portugal, espanha, 0, 1, 1) o resultado deve ser false. 

#pode_entrar(origem, destino, pcr, vacina, recuperado)
pode_entrar(ORIGEM, DESTINO, 1, _, _):-viagem(ORIGEM, DESTINO, 1, _, _), !.
pode_entrar(ORIGEM, DESTINO, _, 1, _):-viagem(ORIGEM, DESTINO, _, 1, _), !.
pode_entrar(ORIGEM, DESTINO, _, _, 1):-viagem(ORIGEM, DESTINO, _, _, 1), !.
pode_entrar(ORIGEM, DESTINO, _, _, _):-viagem(ORIGEM, DESTINO, 0, 0, 0).


# Considere a base de conhecimento que se apresenta à direita.
# Os factos multa/2 indicam a multa que um viajante que entre ilegalmente no país tem que pagar ao respetivo país.
# Os factos entrou/1 contêm uma listagem de todas as entradas em vários países, legalmente ou não.
# Implemente o predicado lucro_multas/2 que calcula quando  um determinado país ganhou em multas devido às entradas ilegais no país. Se o país não figurar na lista de multas isto quer dizer que o país não tem regras de entrada, pelo que o predicado deve devolver 0.
# Por exemplo, para esta base de conhecimento, o resultado de lucro_multas(espanha, X) deve ser X = 1500, e o resultado de lucro_multas(portugal, X) deve ser X = 0.

#multa(pais, valor)
multa("espanha", 500).
multa("franca", 750).
multa("reino unido", 1250).

#entrou(id, pais, legalmente)
entrou(1, "espanha", sim)
entrou(2, "espanha", nao)
entrou(3, "espanha", nao)
entrou(4, "espanha", nao)
entrou(5, "reino unido", sim)
entrou(6, "reino unido", nao)

#lucro_multas("espanha", MULTA), MULTA = 1500; lucro_multas("portugal", MULTA), MULTA = 0
lucro_multas(PAIS, MULTATOTAL):-findall(MULTATOTAL, entrou(_,PAIS,nao), L),
    length(L, NMULTAS),
    multa(PAIS, VALORMULTA),
    MULTATOTAL is NMULTAS * VALORMULTA, !.
lucro_multas(_, 0).