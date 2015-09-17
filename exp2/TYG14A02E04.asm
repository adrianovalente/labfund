@ /0000
MAIN JP COMECAR
SAIDA $ /0001              ; Posicao de retorno, inicia com 0000
            K 'va            ; Constantes para a string 1
            K 'ac
            K 'oa
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

A           $ /0001
B           $ /0001
A_1         $ /0001
A_2         $ /0001
B_1         $ /0001
B_2         $ /0001
SAIDA1      $ /0001
SAIDA2      $ /0001
PACKED      $ /0001
CONST_100   K /0100
CONST_FF    K /FF00
CONST_01    K /0001
CONST_02    k /0002
AUX         $ /0001
X           $ /0001

LOAD       LD /0000
STORE      MM /0000

;  ######################
;  ##      INICIO      ##
;  ######################

; Automodificação para carregar o primeiro endereço
COMECAR LD PRIMEIRA
+ LOAD
MM LOAD_PRIMEIRA
LOAD_PRIMEIRA $ /0001

; Chamando UNPACK e guardando os resultados em variáveis auxiliares
MM PACKED
SC UNPACK
LD SAIDA1
MM A_1
LD SAIDA2
MM A_2

; Automodificação para carregar o segundo endereço
LD SEGUNDA
+ LOAD
MM LOAD_SEGUNDA
LOAD_SEGUNDA $ /0001

; Chamando UNPACK again e guardando os resultados em variáveis auxiliares
MM PACKED
SC UNPACK
LD SAIDA1
MM B_1
LD SAIDA2
MM B_2


; ###################################
; ##         COMPARACOES           ##
; ###################################

LD A_1
JZ FIM
LD B_1
JZ FIM
- A_1
JZ PRIMEIRO_IGUAL
JP FIM ; Finaliza a execução se as strings não forem iguais


COMPARA_SEGUNDO LD A_2
JZ FIM
LD B_2
JZ FIM
- A_2
JZ SEGUNDO_IGUAL
JP FIM ; Finaliza a execução se as strings não forem iguais

; ###################################
; ##    Atualizando ponteiros      ##
; ###################################

ATUALIZA_CONTADOR LD PRIMEIRA
+ CONST_02
MM PRIMEIRA

LD SEGUNDA
+ CONST_02
MM SEGUNDA

JP COMECAR

FIM HM FIM                  ; Fim do programa

PRIMEIRO_IGUAL LD SAIDA
+ CONST_01
MM SAIDA
JP COMPARA_SEGUNDO

SEGUNDO_IGUAL LD SAIDA
+ CONST_01
MM SAIDA
JP ATUALIZA_CONTADOR

; ###################################
; ##            UNPACK             ##
; ###################################

UNPACK $ /0001            ; Guarda a posição de retorno
LD PACKED                      ; Carrega X (PACKED) no acumulador
/ CONST_100               ; Divide X por 100 (desloca para a direita)
JN NEGATIVO               ; Se o valor é negativo, dá o tratamento devido
POSITIVO MM SAIDA1
* CONST_100
MM AUX
LD X
- AUX
MM SAIDA2
SC ERRO_ARREDONDAMENTO

RS UNPACK

NEGATIVO - CONST_FF
JP POSITIVO


;  #################################################
;  ##    Tratamento de erros de arredondamento    ##
;  #################################################

ERRO_ARREDONDAMENTO $ /0001
LD SAIDA1                  ; Carrega a saida 1
* CONST_100                ; Multiplica por 100 (desloca para a esquerda)
+ SAIDA2                   ; Soma a SAIDA 2

; Agora o valor no acumulador deve ser igual a PACKED.
; Vamos verificar isto subtraindo PACKED do valor salvo no acumulador

- PACKED

; Se a subtração é zero não há nada a ser feito

JZ FINAL

; Se a subtraçao não é zero, tivemos erros de arredondamento
; Nesse caso este é o procedimento para arrumar

LD SAIDA1

+ CONST_01                 ; Devemos somar /0001 na saída 1
MM SAIDA1
LD SAIDA2
- CONST_100                ; E subtrair /0100 da saída 2
MM SAIDA2
FINAL RS ERRO_ARREDONDAMENTO

# MAIN
