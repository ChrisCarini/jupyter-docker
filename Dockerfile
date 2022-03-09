# If I ever dive into R / Julia, I'll probably want to use the `datascience-notebook`;
# until then, I will just stick with the scipy to keep this image smaller.
#
# Docs: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
#FROM jupyter/datascience-notebook

# We pin the Docker image tag to this specific one because it was the tag when I
# most recently was able to build my own Dockerfile. When using the `latest` tag
# on 2021-07-10, I was receiving the below error, which did not seem to make any
# sense:
#
#        #8 49.05 ERROR: Cannot install -r /tmp/requirements.txt (line 2), -r /tmp/requirements.txt (line 6) and -r /tmp/requirements.txt (line 9) because these package versions have conflicting dependencies.
#        #8 49.05
#        #8 49.05 The conflict is caused by:
#        #8 49.05     dowhy 0.6 depends on scikit-learn
#        #8 49.05     lux-api 0.3.1 depends on scikit-learn>=0.22
#        #8 49.05     pycaret 2.3.2 depends on scikit-learn==0.23.2
#        #8 49.05
#        #8 49.05 To fix this you could try to:
#        #8 49.05 1. loosen the range of package versions you've specified
#        #8 49.05 2. remove package versions to allow pip attempt to solve the dependency conflict
#        #8 49.05
#        #8 49.05 ERROR: ResolutionImpossible: for help visit https://pip.pypa.io/en/latest/user_guide/#fixing-conflicting-dependencies
#
# This did not make sense to me because the version resolution seemed to be logical
# based on the error message; just resolve to `scikit-learn==0.23.2`. However, it
# seems that the scipy-notebook Dockerfile (ref: https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile)
# has a dependency `scikit-learn=0.24.*`, which might be why this is happening.
FROM jupyter/scipy-notebook:584f43f06586

# Opt to use Jupyter Lab instead of Notebook
# Ref: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html?highlight=JUPYTER_ENABLE_LAB#docker-options
ENV JUPYTER_ENABLE_LAB=yes

# Upgrade lab version + rebuild
RUN pip install --upgrade jupyterlab \
        # Git Support (Adds sidebar for Git) - https://github.com/jupyterlab/jupyterlab-git
        jupyterlab-git \
    && \
    jupyter lab build --no-minimize && \

    # Cleanup (index caches/lock files/etc..)
    conda clean --all -f -y && \

    # Correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install from requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/

# Install Python Packages & Requirements (Done near end to avoid invalidating cache)
RUN pip install -r /tmp/requirements.txt && \

    ##
    # Extensions
    ##

    # Table of Contents - https://github.com/jupyterlab/jupyterlab-toc
    jupyter labextension install --no-minimize @jupyterlab/toc && \

#    # TODO - Disabled due to lack of JupyterLab 3.0 support - https://github.com/jupyterlab/jupyterlab-data-explorer/issues/143
#    # Data Explorer - https://github.com/jupyterlab/jupyterlab-data-explorer
#    jupyter labextension install @jupyterlab/dataregistry-extension && \

#    # TODO - Disabled due to lack of JupyterLab 3.0 support - https://github.com/jupyterlab/jupyterlab-shortcutui/issues/63
#    # Shortcut UI - https://github.com/jupyterlab/jupyterlab-shortcutui
#    jupyter labextension install @jupyterlab/shortcutui && \

    # GitHub - https://github.com/jupyterlab/jupyterlab-github
    jupyter labextension install --no-minimize @jupyterlab/github && \

    # Cleanup (index caches/lock files/etc..)
    conda clean --all -f -y && \

    # Correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Set the user to be $NB_USER so the notebook directory is correct.
USER $NB_USER

# Overwrite the notebook directory...
CMD [ "start-notebook.sh", "--notebook-dir=~/workbooks" ]
