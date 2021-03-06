/****** Script for SelectTopNRows command from SSMS  ******/

with pop as (
SELECT  [Country Name]
      ,[Country Code]
      ,[Indicator Name]
      ,[Indicator Code]
     -- ,[YEAR]
      ,avg([value]) [value]

  FROM [DB_jgomezgar].[dbo].[WDI_Data]
  where 
  
  year >= 2010 -- (2015,2016,2017,2018,2019) 
  and
  [Indicator Code]  in ('SP.POP.TOTL.FE.IN','SP.POP.TOTL.MA.IN',
  'SP.ADO.TFRT','EG.USE.PCAP.KG.OE','NY.GDP.PCAP.KD','NY.GDP.PCAP.PP.KD','HD.HCI.OVRL','IQ.SCI.OVRL','IQ.SPI.OVRL','SG.VAW.REAS.ZS')
group by 
       [Country Name]
      ,[Country Code]
      ,[Indicator Name]
      ,[Indicator Code]
)


select [Country Name]
      ,[Country Code]
	  ,sum([Population, female]) +sum([Population, male])  Pop_total
	  ,sum([Population, female]) Pop_female
	  ,sum([Population, male]) Pop_male
	  ,sum([Adolescent fertility rate (births per 1,000 women ages 15-19)])/10 [Adolescent fertility %], 
sum([Women who believe a husband is justified in beating his wife (any of five reasons) (%)]) [Women justified in beating %],

sum([Energy use (kg of oil equivalent per capita)]) [Energy pc],
--sum([GDP per capita (constant 2010 US$)]) [GDP per capita],
sum([GDP per capita, PPP (constant 2017 international $)])[GDP pc],
sum([Human capital index (HCI) (scale 0-1)]) [Human capital index], 
--sum([Statistical Capacity score (Overall average)]),
sum([Statistical performance indicators (SPI): Overall score (scale 0-100)]) [Statistical performance indicator]

From pop 
PIVOT  
(  
  sum([value])
  FOR [Indicator Name] IN ([Population, female],[Population, male],
  [Adolescent fertility rate (births per 1,000 women ages 15-19)],[Energy use (kg of oil equivalent per capita)],[GDP per capita (constant 2010 US$)],[GDP per capita, PPP (constant 2017 international $)],[Human capital index (HCI) (scale 0-1)],[Statistical Capacity score (Overall average)],[Statistical performance indicators (SPI): Overall score (scale 0-100)],[Women who believe a husband is justified in beating his wife (any of five reasons) (%)])  
) AS PivotTable
 
group by 
		[Country Name]
      ,[Country Code]
having sum([Population, female]) is  not null and sum([Statistical performance indicators (SPI): Overall score (scale 0-100)]) is not null
order by 1
