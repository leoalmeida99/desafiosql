use sucos_vendas;

select * from tabela_de_produtos;
select * from itens_notas_fiscais;
select * from  notas_fiscais;

select * from tabela_de_produtos TP
inner join itens_notas_fiscais INF 
on TP.codigo_do_produto = INF.codigo_do_produto
inner join notas_fiscais NF
on INF.numero = NF.numero;

select TP.sabor, NF.data_venda, sum(quantidade * preco) from tabela_de_produtos TP
inner join itens_notas_fiscais INF 
on TP.codigo_do_produto = INF.codigo_do_produto
inner join notas_fiscais NF
on INF.numero = NF.numero
where TP.sabor = 'açai'
group by TP.sabor, NF.data_venda;

select TP.sabor, NF.data_venda, sum(quantidade * preco) from tabela_de_produtos TP
inner join itens_notas_fiscais INF 
on TP.codigo_do_produto = INF.codigo_do_produto
inner join notas_fiscais NF
on INF.numero = NF.numero

where year(NF.data_venda) = 2016
group by TP.sabor, NF.data_venda;
-- minha selecao principal:
select TP.sabor, extract(YEAR from NF.data_venda), sum(quantidade * preco) as SOMA from tabela_de_produtos TP
inner join itens_notas_fiscais INF 
on TP.codigo_do_produto = INF.codigo_do_produto
inner join notas_fiscais NF
on INF.numero = NF.numero
where year(data_venda) = 2016
group by TP.sabor, extract(YEAR from NF.data_venda)
order by SOMA desc;
-- selecao para descobrir o total (100%)
select sum(quantidade * preco) as SOMA from tabela_de_produtos TP
inner join itens_notas_fiscais INF 
on TP.codigo_do_produto = INF.codigo_do_produto
inner join notas_fiscais NF
on INF.numero = NF.numero
where year(data_venda) = 2016;


-- selecao final
select TP.sabor, extract(YEAR from NF.data_venda), sum(quantidade * preco), (sum(quantidade * preco) / 42362119.43621111) * 100
from tabela_de_produtos TP 
inner join itens_notas_fiscais INF 
on TP.codigo_do_produto = INF.codigo_do_produto
inner join notas_fiscais NF
on INF.numero = NF.numero
where year(data_venda) = 2016
group by TP.sabor, extract(YEAR from NF.data_venda)
order by sum(quantidade * preco) desc;