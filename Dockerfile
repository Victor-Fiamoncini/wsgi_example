FROM python:3.11.6-slim

# Installs python sys dependencies as admin user
RUN apt-get update \
    && apt-get install --no-install-recommends -y gcc g++ libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Create and use a "my_user" user
RUN useradd -ms /bin/bash my_user

# Switch to the new user and set the home directory as the working directory
WORKDIR /home/my_user
COPY --chown=my_user:my_user . .

# Switches to the new user for installing python packages
USER my_user

# Installs dependencies
RUN pip install --no-cache-dir -r requirements.txt -r requirements_dev.txt

# Checks that uwsgi is installed and available in the PATH
RUN /home/my_user/.local/bin/uwsgi --version

# Sets PATH environment variable
ENV PATH="/home/my_user/.local/bin:$PATH"

# Runs the WSGI server as the "my_user" user
CMD ["sh", "run_wsgi_server.sh"]
