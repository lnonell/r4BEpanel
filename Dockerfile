#################################################################
# Dockerfile
#
# Version:          1
# Software:         R
# Description:      R and necessary packages for the analysis of the NGS hemato panel data 
# Website:          NO https://github.com/isglobal-brge/nlOmicAssoc|https://hub.docker.com/r/lnonell/nlomicsassoc
# Tags:             None, for the moment
# Base Image:       R
#################################################################

##Image created on a debian
FROM r-base:3.4.0

## Install the R packages, some of those are necessary for the bioconductor's packages.  NOTE: failure to install a package doesn't throw an image build error.
RUN apt-get update && apt-get build-dep -y \
    r-cran-xml 

RUN install2.r -r "http://www.omegahat.net/R" --deps TRUE \
    Rcompression \
    && rm -rf /tmp/downloaded_packages/


RUN install2.r --error --deps TRUE \
    RCurl \
    # parallel \
    RSQLite \
    matrixStats \
    futile.logger \
    && rm -rf /tmp/downloaded_packages/


## Add BiocInstaller and graph which is needed for igraph
RUN install2.r -r http://bioconductor.org/packages/3.5/bioc --deps TRUE \
    Biobase \
    CopywriteR \
    Rsamtools \
    && rm -rf /tmp/downloaded_packages/

## Finally ready to install the R packages.  NOTE: failure to install a package doesn't throw an image build error.

##That's all for the moment
