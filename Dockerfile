FROM rocker/r-ver:4.0.5
RUN apt-get update && apt-get install -y  libcurl4-openssl-dev libssl-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("httr",upgrade="never", version = "1.4.2")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.0.2")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
RUN rm -rf /build_zone
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');asnDeploy::run_app()"
