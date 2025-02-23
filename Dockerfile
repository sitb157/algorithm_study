FROM ubuntu:20.04

# 1. Update & install Python 3 + pip
RUN apt-get update && apt-get install -y python3 python3-pip

# 2. Install notebook < 7, nbextensions, plus the JSONSchema “format-nongpl” extras
RUN pip3 install --upgrade pip && \
    pip3 install \
      "notebook<7" \
      jupyter_contrib_nbextensions \
      "jsonschema[format-nongpl]"

# 3. Install nbextensions for the user
RUN jupyter contrib nbextension install --user

# 4. (Optional) Enable specific extensions
RUN jupyter nbextension enable hinterland/hinterland

# 5. Configure Jupyter
RUN mkdir -p /root/.jupyter && \
    echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.password = ''" >> /root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.token = ''" >> /root/.jupyter/jupyter_notebook_config.py

CMD ["jupyter", "notebook", "--allow-root"]
