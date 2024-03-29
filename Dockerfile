FROM ubuntu:22.04

# Install conda / mamba
RUN apt-get update && apt-get install -y wget

RUN CONDA="Mambaforge-pypy3-Linux-x86_64.sh" && \
    wget --quiet https://github.com/conda-forge/miniforge/releases/latest/download/$CONDA && \
    chmod +x $CONDA && \
    ./$CONDA -b -p /mambaforge-pypy3 && \
    rm -f $CONDA
ENV PATH /mambaforge-pypy3/bin:$PATH

# Install timeseriesplots
COPY . /timeseriesplots
WORKDIR /timeseriesplots

RUN mamba env update --name base --file install/system_deps.yml
RUN pip install -e ".[all]"

ADD Dockerfile /
