@ /0000
MAIN JP INICIO
B1 K /0012      ; Primeiro operando
B2 K /0034      ; Segundo operando
SAIDA $ /0001   ; Endereço de saída do resultado
MULT K /0100    ; Constante para deslocar para esquerda


INICIO LD B1
MM X
LD B2
MM Y
SC PACK         ; Chama a subrotina
MM SAIDA        ; Guarda o resultado da subrotina na posição de saída
FIM HM FIM      ; Fim do programa

X $ /0001
Y $ /0001

PACK $ /0001
LD X            ; Carregando X no acumulador
* MULT          ; Deslocando para a esquerda
+ Y             ; Somando Y
RS PACK
# MAIN
