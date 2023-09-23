# Refer to https://hub.docker.com/r/jupyter/datascience-notebook/Dockerfile for examples etc
FROM jupyter/julia-notebook

# Install jupyter-book
RUN python3 -m pip install --no-cache-dir jupyter-book==0.15.1

# Install julia packages from the optimalcontrol directory
RUN --mount=type=bind,target=./,readwrite \
    cd optimalcontrol \
    && julia -e 'import Pkg; Pkg.activate(@__DIR__); Pkg.instantiate(); Pkg.precompile();'

# Do last. Fix permissions so the NB_USER can install more packages live
RUN chown "${NB_USER}" "${JULIA_PKGDIR}" \
    && fix-permissions "${JULIA_PKGDIR}"

# Note have to change/reset user
USER root
RUN apt-get update && apt-get install -y \
    vim \
 && rm -rf /var/lib/apt/lists/*
USER $NB_UID
