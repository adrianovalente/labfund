; ####################################
; Exportacoes e importacoes do arquivo
; ####################################

; ITOCH
ITOCH <
ITOCH_SAIDA1 >      ; interno
ITOCH_SAIDA2 >      ; interno

; CHTOI
CHTOI <             ; externo
CHTOI_A <           ; externo
CHTOI_B <           ; externo
CHTOI_SAIDA >       ; interno


@  /0000

JP INICIO

VALOR1_CHTOI K /3132
VALOR2_CHTOI K /3334
CHTOI_SAIDA K /0000

VALOR_ITOCH K /1234
ITOCH_SAIDA1 K /0000
ITOCH_SAIDA2 K /0000

INICIO   LD VALOR_ITOCH
SC ITOCH

LD VALOR1_CHTOI
MM CHTOI_A
LD VALOR2_CHTOI
MM CHTOI_B
SC CHTOI

HM /00
#  INICIO
