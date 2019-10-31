# Docker file to build ANTsR from the rocker/rstudio base image
# using the devtools method to build from source.
FROM rocker/rstudio:3.6.1

LABEL maintainer='Dorian Pustina'

RUN \
cat /etc/*release \
&& echo "Building user:" `whoami` \
&& echo "Number of cores:" $(nproc) \
\
&& START=$(date +%s) \
\
&& apt-get install -f \
&& apt update && apt upgrade -y \
\
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
\
&& apt install -y \
curl \
git \
zlib1g-dev \
libxml2 \
libxml2-dev \
libssl-dev \
libcurl4-gnutls-dev \
libssh2-1-dev \
libgit2-dev \
\
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
\
&& wget https://github.com/Kitware/CMake/releases/download/v3.15.4/cmake-3.15.4.tar.gz \
&&  tar -zxf cmake-3.15.4.tar.gz \
&&  cd cmake-3.15.4 \
&&  ./configure \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&&  make \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&&  make install \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&& cd .. \
&& rm -Rf cmake* \
&& Rscript -e "install.packages('devtools')" \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&& Rscript -e "install.packages(c('misc3d', 'pixmap'))" \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&& Rscript -e "devtools::install_github('ANTsX/ANTsR')" \
\
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
\
USER rstudio \
&& mkdir -p /home/rstudio/mydata \
&& echo "setwd('/home/rstudio/mydata')" > /home/rstudio/.Rprofile \
&& echo "sessioninfo::package_info(c('ANTsR','ANTsRCore','ITKR'), dependencies = FALSE)" >> /home/rstudio/.Rprofile \
&& echo "Sys.setenv(ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS = system('nproc', intern=TRUE) )" >> /home/rstudio/.Rprofile \
\
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..."

