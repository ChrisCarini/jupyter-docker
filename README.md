# jupyter-docker

# Quick Start

```shell
make run
```

The above command will:

1. build the docker image
1. start the container
1. print the connection information

# Customizations

Below are the customizations / packages I added.

## Jupyter Extensions

### `jupyterlab-git`

* [PyPi](https://pypi.org/project/jupyterlab-git/)
* [GitHub](https://github.com/jupyterlab/jupyterlab-git)
* [Documentation](https://github.com/jupyterlab/jupyterlab-git/blob/master/README.md)

## ML / AI

### `matrixprofile`

* [PyPi](https://pypi.org/project/matrixprofile/)
* [GitHub](https://github.com/matrix-profile-foundation/matrixprofile)
* [Documentation](https://matrixprofile.docs.matrixprofile.org/api.html)
    * [Quick Start](https://matrixprofile.docs.matrixprofile.org/Quickstart.html)
    * [Examples](https://matrixprofile.docs.matrixprofile.org/examples.html)

**What/Why:** Neat library for mining time-series data.

**How did I discover this lib?:** I saw a talk/presentation about this at work.

**Example:** ✅ - [matrixprofile.ipynb](./workbooks/examples/ML%20and%20AI/matrixprofile.ipynb)

### `DoWhy`

* [PyPi](https://pypi.org/project/dowhy/)
* [GitHub](https://github.com/microsoft/dowhy)
* [Documentation](https://microsoft.github.io/dowhy/)

**What/Why:** An end-to-end library for causal inference.

**How did I discover this lib?:** Suggested from colleague at work (Shailesh).

**Example:** ❌ - Not yet `:(`

### `XGBoost`

* [PyPi](https://pypi.org/project/xgboost/)
* [GitHub](https://github.com/dmlc/xgboost)
* [Documentation](https://xgboost.readthedocs.io/en/latest/)

**What/Why:** e[X]treme [G]radient Boosting. XGBoost is an optimized distributed gradient boosting library designed to
be highly _**efficient**_, _**flexible**_ and _**portable**_.

**How did I discover this lib?:** Suggested from colleague at work (Shailesh).

**Example:** ❌ - Not yet `:(`

**NOTE:** XGBoost in JupyterLab has some special
sauce: https://jupyter-docker-stacks.readthedocs.io/en/latest/using/recipes.html#xgboost

### `interpret`

* [PyPi](https://pypi.org/project/interpret/)
* [GitHub](https://github.com/interpretml/interpret)
* Documentation - N/A
* Examples: https://github.com/interpretml/interpret#supported-techniques

**What/Why:** InterpretML is an open-source package that incorporates state-of-the-art machine learning interpretability
techniques under one roof. With this package, you can train interpretable glassbox models and explain blackbox systems.
InterpretML helps you understand your model's global behavior, or understand the reasons behind individual predictions.

**How did I discover this lib?:** Suggested from colleague at work (Shailesh).

**Example:** ❌ - Not yet `:(`

### `kiwisolver`

* [PyPi](https://pypi.org/project/kiwisolver/)
* [GitHub](https://github.com/nucleic/kiwi)
* [Documentation](https://kiwisolver.readthedocs.io/en/latest/)

**What/Why:** Kiwi is an efficient C++ implementation of the Cassowary constraint solving algorithm.

**How did I discover this lib?:** I discovered this as part of my readings / research for correlation analysis. I
believe I was investigating ways to 'trial & error' plugging in different 'weights' for correlation analysis work for
reliability calculations to identify the weight of subsystems.

**Example:** ❌ - Not yet `:(`

### `PyCaret`

* [PyPi](https://pypi.org/project/pycaret/)
* [GitHub](https://github.com/pycaret/pycaret)
* [Documentation](https://pycaret.readthedocs.io/en/latest/)

**What/Why:** PyCaret is an open source, _**low-code**_ machine learning library in Python that allows you to go from
preparing your data to deploying your model within minutes in your choice of notebook environment.

**How did I discover this lib?:** No idea. Maybe a suggestion from a colleague at work (Shailesh)?

**Example:** ❌ - Not yet `:(`

### `pyfpgrowth`

* [PyPi](https://pypi.org/project/pyfpgrowth/)
* [GitHub](https://github.com/evandempsey/fp-growth)
* [Documentation](https://fp-growth.readthedocs.org/)

**What/Why:** A Python implementation of the Frequent Pattern Growth algorithm.

**How did I discover this lib?:** Discovered this library when reading up on FPGrowth.

**Example:** ❌ - Not yet `:(`

## Data Visualization

### `Datashader`

* [PyPi](https://pypi.org/project/datashader/)
* [GitHub](https://github.com/holoviz/datashader/)
* [Documentation - Website](https://datashader.org/)

**What/Why:** Datashader is a graphics pipeline system for creating meaningful representations of large datasets quickly
and flexibly.

**How did I discover this lib?:** Suggested from colleague at work (Grant). Also posted by Christopher Walker in work
Slack channel #oneliners back in mid-2020.

**Example:** ❌ - Not yet `:(`

### `Panel`

* [PyPi](https://pypi.org/project/panel/)
* [GitHub](https://github.com/holoviz/panel/)
* [Documentation - Website](https://panel.holoviz.org/)

**What/Why:** Panel is an open-source Python library that lets you create custom interactive web apps and dashboards by
connecting user-defined widgets to plots, images, tables, or text.

**How did I discover this lib?:** It was likely pulled in from `Datashader` or `Holoviews`.

**Example:** ✅ - [holoviz - panel.ipynb](./workbooks/examples/Data%20Visualization/holoviz%20-%20panel.ipynb)

### `Lux`

* [PyPi](https://pypi.org/project/lux-api/)
* [GitHub](https://github.com/lux-org/lux)
* [Documentation](https://lux-api.readthedocs.io/en/latest/source/getting_started/installation.html)

**What/Why:** Lux is a Python library that makes data science easier by automating aspects of the data exploration
process. Lux facilitate faster experimentation with data, even when the user does not have a clear idea of what they are
looking for.

**How did I discover this lib?:** Suggested from colleague at work (Jim).

### `seaborn`

* [PyPi](https://pypi.org/project/seaborn/)
* [GitHub](https://github.com/mwaskom/seaborn/)
* [Documentation](https://seaborn.pydata.org/)

**What/Why:** Seaborn is a library for making statistical graphics in Python.

**How did I discover this lib?:** Found when researching heatmaps for correlation diagram.

**Example:** ❌ - Not yet `:(`

### `holoviews`

* [PyPi](https://pypi.org/project/holoviews/)
* [GitHub](https://github.com/holoviz/holoviews)
* [Documentation](https://www.holoviews.org/)

**What/Why:** Stop plotting your data - annotate your data and let it visualize itself.

Library designed to make data analysis and visualization seamless and simple. With HoloViews, you can usually express
what you want to do in very few lines of code, letting you focus on what you are trying to explore and convey, not on
the process of plotting.

**How did I discover this lib?:** No idea.

**Example:** ❌ - Not yet `:(`

## EDA (Exploratory Data Analysis)

### `pandas-profiling`

* [PyPi](https://pypi.org/project/pandas-profiling/)
* [GitHub](https://github.com/pandas-profiling/pandas-profiling)
* [Documentation](https://pandas-profiling.github.io/pandas-profiling/docs/master/rtd/)

**What/Why:** `pandas_profiling` extends the pandas DataFrame with `df.profile_report()` for quick data analysis.
Outputs HTML reports.

**How did I discover this lib?:** Discovered as part of my research of EDA libraries.

**Example:** ✅ - [pandas-profiling.ipynb](./workbooks/examples/EDA/pandas-profiling.ipynb)

### `sweetviz`

* [PyPi](https://pypi.org/project/sweetviz/)
* [GitHub](https://github.com/fbdesignpro/sweetviz)
* [Documentation - Basic Usage](https://github.com/fbdesignpro/sweetviz#basic-usage)

**What/Why:** In-depth EDA (target analysis, comparison, feature analysis, correlation) in two lines of code! Outputs
HTML reports.

**How did I discover this lib?:** Discovered as part of my research of EDA libraries.

**Example:** ✅ - [sweetviz.ipynb](./workbooks/examples/EDA/sweetviz.ipynb)

## General / Misc / Other

### `requests`

* [PyPi](https://pypi.org/project/requests/)
* [GitHub](https://github.com/psf/requests)
* [Documentation](https://docs.python-requests.org/en/master/)

**What/Why:** I occasionally need to `GET` some data or `POST` some data. I prefer doing that through `requests`.

**How did I discover this lib?:** `requests` is a super common library for making web requests.

**Example:** ❌ - Not yet `:(`

# Notes

_**On OSX**_, you will need to increase docker:

- memory to 4GB+
- storage to 24GB+

# (`make`) Commands

- `make run` — Run the container (will build the Docker image if not built already)
- `make lab` — Alias for `make run`
- `make access` — Print the access information for the JupyterLab instance
- `make stop` — Stop the Docker container
- `make login` — Access a `bash` prompt within the container
- `make build` — Build the Docker image
- `make rebuild` — Rebuild the Docker image (overrides any caches)
- `make clean`
    1) Stop the Docker container
    2) Remove container, network, volumes and images
    3) Remove the stopped container

# NOTES

Look into https://github.com/marketplace/actions/build-and-push-docker-images