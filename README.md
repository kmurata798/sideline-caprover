<!-- Dockerized project README -->
### This portion of the README is for users who are using docker who want to build and run a Docker container which holds the Django project.  

### Read my blog post for more information on what is going on in this project:
https://medium.com/@kmurata798/dockering-an-sqlite-django-project-75160855c5bf
## How to Build (WIP)
This project uses Docker.  

To build and run the application, simply run this command after entering the project directory:  
``` docker-compose up ```

## Changelog
- [x] Implement my Sideline Django project which uses SQLite as a database
- [x] Write the docker-compose.yml file
- [ ] Fix Caprover error occurring with Digital Ocean Droplet IP Address
- [ ] Deploy on caprover

<!-- Base project README -->
### This portion of the README is for users not using docker who want to test out the Django project.
# sideline (Team Project)
![Sideline image](https://henricolibrary.org/images/easyblog_articles/129/b2ap3_large_20190712-hobbies-blog.jpg)

## Link to Live Website (Heroku app):
https://spd-sideline.herokuapp.com

### Description:
Subscription based website allowing users to sign up for specific hobby classes/groups.
"ClassPass for hobbies!"

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [Deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

All dependencies are listed in the Pipfile in the repository.

### Installing

Clone this repository   (Don't include the $. This symbol indicates that you need to write this command in the commandline in this repository):

```
$ git clone https://github.com/kmurata798/sideline-caprover–
```

Traverse into the this repository:

```
$ cd /path/to/file/sideline
```

Run virtual environment which carries all the dependencies needed for this program:

```
$ pipenv shell
```

Run Django server:

```
$ python3 manage.py runserver
```

## Deployment
Clone this repository and follow the instructions provided at this link [Heroku deployment](https://devcenter.heroku.com/articles/git) to deploy your own project.

## Built With

* [Django](https://flask.palletsprojects.com/en/1.1.x/) - The web framework used
* [Heroku](https://www.heroku.com) - Deployment

## Authors

* **Kento Murata** - *Initial work* - [kmurata798](https://github.com/kmurata798)

* **Uyen Nguyen** - *Initial work* - [uyennguyen16900](https://github.com/uyennguyen16900)

* **Tasfia Addrita** - *Initial work* - [TasfiaAddrita](https://github.com/TasfiaAddrita)

* **Audarias Blades** - *Initial work* - [ablades](https://github.com/ablades)

* **Mondale Felix** - *Initial work* - [MondaleFelix](https://github.com/MondaleFelix)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
