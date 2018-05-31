FROM rootproject/root-ubuntu16:latest

LABEL author="nuria.castello.mor@gmail.com" \
    version="1.0" \
    description="Docker image for DQM4HEP for DAMIC"

USER 0

# uid (-u) and group IDs (-g) are fixed to 1000 to be used for development
# purposes
RUN useradd -u 1000 -md /home/damicuser -ms /bin/bash -G builder,sudo damicuser \
    && echo "damicuser:docker" | chpasswd \
    && echo "damicuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Correct base image to include ROOT python module
ENV PYTHONPATH="${PYTHONPATH}:/usr/local/lib/root"
# Include ROOT libraries
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib/root"

RUN apt-get update && apt-get -y install \
    cmake build-essential \
    qt4-dev-tools \
    #libxerces-c-dev \
    libgl1-mesa-dev \
    #libxmu-dev \
    #libmotif-dev \
    #libexpat1-dev \
    #libboost-all-dev \
    xfonts-75dpi \
    xfonts-100dpi \
    #imagemagick \
    wget \
    vim \
    # XXX --> TO Be deleted with new version dqm4hep
    liblog4cxx-dev \
    libaprutil1-dev \ 
    # subversion \ 
    # XXX --> TO Be deleted with new version dqm4hep
    #tk \
    #ipython \
    #python-numpy \
    #python-scipy \
    #python-matplotlib \
    && apt-get autoremove && rm -rf /var/lib/apt/lists/*

# Boot and damic source container with GEANT4 started
WORKDIR /damic

# Download dq4hep
RUN cd /damic && git clone -b release-1.4.4 https://github.com/DQM4HEP/dqm4hep.git \
    && cd dqm4hep && mkdir build && cd build \
    # ONlye valid for release-1.4.4.
    && cmake .. -DBUILD_DQMVIZ=ON -DBUILD_DQM4ILC=OFF -DBUILD_EXAMPLES=OFF -DINSTALL_DOCS=OFF -DDIM_GUI=OFF -DFORCE_DIMJC_INSTALL=ON\
    && make -j4 \
    && chown -R damicuser:damicuser /damic

USER damicuser

ENV HOME /home/damicuser
ENV PATH="${PATH}:/damic/dqm4hep/bin"
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/damic/dqm4hep/lib"
ENV DIM_DNS_NODE="localhost"
#ENV DQM4HEP_PLUGIN_DLL="/damic/ddama/lib/libddama.so"

ENTRYPOINT ["/bin/bash"]


