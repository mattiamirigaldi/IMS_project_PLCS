from asyncio.windows_events import NULL
from contextlib import nullcontext
from turtle import title
from flask import Flask, redirect, render_template, Blueprint, request, json, jsonify, url_for, send_from_directory
import pyodbc
from mobile_methods import mobile_methods
from totem_methods import totem_methods
from webApp_methods import webApp_methods

# __name__ means that is referencing this file
app = Flask(__name__)

FLUTTER_WEB_APP = 'templates'

# imported applications in webApp methods into app
app.register_blueprint(webApp_methods)
# imported applications in totem_methods into app
app.register_blueprint(totem_methods)
# imported applications in mobile_methods into app
app.register_blueprint(mobile_methods)

@app.route('/')
def render_page_web():
    return render_template('index.html')

@app.route('/<path:name>')
def return_flutter_doc(name):
    # the path to the requested files in the templates directory is embedded in the URL of the request.
    # Hence, the return_flutter_doc function extracts the path to the requested files from the request URL
    #  and serves the files from the templates folder over HTTP.
    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]

    return send_from_directory(DIR_NAME, datalist[-1])

@app.route("/test", methods=["GET", "POST"])
def test():
    global rfid
    if request.method == 'POST':
        rfid = request.form['rfid']
        print(rfid)
        return redirect(url_for('totem'))
    return "welcome dear : "+str(rfid)

@app.route("/get", methods=["GET","POST"])
def getdata(iiid):
    return "welcome dear : "+str(iiid)

if __name__=="__main__":
    app.run(host='0.0.0.0')