# based on the jupyter/scipy-notebook dockerfile
FROM jupyter/minimal-notebook:7a0c7325e470
COPY requirements.txt $HOME/
COPY jupyter_notebook_config.py $HOME/.jupyter/jupyter_notebook_config.py

ENV PYTHONPATH .:/app/fiddler_samples

# Install Python 3 packages
RUN pip --default-timeout=1000 install -r requirements.txt


# Copy config to root's home directory. Enables running as root.
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# Start as root. Allows running jupyter as users other than jovyan.
USER root

WORKDIR /tmp

COPY ./runit.sh /app/runit.sh

CMD /app/runit.sh
