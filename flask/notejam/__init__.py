from flask import Flask
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.login import LoginManager
from flask.ext.mail import Mail

import logging

# @TODO use application factory approach
app = Flask(__name__)
app.config.from_object('notejam.config.Config')
db = SQLAlchemy(app)

gunicorn_logger = logging.getLogger('gunicorn.error')
app.logger.handlers = gunicorn_logger.handlers
app.logger.setLevel(gunicorn_logger.level)

login_manager = LoginManager()
login_manager.login_view = "signin"
login_manager.init_app(app)

mail = Mail()
mail.init_app(app)

from notejam import views
