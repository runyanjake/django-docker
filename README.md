# Django

A Django webapp built for running in a docker container on my server.

### Resources

https://www.django-rest-framework.org/tutorial/quickstart/ (Has some ideas about views vs viewsets that i am using.)

https://djangocentral.com/create-a-hello-world-django-application/

### Simple Hello World

1. Create a python env and a new Django Project.

`python3 -m venv env`

`source env/bin/activate`

`pip install django`

`django-admin startproject projectname`

`python manage.py migrate`

2. Configure settings.

Add APPEND_SLASH=True to projectname/settings.py, this redirects anything without a trailing slash to a url where there is a slash. Behavior is weird from curl perspective but good from a browser i imagine.

Set DEBUG=False for prod, True for dev.

3. Build app & test locally.

`python manage.py migrate`

`python manage.py runserver`

`curl -vvv 127.0.0.1:8000` -> 404

4. (Optional) Basic Rest Api

Move to project folder and create new app.

`cd projectname`

`python manage.py startapp hello`

Edit views.py to add some views methods for http calls to route to. 

```
from django.http import HttpResponse

def hello_world(request):
    return HttpResponse("Hello World!");

def hello_queryparam(request, query_param):
    return HttpResponse("Passed Query Param: " + str(query_param));
```

Go back to the project folder and edit urls.py to map the views we created to urls.

```
from hello import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('hello/', views.hello_world, name='hello'),
    path('hello/<int:query_param>/', views.hello_queryparam, name='hello_query'),
]
```

Migrate/Run the server and validate the new endpoints work locally.

`python manage.py migrate`

`python manage.py runserver``

`curl 127.0.0.1:8000` -> 404

`curl 127.0.0.1:8000/hello/` -> 200

`curl 127.0.0.1:8000/hello/123/` -> 200

Missing the trailing forward slash results in 301.

### Run this on a Docker container.

Note to get the server running locally first, as the repo contains only modified files (with the exception of settings.py, which has to be manually updated).

1. The Dockerfile contains instructions to build the container and copy in website code from the "project folder". This is the one that was created with the django-admin command.

2. Build container: `docker build --tag="runyanjake/website" .` 

3. Run docker-compose.

4. Confirm working

	a. exec onto container and curl localhost:8000
	
	b. curl from remote location to the :8998 port.

