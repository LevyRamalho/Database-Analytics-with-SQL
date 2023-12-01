# @AUTHOR: LEVY RAMALHO
# ESSE CÓDIGO VAI SE FOCAR EM ANÁLISE EXPLORATÓRIA

## Qual a taxa de churn total?

# CAST é usada para garantir que o resultado seja convertido para o formato esperado
SELECT TotalNumbersOfCustomers,
		TotalNumberOfChurnedCustumers,
        CAST((TotalNumberOfChurnedCustumers * 1.0 / TotalNumbersOfCustomers * 1.0) * 100 AS DECIMAL(10,2)) AS ChurnRate
        FROM 
        (SELECT COUNT(*) AS TotalNumbersOfCustomers
        FROM ecommerce.ecommercechurn) AS Total,
        (SELECT COUNT(*) AS TotalNumberOfChurnedCustumers
        FROM ecommerce.ecommercechurn
        WHERE CustomerStatus = 'churned') AS Churned;
        
## Como a taxa de churn varia com base no Dispositivo de login?

SELECT preferredlogindevice,
	COUNT(*) AS TotalCustomers,
    SUM(churn) AS ChurnedCustomers,
    CAST(SUM(churn) * 1.0 / COUNT(*) * 100 AS DECIMAL(10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY PreferredLoginDevice;

## Existe correlação entre a distância warehouse-to-home e churns?

# 1º Vou organizar em grupos de distâncias

ALTER TABLE ecommerce.ecommercechurn 
ADD warehousetohomerange VARCHAR(50);

UPDATE ecommerce.ecommercechurn 
SET warehousetohomerange =
CASE 
	WHEN warehousetohome <= 10 THEN 'Very close distance'
    WHEN warehousetohome > 10 AND warehousetohome <= 20 THEN 'Close distance'
    WHEN warehousetohome > 20 AND warehousetohome <= 30 THEN 'Moderate distance'
    WHEN warehousetohome > 30 THEN 'Far distance'
END;

# Encontrando a Taxa de churn por grupo de distância

SELECT warehousetohomerange,
		COUNT(*) AS TotalCustomer,
        SUM(Churn) AS CustomerChurn,
        CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL (10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY warehousetohomerange
ORDER BY ChurnRate DESC;

## Qual é o modo de pagamento preferido entre os clientes churned?

SELECT PreferredPaymentMode,
		COUNT(*) AS TotalCustomer,
        SUM(Churn) AS CustomerChurn,
        CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL (10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY PreferredPaymentMode
ORDER BY ChurnRate DESC;

## Qual é o Tenure tipico dos clientes churned?

ALTER TABLE ecommerce.ecommercechurn
ADD TenureRange VARCHAR(50);

UPDATE ecommerce.ecommercechurn
SET TenureRange =
CASE 
	WHEN tenure <= 6 THEN '6 Months'
	WHEN tenure > 6 AND tenure <= 12 THEN '1 Year'
	WHEN tenure > 12 AND tenure <= 24 THEN '2 Years'
	WHEN tenure > 24 THEN 'more than 2 years'
END;

SELECT TenureRange,
		COUNT(*) AS TotalCustomer,
        SUM(Churn) AS CustomerChurn,
        CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL (10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY TenureRange
ORDER BY ChurnRate DESC;

## Exite diferença na taxa de churn entre clientes Masculinos e Feminino?

SELECT gender,
		COUNT(*) AS TotalCustomer,
        SUM(Churn) AS CustomerChurn,
        CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL (10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY gender
ORDER BY ChurnRate DESC;

## Como a média de tempo usado no APP difere entre clientes churned e não churned

SELECT customerstatus, AVG(HourSpendOnApp) AS MediaHoraAPP
FROM ecommerce.ecommercechurn
GROUP BY CustomerStatus;

## O número de Dispositivos cadastrados impacta na probabilidade de churn?

SELECT NumberOfDeviceRegistered,
		COUNT(*) AS TotalCustomer,
        SUM(Churn) AS CustomerChurn,
        CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL (10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY NumberOfDeviceRegistered
ORDER BY ChurnRate DESC;

## Qual categoria é mais preferida entre os clientes que churned?

SELECT PreferedOrderCat,
		COUNT(*) AS TotalCustomer,
        SUM(Churn) AS CustomerChurn,
        CAST(SUM(Churn) * 1.0 /COUNT(*) * 100 AS DECIMAL (10,2)) AS ChurnRate
FROM ecommerce.ecommercechurn
GROUP BY PreferedOrderCat
ORDER BY ChurnRate DESC;