from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc

totem_methods = Blueprint('totem_methods', __name__)

user_rfid = 1
user_found_flag = 0

def connection():
    ## Connection to the database
    # server and database names are given by SQL
    server = 'DESKTOP-I7POIMI\SQLEXPRESS'
    database = 'SQLTest'
    # Cnxn : is the connection string
    # If trusted connection is 'yes' then we log using our windows authentication
    cnxn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server}; \
         SERVER=' + server + '; \
         DATABASE=' + database + '; \
        Trusted_Connection=yes;')
    return cnxn

@totem_methods.route("/totem", methods=["GET"])
def totem():
    if request.method == 'GET':
        return render_template('index.html')


@totem_methods.route("/test", methods=["GET","POST"])
def test():
    global user_rfid
    if request.method == 'POST':
        user_rfid = request.form['rfid']
        print(user_rfid)
        return redirect(url_for('totem/User'))
    return "welcome dear : " + str(user_rfid)


@totem_methods.route('/totem/User', methods=["GET", "POST"])
def totem_login():
    cnxn = connection()
    cursor = cnxn.cursor()
    global user_found_flag
    global user_rfid
    if request.method == 'POST':
        user_rfid = request.form['rfid']
        print(user_rfid)
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = user_rfid
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    print(row)
    if row != None:
        user_found_flag = "found"
        print("User Found : FIRSTNAME is " + row.firstName)
        return jsonify([user_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd)
    else:
        user_found_flag = "not_found"
        # row.firstName = "hichi"
        # row.lastName = "hichi"
        # row.userName = "hichi"
        print("User Not found")
        return jsonify([user_found_flag])

    # return jsonify(user_found_flag,row.firstName,row.lastName,row.userName,row.mail,row.pwd)
    # return jsonify( key1 = user_rfid )
    # return redirect(url_for('test'))



