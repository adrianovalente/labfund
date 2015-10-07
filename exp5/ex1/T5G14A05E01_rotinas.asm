GETLINEF >
GL_END <
GL_UL <
GL_BUF <
POS_BUFFER <
GET_DATA <
TEMP_DATA <
EOF_CHAR <
CONST_02 <


& /0000

GETLINEEF $ /0001
JP GETLINE_INICIO

; Guardando constante de posição do buffer
LD GL_END
MM POS_BUFFER

; Automodificação para carregar o valor
GETLINE_INICIO LD GET_DATA
+ GL_UL
MM GET
GET $/0001

; Guardando valor lido numa posição temporária da memória
MM TEMP_DATA

; Atalizando ponteiro da posição do buffer
LD POS_BUFFER
+ CONST_02
MM POS_BUFFER

SC VERIFICA_FINAL
JZ ACABOU

SC VERIFICA_BUFFER
JZ BUFFER_CHEIO

; Volta para o início do loop
JP GETLINE_INICIO

; Rotina secundária para verificar a presença de caracter de final de linha ou aquivo
VERIFICA_FINAL $ /0001
LD TEMP_DATA
- EOL_CHAR
RS VERIFICA_FINAL

; Rotina secundária para verificar se o buffer já está cheio
VERIFICA_BUFFER $ /0001
LD GL_UL
+ GL_BUF
- POS_BUFFER
RS VERIFICA_BUFFER

; Subrotina para terminar em caso de buffer cheio
BUFFER_CHEIO LD CONST_01
JP TERMINAR

; Subrotina para terminar em caso de buffer com posições vazias
ACABOU LD CONST_00
JP TERMINAR

TERMINAR RS GETLINEEF

# GETLINEEF
