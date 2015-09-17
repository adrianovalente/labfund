@ /0000
MAIN JP INICIO
SAIDA $ /0001              ; Posicao de retorno, inicia com 0000
STRING1_1 K 'va            ; Constantes para a string 1
STRING1_2 K 'ic
STRING1_3 K 'om
STRING1_4 K /6665
STRING1_5 K /0000
STRING1_6 K /0000
STRING1_7 K /0000
STRING1_8 K /0000

STRING2_1 K 'va             ; Constantes para a string 2
STRING2_2 K 'ic
STRING2_3 K 'om
STRING2_4 K /6600
STRING2_5 K /0000
STRING2_6 K /0000
STRING2_7 K /0000
STRING2_8 K /0000

; #### Variaveis auxiliares ####
A $ /0001
B $ /0001

; #### Constantes uteis ####
CONST_2 K /0002
CONST_1 K /0001
CONST_MAX_UM_BYTE K /00FF
;  ######################
;  ##      INICIO      ##
;  ######################

INICIO LD STRING1_1
JZ FIM                      ; Se encontrar uma word 0000, termina.
MM A                        ; Atribui um valor da STRING1 na variavel A
LD STRING2_1
JZ FIM                      ; Checa o 0000 tambem para a STRING2
MM B                        ; Atribui um valor da STRING2 na variavel B
SC CONFERE                  ; Processa os dois valores...

LD STRING1_2                ; ... e repete para todos os valores das strings.
JZ FIM
MM A
LD STRING2_2
JZ FIM
MM B
SC CONFERE

LD STRING1_3                ; Word 3...
JZ FIM
MM A
LD STRING2_3
JZ FIM
MM B
SC CONFERE

LD STRING1_4                ; Word 4...
JZ FIM
MM A
LD STRING2_4
JZ FIM
MM B
SC CONFERE

LD STRING1_5                ; Word 5...
JZ FIM
MM A
LD STRING2_5
JZ FIM
MM B
SC CONFERE

LD STRING1_6                ; Word 6...
JZ FIM
MM A
LD STRING2_6
JZ FIM
MM B
SC CONFERE

LD STRING1_7                ; Word 7...
JZ FIM
MM A
LD STRING2_7
JZ FIM
MM B
SC CONFERE

LD STRING1_8                ; ...e word 8!
JZ FIM
MM A
LD STRING2_8
JZ FIM
MM B
SC CONFERE

FIM HM FIM                  ; Fim do programa



;  ######################
;  ##    SUBROTINAS    ##
;  ######################

; #### Conferir se A e B sao iguais, atualizar o contador ####
CONFERE $ /0001
LD A                        ; Calcula a diferenca das words
- B
JZ IGUAIS                   ; Se der 0, fica facil
JN B_MAIOR                  ; O numero no acumulador tem que ser positivo agora.
                            ; Se a diferenca for maior que 00FF, o primeiro byte
                            ; e diferente. Caso contrario, a diferenca tem que
                            ; estar no segundo byte. Segue o algoritmo.
GAMBIARRA - CONST_MAX_UM_BYTE
JN PRIMEIRO_BYTE_IGUAL
JP FIM                      ; Se o primeiro byte nao for igual, so finaliza.

IGUAIS LD SAIDA             ; So somar 2 na saida
+ CONST_2
MM SAIDA
JP RETORNA

B_MAIOR LD B                ; Se o B for maior, inverte a subtracao
- A
JP GAMBIARRA

PRIMEIRO_BYTE_IGUAL LD SAIDA
+ CONST_1                   ; Soma 1 na saida e finaliza o programa
MM SAIDA
JP FIM

RETORNA RS CONFERE

# MAIN
