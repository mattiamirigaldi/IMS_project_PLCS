from xml.etree.ElementTree import tostring
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc
import connectionToDb as db

totem_methods = Blueprint('totem_methods', __name__)

#Totem RFID read
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
    check_query = "SELECT * FROM customers WHERE rfid = (?) "
    cursor.execute(check_query, rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        global cus_id
        global u_admin_id
        global u_opr_id
        cus_id = row.id
        u_admin_id = row.admin_id
        u_opr_id = row.opr_id
        print("User Found : FIRSTNAME is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid))
    else:
        print (rfid)
        print("User Not found")
        return jsonify(["not_found"])

# User login Credentials
@totem_methods.route('/totem//UsrLoginCredential', methods=["GET", "POST"])
def UsrLoginCredential():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM customers WHERE username = (?) and pwd = (?) "
    value = (username,password)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        global cus_id
        global u_admin_id
        global u_opr_id
        cus_id = row.id
        u_admin_id = row.admin_id
        u_opr_id = row.opr_id

        print("User Found : FIRSTNAME is " + row.firstname)
        print("User Found : RFID is " + str(row.rfid))
        #useruser = row.userName
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid))
    else:
        print("User Not found")
        return jsonify(["not found"])

# Operator login RFID
@totem_methods.route("/totem/OprLoginRFID", methods=["GET", "POST"])
def OprLoginRFID():
    cnxn = db.connection()
    cursor = cnxn.cursor()  
    check_query = "SELECT * FROM operators WHERE rfid = (?) "
    cursor.execute(check_query, rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        global o_opr_id
        global o_admin_id
        o_opr_id = row.id
        o_admin_id = row.admin_id
        print("Operator Found : Firstname is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id))
        
    else:
        print("Operator_not_found")
        return jsonify(["Operator not found"])


# Operator login Credentials
@totem_methods.route('/totem/OprLoginCredential', methods=["GET", "POST"])
def OprLoginCredential():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM operators WHERE username = (?) and pwd = (?)"
    cursor.execute(check_query, username,password)
    row = cursor.fetchone()
    cnxn.close()
    global o_opr_id
    global o_admin_id
    o_admin_id = row.admin_id
    o_opr_id = row.id
    if row != None:
        print("operator Found : firstname is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id))
    else:
        print("operator Not found")
        return jsonify(["not_found"])


# book check Rent
@totem_methods.route("/totem/BookCheckRent", methods=["GET", "POST"])
def totem_BookCheckRent():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print (rfid)
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where items.rfid = (?) "
    cursor.execute(check_query, rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        if row.cus_id == -1 :
            book_found_flag = "found"
            print("Book Found : TITLE is " + row.title)
            return jsonify([book_found_flag], row.location, row.title, row.author, row.genre, row.rfid)
        else:
            return jsonify(["Book not available"])
    else:
        book_found_flag = "not_found"
        print("Book Not found")
        return jsonify([book_found_flag])

# Rent book
@totem_methods.route("/totem/User/RentBook", methods=["GET", "POST"])
def totem_book_rent():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "UPDATE items SET admin_id = (?),opr_id = (?) ,cus_id = (?) WHERE rfid = (?) "
    cursor.execute(check_query, u_admin_id,u_opr_id,cus_id , rfid)
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
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where items.rfid = (?) AND cus_id = (?)"
    cursor.execute(check_query, rfid , cus_id)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        book_found_flag = "found"
        print("Book Found : TITLE is " + row.title)
        return jsonify([book_found_flag], row.location, row.title, row.author, row.genre, row.rfid)
    else:
        book_found_flag = "not_found"
        print("Book Not found")
        return jsonify([book_found_flag])

# Return book
@totem_methods.route("/totem/User/ReturnBook", methods=["GET", "POST"])
def totem_book_return():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "UPDATE items SET cus_id = (?) WHERE rfid = (?) "
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
    check_query = "SELECT * FROM customers WHERE username = (?) AND opr_id = (?) AND admin_id = (?)"
    value = (username,o_opr_id,o_admin_id)
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

    check_query = "SELECT * FROM customers WHERE rfid = (?) and admin_id = (?) and opr_id = (?) "
    value = (rfid,o_admin_id,o_opr_id)
    cursor.execute(check_query, value)
    row = cursor.fetchone()

    if row == None:
        insert_query = "INSERT INTO customers VALUES (?,?,?,?,?,?,?,?,?);"  # the '?' are placeholders
        value = (o_admin_id,o_opr_id,rfid,firstName, lastName, username, mail, password, rfid)
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
    check_query = "SELECT * FROM customers WHERE rfid= (?) and admin_id = (?) and opr_id = (?)"
    value = (rfid,o_admin_id,o_opr_id)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    if row != None :
        check_query = "DELETE FROM customers WHERE rfid = (?)"
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
        check_query = "SELECT * FROM items WHERE rfid = (?)"
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
