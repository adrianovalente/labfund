PACK             <
UNPACK           <
STRCOMP          <

PACK_ENTRADA1    >
PACK_ENTRADA2    >
PACK_SAIDA       >

UNPACK_ENTRADA   >
UNPACK_SAIDA1    >
UNPACK_SAIDA2    >

PRIMEIRA         >
SEGUNDA          >
SAIDA_STRCOMP    >

&                /0000

PACK_ENTRADA1  K /00AB  ; 0002
PACK_ENTRADA2  K /00CD  ; 0004
PACK_SAIDA     $ /0001  ; 0006

UNPACK_ENTRADA K /1234  ; 0008
UNPACK_SAIDA1  $ /0001  ; 000A
UNPACK_SAIDA2  $ /0001  ; 000C

PRIMEIRA       $ /0020  ;


SEGUNDA        K /000E
SAIDA_STRCOMP  $ /001E

INICIO         SC PACK
               SC UNPACK
               SC STRCOMP
FIM            HM FIM
#              INICIO
