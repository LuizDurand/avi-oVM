# 🛫 AviãoVM – Definição da Linguagem (EBNF)

## 🎯 Objetivo
A **AviãoVM** é uma linguagem de programação de alto nível projetada para interagir com uma máquina virtual que simula o funcionamento básico de um avião.  
A linguagem possui variáveis, condicionais, loops e instruções específicas para controlar o voo, como **decolar, pousar, subir, descer e acelerar**.  

O compilador dessa linguagem terá como destino um Assembly simplificado que manipula registradores da VM (`ALTITUDE`, `VELOCIDADE`) e sensores (`COMBUSTIVEL`, `CLIMA`).  

---

## 🏗️ Estruturas da Linguagem

### 📌 Declarações
- `inteiro x;` → declara uma variável inteira.  

### 📌 Comandos de ação
- `decolar();`  
- `pousar();`  
- `acelerar(10);`  
- `frear();`  
- `subir(1000);`  
- `descer(500);`  
- `girar("esquerda");`  

### 📌 Estruturas de controle
- `se ... entao ... senao ...`  
- `enquanto ... faca ...`  

### 📌 Entrada/Saída
- `escrever(expr);` → imprime valor no console.  

---

## 📜 Definição em EBNF

```ebnf
program         = { declaration | statement } ;

declaration     = "inteiro" identifier ";" ;

statement       = assign | action | conditional | loop | io ;

assign          = identifier ":=" expression ";" ;

action          = "decolar()" ";"
                | "pousar()" ";"
                | "acelerar(" number ")" ";"
                | "frear()" ";"
                | "subir(" number ")" ";"
                | "descer(" number ")" ";"
                | "girar(" direction ")" ";" ;

conditional     = "se" expression "entao" block [ "senao" block ] ;

loop            = "enquanto" expression "faca" block ;

io              = "escrever(" expression ")" ";" ;

block           = "{" { statement } "}" ;

expression      = term { ("+" | "-" | "*" | "/" | ">" | "<" | "==") term } ;
term            = number | identifier | sensor ;

sensor          = "COMBUSTIVEL" | "CLIMA" | "ALTITUDE" | "VELOCIDADE" ;

direction       = '"esquerda"' | '"direita"' ;

identifier      = letter { letter | digit } ;
number          = digit { digit } ;
letter          = "a"…"z" | "A"…"Z" ;
digit           = "0"…"9" ;
```

---

## 💻 Exemplo de Programa em AviãoVM

```avm
inteiro x;
x := 2;

decolar();
enquanto COMBUSTIVEL > 0 faca {
    acelerar(15);
    subir(1000);
    x := x - 1;
    se x == 0 entao {
        pousar();
    }
}
escrever(ALTITUDE);
```
