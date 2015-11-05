LOADER		>
LOADER_UL 	>

& /0000

; Constantes e variaveis
LOADER_UL $ /0001

END_INICIAL $ /0001
TAMANHO $/0001
GET_DATA GD /000
GET $/0001
CONST_FF00 K /FF00
CONST_ERRO K /FFFF

; ########################################### ;
; ##           SUBROTINA LOADER            ## ;
; ########################################### ;

LOADER $ /0001
LD GET_DATA
+ LOADER_UL
MM GET

; Carregando endereço inicial
LD GET
MM GET_ENDERECO
GET_ENDERECO $ /0001
MM END_INICIAL

; Carregando tamanho
LD GET
MM GET_TAMANHO
GET_TAMANHO $ /0001
MM TAMANHO

; Verificando se cabe tudo na memória
+ END_INICIAL
- CONST_FF00
JN MEMORIA_OK
JP FINALIZAR_ERRO

; MEMORIA_OK
MEMORIA_OK JP LER_BLOCO

LER_BLOCO

FINALIZAR_ERRO LD CONST_ERRO
RD LOADER
