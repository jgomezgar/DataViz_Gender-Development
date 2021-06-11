# Gender Gap and Development
## DataViz_Gender-Development


## Data preparation

Data preparation has been developed in two phases:

ETL of the data files:
- Loading of country data.
- Loading of World Bank country development indicators.
  (https://datacatalog.worldbank.org/dataset/world-development-indicators)
- Loading of World Bank country government indicators.
  (https://info.worldbank.org/governance/wgi/)
 
ETLs have been developed with Pentaho Data integration (PDI) and loaded into SQLServer DB.

The code can be found in files with extension ".ktr".
 
**Preparation of the data to adapt it to the graphs:**

Mainly the following tasks have been developed:
- Selection of Features.
- Calculations for the creation of derived indicators.
- Pivoting and unpivoting of Features to adapt them to the needs of the chart.

The code can be found in files with extension ".sql ".

## Visualizations:

Developed with Tableau Public (Dash final version) and flourish (Dash proptotypes).

**Dashboard to detect the relationship between economic and government indicators and the birth rate on teenage mothers:**

In this graph it is found that although in isolation, there is no clear relationship between the different variables. But combinated all of them, the more economic and government variables with high values, the lower the birth rate in teenage mothers.

On the other hand, two groups of variables can be established:
*Economic variables, which include:*
- GDP per capita.
- Energy consumption per capita
- Human capital index

*Freedom and good governance variables:*
- Government Effectiveness Index
- Political Stability and No Violence
- Voice and Accountability

https://public.tableau.com/app/profile/jose.luis.gomez2469/viz/EconomicFreedomIndexoverAdolescentFertility/EconomicvsFreedomindexes

**Non Remunerated Family Workers by Gender**

After carefully analyzing the variables with differentiation by gender, as well as the completeness of the information using the flourish Prototype: ( https://public.flourish.studio/visualisation/6404387/ )

Following Dashboard, which shows both the level of development of the country or grouping, by the degree of non-remunerated family workers, but above all the gender gap.

https://public.tableau.com/app/profile/jose.luis.gomez2469/viz/NonRemuneratedFamilyWorkersbyGender/NonRemunerateFamilyWorkersbyGender
