# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# Get a minimal notebook from the public Docker jupyter images
FROM jupyter/minimal-notebook
# Switch to root to install new components
USER root
# Update index
RUN apt-get update
# Install minimal OpenModelica Components
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt xenial nightly"; done | sudo tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | sudo apt-key add -
RUN apt-key fingerprint
RUN apt-get update
RUN apt-get install -y openmodelica
# Switch back to jupyter notebook default user to install the OpenModelica kernel
USER $NB_UID
# Install OMPython and jupyter-openmodelica kernel
RUN pip install -U git+git://github.com/OpenModelica/OMPython.git
RUN pip install -U git+git://github.com/OpenModelica/jupyter-openmodelica.git



