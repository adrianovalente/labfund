# Como usar o mounter v2.0 #

Sendo **arquivo_main.asm** o nomes do arquivo que contém a função MAIN
e **funcaoX.asm** os arquivos que contêm as funções auxiliares utilizadas na MAIN,
execute:
```shell
    ./mounter arquivo_main.asm funcao1.asm funcao2.asm
```
O arquivo de saída, que deve ser executado no MVN vai ser sempre **saida.mvn**.
Eu poderia ter colocado isso em um parâmetro, mas iria tornar o comando e o script
muito mais complexos.

**AVISO:** Ainda não testei direito o script, pode ter algum bugzinho, mas deve ocorrer tudo bem.
