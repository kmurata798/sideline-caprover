# FROM library/python:3.7-alpine as base

# # Section 1/2: INSTALL DEPENDENCIES
# FROM base as builder

# RUN mkdir /code
# WORKDIR /code
# RUN apk --no-cache --quiet add gcc make g++ bash git openssh \
#         curl build-base libffi-dev python-dev py-pip \
#         jpeg-dev zlib-dev libsass-dev

# # Install pillow globally.
# ENV LIBRARY_PATH=/lib:/usr/lib

# # Add requirements.txt before rest of repo for caching.
# COPY requirements.txt /requirements.txt

# # Install project dependencies before copying the rest of the codebase.
# RUN python -m pip install -r /requirements.txt


# # Section 2/2:

# FROM base
# COPY --from=builder /code /usr/local

# RUN apk --no-cache --quiet add libpq

# # Set project path for use throughout the script.
# ENV PROJECT_PATH=/usr/src/app

# # Echo the directory to install as a sanity check.
# RUN echo "Installing into $PROJECT_PATH..."

# # Create project directory on the image.
# RUN mkdir -p $PROJECT_PATH

# # Create directories the project depends upon.
# RUN mkdir -p $PROJECT_PATH/media
# RUN mkdir -p $PROJECT_PATH/static/assets

# # We need a .env file to start the server.
# #COPY deploy/.env.captain $PROJECT_PATH/.env
# RUN touch $PROJECT_PATH/.env

# # Run all commands in this new directory.
# WORKDIR $PROJECT_PATH

# # Copy this directory to the image.
# COPY . $PROJECT_PATH

# # Open port 80 to traffic.
# EXPOSE 8080 80 443

# # Run a startup script in the specified directory.
# CMD sh /usr/src/app/deploy/run.sh

# My codeeeeeeeeeeeeeeeee
# ===========================================================================================

# # -==- Section 1/2: Installing dependencies -==-
# FROM library/python:3.7-alpine as base
# FROM base as builder


# # Create a new directory inside of the container
# RUN mkdir /code

# # Assign the new directory created as the working directory (Which folder we want all of our commands to execute in.)
# WORKDIR /code


# # Install all required libraries to allow our installed dependencies to function properly
# # --no-cache allows users to avoid using a local cache by installing packages with an index that is updated automatically
# # --quiet suppresses the build output and print image ID on success
# # zlib-dev is for Pillow package
# RUN apk --no-cache --quiet add gcc make g++ bash git openssh \
#         sqlite curl build-base libffi-dev python-dev py-pip \
#         jpeg-dev zlib-dev


# # Make a copy of the project's requirements.txt and put it in 
# COPY requirements.txt /code

# # Install dependencies found in requirements.txt
# RUN pip install -r requirements.txt

# # Install Pillow package dependency separately after requirements.txt to avoid Pillow building error with docker
# RUN pip install Pillow

# # -==- Section 2/2: Running project -==-
# FROM base
# COPY --from=builder /code /usr/local

# # Set project path for use throughout the script.
# ENV PROJECT_PATH=/usr/src/app

# # Echo the directory to install as a sanity check.
# RUN echo "Installing into $PROJECT_PATH..."

# # Create project directory on the image.
# RUN mkdir -p $PROJECT_PATH

# # Create directories the project depends upon.
# RUN mkdir -p $PROJECT_PATH/media
# RUN mkdir -p $PROJECT_PATH/static/assets

# # We need a .env file to start the server.
# #COPY deploy/.env.captain $PROJECT_PATH/.env
# RUN touch $PROJECT_PATH/.env

# WORKDIR $PROJECT_PATH

# COPY . $PROJECT_PATH

# # Open port 80 to traffic.
# EXPOSE 8080 80 443

# # Run a startup script in the specified directory.
# CMD sh /usr/src/app/deploy/run.sh

# # CMD ["python3", "manage.py", "runserver", "0.0.0.0:8080"]

# tutorial attempttttttttttttttttttttt
# ==============================================================================

FROM python:3.7
# Install Python and Package Libraries
RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
RUN apt-get install -y \
    libffi-dev \
    libssl-dev \
    default-libmysqlclient-dev \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    net-tools \
    vim
# Project Files and Settings
ARG PROJECT=myproject
ARG PROJECT_DIR=/var/www/${PROJECT}
RUN mkdir -p $PROJECT_DIR
WORKDIR $PROJECT_DIR
COPY requirements.txt .
RUN pip install -r requirements.txt

# Server
EXPOSE 8000
STOPSIGNAL SIGINT
ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]