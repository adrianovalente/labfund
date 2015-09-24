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
                   JZ FINAL
                   LD UNPACK_SAIDA1

                   + CONST_01
                   MM UNPACK_SAIDA1
                   LD UNPACK_SAIDA2
                   - CONST_100                ; E subtrair /0100 da saída 2
                   MM UNPACK_SAIDA2
FINAL              RS ERRO_ARREDONDAMENTO
