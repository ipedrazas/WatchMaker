"""Meetup API."""

from flask import Flask, jsonify
import requests
import os

app = Flask(__name__, static_folder='img')

token_location = '/var/run/secrets/kubernetes.io/serviceaccount/token'
with open(token_location, 'r') as token_file:
    auth_token = token_file.read().replace('\n', '')


API_SERVER = "https://" + os.getenv("KUBERNETES_SERVICE_HOST")
HEADERS = {"Authorization": "Bearer %s" % auth_token}


# TODO: implement sockets to keep connection alive to read the incoming stream
@app.route('/pods')
def pods():
    """Pods."""
    pods_url = API_SERVER + "/api/v1/pods"
    r = requests.get(pods_url, headers=HEADERS, verify=False)
    return jsonify(Results=r.json())


@app.route('/')
def watchmaker():
    """watchmaker."""
    return "watchmaker v0.9"


if __name__ == '__main__':
    app.run(
        host='0.0.0.0',
        port=5000,
        debug=True,
        threaded=True)
