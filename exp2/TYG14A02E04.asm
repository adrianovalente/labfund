@ /0000
MAIN JP INICIO
SAIDA $ /0001              ; Posicao de retorno, inicia com 0000
            K 'va            ; Constantes para a string 1
            K 'ic
            K 'om
            K /6665
            K /0000
            K /0000
            K /0000
            K /0000

            K 'va             ; Constantes para a string 2
            K 'ic
            K 'om
            K /6600
            K /0000
            K /0000
            K /0000
            K /0000

PRIMEIRA    K /0004
SEGUNDA     K /0014

; #### Variaveis auxiliares ####


A $ /0001
B $ /0001
LOAD LD /0000
STORE MM /0000

; #### Constantes uteis ####
CONST_2 K /0002
CONST_1 K /0001
CONST_MAX_UM_BYTE K /00FF

;  ######################
;  ##      INICIO      ##
;  ######################

INICIO $ /0001

COMECAR LD PRIMEIRA
+ LOAD
MM LOAD_PRIMEIRA
LOAD_PRIMEIRA $ /0001
JZ FIM
MM A

LD SEGUNDA
+ LOAD
MM LOAD_SEGUNDA
LOAD_SEGUNDA $ /0001
MM B

SC CONFERE

LD PRIMEIRA
+ CONST_2
MM PRIMEIRA

LD SEGUNDA
+ CONST_2
MM SEGUNDA

JP COMECAR

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
