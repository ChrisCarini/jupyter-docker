# If I ever dive into R / Julia, I'll probably want to use the `datascience-notebook`;
# until then, I will just stick with the scipy to keep this image smaller.
#
# Docs: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
#FROM jupyter/datascience-notebook
FROM jupyter/scipy-notebook:lab-3.3.2

# Opt to use Jupyter Lab instead of Notebook
# Ref: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/common.html?highlight=JUPYTER_ENABLE_LAB#docker-options
ENV JUPYTER_ENABLE_LAB=yes

# Update apt & install `graphviz` (needed for `pm4py` library). Note: This needs to be done as the `root` user.
USER root
RUN whoami && apt-get update && apt-get install -y graphviz
USER $NB_USER

# Install from requirements.txt file
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/

# Install Python Packages & Requirements (Done near end to avoid invalidating cache)
RUN pip install -r /tmp/requirements.txt && \
    ##
    # Extensions
    ##

    # Lux Widget - https://github.com/lux-org/lux#setup-in-jupyter-lab
    jupyter labextension install --no-minimize @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install --no-minimize luxwidget && \

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
