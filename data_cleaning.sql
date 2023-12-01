# @AUTHOR: LEVY RAMALHO
# ESSE CÓDIGO VAI SE FOCAR EM LIMPAR OS DADOS PARA UMA FUTURA ANÁLISE EXPLORATÓRIA

# Ecnontrando o total de Consumidores
SELECT DISTINCT COUNT(CustomerID) as TotalDeConsumidores
FROM ecommerce.ecommercechurn;

# Checando se há duplicatas de linhas

SELECT CustomerID, COUNT(CustomerID) as Count
FROM ecommerce.ecommercechurn
GROUP BY CustomerID 
HAVING COUNT(CustomerID) > 1;

# Checando Valores NULL

SELECT 'Tenure' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE Tenure IS NULL
UNION #UNION VAI ENCADEAR OS RESULTADOS GERANDO UMA ÚNICA TABELA
SELECT 'WarehouseToHome' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE WarehouseToHome IS NULL
UNION
SELECT 'HourSpendonApp' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE HourSpendonApp IS NULL
UNION
SELECT 'OrderAmountHikeFromLastYear' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE OrderAmountHikeFromLastYear IS NULL
UNION
SELECT 'CouponUsed' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE CouponUsed IS NULL
UNION
SELECT 'OrderCount' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE OrderCount IS NULL
UNION
SELECT 'DaySinceLastOrder' as ColumnName, COUNT(*) AS NullCounts
FROM ecommerce.ecommercechurn
WHERE DaySinceLastOrder IS NULL;

# CORRIGINDO OS VALORES NULL PELA MÉDIA DE CADA COLUNA
UPDATE ecommerce.ecommercechurn
SET Tenure = (
				SELECT avg_tenure
                FROM (
					SELECT AVG(Tenure) AS avg_tenure
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE Tenure IS NULL;

UPDATE ecommerce.ecommercechurn
SET WarehouseToHome = (
				SELECT avg_WarehouseToHome
                FROM (
					SELECT AVG(WarehouseToHome) AS avg_WarehouseToHome
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE WarehouseToHome IS NULL;

UPDATE ecommerce.ecommercechurn
SET HourSpendonApp = (
				SELECT avg_HourSpendonApp
                FROM (
					SELECT AVG(HourSpendonApp) AS avg_HourSpendonApp
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE HourSpendonApp IS NULL;

UPDATE ecommerce.ecommercechurn
SET OrderAmountHikeFromLastYear = (
				SELECT avg_OrderAmountHikeFromLastYear
                FROM (
					SELECT AVG(OrderAmountHikeFromLastYear) AS avg_OrderAmountHikeFromLastYear
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE OrderAmountHikeFromLastYear IS NULL;

UPDATE ecommerce.ecommercechurn
SET CouponUsed = (
				SELECT avg_CouponUsed
                FROM (
					SELECT AVG(CouponUsed) AS avg_CouponUsed
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE CouponUsed IS NULL;

UPDATE ecommerce.ecommercechurn
SET OrderCount = (
				SELECT avg_OrderCount
                FROM (
					SELECT AVG(OrderCount) AS avg_OrderCount
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE OrderCount IS NULL;

UPDATE ecommerce.ecommercechurn
SET DaySinceLastOrder = (
				SELECT avg_DaySinceLastOrder
                FROM (
					SELECT AVG(DaySinceLastOrder) AS avg_DaySinceLastOrder
                    FROM ecommerce.ecommercechurn
					) AS avg_table
                )
WHERE DaySinceLastOrder IS NULL;

# Criando uma coluna especificando se um cliente churnou ou não

ALTER TABLE ecommerce.ecommercechurn
ADD CustomerStatus VARCHAR(50);

UPDATE ecommerce.ecommercechurn
SET CustomerStatus =
CASE 
	WHEN Churn = 1 THEN 'Churned'
    WHEN Churn = 0 THEN 'Stayed'
END;

# Criando uma coluna especificando se um cliente Registrou reclamações

ALTER TABLE ecommerce.ecommercechurn 
ADD ComplainRecieved VARCHAR(50);

UPDATE ecommerce.ecommercechurn
SET ComplainRecieved =
CASE 
	WHEN Complain = 1 THEN 'Yes'
    WHEN Complain = 0 THEN 'No'
END;

# Corrigindo a redundacia em  PreferredLoginDevice

SELECT DISTINCT PreferredLoginDevice
FROM ecommerce.ecommercechurn;

UPDATE ecommerce.ecommercechurn
SET PreferredLoginDevice = 'Phone'
WHERE PreferredLoginDevice = 'Mobile Phone';

# Corrigindo a redundacia em  PreferedOrderCat

SELECT DISTINCT PreferedOrderCat
FROM ecommerce.ecommercechurn;

UPDATE ecommerce.ecommercechurn
SET PreferedOrderCat = 'Phone'
WHERE PreferedOrderCat = 'Mobile Phone';

# Corrigindo a redundacia em  PreferredPaymentMode

SELECT DISTINCT PreferredPaymentMode
FROM ecommerce.ecommercechurn;

UPDATE ecommerce.ecommercechurn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';

# Corrigindo outlier 127 e 126 em WarehouseToHome

SELECT DISTINCT WarehouseToHome
FROM ecommerce.ecommercechurn;

UPDATE ecommerce.ecommercechurn
SET WarehouseToHome = '27'
WHERE WarehouseToHome = '127';

UPDATE ecommerce.ecommercechurn
SET WarehouseToHome = '26'
WHERE WarehouseToHome = '126';