# Análise de Churn em E-Commerce

<aside>
📌 Esse projeto foi desenvolvido com o intuito de concatenar meus conhecimentos em SQL.

</aside>

# Análise de Churn em E-Commerce

## Visão Geral:

---

Esse projeto foi desenvolvido com o propósito de desenvolver minhas habilidade com a linguagem SQL. Diante isso, esse projeto buscará tratar e analisar a base de dados disponível no [Kaggle](https://www.kaggle.com/datasets/ankitverma2010/ecommerce-customer-churn-analysis-and-prediction?sort=most-comments) sobre Churn em E-commerce de modo a responder perguntas de negócio e oferecer recomendações.

> **Churn:** churn refere-se à situação em que os clientes decidem parar de fazer negócios com uma empresa; rotatividade; cancelamento.
> 

## Atividades:

---

Utilizando a biblioteca **sqlalchemy** do python, inseri os dados da base extraída do Kaggle em um Banco de Dados MYSQL. 

### [Limpeza e transformação de dados:](https://github.com/LevyRamalho/Database-Analytics-with-SQL/blob/main/data_cleaning.sql)

---

1. Checar se há duplicatas.
2. Checar se há valores NULL.
3. Corrigir valores NULL pela média de cada coluna.
4. Criar uma coluna especificando se um cliente churned ou não.
5. Criar  uma coluna especificando se um cliente registrou reclamações.
6. Corrigir a redundância na coluna PreferredLoginDevice.
7. Corrigir a redundância na coluna PreferedOrderCat.
8. Corrigir a redundância na coluna PreferredPaymentMode.
9. Corrigir outlier 127 e 126 na coluna WarehouseToHome.

### [Análise e resposta de perguntas de negócio:](https://github.com/LevyRamalho/Database-Analytics-with-SQL/blob/main/data_analises.sql)

---

1. Qual a taxa de churn total?
    
    O número de consumidores do E-commerce é de 5630, sendo 948 clientes que churned. Desse modo, a taxa de churn total é de 16,84%.
    
2. Como a taxa de churn varia com base no Dispositivo de login?
    
    Cliente que utilizando o celular como forma de login têm taxa de churn de 15,62%, em quanto clientes que utilizam o computador como forma de login tem taxa de churn de 19,83%. Portanto, é perceptível que aparentemente há uma influencia da forma de login na taxa de churn, sendo os usuários de computadores a maior taxa de churn o que indica que usuários desse tipo provavelmente tem padrões e preferências especificas. 
    
3. Existe alguma correlação entre a distância entre o armazém e a casa e a rotatividade de clientes?
    
    Consumidores que moram distantes tem a maior taxa de churn, chegando a 20,90%. Isso sugere que fatores como prazos de entrega, custos de envio ou conveniência podem desempenhar um papel na retenção de clientes. O E-commerce pode utilizar dessa análise para obter insights de melhoria em processos de logística ou criar estratégias de retenção para clientes que mora distante.   
    
4. Qual é o modo de pagamento preferido entre os clientes churned?
    
    O  método de pagamento mais comum entre os clientes que param de comprar nesse E-commerce é o Pagamento na entrega.
    
5. Qual é a Permanência típica dos clientes churned?
    
    Os clientes que deixam de comprar tem em sua maioria permanência de 6 meses. Isso indica que a companhia pode criar estratégias de Customers Experience que visam a retenção desse perfil de clientes. A Companhia possivelmente tende a fidelizar clientes com mais de 2 anos de permanência visto que esses tem a menor taxa de churn.
    
6. Existe diferença na taxa de churn entre clientes Masculinos e Feminino?
    
    Ambos os gêneros apresentam taxa de churn, sendo que clientes masculinos apresentam uma taxa de rotatividade ligeiramente maior em consideração ao gênero feminino. 
    
7. Como a média de tempo usado no APP difere entre clientes churned e não churned?
    
    Ambos, churned e não churned, apresentam a mesma média de uso do APP, sendo assim, aparentemente, o a média de tempo usado no APP não apresenta impacto na taxa de churn.
    
8. O número de Dispositivos cadastrados impacta na probabilidade de churn?
    
    Parece haver uma correlação entre o número de dispositivos registrados pelos clientes e a probabilidade de rotatividade. Clientes com maior número de dispositivos cadastrados, como 6 ou 5, apresentam maiores taxas de rotatividade. Por outro lado, clientes com menos dispositivos cadastrados, como 2 ou 1, apresentam taxas de cancelamento relativamente mais baixas.
    
9. Qual categoria é mais preferida entre os clientes que churned?
    
    Os clientes que encomendam principalmente itens na categoria “Celular” apresentam a maior taxa de rotatividade, indicando uma necessidade imediata de estratégias de retenção direcionadas para este grupo.