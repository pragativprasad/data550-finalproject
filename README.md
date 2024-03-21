# data550-finalproject

Final project for DATA 550 

------------------------------------------------------------------------

## Code Description

`code/01_data_cleaning.R`

  - creates cleaned data from files found in `data/raw/`
  - saves data as CSV files found in `data/` folder

`code/02_regression_analysis.R`

  - runs regression analysis of race on cumulative rate from cleaned data files in `data/` folder
  - outputs regression summary tables to `.rds` files in `output/` folder
  
`code/03_render_report.R`

  - renders `FluRSV_Report.Rmd`
  
`FluRSV_Report.Rmd`

  - reads in cleaned data files found in `data/raw/`
  - creates summary tables by race and age as well as epi curves for RSV and Flu
  - prints regression summary table for race on cumulative rate.

------------------------------------------------------------------------

