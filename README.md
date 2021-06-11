# Gender Gap and Development
## DataViz_Gender-Development

**Data preparation has been developed in two phases:** 

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
