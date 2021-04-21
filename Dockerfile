# If I ever dive into R / Julia, I'll probably want to use the `datascience-notebook`;
# until then, I will just stick with the scipy to keep this image smaller.
#
# Docs: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
#FROM jupyter/datascience-notebook

FROM jupyter/scipy-notebook

# Opt to use Jupyter Lab instead of Notebook
# Ref: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html?highlight=JUPYTER_ENABLE_LAB#docker-options
ENV JUPYTER_ENABLE_LAB=yes

# Upgrade lab version + rebuild
RUN pip install --upgrade jupyterlab \
        # Git Support (Adds sidebar for Git) - https://github.com/jupyterlab/jupyterlab-git
        jupyterlab-git \
    && \
    jupyter lab build && \

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
    jupyter labextension install @jupyterlab/toc && \

#    # TODO - Disabled due to lack of JupyterLab 3.0 support - https://github.com/jupyterlab/jupyterlab-data-explorer/issues/143
#    # Data Explorer - https://github.com/jupyterlab/jupyterlab-data-explorer
#    jupyter labextension install @jupyterlab/dataregistry-extension && \

#    # TODO - Disabled due to lack of JupyterLab 3.0 support - https://github.com/jupyterlab/jupyterlab-shortcutui/issues/63
#    # Shortcut UI - https://github.com/jupyterlab/jupyterlab-shortcutui
#    jupyter labextension install @jupyterlab/shortcutui && \

#    # TODO - Disabled due to lack of JupyterLab 3.0 support - https://github.com/jupyterlab/jupyterlab-github/issues/111
#    # GitHub - https://github.com/jupyterlab/jupyterlab-github
#    jupyter labextension install @jupyterlab/github && \

    # Cleanup (index caches/lock files/etc..)
    conda clean --all -f -y && \

    # Correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Set the user to be $NB_USER so the notebook directory is correct.
USER $NB_USER

# Overwrite the notebook directory...
CMD [ "start-notebook.sh", "--notebook-dir=~/workbooks" ]
