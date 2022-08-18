/* Luiz Roberto Francisconi
#### AULA 3  ###

Insert com sub select criando uma nova tabela Vendas_Produtos2

Funções contagem dos Registro das Vendas_Produtos

Função de Agregação(SUM) dos Registros de um de Valor Qualquer da Tabela Vendas_Produtos

Função de adição um valor e quantidade de um ID de registro da tabela Vendas_Produtos
*/

## Insert com sub select criando uma nova tabela Vendas_Produtos2

create table vendas_produtos2(
select * from Vendas_produtos)

insert into vendas_produtos2(select id_Vendas_Prod,Nome_produtos,Valor,Quantidade,id_cad
from vendas_produtos)

select * from vendas_produtos2

## Funções contagem dos Registro das Vendas_Produtos

select count(*) as contador from vendas_produtos;

## Função de Agregação(SUM) dos Registros de um de Valor Qualquer da Tabela Vendas_Produtos

select sum(Quantidade) as QT_TOTAL, sum(valor) as VL_TOTAL from vendas_produtos;

select * from vendas_produtos

## Função de adição um valor e quantidade de um ID de registro da tabela Vendas_Produtos

select(Quantidade+valor),quantidade,valor,nome_produtos from vendas_produtos
