import os
from notejam import app

host = '127.0.0.1'
config = 'notejam.config.DevelopmentConfig'
env_config = os.environ.get("APP_SETTINGS")
if env_config:
    config = env_config
    host = '0.0.0.0'

app.config.from_object(config)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
