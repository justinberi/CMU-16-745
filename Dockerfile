FROM jupyter/julia-notebook

# Install jupyter-book
RUN pip install jupyter-book

# Install julia packages from the optimalcontrol directory
RUN --mount=type=bind,target=./,readwrite \
    cd optimalcontrol \
    && julia -e 'import Pkg; Pkg.activate(@__DIR__); Pkg.instantiate()'

# Do last. Fix permissions so the NB_USER can install more packages live
RUN chown "${NB_USER}" "${JULIA_PKGDIR}" \
    && fix-permissions "${JULIA_PKGDIR}"