@ /0000
MAIN JP INICIO
PACKED K /1234            ; Carrega numa constante o valor concatenado
SAIDA1 $ /0001            ; Guarda a posição para a saída 1
SAIDA2 $ /0001            ; Guarda a posição para a saída 2

;  ######################
;  ##    Constantes    ##
;  ######################

CONST_100 K /0100
CONST_FF K /FF00
CONST_01 K /0001
AUX $ /0001

INICIO LD PACKED
MM X                      ; Carrega o valor PACKED na memória X
SC UNPACK                 ; Chama a subrotina UNPACK
FIM HM FIM                ; Fim do programa
X $ /0001                 ; Guarda a posição para a variavel X

UNPACK $ /0001            ; Guarda a posição de retorno
LD X                      ; Carrega X (PACKED) no acumulador
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
