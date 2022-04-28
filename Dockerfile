FROM runtimeverificationinc/kframework-k:ubuntu-focal-release

RUN python3 -m pip install --no-cache-dir notebook jupyterlab

RUN pip install --no-cache-dir jupyterhub

RUN pip install --index-url https://test.pypi.org/simple/ k_jupyter_poc==0.0.0
RUN python3 -m k_jupyter_poc.install

ARG NB_USER=kdoc
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
	
# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}