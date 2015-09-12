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
ERROR_CONST  K /FFFF


INICIO      SC VERIFY      ; Verifica se pode haver erro de memória
            JZ START_COPY  ; Somente começa a cópia se há espaço disponível

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
            LD ZERO         ; Procedimento padrão para retornar sucesso
VERIFY_OK   RS VERIFY
ERROR       LD ERROR_CONST
            JP VERIFY_OK
