from tkinter.messagebox import NO
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc
import connectionToDb as db
webApp_methods = Blueprint('webApp_methods', __name__)

@webApp_methods.route("/web", methods=["GET", "POST"])
def webApp():
    if request.method == 'GET':
        return render_template('index.html')

@webApp_methods.route("/register", methods=["GET", "POST"])
def register():
    ## 1 SECTION: Connection to the database
    cnxn = db.connection()
    # create the connection cursor, to do queries in the database
    cursor = cnxn.cursor()

    ## 2 SECTION : API interface
    if request.method == 'POST':
        firstName = request.form["firstName"]
        print("firstname is " + firstName)
        lastName = request.form["lastName"]
        print("lastname is " + lastName)
        userName = request.form["userName"]
        print("username is " + userName)
        mail = request.form["email"]
        print("mail is " + mail)
        password = request.form["password"]
        print("password is " + password)

    ## 3 SECTION : Interaction with database, used the pyodbc library
    # Inserted register credentials in the table
    # insert_query is a variable, is a multiline string
    insert_query = '''INSERT INTO Library_Clients VALUES (?,?,?,?,?);'''  # the '?' are placeholders
    # Then to execute the query is use the method execute(), it can take as argument directly the line of code
    # to execute or a the variable query and the values to be used
    value = (firstName, lastName, userName, mail, password)
    cursor.execute(insert_query, value)
    # Lastly the change is committed
    cnxn.commit()
    # Then the connection can be closed
    cnxn.close()
    return jsonify(["Register success"])


@webApp_methods.route("/login", methods=["GET", "POST"])
def login():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        userName = request.form["userName"]
        print("Username is " + userName)
        password = request.form["password"]
        print("Password is " + password)
    # check if user is registered
    check_query = '''SELECT CASE WHEN EXISTS (SELECT * FROM [Library_Clients] WHERE userName = (?) AND pwd = (?)) 
                    THEN CAST(1 AS BIT) 
                    ELSE CAST(0 AS BIT) 
                    END'''  # the '?' are placeholders
    value = (userName, password)
    cursor.execute(check_query, value)
    # the returned output is a cursor object
    checked = cursor.fetchone()
    print(checked)
    if checked[0]:
        # Then the connection can be closed
        check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
        value = (userName)
        cursor.execute(check_query, value)
        row = cursor.fetchone()
        cnxn.close()
        print("Access to Login url : Successful")
        return jsonify(row.firstName, row.mail)
        # return jsonify(["valid user"])
    else:
        # Then the connection can be closed
        cnxn.close()
        return jsonify(["user not registered"])


@webApp_methods.route("/settings/<userName>", methods=["GET", "POST"])
def settings(userName):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        userName = request.form["userName"]
        print(userName)
    check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
    value = (userName)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    if row != None :    
        print("SETTINGS : FIRSTNAME is " + row.firstName)
        print("Access to Settings url : Successful")
        cnxn.close()
        return jsonify(row.firstName, row.lastName, row.userName, row.mail, row.pwd)
    else: 
        cnxn.close()
        return jsonify(["1"],["2"],["3"],["4"],["5"])

@webApp_methods.route("/settings_ch/<usr>", methods=["GET", "POST"])
def settings_ch(usr):
    cnxn = db.connection()
    cursor = cnxn.cursor()

    if request.method == 'POST':
        firstName = request.form["firstName"]
        lastName = request.form["lastName"]
        userName = request.form["userName"]
        mail = request.form["email"]
        password = request.form["password"]

    print("SETTINGS : FIRSTNAME is " + firstName)
    print("Access to Settings_ch url : Successful_1")

    insert_query = "UPDATE Library_Clients SET firstName = (?), lastName = (?), userName = (?), mail= (?), pwd= (?) WHERE userName = (?)"
    value = (firstName, lastName, userName, mail, password, usr)
    cursor.execute(insert_query, value)
    cnxn.commit()

    print("Access to Settings_ch url : Successful_2")

    check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
    value = (userName)
    cursor.execute(check_query, value)
    row = cursor.fetchone()

    cnxn.close()

    print("Access to Settings_ch url : Successful_3")

    return jsonify(firstName, mail)


@webApp_methods.route("/web/items", methods=["GET", "POST"])
def items():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'GET':
        print("GET request")
    print("Access to items url : Successful_1")
    check_query = 'SELECT * FROM [Items]'
    cursor.execute(check_query)
    j = 0
    tit = []
    aut = []
    gen = []
    rfid = []
    usr = []
    loc = []
    data = []
    for row in cursor:
        print("Access to items url : Successful_3")
        books = {"Title": row[0], "Author": row[1], "Genre": row[2], "RFID": row[3], "userName": row[4], "Location": row[5]}
        data.append(books)
    for i in data:
        tit.append(data[j]["Title"])
        aut.append(data[j]["Author"])
        gen.append(data[j]["Genre"])
        rfid.append(data[j]["RFID"])
        usr.append(data[j]["userName"])
        loc.append(data[j]["Location"])
        j += 1
    cnxn.close()
    return jsonify(tit, aut, gen, rfid, usr, loc)
    # row = cursor.fetchone()
