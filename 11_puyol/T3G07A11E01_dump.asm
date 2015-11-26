&		/0000
DUMPER 		> 
DUMP_INI 	>
DUMP_TAM 	>
DUMP_UL 	>
DUMP_BL 	>
DUMP_EXE 	>
LOADER		>
LOADER_UL 	>
CHTOI 		>
ENDWORD1 	>
ENDWORD2	>
ISEXEC		>

DUMP_INI 	K		/0000
DUMP_TAM 	K		/0000
DUMP_UL 	K		/0000
DUMP_BL 	K		/0000
DUMP_EXE 	K		/0000
DUMPER 		K		/0000
			LD		DUMP_UL
			+		DISCO
			MM		MOVE1
			MM		MOVE2
			MM		MOVE3
			MM		MOVE4
			MM		MOVE5
			MM		MOVE6
			MM		MOVE7
			MM		MOVE8
			LD		DUMP_INI
			MM		NEXTEND
MOVE1		K		/0000		;move o endereço inicial para o disco
			LD		DUMP_TAM
			MM		NWORDS		;numero de words que faltam ser movidos
MOVE2		K		/0000		;move o número de words para o disco
LOOP2		LD      NWORDS
			JZ		ENDLOOP2
			JN		ENDLOOP2
			LD		NEXTEND
MOVE3		K		/0000 		;move o endereço inicial do primeiro bloco
			+		CHECKSUM
			MM		CHECKSUM
			LD		NWORDS
			-		DUMP_BL
			JN		CHECAGEM	;checa se bloco > numero de words
			LD		DUMP_BL
MOVE4		K		/0000 		;se bloco < num words, move tam do bloco pro disco
			+		CHECKSUM
			MM		CHECKSUM
			LD      DUMP_BL
			MM		COUNT
			JP 		LOOP1
CHECAGEM	LD    	NWORDS	
MOVE5		K		/0000 		;se bloco > nwords, move as words que faltam pro disco
			+		CHECKSUM
			MM		CHECKSUM
			LD      NWORDS
			MM		COUNT
LOOP1		LD		COUNT		;loop para mover as words do bloco
			JZ		ENDLOOP1
			-		UM
			MM		COUNT
			LD 		NEXTEND
			MM		ADDRESS
			+		DOIS
			MM		NEXTEND
			SC		LFA
MOVE6		K		/0000
			+		CHECKSUM
			MM		CHECKSUM
			JP		LOOP1
ENDLOOP1	LD 		CHECKSUM
MOVE7		K		/0000 		;mover checksum para o disco
			LD 		ZERO	
			MM		CHECKSUM 	;zerar checksum
			LD 		NWORDS
			-		DUMP_BL
			MM		NWORDS		;atualiza o numero de words que faltam ser movidos
			JP 		LOOP2
ENDLOOP2	LD 		DUMP_EXE
MOVE8		K		/0000 		;move o end da 1a instrução executavel para o disco
			RS		DUMPER


;sub-rotina load from address
ADDRESS   K     /0000
LFA       K     /0000
          LD    ADDRESS
          +     LOAD
          MM    RL5
RL5       K     /0000
          RS    LFA

DISCO 		PD		/300		;instrução de mover para o disco correto
NEXTEND		K		/0000		;salva qual o end inicial do prox bloco
CHECKSUM	K		/0000
COUNT		K		/0000
NWORDS		K		/0000
ZERO		K		/0000
UM			K		/0001
LOAD 		LD 		/0000
DOIS		K		/0002
MOVE      MM    /0000
ENDMEM    K     /0FFF
ERROR     K     /FFFF
CEM       K     /0100
CONV      K     /FF00
TRINTA    K     /0030
DEZ       K     /0010
RVP2	    K		  /0000
NOVE      K     /0009
MIL       K     /1000
F         K     /F000
FFF       K     /FFF0
A         K     /000A
FFFF      K     /FFFF



; Constantes e variaveis
LOADER_UL $ /0001

END_INICIAL $ /0001
TAMANHO $ /0001
GET_DATA GD /300
GET $ /0001
WORD $ /0001
WRITE MM /0000
CHECKSUML $ /0001
ISEXEC		K	/0001

CONST_0FFF  K /0FFF
CONST_ERRO  K /FFFE
CONST_CERRO K /FFFC
CONST_ZERO  K /0000
CONST_DOIS  K /0002
CONST_UM    K /0001


END_ESCREVER $ /0001
TAM_BLOCO $ /0001


; ########################################### ;
; ##           SUBROTINA LOADER            ## ;
; ########################################### ;

LOADER $ /0001
LD GET_DATA
+ LOADER_UL
MM GET

; Carregando endereço inicial
LD ISEXEC
JZ LDEXEC
LD GET
MM GET_ENDERECO
GET_ENDERECO $ /0001
MM END_INICIAL
JP	CONT

LDEXEC LD GET
MM GET_ENDERECOEX
GET_ENDERECOEX $ /0001
MM END_INICIAL
-	CONST_0FFF
JN CONT
LV /0005
RS LOADER

; Carregando tamanho
CONT LD GET
MM GET_TAMANHO
GET_TAMANHO $ /0001
MM TAMANHO

; Verificando se cabe tudo na memória
LD TAMANHO
+ TAMANHO
+ END_INICIAL
- CONST_0FFF
JN MEMORIA_OK
JP FINALIZAR_ERRO

; MEMORIA_OK
MEMORIA_OK JP COPIAR_BLOCO
COPIAR_BLOCO SC LER_BLOCO
LD TAMANHO
JZ FIM_LOADER
JP COPIAR_BLOCO
FIM_LOADER LD GET
MM GET_EXEC
GET_EXEC $ /0001
RS LOADER

; ########################################### ;
; ##          SUBROTINA LER_BLOCO          ## ;
; ########################################### ;

; Lendo endereço inicial do bloco
LER_BLOCO $ /0001

; Inicializando o CHECKSUML
LD CONST_ZERO
MM CHECKSUML

LD GET
MM GET_END_INICIAL
GET_END_INICIAL $ /0001
MM END_ESCREVER
+ CHECKSUML
MM CHECKSUML

; Lendo tamanho do bloco
LD GET
MM GET_TAM_BLOCO
GET_TAM_BLOCO $ /0001
MM TAM_BLOCO
+ CHECKSUML
MM CHECKSUML

; Lendo words do bloco
ESCREVER_WORD LD GET
MM GET_WORD
GET_WORD $ /0001
MM WORD
+ CHECKSUML
MM CHECKSUML

; Automodificação para escrever word no local desejado
LD WRITE
+ END_ESCREVER
MM MM_WORD
LD WORD
MM_WORD $ /0001

; Atualizando contadores e ponteiros
LD END_ESCREVER
+ CONST_DOIS
MM END_ESCREVER

LD TAMANHO
- CONST_UM
MM TAMANHO

LD TAM_BLOCO
- CONST_UM
MM TAM_BLOCO

JZ FINAL_BLOCO
JP ESCREVER_WORD

; Checksum
FINAL_BLOCO LD GET
MM GET_CHECKSUML
GET_CHECKSUML $ /0001
- CHECKSUML
JZ CHECKSUML_OK

; Em caso de erro no checksum
LD CONST_CERRO
RS LOADER

CHECKSUML_OK RS LER_BLOCO


FINALIZAR_ERRO LD CONST_ERRO
RS LOADER

;sub-rotina chtoi
ENDWORD1	K			/0000
ENDWORD2	K			/0000
CHTOI			K			/0000
					LD		ENDWORD1
					MM		PACKED2
					SC		UNPACK2
					-			TRINTA
					JN		ERRCHTOI
					-			DEZ
					JN		NEG1
					JP		ADD1
NEG1			+			DEZ
					JP		SAVE1
ADD1			+			NOVE
					-			DEZ
					JN		VALID1
					JP		ERRCHTOI
VALID1		+			DEZ
SAVE1			MM		VAR4
					LD		ENDWORD1
					MM		PACKED
					SC		UNPACK1
					-			TRINTA
					JN		ERRCHTOI
					-			DEZ
					JN		NEG2
					JP		ADD2
NEG2			+			DEZ
					JP		MULT1
ADD2			+			NOVE
					-			DEZ
					JN		VALID2
					JP		ERRCHTOI
VALID2		+			DEZ
MULT1			*			DEZ
					+			VAR4
					MM		VAR4
					LD		ENDWORD2
					MM		PACKED2
					SC		UNPACK2
					-			TRINTA
					JN		ERRCHTOI
					-			DEZ
					JN		NEG3
					JP		ADD3
NEG3			+			DEZ
					JP		SAVE2
ADD3			+			NOVE
					-			DEZ
					JN		VALID3
					JP		ERRCHTOI
VALID3		+			DEZ
SAVE2			MM		VAR5
					LD		ENDWORD2
					MM		PACKED
					SC		UNPACK1
					-			TRINTA
					JN		ERRCHTOI
					-			DEZ
					JN		NEG4
					JP		ADD4
NEG4			+			DEZ
					JP		MULT2
ADD4			+			NOVE
					-			DEZ
					JN		VALID4
					JP		ERRCHTOI
VALID4		+			DEZ
MULT2			*			DEZ
					+			VAR5
					MM		VAR5
					LD		VAR4
					*			CEM
					+			VAR5
					JP		ENDCHTOI
ERRCHTOI	LD		ERROR
ENDCHTOI	RS		CHTOI

VAR4			K			/0000
VAR5			K			/0000

;subrotina UNPACK
;SUB-ROTINA 1
PACKED  K     /0000
UNPACK1 K     /0000
        LD    PACKED
        +     LOAD
        MM    RL3
RL3     K     /0000
        MM    VAR2
				-			FFFF
				JZ		SPECIAL
        /     CEM
SPEND   JN    NEGAT
        JP    NNEGAT
NEGAT   -     CONV
NNEGAT  MM    VAR3
        *     CEM
        -     VAR2
        +     VAR
        JZ    ZEROO
        JP    NZERO
ZEROO   LD    VAR3
        JP    END
NZERO   LD    VAR3
        -     UM
END     RS    UNPACK1
SPECIAL	+			FFFF
				JP		SPEND

;SUB-ROTINA 2
PACKED2 K     /0000
UNPACK2 K     /0000
        LD    PACKED2
        +     LOAD
        MM    RL4
RL4     K     /0000
        *     CEM
        /     CEM
        JN    NEG
        JP    NNEG
NEG     -     CONV
NNEG    MM    VAR
        RS    UNPACK2

VAR 		K			/0000
VAR2		K			/0000
VAR3		K			/0000

			#		DUMPER

