from flask import Blueprint, Flask

bp = Blueprint("router", __name__)


@bp.get("/health")
def health_check():
    return "Server is alive!", 200


def init_app(app: Flask):
    app.register_blueprint(bp)
