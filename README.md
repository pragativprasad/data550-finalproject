# data550-finalproject

Final project for DATA 550 

------------------------------------------------------------------------

## Code Description

`code/01_data_cleaning.R`

  - creates cleaned data from files found in `data/raw/`
  - saves data as CSV files found in `data/` folder
  - run `make data` to run this script

`code/02_regression_analysis.R`

  - runs regression analysis of race on cumulative rate from cleaned data files in `data/` folder
  - outputs regression summary tables to `.rds` files in `output/` folder
  - run `make regression` to run this script

`code/03_render_report.R`

  - renders `FluRSV_Report.Rmd`
  - run `make FluRSV_Report.html` to run this script
  
`FluRSV_Report.Rmd`

  - reads in cleaned data files found in `data/raw/`
  - creates summary tables by race and age as well as epi curves for RSV and Flu
  - prints regression summary table for race on cumulative rate.
  - called by `code/03_render_report.R` 

------------------------------------------------------------------------

How to synchronize packages:

1. Run `Rscript renv/activate.R`.
2. Run `make install` to restore package versions.

------------------------------------------------------------------------

How to build Docker image:

  Run `make resp_image`
 
------------------------------------------------------------------------

How to create FluRSV_Report.html repory:

  Run `make docker-run`

------------------------------------------------------------------------