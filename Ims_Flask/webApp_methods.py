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
        username = request.form["userName"]
        print("Username is " + username)
        password = request.form["password"]
        print("Password is " + password)
        role = request.form["role"]
        print("role is " + role)
    # check if user is registered
    check_query = "SELECT * FROM %s WHERE username = (?) and pwd = (?)" %role
    cursor.execute(check_query,username,password)
    if cursor.rowcount == 0:
        print("User Not found")
        return jsonify(["not_found"])
    row = cursor.fetchone()
    print("User Found : FIRSTNAME is " + row.firstname)
    cnxn.close()
    if role == "admins" :
        print("user is admin")
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, row.pwd, str(row.rfid))
    if role == "operators":
        print("user is operator")
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, row.pwd, str(row.rfid),str(row.admin_id))
    if role == "customers":
        print("user is customer")
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, row.pwd, str(row.rfid),str(row.opr_id),str(row.admin_id))




# @webApp_methods.route("/settings/<userName>", methods=["GET", "POST"])
# def settings(userName):
#     cnxn = db.connection()
#     cursor = cnxn.cursor()
#     if request.method == 'POST':
#         userName = request.form["userName"]
#         print(userName)
#     check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
#     value = (userName)
#     cursor.execute(check_query, value)
#     row = cursor.fetchone()
#     if row != None :
#         print("SETTINGS : FIRSTNAME is " + row.firstName)
#         print("Access to Settings url : Successful")
#         cnxn.close()
#         return jsonify(row.firstName, row.lastName, row.userName, row.mail, row.pwd)
#     else:
#         cnxn.close()
#         return jsonify(["1"],["2"],["3"],["4"],["5"])

@webApp_methods.route("/settings_ch/<usr>", methods=["GET", "POST"])
def settings_ch(usr):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    
    if request.method == 'POST':
        firstname = request.form["firstname"]
        lastname = request.form["lastname"]
        username = request.form["username"]
        mail = request.form["mail"]
        password = request.form["password"]

    print("SETTINGS : FIRSTNAME is " + firstname)
    print("SETTINGS : usr is " + usr)
    print("SETTINGS : username is " + username)
    print("************************************")
    
    insert_query = "UPDATE customers SET firstname = (?), lastname = (?), username = (?), mail= (?), pwd= (?) WHERE username = (?)"
    value = (firstname, lastname, username, mail, password, usr)
    cursor.execute(insert_query, value)
    cnxn.commit()
    cnxn.close()
    return jsonify("done")


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


# add customer check
@webApp_methods.route("/Web/AddCustomerCheck/<adminID>/<rfid>", methods=["GET", "POST"])
def web_op_add_customer_check(adminID,rfid):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["username"]
    check_query = "SELECT * FROM customers WHERE username = (?) AND admin_id = (?) AND opr_id = (?) "
    cursor.execute(check_query,username,adminID,rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print("user used")
        return jsonify(["the entered username is used before"])
    else:
        print("user available")
        return jsonify(["username is valid"])


# add customer
@webApp_methods.route("/Web/AddCustomer/<adminID>/<rfid>", methods=["GET", "POST"])
def web_op_add_customer(adminID,rfid):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    global user_add_flag
    if request.method == 'POST':
        firstname = request.form["firstName"]
        lastname = request.form["lastName"]
        username = request.form["username"]
        mail = request.form["email"]
        pwd = request.form["password"]
        rfid_flag = request.form["rfid_flag"]
    print("11111111111")
    if rfid_flag == "yes" :
        check_query = "SELECT * FROM customers WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
        cursor.execute(check_query, rfid, adminID, rfid)
        rfiddd = rfid
        row = cursor.fetchone()
    else :
        rfiddd = None
        row = None
    print("22222222222")
    if row == None:
        insert_query = '''INSERT INTO customers VALUES (?,?,?,?,?,?,?,?,?);'''  # the '?' are placeholders
        value = (adminID, rfid, rfiddd, firstname, lastname, username, mail, pwd, rfiddd)
        cursor.execute(insert_query, value)
        cnxn.commit()
        cnxn.close()
        user_add_flag = "new User added to the database successfully"
        print(user_add_flag)
        return jsonify([user_add_flag])
    else:
        user_add_flag = "RFID is already in the db"
        print(user_add_flag)
        return jsonify([user_add_flag])

#############################################################

# Remove Customer
@webApp_methods.route("/Web/RemoveCustomer/<adminID>/<rfid>", methods=["GET", "POST"])
def web_RemoveCustomer(adminID,rfid):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("33333333")
    if request.method == 'POST':
        cst_username = request.form["cst_username"]
        role = request.form["role"]
        print("role is " + role)
        check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) "%role
        value = (cst_username,adminID)
        delete_query = "DELETE FROM %s WHERE username = (?) AND admin_id = (?)"%role
        delete_value = (cst_username,adminID)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    print("66666666")
    if row != None :
        cursor.execute(delete_query, delete_value)
        cnxn.commit()
        cnxn.close()
        print("Operator removed a User successfully")
        return jsonify(["Done"])
    else:
        cnxn.close()
        print("user not found")
        return jsonify(["no"])