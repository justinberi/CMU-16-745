FROM jupyter/julia-notebook

# Install jupyter-book
RUN pip install jupyter-book

# Precompile the packages
USER root
RUN --mount=type=bind,target=./,readwrite \
cd optimalcontrol \
&& julia -e 'import Pkg; Pkg.activate(@__DIR__); Pkg.instantiate()'

# # https://medium.com/@coderun003/running-julia-interpreter-on-jupyter-notebook-docker-container-in-7-simple-steps-3a5fac566bb5
# RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.9/julia-1.9.3-linux-x86_64.tar.gz \
# && tar -xvzf julia-1.9.3-linux-x86_64.tar.gz \
# && mv julia-1.9.3 /opt/.
#\
# && ln -s /opt/julia-1.9.3/bin/julia /usr/local/bin/julia

# RUN julia -e 'using Pkg; Pkg.add("IJulia")'

# RUN apk add --no-cache build-base linux-headers musl-dev gcc python3-dev py3-pip
# RUN pip install jupyter-book

USER jovyan