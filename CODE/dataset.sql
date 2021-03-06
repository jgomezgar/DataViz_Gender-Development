with datagov as (
SELECT 
      [Stad]
	,[Code]
      ,[Country/Territory]
      ,([Estimate_16]+
      [Estimate_17]+
      [Estimate_18]+
      [Estimate_19]+
      [Estimate_20])/5 estimate

    --  ,[Estimate]
  FROM [DB_jgomezgar].[dbo].[WDI_DataGov]
  where ([Estimate_16]+
      [Estimate_17]+
      [Estimate_18]+
      [Estimate_19]+
      [Estimate_20]) is not null
) 

,gov as (
select 	[Code] Country_Code
      ,[Country/Territory] Country
	  ,[GovernmentEffectiveness]
	  ,[Political StabilityNoViolence]
	  ,[VoiceandAccountability]
FROM  datagov

PIVOT  
(  
  sum(estimate)  
  FOR [Stad] IN ([GovernmentEffectiveness]
				,[Political StabilityNoViolence]
				,[VoiceandAccountability])  
) AS PivotTable

where  [GovernmentEffectiveness] +
	  [Political StabilityNoViolence] +
	  [VoiceandAccountability] is not null
)

, country as (
SELECT  [Country Code]
      ,[Short Name]
      ,[Table Name]
      ,[Long Name]
    --  ,[2-alpha code]
    --  ,[Currency Unit]
    --  ,[Special Notes]
      ,[Region]
      ,[Income Group]
	  ,[Other groups]
	  ,[GovernmentEffectiveness]
	  ,[Political StabilityNoViolence]
	  ,[VoiceandAccountability]     
  FROM  gov  join 
  [DB_jgomezgar].[dbo].[WDI_Country] c on  gov.country_code = c.[Country Code]
  where [Currency Unit] is not NULL
)

, pop as (
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

, population as (
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
)



SELECT 
	 c.[Country Code]
      ,c.[Short Name]
      ,c.[Table Name]
      ,c.[Long Name]
    --  ,[2-alpha code]
    --  ,[Currency Unit]
    --  ,[Special Notes]
      ,c.[Region]
      ,c.[Income Group]
	  ,c.[Other groups]
	  ,c.[GovernmentEffectiveness]
	  ,c.[Political StabilityNoViolence]
	  ,c.[VoiceandAccountability] 
	  ,Pop_female
	  ,Pop_male
	  ,Pop_total
		,[Adolescent fertility %]
		,[Women justified in beating %]
		,[Energy pc]
		,[GDP pc]
		,[Human capital index]
		,[Statistical performance indicator]
	  ,[Indicator Name]
      ,[Indicator Code]
     -- ,[YEAR]
      ,avg([value]) [value]

  FROM [DB_jgomezgar].[dbo].[WDI_Data] d
  join country c on c.[Country Code] = d.[Country Code]
  join population p on c.[Country Code] = p.[Country Code]
  where 
  
  year in (2015,2016,2017,2018,2019) and
  [Indicator Code]  in 
  ('SE.SEC.UNER.LO.FE.ZS','SE.SEC.UNER.LO.MA.ZS',
  'SL.FAM.WORK.FE.ZS','SL.FAM.WORK.MA.ZS',
  'SL.EMP.TOTL.SP.FE.NE.ZS','SL.EMP.TOTL.SP.MA.NE.ZS',
  'HD.HCI.OVRL.FE','HD.HCI.OVRL.MA',
  'SL.UEM.NEET.FE.ZS','SL.UEM.NEET.MA.ZS')
group by 
	 c.[Country Code]
      ,c.[Short Name]
      ,c.[Table Name]
      ,c.[Long Name]
    --  ,[2-alpha code]
    --  ,[Currency Unit]
    --  ,[Special Notes]
      ,c.[Region]
      ,c.[Income Group]
	  ,c.[Other groups]
	  ,c.[GovernmentEffectiveness]
	  ,c.[Political StabilityNoViolence]
	  ,c.[VoiceandAccountability]  
	  ,Pop_female
	  ,Pop_male
	  ,Pop_total
		,[Adolescent fertility %]
		,[Women justified in beating %]
		,[Energy pc]
		,[GDP pc]
		,[Human capital index]
		,[Statistical performance indicator]
	,[Indicator Name]
      ,[Indicator Code]

having count(year) =5