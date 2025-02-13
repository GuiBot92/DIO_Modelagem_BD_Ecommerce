# DIO-projects
Projetos criados durante curso na DIO

Descrição do Projeto Conceitual da Modelagem de cenário de E-commerce:

Produto:
- Os produtos são vendidos por uma única plataforma online. Contudo, estes podem ter vendedores distintos(terceiros)
- Cada produto possui um fornecedor
- Um ou mais produtos podem compor um pedido

Cliente:
- O Cliente pode se cadastrar no site com CPF ou CNPJ (não os 2)
- Endereço do cliente irá determinar o valor do frete
- Um cliente pode comprar mais de um pedido. Este tem um período de carência para devolução do produto

Pedido:
- Pedidos são criados por clientes e possuem informações de compra, endereço e status da entrega
- Um produto ou mais compõem o pedido
- O pedido pode ser cancelado

Pagamento:
- Pode ter cadastrado mais de uma forma de pagamento

Entrega:
- Possui status e Código de rastreio
