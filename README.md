# Projeto de Banco de Dados E-commerce

Este projeto envolve a criação de um esquema de banco de dados relacional para uma plataforma de e-commerce. O banco de dados modela um sistema típico de e-commerce com diversas entidades, como clientes, produtos, pedidos, pagamentos, fornecedores e gerenciamento de estoque. Abaixo está uma visão geral da estrutura:

## Tabelas:
- **Cliente**: Armazena informações sobre os clientes, incluindo clientes individuais (PF) e empresariais (PJ).
- **Pessoa Física (PF)**: Contém detalhes sobre clientes individuais (ex: nome, CPF, data de nascimento).
- **Pessoa Jurídica (PJ)**: Armazena informações sobre clientes empresariais (ex: CNPJ, nome da empresa).
- **Terceiro Fornecedor**: Representa vendedores ou fornecedores terceiros, incluindo seus dados da empresa e informações de contato.
- **Fornecedor**: Contém detalhes sobre fornecedores de produtos, incluindo CNPJ e informações da empresa.
- **Produto**: Armazena os detalhes dos produtos, como categoria, descrição e preço.
- **Pedido**: Acompanha os pedidos dos clientes, seu status, descrição e detalhes de envio.
- **Pagamento**: Contém os detalhes de pagamento associados aos pedidos, como status e método (cartão de crédito, débito, boleto, Pix).
- **Estoque**: Gerencia o inventário, incluindo localizações e quantidades disponíveis.
- **Transportadora**: Representa as empresas logísticas responsáveis pelas entregas.
- **Entrega**: Acompanha os status das entregas e detalhes como número de rastreamento e transportadora.

## Tabelas Relacionais:
O banco de dados também inclui várias tabelas relacionais para gerenciar relacionamentos muitos-para-muitos:
- **Terceiro Fornecedor vs Produto**: Relaciona os fornecedores terceiros aos produtos que oferecem.
- **Fornecedor vs Produto**: Relaciona os fornecedores aos produtos que fornecem.
- **Pedido vs Produto**: Representa quais produtos fazem parte de quais pedidos, juntamente com as quantidades.
- **Estoque vs Produto**: Acompanha os níveis de estoque de cada produto em diferentes localizações.
- **Pagamento vs Pedido**: Relaciona os pagamentos aos pedidos com os valores pagos.
- **Entrega vs Pedido**: Relaciona as entregas aos pedidos, incluindo endereços de entrega e datas.

## Principais Características:
- **Gestão de Clientes**: O banco de dados suporta tanto clientes individuais quanto empresariais.
- **Catálogo de Produtos**: Gerencia produtos de diferentes fornecedores com dados de preços e inventário.
- **Processamento de Pedidos**: Acompanha o ciclo de vida dos pedidos, incluindo status de pagamento e entrega.
- **Pagamentos e Transações**: Suporta diferentes métodos de pagamento e acompanha o status das transações.
- **Estoque e Entregas**: Fornece informações sobre os níveis de estoque dos produtos e o rastreamento de entregas com múltiplos provedores logísticos.

Este banco de dados serve como a espinha dorsal para uma plataforma de e-commerce, permitindo a gestão eficiente de produtos, pedidos, pagamentos e logística, ao mesmo tempo em que suporta diferentes tipos de clientes e fornecedores.
