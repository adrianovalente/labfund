; ####################################
; Exportacoes e importacoes do arquivo
; ####################################

; ITOCH
ITOCH >				; interno
ITOCH_SAIDA1 <      ; externo
ITOCH_SAIDA2 <      ; externo

; CHTOI
CHTOI >             ; interno
CHTOI_A >           ; interno
CHTOI_B >           ; interno
CHTOI_SAIDA <       ; externo

; ################################
; Constantes utilizadas no arquivo
; ################################

C_SHIFT <
C_ASCII_0 <
C_9 <
C_A <
C_ASCII_A <
C_ASCII_MAX <
C_FFFF <
C_0000 <
CONST_100 <
CONST_01 <
CONST_FF <

& /0000             ; Origem relocável


;  #################
;  ##    ITOCH    ##
;  #################
; Converte um número inteiro do acumulador em 
; duas words com os caracteres ASCII hexadecimais 
; correspondentes, colocando-os nas posicoes
; ITOCH_SAIDA1 e ITOCH_SAIDA2

ITOCH_IN $ /0001
ITOCH_AUX $ /0001

ITOCH K /0000
INICIO_ITOCH MM ITOCH_IN ; Guarda o valor de entrada na memoria

MM UNPACK_PACKED
SC UNPACK           ; Divide os bits que vao formar as saidas

LD UNPACK_SAIDA1
/ C_SHIFT           ; Pegando o primeiro caractere da primeira word...
MM ITOCH_AUX        ; Esse numero vai ser util mais tarde
SC PROCESSA_NUM
MM PACK_X

LD ITOCH_AUX		; Shift o primeiro valor para o segundo byte
* C_SHIFT
MM ITOCH_AUX
LD UNPACK_SAIDA1
- ITOCH_AUX			; Tira do valor total para pegar o primeiro bit
SC PROCESSA_NUM
MM PACK_Y

SC PACK				; Junta os dois caracteres na ordem
MM ITOCH_SAIDA1		; E essa e a primeira saida

LD UNPACK_SAIDA2	; Agora faz tudo de novo para a segunda word
/ C_SHIFT           
MM ITOCH_AUX        
SC PROCESSA_NUM
MM PACK_X

LD ITOCH_AUX
* C_SHIFT
MM ITOCH_AUX
LD UNPACK_SAIDA2
- ITOCH_AUX	
SC PROCESSA_NUM
MM PACK_Y

SC PACK
MM ITOCH_SAIDA2

RS ITOCH			; E retorna a funcao
# INICIO_ITOCH

; #### Subrotina para transformar um numero em caractere ####
PROCESSA_NUM K /0000
NUM_IN $ /0001
- C_A				; Verifica se e menor que A
JN NUMERO
+ C_ASCII_A			; Se nao for numero, so somar /0041
RS PROCESSA_NUM

NUMERO LD NUM_IN
+ C_ASCII_0			; Se for numero, so somar /0030
RS PROCESSA_NUM

# INICIO_ITOCH

;  #################
;  ##    CHTOI    ##
;  #################
; Funcao que recebe duas entradas, nas posicoes
; CHTOI_A e CHTOI_B, com caracteres ASCII representando
; um numero, e converte para o valor numerico, colocando
; o resultado na posicao CHTOI_SAIDA.

; Entradas do programa.
CHTOI_A K /0000
CHTOI_B K /0000


CHTOI K  /0000      ; Ponto de entrada da subrotina
INICIO_CHTOI LD CHTOI_A

MM UNPACK_PACKED
SC UNPACK           ; Dividindo os caracteres da primeira word.

LD UNPACK_SAIDA1    ; Processando o primeiro caractere
SC PROCESSA_CHAR    ; Transforma o primeiro caractere em numero.
* C_SHIFT           ; Esse e o digito mais significativo, precisa shiftar 3 vezes
* C_SHIFT
* C_SHIFT
MM CHTOI_SAIDA      ; Move o numero para a saida

LD UNPACK_SAIDA2    ; Processando o segundo caractere
SC PROCESSA_CHAR
* C_SHIFT           ; Segundo digito mais significa, shift 2 vezes
* C_SHIFT
+ CHTOI_SAIDA       ; Soma com o que ja esta na saida
MM CHTOI_SAIDA      ; E move o novo valor para a saida


LD CHTOI_B          ; Agora vamos fazer tudo de novo com a segunda word
MM UNPACK_PACKED
SC UNPACK

LD UNPACK_SAIDA1
SC PROCESSA_CHAR
* C_SHIFT           ; Esse e o terceiro digito mais significativo, 1 shift
MM CHTOI_SAIDA

LD UNPACK_SAIDA2    ; Processando o segundo caractere
SC PROCESSA_CHAR
+ CHTOI_SAIDA
MM CHTOI_SAIDA

FINAL_CHTOI RS CHTOI


; #### Subrotina para transformar um caractere em numero ####
PROCESSA_CHAR K /0000
CHAR_IN $ /0001
MM CHAR_IN

- C_ASCII_MAX       ; Checa se esta acima de F
JN CHECA_A_F
JP ERRO             ; Se nao deu negativo, o numero e grande demais

CHECA_A_F LD CHAR_IN
- C_ASCII_A       ; Checa se esta entre A e F
JN CHECA_NUMERO     ; Se deu negativo, deve ser um numero
RS PROCESSA_CHAR    ; Caso contrario, o registrador ja tem o valor numerico do caractere

CHECA_NUMERO LD CHAR_IN
- C_ASCII_0       ; Checa se nao e pequeno demais para ser um numero
JN ERRO
- C_9               ; Checa se nao e GRANDE demais para ser um numero
JN E_NUMERO         ; Se for menor que 9, e um numero!
JP ERRO

E_NUMERO LD CHAR_IN
- C_ASCII_0       ; Se e um numero, so tirar /0030 e pronto
RS PROCESSA_CHAR

ERRO LD C_FFFF      ; Se der erro, retorna /FFFF ...
MM CHTOI_SAIDA
JP FINAL_CHTOI      ; ...e aborta a funcao toda.
# INICIO_CHTOI



;  ################
;  ##    PACK    ##
;  ################
PACK_X $ /0001
PACK_Y $ /0001

PACK $ /0001
LD PACK_X            ; Carregando X no acumulador
* C_SHIFT          ; Deslocando para a esquerda
+ PACK_Y             ; Somando Y
RS PACK


;  ##################
;  ##    UNPACK    ##
;  ##################
UNPACK_PACKED $ /0001
UNPACK_SAIDA1 $ /0001
UNPACK_SAIDA2 $ /0001
UNPACK_AUX $ /0001

UNPACK $ /0001            ; Guarda a posição de retorno
LD UNPACK_PACKED
/ CONST_100              
JN NEGATIVO               ; Se o valor é negativo, dá o tratamento devido
POSITIVO MM UNPACK_SAIDA1
* CONST_100
MM UNPACK_AUX
LD UNPACK_PACKED
- UNPACK_AUX
MM UNPACK_SAIDA2
SC ERRO_ARREDONDAMENTO

RS UNPACK

NEGATIVO - CONST_FF
JP POSITIVO

;  ##    Arredondamento   ##
ERRO_ARREDONDAMENTO $ /0001
LD UNPACK_SAIDA1                  ; Carrega a saida 1
* CONST_100                ; Multiplica por 100 (desloca para a esquerda)
+ UNPACK_SAIDA2                   ; Soma a SAIDA 2

; Agora o valor no acumulador deve ser igual a PACKED.
; Vamos verificar isto subtraindo PACKED do valor salvo no acumulador

- UNPACK_PACKED

; Se a subtração é zero não há nada a ser feito

JZ FINAL

; Se a subtraçao não é zero, tivemos erros de arredondamento
; Nesse caso este é o procedimento para arrumar

LD UNPACK_SAIDA1

+ CONST_01                 ; Devemos somar /0001 na saída 1
MM UNPACK_SAIDA1
LD UNPACK_SAIDA2
- CONST_100                ; E subtrair /0100 da saída 2
MM UNPACK_SAIDA2
FINAL RS ERRO_ARREDONDAMENTO
#  INICIO_ITOCH
