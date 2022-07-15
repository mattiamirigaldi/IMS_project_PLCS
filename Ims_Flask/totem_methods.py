from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc

totem_methods = Blueprint('totem_methods', __name__)

#Totem RFID read

rfid = 1
opr_found_flag = 0
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

# RFID reader with POST method
@totem_methods.route("/totem", methods=["GET", "POST"])
def totem():
    if request.method == 'GET':
        return render_template('index.html')
    else :
        cnxn = connection()
        cursor = cnxn.cursor()
        global rfid
        if request.method == 'POST':
            rfid = request.form['rfid']
            print(rfid)
        return ("nunn")

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

# Operator login
@totem_methods.route("/totem/login", methods=["GET", "POST"])
def totem_op_login():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    global role
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    role = row.role_i
    print(role)
    if row != None:
        opr_found_flag = "found"
        print("Operator Found : Email is " + row.mail)
        return jsonify([opr_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd, row.RFID_i)
    else:
        opr_found_flag = "not_found"
        print("Operator Not found")
        return jsonify([opr_found_flag])

# User login
@totem_methods.route("/totem/user/login", methods=["GET", "POST"])
def totem_usr_login():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        global role
        global user_rfid
        role = row.role_i
        user_rfid = row.RFID_i
        usr_found_flag = "found"
        print("User Found : Email is " + row.mail)
        return jsonify([usr_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd, row.RFID_i)
    else:
        usr_found_flag = "not_found"
        print("User Not found")
        return jsonify([usr_found_flag])


# book check
@totem_methods.route("/totem/BookCheck", methods=["GET", "POST"])
def totem_op_bc():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    global book_rfid
    check_query = "SELECT * FROM [Items] WHERE RFID = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    print(row)
    if row != None:
        book_rfid = row.RFID
        book_found_flag = "found"
        print("Book Found : TITLE is " + row.Title)
        return jsonify([book_found_flag], row.id, row.Title, row.Author, row.Genre, row.RFID, row.RFID_i)
    else:
        book_found_flag = "not_found"
        print("Book Not found")
        return jsonify([book_found_flag])

# add customer check
@totem_methods.route("/totem/Operator/AddCustomerCheck", methods=["GET", "POST"])
def totem_op_add_customer_check():
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["username"]
    check_query = "SELECT * FROM [Library_Clients] WHERE username = (?) "
    value = (username)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        return jsonify(["the entered username is used before"])
    else:
        return jsonify(["username is valid"])


# add customer
@totem_methods.route("/totem/Operator/AddCustomer", methods=["GET", "POST"])
def totem_op_add_customer():
    cnxn = connection()
    cursor = cnxn.cursor()
    global user_add_flag

    if request.method == 'POST':
        firstName = request.form["firstName"]
        lastName = request.form["lastName"]
        username = request.form["username"]
        mail = request.form["email"]
        password = request.form["password"]

    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()

    if row == None:
        insert_query = '''INSERT INTO Library_Clients VALUES (?,?,?,?,?,?,'usr');'''  # the '?' are placeholders
        value = (firstName, lastName, username, mail, password, rfid)
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


# Remove Customer
@totem_methods.route("/totem/Operator/RemoveCustomer", methods=["GET", "POST"])
def RemoveCustomer():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "DELETE FROM [Library_Clients] WHERE rfid_i = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    cnxn.commit()
    cnxn.close()
    remove_flag = "Customer removed successfully"
    print("Customer removed successfully")
    return jsonify([remove_flag])


# Remove Book
@totem_methods.route("/totem/Operator/RemoveBook", methods=["GET", "POST"])
def RemoveBook():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    cnxn = connection()
    cursor = cnxn.cursor()
    print(rfid)
    check_query = "DELETE FROM [Items] WHERE RFID = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    cnxn.commit()
    cnxn.close()
    remove_flag = "Book removed successfully"
    print("Book removed successfully")
    return jsonify([remove_flag])

# Rent book
@totem_methods.route("/totem/User/RentBook", methods=["GET", "POST"])
def totem_book_rent():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    global user_rfid
    cnxn = connection()
    cursor = cnxn.cursor()
    print(rfid)
    check_query = "UPDATE [Items] SET RFID_i = (?) WHERE RFID = (?) "
    value = (user_rfid, rfid)
    cursor.execute(check_query, value)
    cnxn.commit()
    cnxn.close()
    rent_flag = "Book rented successfully"
    print("Book rented successfully")
    return jsonify([rent_flag])


# Return book
@totem_methods.route("/totem/User/ReturnBook", methods=["GET", "POST"])
def totem_book_return():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    global user_rfid
    cnxn = connection()
    cursor = cnxn.cursor()
    print(rfid)
    check_query = "UPDATE [Items] SET RFID_i = (?) WHERE RFID = (?) "
    value = ('-1', rfid)
    cursor.execute(check_query, value)
    cnxn.commit()
    cnxn.close()
    return_flag = "Book returned successfully"
    print("Book returned successfully")
    return jsonify([return_flag])


@totem_methods.route("/get", methods=["GET", "POST"])
def getdata(iiid):
    return "welcome dear : " + str(iiid)


