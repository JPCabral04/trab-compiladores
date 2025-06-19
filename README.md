# **Projeto de Compiladores - Analisador Léxico e Sintático**

[cite_start]Este projeto consiste na implementação de um analisador léxico e um analisador sintático para uma linguagem de programação simplificada, como parte dos requisitos da disciplina ECOM06A - Compiladores da Universidade Federal de Itajubá[cite: 1].

[cite_start]O analisador léxico foi desenvolvido com a ferramenta **Flex** e o analisador sintático com a ferramenta **Bison**[cite: 5]. [cite_start]O objetivo é processar um código-fonte escrito na linguagem proposta e gerar um arquivo com o reconhecimento de todos os tokens e símbolos encontrados[cite: 12, 16].

## **Autores**

* Bruno Raiado Bianchi - 2023012338
* João Pedro Quintero Cabral - 2023001479
* Rodrigo Pereira Dos Santos - 2023012383

## **Estrutura dos Arquivos**

O projeto está organizado com os seguintes arquivos principais:

* `scanner.l`: Arquivo de definição do analisador léxico para o **Flex**. [cite_start]Contém as expressões regulares que definem os tokens da linguagem (palavras reservadas, identificadores, operadores, etc.)[cite: 6].
* `parser.y`: Arquivo de definição do analisador sintático para o **Bison**. [cite_start]Contém a gramática formal da linguagem, especificando as regras de produção para as estruturas sintáticas (declarações, comandos condicionais, laços, etc.)[cite: 7].
* `Makefile`: Arquivo de automação que gerencia o processo de compilação, orquestrando o Flex, o Bison e o compilador GCC para gerar o executável final.
* [cite_start]`exemplos/`: Diretório contendo três programas de exemplo (`exemplo1.lang`, `exemplo2.lang`, `exemplo3.lang`) que demonstram as funcionalidades da linguagem, como operações de entrada/saída, condicionais e laços de repetição[cite: 9].

## **1. Pré-requisitos e Instalação (Ambiente Windows)**

Para compilar e executar este projeto, é necessário um ambiente de desenvolvimento com as ferramentas corretas. As instruções a seguir são para o Windows.

### **Passo 1: Instalar o MSYS2**

O MSYS2 fornecerá um ambiente de terminal e um gerenciador de pacotes (`pacman`) que nos permitirá instalar facilmente todas as ferramentas necessárias.

1.  Baixe o instalador no site oficial: [**msys2.org**](https://www.msys2.org/)
2.  Execute o instalador e siga as instruções padrão.

### **Passo 2: Instalar as Ferramentas de Compilação**

1.  Após a instalação, abra o terminal **"MSYS2 MINGW64"** a partir do Menu Iniciar do Windows.
2.  Dentro deste terminal, execute o comando abaixo para instalar o compilador GCC, o Flex, o Bison e outras ferramentas essenciais. O comando só instalará o que for necessário.
    ```bash
    pacman -S --needed base-devel mingw-w64-x86_64-toolchain flex bison
    ```
3.  Confirme a instalação pressionando `Y` (sim) quando solicitado.

Com isso, o ambiente está pronto.

## **2. Compilação do Projeto**

O `Makefile` incluído no projeto automatiza todo o processo de compilação.

1.  Abra o terminal **MSYS2 MINGW64**.
2.  Navegue até o diretório raiz do projeto.
    ```bash
    # Exemplo de caminho, ajuste para o seu caso
    cd /c/Users/SeuUsuario/Caminho/Para/O/Projeto/
    ```
3.  Execute o comando `make`:
    ```bash
    make
    ```
4.  Este comando irá:
    * Executar o **Bison** em `parser.y` para gerar `parser.tab.c` e `parser.tab.h`.
    * Executar o **Flex** em `scanner.l` para gerar `lex.yy.c`.
    * Compilar todos os arquivos `.c` gerados com o **GCC** para criar o executável final, `compilador.exe`.

## **3. Execução e Geração da Saída**

Após a compilação, o programa `compilador.exe` estará disponível no diretório raiz.

### **Analisando um Arquivo de Exemplo**

[cite_start]Para executar o analisador em um dos arquivos de exemplo e gerar o arquivo de reconhecimento de tokens (conforme exigido pelo trabalho [cite: 12, 16]), use o seguinte formato:

```bash
./compilador.exe <caminho_do_arquivo_de_entrada> > <nome_do_arquivo_de_saida>
```

**Exemplos Práticos:**

```bash
# Para o exemplo 1
./compilador.exe exemplos/exemplo1.lang > reconhecimento_exemplo1.txt

# Para o exemplo 2
./compilador.exe exemplos/exemplo2.lang > reconhecimento_exemplo2.txt

# Para o exemplo 3
./compilador.exe exemplos/exemplo3.lang > reconhecimento_exemplo3.txt
```

[cite_start]Ao final de cada comando, um arquivo `.txt` será criado no diretório, contendo a lista sequencial de todos os tokens que foram reconhecidos no programa de exemplo correspondente[cite: 13].

## **4. Limpando os Arquivos Gerados**

Para remover todos os arquivos gerados pelo processo de compilação (`.exe`, `.o`, `.c` e `.h` intermediários) e limpar o diretório, execute:

```bash
make clean
```
