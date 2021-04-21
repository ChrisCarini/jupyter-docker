FROM jupyter/datascience-notebook

# Opt to use Jupyter Lab instead of Notebook
# Ref: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html?highlight=JUPYTER_ENABLE_LAB#docker-options
ENV JUPYTER_ENABLE_LAB=yes

# Upgrade lab version + rebuild
RUN pip install --upgrade jupyterlab && \
    jupyter lab build && \

    # Cleanup (index caches/lock files/etc..)
    conda clean --all -f -y && \

    # Correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install from requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/

# Install Python Packages & Requirements (Done near end to avoid invalidating cache)
RUN pip install --user -r /tmp/requirements.txt && \

    # Extension TOC
    jupyter labextension install @jupyterlab/toc && \

#    # NOTE: THE BELOW CAN NOT BE ENABLED BECAUSE IT FAILS WITH THE BELOW ERROR:
#    #      ValueError: The extension "@pyviz/jupyterlab_pyviz" does not yet
#    #      support the current version of JupyterLab.
#    # HoloViz Extension
#    # Ref: https://holoviz.org/installation.html#step-4-option-b-launch-jupyterlab
#    jupyter labextension install @pyviz/jupyterlab_pyviz && \

    # Cleanup (index caches/lock files/etc..)
    conda clean --all -f -y && \

    # Correct permissions
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Set the user to be $NB_USER so the notebook directory is correct.
USER $NB_USER

# Overwrite the notebook directory...
CMD [ "start-notebook.sh", "--notebook-dir=~/workbooks" ]
