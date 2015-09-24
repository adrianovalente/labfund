; Importações de constantes
CONST_100       <
CONST_01        <
CONST_02        <
CONST_FF        <

; Variáveis para a subrotina PACK
PACK            >
PACK_ENTRADA1   <
PACK_ENTRADA2   <
PACK_SAIDA      <

; Variáveis para a subrotina UNPACK
UNPACK          >
UNPACK_ENTRADA  <
UNPACK_SAIDA1   <
UNPACK_SAIDA2   <

; Variáveis para a subrotina STRCOMP
STRCOMP         >
LOAD            <
PRIMEIRA        <
SEGUNDA         <
SAIDA_STRCOMP   <

; Variáveis auxiliares
AUX             $ /0001
A               $ /0001
B               $ /0001
A_1             $ /0001
A_2             $ /0001
B_1             $ /0001
B_2             $ /0001

; Subrotina PACK
PACK            $ /0001
               LD PACK_ENTRADA1
                < CONST_100
                * CONST_100
                + PACK_ENTRADA2
               MM PACK_SAIDA

; Subrotina UNPACK
UNPACK          $ /0001                  ; Guarda a posição de retorno
               LD UNPACK_ENTRADA
                / CONST_100              ; Divide X por 100 (desloca para a direita)
               JN NEGATIVO               ; Se o valor é negativo, dá o tratamento devido
POSITIVO       MM UNPACK_SAIDA1
                * CONST_100
              MM AUX
              LD UNPACK_ENTRADA
               - AUX
              MM UNPACK_SAIDA2
              SC ERRO_ARREDONDAMENTO

              RS UNPACK

NEGATIVO      - CONST_FF
              JP POSITIVO


; Tratamento de erros de arredondamento na subrotina UNPACK
ERRO_ARREDONDAMENTO $ /0001
                   LD UNPACK_SAIDA1            ; Carrega a saida 1
                    * CONST_100                ; Multiplica por 100 (desloca para a esquerda)
                    + UNPACK_SAIDA2
                    - PACK_SAIDA
                   JZ FINAL_ERR
                   LD UNPACK_SAIDA1

                   + CONST_01
                   MM UNPACK_SAIDA1
                   LD UNPACK_SAIDA2
                   - CONST_100                ; E subtrair /0100 da saída 2
                   MM UNPACK_SAIDA2
FINAL_ERR          RS ERRO_ARREDONDAMENTO


;Subrotina STRCOMP

; Automodificação para carregar o primeiro endereço
STRCOMP  $ /0001
COMECAR LD PRIMEIRA
+ LOAD
MM LOAD_PRIMEIRA
LOAD_PRIMEIRA $ /0001

; Chamando UNPACK e guardando os resultados em variáveis auxiliares
MM UNPACK_ENTRADA
SC UNPACK
LD UNPACK_SAIDA1
MM A_1
LD UNPACK_SAIDA2
MM A_2

; Automodificação para carregar o segundo endereço
LD SEGUNDA
+ LOAD
MM LOAD_SEGUNDA
LOAD_SEGUNDA $ /0001

; Chamando UNPACK again e guardando os resultados em variáveis auxiliares
MM UNPACK_ENTRADA
SC UNPACK
LD UNPACK_SAIDA1
MM B_1
LD UNPACK_SAIDA2
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

;FIM HM FIM                  ; Fim do programa
FIM RS STRCOMP

PRIMEIRO_IGUAL LD SAIDA
+ CONST_01
MM SAIDA
JP COMPARA_SEGUNDO

SEGUNDO_IGUAL LD SAIDA
+ CONST_01
MM SAIDA
JP ATUALIZA_CONTADOR
