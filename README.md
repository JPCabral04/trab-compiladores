# **Projeto de Compiladores - Analisador Léxico e Sintático**

Este projeto consiste na implementação de um analisador léxico e um analisador sintático para uma linguagem de programação simplificada, como parte dos requisitos da disciplina ECOM06A - Compiladores da Universidade Federal de Itajubá.

O analisador léxico foi desenvolvido com a ferramenta **Flex** e o analisador sintático com a ferramenta **Bison**. O objetivo é processar um código-fonte escrito na linguagem proposta e gerar um arquivo com o reconhecimento de todos os tokens e símbolos encontrados.

## **Autores**

- Bruno Raiado Bianchi - 2023012338
- João Pedro Quintero Cabral - 2023001479
- Rodrigo Pereira Dos Santos - 2023012383

## **Estrutura de Arquivos do Projeto**

O projeto está organizado com a seguinte estrutura de arquivos e diretórios:

```
.
├── exemplos/
│   ├── exemplo1.lang
│   ├── exemplo2.lang
│   └── exemplo3.lang
├── Makefile
├── parser.y
├── README.md
└── scanner.l
```

- **`scanner.l`**: Arquivo de definição do analisador léxico para o **Flex**. Contém as expressões regulares que definem os tokens da linguagem (palavras reservadas, identificadores, operadores, etc.).
- **`parser.y`**: Arquivo de definição do analisador sintático para o **Bison**. Contém a gramática formal da linguagem, especificando as regras de produção para as estruturas sintáticas.
- **`Makefile`**: Arquivo de automação que gerencia o processo de compilação, orquestrando o Flex, o Bison e o compilador GCC para gerar o executável final.
- **`exemplos/`**: Diretório contendo os programas de exemplo que demonstram as funcionalidades da linguagem.

## **1. Pré-requisitos e Instalação (Ambiente Windows)**

Para compilar e executar este projeto, é necessário um ambiente de desenvolvimento com as ferramentas corretas. As instruções a seguir são para o Windows.

### **Passo 1: Instalar o MSYS2**

O MSYS2 fornecerá um ambiente de terminal e um gerenciador de pacotes (`pacman`) que nos permitirá instalar facilmente todas as ferramentas necessárias.

1.  Baixe o instalador no site oficial: [**msys2.org**](https://www.msys2.org/)
2.  Execute o instalador e siga as instruções padrão.

### **Passo 2: Instalar as Ferramentas de Compilação**

1.  Após a instalação, abra o terminal **"MSYS2 MINGW64"** a partir do Menu Iniciar do Windows.
2.  Dentro deste terminal, execute o comando abaixo para instalar o compilador GCC, o Flex, o Bison e outras ferramentas essenciais.
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
4.  Este comando irá executar o Flex e o Bison e, em seguida, compilar o código gerado para criar o executável final, `compilador.exe`.

## **3. Execução e Geração da Saída**

Após a compilação, o programa `compilador.exe` estará disponível no diretório raiz.

### **Analisando um Arquivo de Exemplo**

Para executar o analisador em um dos arquivos de exemplo e gerar o arquivo de reconhecimento de tokens (conforme exigido pelo trabalho), use o seguinte formato:

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

Ao final de cada comando, um arquivo `.txt` será criado no diretório, contendo a lista sequencial de todos os tokens que foram reconhecidos no programa de exemplo correspondente.

## **4. Limpando os Arquivos Gerados**

Para remover todos os arquivos gerados pelo processo de compilação (`.exe`, `.o`, `.c` e `.h` intermediários) e limpar o diretório, execute:

```bash
make clean
```
