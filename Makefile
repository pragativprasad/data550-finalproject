FluRSV_Report.html: FluRSV_Report.Rmd code/03_render_report.R data regression
	Rscript code/03_render_report.R

data: code/01_data_cleaning.R data/rsv_age.csv data/rsv_race.csv data/rsv_epicurve.csv data/flu_age.csv data/flu_race.csv data/flu_epicurve.csv
	Rscript code/01_data_cleaning.R
	
regression: code/02_regression_analysis.R 
	Rscript code/02_regression_analysis.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f FluRSV_Report.html
	
.PHONY: install
install: 
	Rscript -e "renv::restore(prompt=FALSE)"
	
PROJECTFILES = FluRSV_Report.Rmd code/01_data_cleaning.R code/02_regression_analysis.R code/03_render_report.R data/rsv_age.csv data/rsv_race.csv data/rsv_epicurve.csv data/flu_age.csv data/flu_race.csv data/flu_epicurve.csv Makefile README.md .gitignore  
RENVFILES = renv.lock renv/activate.R renv/settings.json .Rprofile

# Project Image
resp_image: Dockerfile $(PROJECTFILES) $(RENVFILES)
	docker build -t resp_image .
	touch $@

# On Mac
docker-resp-report:
	docker run -v "$$(pwd)"/report:/project/report resp_image	

# On Windows
docker-resp-report-w:
	docker run -v "/$$(pwd)"/report:/project/report resp_image