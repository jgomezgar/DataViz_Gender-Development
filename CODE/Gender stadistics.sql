/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct   [Country Code]
      ,[Short Name] Country
      ,[Region]
      ,[Income Group]
  

-- Derived Features Economic & Freedom Index
      ,round((isnull([GovernmentEffectiveness]      -min([GovernmentEffectiveness]) over()      ,0)/ (max([GovernmentEffectiveness]) over()       -min([GovernmentEffectiveness]) over()         )
      +isnull([Political StabilityNoViolence]-min([Political StabilityNoViolence]) over() ,0)/ (max([Political StabilityNoViolence]) over() -min([Political StabilityNoViolence]) over()   )
      +isnull([VoiceandAccountability]       -min([VoiceandAccountability]) over()        ,0)/ (max([VoiceandAccountability]) over()        -min([VoiceandAccountability]) over()          ))*100/3,2)  Freedom_Index
      
	  ,round((isnull([Energy pc]                    -min([Energy pc]) over()                   ,0)/ (max([Energy pc]) over()                     -min([Energy pc]) over()                       )
      +isnull([GDP pc]                       -min([GDP pc]) over()                       ,0)/ (max([GDP pc]) over()                        -min([GDP pc]) over()                          )
      +isnull([Human capital index]          -min([Human capital index]) over()          ,0)/ (max([Human capital index]) over()           -min([Human capital index]) over()             ))*100/3,2) Economy_Index

      ,case when CHARINDEX('female',[Indicator Name],1) > 1 then 'Female' else 'Male' end Gender
      ,
	  iif(charindex(',', [Indicator Name])>0,
						LEFT([Indicator Name], charindex(',', [Indicator Name]) - 1) ,
						[Indicator Name])	   [Indicator Name]

      ,round([value],2) [value]
  FROM [DB_jgomezgar].[dbo].[WDI_ready_Data]
-- null & outliers
  where [GDP pc] is not null and 
  [Country Code] not in ('LUX','QAT','SGP')

  