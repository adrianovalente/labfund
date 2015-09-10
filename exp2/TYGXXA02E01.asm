@ /0000
MAIN JP INICIO
B1 K /0012 ; Primeiro operando
B2 K /0034 ; Segundo operando
SAIDA $ /0001
MULT K /0100


INICIO LD B1
MM X
LD B2
MM Y
SC PACK ; Chama a subrotina
MM SAIDA ; Guarda o resultado da subrotina na posição de saída
FIM HM FIM ; Fim do programa

X $ /0001
Y $ /0001

PACK $ /0001
LD X
* MULT
+ Y
RS PACK
# MAIN
