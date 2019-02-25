import os
from notejam import app
from notejam.config import DevelopmentConfig, TestingConfig, ProductionConfig, DevelopmentLocalConfig

if os.getenv('ENV') == 'DEV':
    app.config.from_object(DevelopmentConfig)
elif os.getenv('ENV') == 'TST':
    app.config.from_object(TestingConfig)
elif os.getenv('ENV') == 'PRD':
    app.config.from_object(ProductionConfig)
else:
    app.config.from_object(DevelopmentLocalConfig)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)
