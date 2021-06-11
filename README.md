# DataViz_Gender-Development
Gender Gap and Development

**Data preparation has been developed in two phases:**

ETL of the data files:
- Loading of country data
- Loading of development indicators by countries of the world bank
  (https://datacatalog.worldbank.org/dataset/world-development-indicators)
- Loading of government indicators by countries from the World Bank ().
  (https://info.worldbank.org/governance/wgi/)
 
The ETLs have been developed with Pentaho Datra integration (PDI) and loaded into a SQLServer DB.
Files included.
Find the code under the files with extension ".ktr"
 
**Preparation of data to be adapted to graphs:**

Mainly the following have been developed the following tasks:
- Selection of Features
- Calculations for the creation of derived indicators.
- Pivot and unpivot of Features to adapt to the needs of the chart.

Find the code under the files with extension ".sql"
