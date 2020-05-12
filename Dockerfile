FROM library/python:3.7-alpine as base
FROM base as builder

RUN mkdir /app
WORKDIR /app
RUN apk update && apk upgrade && apk add --no-cache make g++ bash git openssh postgresql-dev curl

# Install pillow globally.
ENV LIBRARY_PATH=/lib:/usr/lib

# Add requirements.txt before rest of repo for caching.
COPY requirements.txt /requirements.txt

# Install project dependencies before copying the rest of the codebase.
RUN python -m pip install --install-option="--prefix=/app" -r /requirements.txt


# part 2

FROM base
COPY --from=builder /install /usr/local

RUN apk --no-cache --quiet add libpq

# Set project path for use throughout the script.
ENV PROJECT_PATH=/usr/src/app

# Echo the directory to install as a sanity check.
RUN echo "Installing into $PROJECT_PATH..."

# Create project directory on the image.
RUN mkdir -p $PROJECT_PATH

# Create directories the project depends upon.
RUN mkdir -p $PROJECT_PATH/media
RUN mkdir -p $PROJECT_PATH/static/assets

# We need a .env file to start the server.
#COPY deploy/.env.captain $PROJECT_PATH/.env
RUN touch $PROJECT_PATH/.env

# Run all commands in this new directory.
WORKDIR $PROJECT_PATH

# Copy this directory to the image.
COPY . $PROJECT_PATH

# Open port 80 to traffic.
EXPOSE 8080 80 443

# Run a startup script in the specified directory.
CMD sh /usr/src/app/deploy/run.sh