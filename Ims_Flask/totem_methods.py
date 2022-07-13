from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc

totem_methods = Blueprint('totem_methods', __name__)

@totem_methods.route("/test", methods=["GET","POST"])
def test():
    global user_rfid
    if request.method == 'POST':
        user_rfid = request.form['rfid']
        print(user_rfid)
        return redirect(url_for('totem'))
    return "welcome dear : "+str(user_rfid)

@totem_methods.route('/totem', methods=["GET","POST"])
def totem():
    global user_rfid
    if request.method == 'POST':
        user_rfid = request.form['rfid']
        print(user_rfid)
    # return jsonify( key1 = user_rfid )
    return redirect(url_for('test'))

