Mesmo que as tabelas de um schema estejam com os INDEX bem colocados, pode ser que haja lentidões nas queryes com o passar do tempo, e isso acontece normalmente pelo fato dos metadados da(s) tabela(s) estarem desatualizados, e uma solução pra isso seria dar um CHECK TABLE e estaria tudo bem, mas vamos um pouco além disso.
Quando deletamos um registro de uma tabela, o espaço que aquela linha ocupava em disco permanecerá sendo ocupado, pois um DELETE nada mais é que a alteração de 1 bit daquele registro, e não a remoção física do mesmo.
Para a resolver essas duas questões podemos aplicar um OPTIMIZE TABLE nas tabelas (Mais detalhes sobre a função dele aqui https://dev.mysql.com/doc/refman/8.0/en/optimize-table.html), mas fazer isso manualmente para cada tabela pode ser um saco, e como ele faz um lock na tabela durante sua execução acabaria ficando custoso esperar até o momento em que haja menos processos rodando no banco.
Para isso a preguiça falou alto, e anos atrás eu fiz uma PROCEDURE que resolveria esse problema, colocando ela dentro de um evento que acontece no meio da madrugada.
Lentidões e problemas de armazenamento caíram drasticamente, deixando de ser uma preocupação tão presente, e resolvi compartilhar com vocês essa receitinha.
Para quem está aprendendo MySQL também acredito que possa ser de grande uso e aprendizado, pois deixei o código o mais limpo possível.