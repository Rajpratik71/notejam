from notejam import db
from notejam import app
from notejam.config import ProductionConfig

app.config.from_object(ProductionConfig)

# Create db schema
db.create_all()
