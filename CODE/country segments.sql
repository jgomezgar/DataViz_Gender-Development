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