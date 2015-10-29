DUMPER 		 >
DUMP_INI   >
DUMP_TAM   >
DUMP_UL    >
DUMP_BL    >
DUMP_EXE   >

& /0000

; PARAMETROS
DUMP_INI 	 $ /0001
DUMP_TAM 	 $ /0001
DUMP_UL 	 $ /0001
DUMP_BL 	 $ /0001
DUMP_EXE 	 $ /0001

; Valores auxiliares
LOAD      LD /0000
PUT       PD /300
CONST_1    K /0001
CONST_2    K /0002

; Variaveis auxiliares
COUNTER    $ /0001
G_COUNTER  K /0000
AUX        $ /0001
LER        $ /0001
SIZE_BF    $ /0001
ESCREVER   $ /0001

; =============================== ;
;              DUMPER             ;
; =============================== ;
DUMPER     $ /0001


; Automodificação para escrever no disco
          LD PUT
           + DUMP_UL
          MM ESCREVER
          MM WRITE_INI
          MM WRITE_TOTAL

; Escrevendo endereço inicial
          LD DUMP_INI
WRITE_INI  $ /0001

; Escrevendo o tamanho total
          LD DUMP_TAM
WRITE_TOTAL $ /0001

GRAVAR    SC TAMANHO_BLOCO ; Verificando tamanho do próximo buffer
          JZ FIM_GRAVACAO
          JN FIM_GRAVACAO
          SC GRAVA_BLOCO
          JP GRAVAR

FIM_GRAVACAO JP FIM
FIM HM FIM

; =============================== ;
;   SUBROTINA PARA GRAVAR BLOCO   ;
; =============================== ;

GRAVA_BLOCO $ /0001

; Inicializando contadores
           LD SIZE_BF
           MM COUNTER

           LD ESCREVER
           MM WRITE_POS
           MM WRITE_SIZE

; Escrevendo posição inicial do bloco
           LD DUMP_INI
WRITE_POS   $ /0001

; Escrevendo o tamanho do bloco
           LD SIZE_BF
WRITE_SIZE  $ /0001


; Gravando uma word
GRAVA_WORD LD DUMP_INI
            + LOAD
           MM LEITURA
LEITURA     $ /0001
           MM AUX
           LD ESCREVER
           MM ESCRITA
           LD AUX
ESCRITA     $ /0001

; Atualizando contadores
           LD COUNTER
            - CONST_1
           MM COUNTER
           LD G_COUNTER
            + CONST_1
           MM G_COUNTER

; Atualizando ponteiro
           LD DUMP_INI
            + CONST_2
           MM DUMP_INI

; Verificando se já terminou de gravar
           LD COUNTER
           JZ FIM_BLOCO
           JP GRAVA_WORD

; Terminando Subrotina
FIM_BLOCO  RS GRAVA_BLOCO

; =============================== ;
;   TAMANHO NECESSARIO P/ BLOCO   ;
; =============================== ;

TAMANHO_BLOCO $ /0001
             LD DUMP_TAM
              - G_COUNTER
              - DUMP_BL
             JZ BLOCO_PEQUENO
             JN BLOCO_PEQUENO
             LD DUMP_BL
             MM SIZE_BF
             RS TAMANHO_BLOCO
BLOCO_PEQUENO LD DUMP_TAM
               - G_COUNTER
              MM SIZE_BF
              RS TAMANHO_BLOCO

# DUMPER
