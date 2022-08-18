# Utilizar selects para fazer comandos DML e DDL no banco de dados

# Criar uma tabela ou uma cópia utilizando select

create table produtos2(
select * from produtos
where quantidade>=10)

select * from produtos2

# Insert dos valores de outra tabela

insert into produtos2 (select id_prod,Nome_Produtos,Valor,Quantidade,id_cad
from produtos)

# Não fazer subselect para insert e delete 
### para insert vai escolher o campo inteiro mudando o nome de todos os campos
# update produtos2 sete nome_produtos="abacaxi"
# where nome_produtos in (select nome_produtos from produtos);
# isso vai tornar todo campo nome_produtos em abacaxi
# e delete from produtos2
# where nome_produtos in (select nome_produtos from produtos);
# vai deletar todo o campo, zerar os dados

########## Funções de agregação ####

# São responsáveis por agrupar os valores e retornar um único valor

## Order by - ordenar por um campo da tabela

select Nome_cadastro,Nome_produtos,Quantidade,valor,cadastro.id_cad,produtos.id_cad
from produtos,cadastro
where cadastro.id_cad = produtos.id_cad
order by Quantidade

# para inserir novos registros
insert into produtos(Nome_produtos,Valor,Quantidade,id_cad) values ("Laranja",3.50,15,1)

# Group by ele agrupa valores repetidos

select Nome_produtos,Nome_cadastro
from cadastro,produtos
where cadastro.id_cad = produtos.id_cad
group by Nome_produtos
order by nome_produtos

## Count conta os registros de uma tabela

select count(*) as contador from produtos;

select nome_cadastro, nome_produtos,count(nome_produtos) as contagem
from produtos,cadastro
where cadastro.id_cad=produtos.id_cad
group by Nome_produtos

## Contagem condicional  (relacional) com o having count

select nome_cadastro,valor,nome_produtos,count(nome_produtos) as contagem_produtos,cadastro.id_cad as ID_cadastro,produtos.id_cad as ID_produtos
from produtos,cadastro
where cadastro.id_cad=produtos.id_cad
group by nome_produtos
having count(nome_produtos) <=3

# Funções MAX e MIN

select min(Quantidade) as QT_PROD_MIN,max(Quantidade) as QT_PROD_MAX from produtos

# Função SUM soma todos os valores em um valor final único

select sum(quantidade) as QT_TOTAL,sum(valor) as VL_TOTAL from produtos;

# Função média aritimética 

select avg(valor) as Media from produtos


# Função format
select format(avg(valor),3) as Media from produtos



## CRUD ##
# create or insert
# read (select)
# update
# delete

#### Funções de string ####

# função substring utilizada para capturar parte dos dados de string

# função length é utilizada para capturar comprimento de caracter

select nome_produtos from produtos
where substr(nome_produtos,1,2) = "ma"
and length(nome_produtos)>4

# Concat combina e junta resultados

select concat(nome_cadastro,"   gosta de: ") as pessoas,nome_produtos as gosto_frutas from 
cadastro,produtos
where cadastro.id_cad=produtos.id_cad
order by nome_cadastro

## Concatws ele concatena utilizando um delimitador (para exportar para csv)

select concat_ws(";",nome_produtos,Quantidade,valor) from produtos
where nome_produtos like "L%"

# Lcase e Ucase lower case minúsculo e uppercase maiúsculo

select lcase(nome_cadastro) as minusculo, ucase(nome_cadastro) as maiusculo from cadastro

## Funções de calculos ####

select pi()  # valor de pi

select round(233.674464,2) from dual; # arrendonda com duas casas decimais 

select sqrt(4) as raiz_quadrada

select round(sqrt(534.66),2) as raiz_quadrada

## Funções matemáticas ####

## + - * /

select(Quantidade*valor) as multiplicacao from produtos
where id_prod=4 # sem essa linha vai fazer com todas as linhas e não apenas =4

# Adição (subtração, divisão.. basta mudar o operador)

select(Quantidade+valor) as multiplicacao from produtos
where id_prod=4 # sem essa linha vai fazer com todas as linhas e não apenas =4

#### Funções de data e manipulação de datas ######

### Trazer a data atual

select curdate()

select now()

#date campo de somente data
#datetime campo de data e hora
#time campo de hora apenas
# no projeto pode ser usado um campo de datetime

# current_timesptamp adiciona o carimbo de data e hora no momento da inserção do registro (na hora de criar a tabela)

# Todo campo de data precisamos utilizar aspas para trazer no select e o formato da data 
# "2022-08-02"

# A hora atual

select curtime()

## Analisar intervalo de datas

select datediff("2021-03-20","2020-09-04") as diferenca_dias

## adicionar dias a uma data

select date_add("2019-01-01",interval 60 day)

## Retorna o dia da semana de uma data
select dayname("2018-12-26")

# extrair ano de uma data
select extract(year now())
# hora
select extract(hour now())

#### Retorna o último dia do mês

select last_day

# Formatar o padrão de datas
select date_format(curdate(),get_format(date,"EUR"))

## Transformar uma data em texto e valor de data

select str_to_date("05.05.2019",get_format(date,"USA"))

### condicionais IF e CASE ########

#### if é quando temos uma condição lógica verdadeira
#### case é quando temos várias condições lógicas verdadeiras (uso no projeto)

### testar a quantidade de frutas em estoque e trazer resultado baixo ou alto

select nome_produtos,quantidade,if(quantidade<=20,"Baixo","Alto") as Estoque # se quantidade de nome produtos for menor ou igual a 20 print baixo, senão printa alto
from produtos


select valor,
if(valor<>10.00,"Diferente","Igual") as Classificacao
from produtos

# Vamos supor que temos um controle e analise de estoque
# vamos utilizar os case para validar os níveis

select Nome_produtos,quantidade as Qtdade,

case
when quantidade <=4 then "Baixo estoque"
when quantidade <=15 then "Estoque bom"
when quantidade <=30 then "Estoque médio"
else "Estoque alto"
end as Quantidade,
count(*) quantidade
from produtos
group by quantidade
order by quantidade;



#### Analisar clientes com compras quantidade acima de 10

select nome_cadastro,nome_produtos,quantidade,
if(quantidade>=10,"Alto","Baixo") as Compras_clientes
from produtos join cadastro on
cadastro.id_cad=produtos.id_cad
order by Compras_clientes

### Trazer vendas boas e ruins

select 
case
when quantidade<=10 then "Clientes com poucas vendas"
else "Clientes com vendas boas"
end as Compras_Clientes,
count(*) Nome_cadastro
from produtos join cadastro on
produtos.id_cad=cadastro.id_cad
group by Compras_Clientes
order by Compras_Clientes






