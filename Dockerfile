FROM fredhutch/ichorcna:latest

RUN Rscript -e "install.packages('optparse', repos='https://cloud.r-project.org')"

WORKDIR /ichorCNA
