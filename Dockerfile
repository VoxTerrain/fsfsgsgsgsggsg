# Use an official Jupyter base image
FROM jupyter/base-notebook:latest

# Switch to root user
USER root

# Install ngrok
RUN apt-get update && \
    apt-get install -y unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip -d /usr/local/bin && \
    rm ngrok-stable-linux-amd64.zip

# Switch back to the default Jupyter user
USER $NB_UID

# Set ngrok authtoken
ENV NGROK_AUTH_TOKEN 2MExnEkkUINhCYUztZ6pqFtrRJb_2ZE2neXSvVNQqY7AhWjAs

# Expose port 8080
EXPOSE 8080

# Start Jupyter Notebook with --allow-root flag
CMD ["start-notebook.sh", "--allow-root", "--port=8080", "--NotebookApp.allow_origin='*'", "--NotebookApp.disable_check_xsrf=True", "--NotebookApp.notebook_dir=/home/$NB_USER/work"]

# Expose ngrok web interface for monitoring (optional)
EXPOSE 4040
