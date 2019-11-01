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
&& wget https://github.com/Kitware/CMake/releases/download/v3.15.5/cmake-3.15.5-Linux-x86_64.sh \
&& sh cmake-3.15.5-Linux-x86_64.sh --skip-license \
&& rm -Rf cmake* \
&& Rscript -e "install.packages('devtools')" \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&& Rscript -e "install.packages(c('misc3d', 'pixmap'))" \
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
&& Rscript -e "devtools::install_github('ANTsX/ANTsR')" \
\
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..." \
\
&& USER rstudio \
&& mkdir -p /home/rstudio/mydata \
&& echo -e 'ANTsR\nANTsRCore\nITKR' > /home/rstudio/.Rpackagedisplay \
&& echo "setwd('/home/rstudio/mydata')" > /home/rstudio/.Rprofile \
&& echo "Sys.setenv(ITK_GLOBAL_DEFAULT_NUMBER_OF_THREADS = system('nproc', intern=TRUE) )" >> /home/rstudio/.Rprofile \
&& echo "nthreads = system('echo $(nproc)', intern=TRUE)" >> /home/rstudio/.Rprofile \
&& echo "cat(paste('CPU cores/threads available:', nthreads, '\n'))" >> /home/rstudio/.Rprofile \
&& echo "cat('Memory available:\n')" >> /home/rstudio/.Rprofile \
&& echo "system('free -h')" >> /home/rstudio/.Rprofile \
&& echo "sessioninfo::package_info( read.table('/home/rstudio/.Rpackagedisplay', as.is=TRUE)$V1, dependencies = FALSE)" >> /home/rstudio/.Rprofile \
\
&& NOW=$(date +%s) && DIFF=$(( $NOW - $START )) && echo "Elapsed $DIFF seconds..."

