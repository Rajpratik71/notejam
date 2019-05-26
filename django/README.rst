***************
Notejam: Django
***************

Notejam application implemented using `Django <https://www.djangoproject.com/>`_ framework.

Django version: 1.11.20

==========================
Installation and launching
==========================

-----
Clone
-----

Clone the repo:

.. code-block:: bash

    $ git clone git@github.com:wolfit/notejam.git YOUR_PROJECT_DIR/

-------
Install
-------
Use `virtualenv <http://www.virtualenv.org>`_ or `virtualenvwrapper <http://virtualenvwrapper.readthedocs.org/>`_
for `environment management <http://docs.python-guide.org/en/latest/dev/virtualenvs/>`_.

Install dependencies:

.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/
    $ pip install -r requirements.txt

Create database schema:

.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/
    $ ./manage.py migrate

-----------------
Launch locally
-----------------
Start django web server:

.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/
    $ python manage.py runserver

Go to http://127.0.0.1:8000/ in your browser.

---------------
Launch in cloud
---------------
-------------------
1. Setup VPC in AWS
-------------------
.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/vpc
    $ sls deploy

------------------------
2. Setup Database in AWS
------------------------
.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/db
    $ sls deploy

----------------------------
3. Provision Database in AWS
----------------------------
.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/
    #TODO: This can not connect to database, Why?
    $ python manage.py create_db

-------------------------------------------------------------------------
4. Deploy Django app to AWS with help of serverless framework (not Zappa)
-------------------------------------------------------------------------
.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/
    $ ./deploy.sh

---------
Run tests
---------

Run functional and unit tests:

.. code-block:: bash

    $ cd YOUR_PROJECT_DIR/django/notejam/
    $ ./manage.py test
