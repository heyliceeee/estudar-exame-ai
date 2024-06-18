# Considere o famoso jogo Tic-Tac-Toe, conhecido em Portugal como o jogo do galo, que se joga num tabuleiro de 3x3. Os jogadores vão colocando as suas peças ou símbolos sucessivamente, com o objetivo de conseguir preencher uma linha, coluna ou diagonal com os seus símbolos. O jogo termina quando isso acontecer, com a vitória desse jogador, ou quando todas as posições estiverem preenchidas, terminando assim num empate.
# Pretende-se modelar o funcionamento do jogo do galo em Prolog, utilizando os seguintes factos:
#• simbolo(n, s) – representa que o jogador n está a utilizar o símbolo s para jogar
#• jogada(n, l, c) – representa que o jogador n jogou o seu símbolo na posição (l -> linha, c -> coluna)
#• próximo(n) – representa que o próximo jogador é o n

# Apresenta-se de seguida o estado de um jogo, a sua representação em Prolog, e a sua descrição. Assuma que as coordenadas começam em (1,1) no canto superior esquerdo.
#o jogo é entre a Maria e o João; A Maria usa o símbolo ‘O’; O João usa o símbolo ‘X'

#simbolo(nome, simbolo) - representa que o jogador n está a utilizar o simbolo s para jogar
simbolo("maria", 'O').
simbolo("joao", 'X').

#Já foram feitas 4 jogadas, sendo que foi a Maria que começou a jogar
#jogada(nome, linha, coluna).
jogada("maria", 1, 2).
jogada("joao", 1, 1).
jogada("maria", 2, 1).
jogada("joao", 2, 2).

#O próximo jogador a jogar é a Maria.
#proximo(nome).
proximo("maria").

#Implemente em Prolog a regra valida/4 que, dado o nome de um jogador, um símbolo, e a posição (linha e coluna) em que pretende jogar, determina se essa jogada é válida. Considere as seguintes regras:
# • Um jogador apenas pode jogar se for a sua vez
# • Um jogador apenas pode jogar numa posição livre
# • Um jogador apenas pode jogar utilizando o seu símbolo
valida(JOGADOR, SIMBOLO, LINHA, COLUNA) :- proximo(JOGADOR),
    not(jogada(_, LINHA, COLUNA)),
    simbolo(JOGADOR, SIMBOLO).


# Implemente em Prolog a regra terminou/0 que determina se o jogo já terminou 

# termina quando o tabuleiro ta cheio 
cheio :- findall(jogada(_, _, _), jogada(_, _, _), L),
    length(L, TAMTABULEIRO),
    TAMTABULEIRO == 9.

# ou se alguem ganhou
vencedorVertical(JOGADOR) :- jogada(JOGADOR, 1, COLUNA), jogada(JOGADOR, 2, COLUNA), jogada(JOGADOR, 3, COLUNA).
vencedorHorizontal(JOGADOR) :- jogada(JOGADOR, LINHA, 1), jogada(JOGADOR, LINHA, 2), jogada(JOGADOR, LINHA, 3).
vencedorDiagonalPrincipal(JOGADOR) :- jogada(JOGADOR, 1, 1), jogada(JOGADOR, 2, 2), jogada(JOGADOR, 3, 3).
vencedorDiagonalSecundario(JOGADOR) :- jogada(JOGADOR, 1, 3), jogada(JOGADOR, 2, 2), jogada(JOGADOR, 3, 1).

ganhou(JOGADOR) :- vencedorVertical(JOGADOR); vencedorHorizontal(JOGADOR); vencedorDiagonalPrincipal(JOGADOR); vencedorDiagonalSecundario(JOGADOR).

terminou :- cheio; ganhou(JOGADOR).


# Implemente em Prolog a regra vencedor/1 que determina o nome do vencedor do jogo. Caso o jogo ainda não tenha terminado ou tenha terminado em empate, a regra deve falhar. 
vencedor(JOGADOR) :- vencedorVertical(JOGADOR); vencedorHorizontal(JOGADOR); vencedorDiagonalPrincipal(JOGADOR); vencedorDiagonalSecundario(JOGADOR).
