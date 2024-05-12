from flask import Flask

from app.router_blueprint import init_app as init_router_blueprint


def create_app() -> Flask:
    app = Flask(__name__)

    init_router_blueprint(app)

    return app
