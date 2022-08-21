from xml.etree.ElementTree import tostring
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc
import connectionToDb as db

totem_methods = Blueprint('totem_methods', __name__)

#Totem RFID read
rfid = 1
global opr_found_flag
global user_username
global user_found_flag
global role
global book_rfid

# RFID reader with POST method
@totem_methods.route("/totem", methods=["GET", "POST"])
def totem():
    if request.method == 'GET':
        return render_template('index.html')
    else :
        global rfid
        if request.method == 'POST':
            rfid = request.form['rfid']
            print(rfid)
        return ("nunn")

# User login RFID
@totem_methods.route('/totem//UsrLoginRFID', methods=["GET", "POST"])
def UsrLoginRFID():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = rfid
    print(value)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    global useruser
    if row != None:
        if row.role_i == "usr":
            user_found_flag = "found"
            print("User Found : FIRSTNAME is " + row.firstName)
            useruser = row.userName
            return jsonify([user_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd)
        else:
            user_found_flag = "operator"
            return jsonify([user_found_flag])
    else:
        user_found_flag = "not_found"
        print("User Not found")
        return jsonify([user_found_flag])

# User login Credentials
@totem_methods.route('/totem//UsrLoginCredential', methods=["GET", "POST"])
def UsrLoginCredential():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM [Library_Clients] WHERE username = (?) and pwd = (?) and role_i = 'usr'"
    value = (username,password)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    global useruser
    if row != None:
        user_found_flag = "found"
        print("User Found : FIRSTNAME is " + row.firstName)
        useruser = row.userName
        return jsonify([user_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd)
    else:
        user_found_flag = "not_found"
        print("User Not found")
        return jsonify([user_found_flag])

# Operator login RFID
@totem_methods.route("/totem/OprLoginRFID", methods=["GET", "POST"])
def OprLoginRFID():
    cnxn = db.connection()
    cursor = cnxn.cursor()  
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        if row.role_i == "opr":
            opr_found_flag = "found"
            print("Operator Found : Email is " + row.mail)
            return jsonify([opr_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd, row.RFID_i)
        else:
            opr_found_flag = "dear "+row.firstName+", you are not an Operator"
            print(opr_found_flag)
            return jsonify(["User"])
    else:
        opr_found_flag = "Operator_not_found"
        print(opr_found_flag)
        return jsonify([opr_found_flag])

# Operator login Credentials
@totem_methods.route('/totem/OprLoginCredential', methods=["GET", "POST"])
def OprLoginCredential():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM [Library_Clients] WHERE username = (?) and pwd = (?) and role_i = 'opr'"
    value = (username,password)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        opr_found_flag = "found"
        print("User Found : FIRSTNAME is " + row.firstName)
        return jsonify([opr_found_flag], row.firstName, row.lastName, row.userName, row.mail, row.pwd)
    else:
        opr_found_flag = "not_found"
        print("User Not found")
        return jsonify([opr_found_flag])


# book check Rent
@totem_methods.route("/totem/BookCheckRent", methods=["GET", "POST"])
def totem_BookCheckRent():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [Items] WHERE RFID = (?) "
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        if row.userName == "-1" :
            book_found_flag = "found"
            print("Book Found : TITLE is " + row.Title)
            return jsonify([book_found_flag], row.Location, row.Title, row.Author, row.Genre, row.RFID, row.userName)
        else:
            return jsonify(["Book_not_available"])
    else:
        book_found_flag = "not_found"
        print("Book Not found")
        return jsonify([book_found_flag])

# Rent book
@totem_methods.route("/totem/User/RentBook", methods=["GET", "POST"])
def totem_book_rent():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    cnxn = db.connection()
    cursor = cnxn.cursor()
    global useruser
    check_query = "UPDATE [Items] SET userName = (?) WHERE RFID = (?) "
    value = (useruser, rfid)
    cursor.execute(check_query, value)
    cnxn.commit()
    cnxn.close()
    rent_flag = "Book rented successfully"
    print("Book rented successfully")
    return jsonify([rent_flag])

#############################################################

# book check Return
@totem_methods.route("/totem/BookCheckReturn", methods=["GET", "POST"])
def totem_BookCheckReturn():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [Items] WHERE RFID = (?) and userName = (?)"
    value = (rfid,useruser)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        book_found_flag = "found"
        print("Book Found : TITLE is " + row.Title)
        return jsonify([book_found_flag], row.Location, row.Title, row.Author, row.Genre, row.RFID, row.userName)
    else:
        book_found_flag = "not_found"
        print("Book Not found")
        return jsonify([book_found_flag])

# Return book
@totem_methods.route("/totem/User/ReturnBook", methods=["GET", "POST"])
def totem_book_return():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    global rfid
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "UPDATE [Items] SET userName = (?) WHERE RFID = (?) "
    value = ('-1', rfid)
    cursor.execute(check_query, value)
    cnxn.commit()
    cnxn.close()
    return ("panir")

#############################################################

# add customer check
@totem_methods.route("/totem/Operator/AddCustomerCheck", methods=["GET", "POST"])
def totem_op_add_customer_check():
    cnxn = db.connection()
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
    cnxn = db.connection()
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

#############################################################

# Remove Customer
@totem_methods.route("/totem/Operator/RemoveCustomer", methods=["GET", "POST"])
def RemoveCustomer():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [Library_Clients] WHERE rfid_i = (?) and role_i = (?)"
    value = (rfid,'usr')
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    if row != None :
        check_query = "DELETE FROM [Library_Clients] WHERE rfid_i = (?)"
        value = (rfid)
        cursor.execute(check_query, value)
        cnxn.commit()
        cnxn.close()
        print("Operator removed a User successfully")
        return jsonify(["Done"])
    else:
        cnxn.close()
        print("user not found")
        return jsonify(["no"])

#############################################################

# Add Book
@totem_methods.route("/totem/Operator/AddBook", methods=["GET", "POST"])
def totem_AddBook():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        Title = request.form["Title"]
        Author = request.form["Author"]
        Genre = request.form["Genre"]
        Location = request.form["Location"]
        check_query = "SELECT * FROM [Items] WHERE RFID = (?)"
        value = (rfid)
        cursor.execute(check_query, value)
        row = cursor.fetchone()
        print("1111111")
        if row == None :
            check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?)"
            value = (rfid)
            cursor.execute(check_query, value)
            row = cursor.fetchone()
            if row == None :
                insert_query = '''INSERT INTO Items VALUES (?,?,?,?,'-1',?);'''  # the '?' are placeholders
                value = (Title, Author, Genre, rfid, Location)
                cursor.execute(insert_query, value)
                cnxn.commit()
                cnxn.close()
                print("222222222")
                return jsonify(["done"])
            return jsonify(["The Scanned RFID is a USER"])
        print("33333333333")
        cnxn.close()
        return jsonify(["The book is already in the database"])
    else :
        return (["nano panir"])


# Remove Book
@totem_methods.route("/totem/Operator/RemoveBook", methods=["GET", "POST"])
def totem_RemoveBook():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [Items] WHERE RFID = (?)"
    value = (rfid)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    if row != None :
        delete_query = "DELETE FROM [Items] WHERE RFID = (?) "
        value = (rfid)
        cursor.execute(delete_query, value)
        cnxn.commit()
        cnxn.close()
        return jsonify(["Done"])
    cnxn.close()
    return jsonify(["no"])

#############################################################

@totem_methods.route("/get", methods=["GET", "POST"])
def getdata(iiid):
    return "welcome dear : " + str(iiid)
