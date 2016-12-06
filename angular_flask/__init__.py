#!/usr/bin/env python
#!-*- coding: utf8 -*-
import os
import json
import sys
from flask import Flask, request, Response
from flask import render_template, send_from_directory, url_for
from flask_cors import CORS

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

app = Flask(__name__)
CORS(app)

app.url_map.strict_slashes = False

import angular_flask.core
import angular_flask.models
import angular_flask.controllers
import angular_flask.views
