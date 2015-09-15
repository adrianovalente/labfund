@ /0000
MAIN        JP INICIO
SIZE         K /0003
TO_COPY      K /0008
TO_PASTE     K /0010

             K /0001
             K /0002
             K /0003
             K /0004
             K /FFFF
             K /FFFF
             K /FFFF
             K /FFFF
ZERO_CONST   K /0000
ONE_CONST    K /0001
ERROR_CONST  K /FFFF
LOAD        LD /0000
STORE       MM /0000
BYTE         $ /0001


INICIO      SC VERIFY      ; Verifica se pode haver erro de memória
            JZ START_COPY  ; Somente começa a cópia se há espaço disponível
FIM         HM FIM

START_COPY  SC COPY



; ##########################
; ##    VERIFY ROUTINE    ##
; ##########################

; Queremos verificar se existe memória disponível
; para copiar os bytes para a posição de destino

VERIFY       $ /0001
            LD TO_PASTE
             - SIZE
             - TO_COPY

; Se essa subtração for negativa, significa que
; TO_COPY + SIZE < TO_PASTE, ou seja, claramente
; não há espaço disponível para realizar a operação

            JN ERROR        ; Neste caso temos que retornar o erro
            LD ZERO_CONST   ; Procedimento padrão para retornar sucesso
VERIFY_OK   RS VERIFY
ERROR       LD ERROR_CONST
            JP VERIFY_OK


; ############################
; ##   START_COPY ROUTINE   ##
; ############################

COPY         $ /0001
            JP COPY_BYTE
COPY_BYTE   LD SIZE
            JZ FINISH       ; Se SIZE = 0 significa que a cópia acabou
             - ONE_CONST    ; Atualizando o tamanho da palavr a ser copiada
            MM SIZE

            LD TO_COPY
             + LOAD
            MM LOAD_LINE
LOAD_LINE    K /0000
            MM BYTE
            LD TO_PASTE
             + STORE
            MM STORE_LINE
            LD BYTE
STORE_LINE   K /0000

            LD TO_COPY
             + ONE_CONST    ; Atualizando o ponteiro TO_COPY
            MM TO_COPY
            LD TO_PASTE
             + ONE_CONST    ; Atualizando o ponteiro TO_PASTE
            MM TO_PASTE
            ;JP COPY_BYTE
            

FINISH      RS COPY

# MAIN
