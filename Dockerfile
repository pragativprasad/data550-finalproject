FROM rocker/r-ubuntu as base
RUN apt-get update && apt-get install -y pandoc


RUN mkdir /project
WORKDIR /project

RUN mkdir code
RUN mkdir output
RUN mkdir data
COPY code code
COPY Makefile .
COPY FluRSV_Report.Rmd .
COPY README.md .
COPY data data
COPY .gitignore .

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json

RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache

RUN R -e "renv::restore()"

RUN mkdir report

CMD make && mv FluRSV_Report.html report
