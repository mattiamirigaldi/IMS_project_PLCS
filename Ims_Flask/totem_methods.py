from xml.etree.ElementTree import tostring
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc
import connectionToDb as db

totem_methods = Blueprint('totem_methods', __name__)

#Totem RFID read
# RFID reader with POST method
rfid = -1
mac = -1
@totem_methods.route("/totem", methods=["GET", "POST"])
def totem():
    if request.method == 'GET':
        return render_template('index.html')
    else :  
        global rfid
        global mac  
        if request.method == 'POST':
            rfid_received = request.form['rfid']
            mac = request.form['mac']
            print(rfid_received)
            print(mac)
            cnxn = db.connection()
            cursor = cnxn.cursor()
            cursor.execute("SELECT * FROM totems WHERE macAddress = (?)",mac)
            if cursor.rowcount == 0:
                rfid = -1
                print('111111')
            else:
                print('222222')
                rfid = rfid_received
        return ("nunn")

# User login RFID
@totem_methods.route('/totem/UsrLoginRFID', methods=["GET", "POST"])
def UsrLoginRFID():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM customers INNER JOIN totems ON customers.branch = totems.branch WHERE rfid = (?)"
    cursor.execute(check_query,rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print("User Found : FIRSTNAME is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id), str(row.opr_id))
    else:
        print (rfid)
        print("User Not found")
        return jsonify(["not_found"])

# User login Credentials
@totem_methods.route('/totem/UsrLoginCredential', methods=["GET", "POST"])
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
        print("User Found : FIRSTNAME is " + row.firstname)
        print("User Found : RFID is " + str(row.rfid))
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id), str(row.opr_id))
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

#############################################################

# book Rent
@totem_methods.route("/totem/BookRent/<adminID>/<oprID>/<cst>", methods=["GET", "POST"])
def totem_BookRent(adminID,oprID,cst):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print (rfid)
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where items.rfid = (?) AND admin_id = (?) AND opr_id = (?)"
    cursor.execute(check_query,rfid,adminID,oprID)
    if cursor.rowcount == 0:
        cnxn.close()
        return jsonify(["The Item is not in the Database"])
    else :
        row = cursor.fetchone()
        if row.cus_id == None :
            rent_query = "UPDATE items SET cus_id = (?) WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
            cursor.execute(rent_query,cst,rfid,adminID,oprID)
            cnxn.commit()
            cnxn.close()
            print("Book rented successfully")
            return jsonify(["Book rented successfully"])
        else:
            cnxn.close()
            print("book found but it's not available")
            return jsonify(["Book not available, it's already rented"])


# book Return
@totem_methods.route("/totem/BookReturn/<adminID>/<oprID>/<cst>", methods=["GET", "POST"])
def totem_BookReturn(adminID,oprID,cst):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where items.rfid = (?) AND cus_id = (?) AND admin_id = (?)"# AND opr_id = (?)"
    cursor.execute(check_query,rfid,cst,adminID)
    if cursor.rowcount == 0:
        cnxn.close()
        print("Book Not found")
        return jsonify(["Book Not found"])
    else:
        print("Book found")
        return_query = "UPDATE items SET cus_id = (?) WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
        cursor.execute(return_query,None,rfid,adminID,oprID)
        cnxn.commit()
        cnxn.close()
        return jsonify(["Book Returned successfully"])

#############################################################

# add customer check
@totem_methods.route("/totem/Operator/AddCustomerCheck/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_op_add_customer_check(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["username"]
    check_query = "SELECT * FROM customers WHERE username = (?) AND opr_id = (?) AND admin_id = (?)"
    value = (username,oprID,adminID)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        return jsonify(["the entered username is used before"])
    else:
        return jsonify(["username is valid"])


# add customer
@totem_methods.route("/totem/Operator/AddCustomer/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_op_add_customer(adminID,oprID):
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
    value = (rfid,adminID,oprID)
    cursor.execute(check_query, value)
    row = cursor.fetchone()

    if row == None:
        insert_query = "INSERT INTO customers VALUES (?,?,?,?,?,?,?,?,?);"  # the '?' are placeholders
        value = (adminID,oprID,rfid,firstName, lastName, username, mail, password, rfid)
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
# insert customer RFID
@totem_methods.route("/totem/Operator/InsertCustomerRFID/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_op_insert_customer_rfid(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    global user_add_flag
    print("1111111111111")

    if request.method == 'POST':
        firstName = request.form["firstName"]
        lastName = request.form["lastName"]
        username = request.form["username"]
        mail = request.form["email"]
    print("2222222222222")
    print(username)

        
    check_query = "SELECT * FROM customers WHERE rfid = (?) and admin_id = (?) and opr_id = (?) "
    value = (rfid,adminID,oprID)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    print("3333333333333333333")
    if row == None:
        insert_query = "UPDATE customers SET rfid = (?),id=(?) WHERE firstname = (?) AND lastname = (?) AND username = (?)"  # the '?' are placeholders
        value = (rfid,rfid,firstName, lastName, username)
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
@totem_methods.route("/totem/Operator/RemoveCustomer/<adminID>/<oprID>", methods=["GET", "POST"])
def RemoveCustomer(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM customers WHERE rfid= (?) AND admin_id = (?) AND opr_id = (?)"
    delete_query = "DELETE FROM customers WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
    cursor.execute(check_query,rfid,adminID,oprID)
    if cursor.rowcount == 0 :
        cnxn.close()
        print("user not found")
        return jsonify(["no"])
    else : 
        cursor.execute(delete_query,rfid,adminID,oprID)
        cnxn.commit()
        cnxn.close()
        print("Operator removed a User successfully")
        return jsonify(["Done"])

#############################################################

# Add Book
@totem_methods.route("/totem/Operator/AddBook/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_AddBook(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        Title = request.form["Title"]
        Author = request.form["Author"]
        Genre = request.form["Genre"]
        Publisher = request.form["Publisher"]
        Date = request.form["Date"]
        Loc = request.form["Loc"]
        Description = request.form["Description"]
    check_query1 = " SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE books.rfid = (?) AND admin_id = (?) and opr_id = (?)"
    cursor.execute(check_query1,rfid,adminID,oprID)
    print("check1: " + str(cursor.rowcount))
    returnMSG = "The book is already in the Database"
    if cursor.rowcount == 0:
        check_query2 = " SELECT * FROM operators WHERE rfid = (?) AND admin_id = (?)"
        cursor.execute(check_query2,rfid,adminID)
        print("check2: " + str(cursor.rowcount))
        returnMSG = "The RFID is for a Operator"
        if cursor.rowcount == 0:
            check_query3 = " SELECT * FROM customers WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
            cursor.execute(check_query3,rfid,adminID,oprID)
            print("check3: " + str(cursor.rowcount))
            returnMSG = "The RFID is for an Customer"
            if cursor.rowcount == 0:
                print("33333333333")
                returnMSG = "Please Scan the RFID"
                if rfid != -1 : 
                    returnMSG = "done"
                    insert_query = '''INSERT INTO books VALUES (?,?,?,?,?,?,?,?,?,?);INSERT INTO items VALUES (?,?,?,?,?,?,?,?)'''
                    insert_value = (rfid,rfid,Title,Author,Genre,Publisher,Date,rfid,Loc,Description,adminID,oprID,None,rfid,Title,"BK","Turin",rfid)
                    cursor.execute(insert_query, insert_value)
                    cnxn.commit()
    cnxn.close()
    print(returnMSG)
    return jsonify([returnMSG])

# insert item RFID
@totem_methods.route("/totem/Operator/InsertItemRFID/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_op_insert_item_rfid(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    global user_add_flag
    print("1111111111111")
    if request.method == 'POST':
        name = request.form["name"]
        #branch = request.form["branch"]
    print("2222222222222")
    print(name)
    check_query = "SELECT * FROM items WHERE rfid = (?) and admin_id = (?) and opr_id = (?) "
    value = (rfid,adminID,oprID)
    cursor.execute(check_query, value)
    row = cursor.fetchone()
    print("3333333333333333333")
    if row == None:
        insert_query = '''  UPDATE items SET rfid = (?),id=(?) WHERE name = (?);
                            UPDATE books SET item_id = (?),id=(?),rfid=(?) WHERE name = (?)'''  # the '?' are placeholders
        value = (rfid,rfid,name,rfid,rfid,rfid,name)
        cursor.execute(insert_query, value)
        cnxn.commit()
        cnxn.close()
        user_add_flag = "new Item added to the database successfully"
        print(user_add_flag)
        return jsonify([user_add_flag])
    else:
        user_add_flag = "RFID is already in the db"
        print(user_add_flag)
        return jsonify([user_add_flag])

#############################################################

# Remove Book
@totem_methods.route("/totem/Operator/RemoveBook/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_RemoveBook(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM items WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
    delete_query = '''DELETE FROM items WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?) ; DELETE FROM books WHERE rfid = (?)'''
    cursor.execute(check_query,rfid,adminID,oprID)
    if cursor.rowcount == 0 :
        cnxn.close()
        print("Book is not in the database")
        return jsonify(["no"])
    else :
        print("Book Removed Successfully")
        cursor.execute(delete_query,rfid,adminID,oprID,rfid)
        cnxn.commit()
        cnxn.close()
        return jsonify(["done"])

#############################################################

# Pending Items
@totem_methods.route("/totem/Operator/PendingItems/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_PendingItems(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE admin_id = (?) AND opr_id = (?) AND cus_id is null"
    cursor.execute(check_query,adminID,oprID)
    if cursor.rowcount == 0 :
        cnxn.close()
        print("Pending List is Empty")
        return jsonify(["no"])
    print("There are Pending Items")
    j = 0
    tit = []
    aut = []
    gen = []
    rfid = []
    usr = []
    loc = []
    data = []
    for row in cursor:
        books = {"title": row[2], "author": row[3], "genre": row[4], "rfid": row[7], "cus_id": row[10], "location": row[14]}
        data.append(books)
    for i in data:
        tit.append(data[j]["title"])
        aut.append(data[j]["author"])
        gen.append(data[j]["genre"])
        rfid.append(data[j]["rfid"])
        usr.append(data[j]["cus_id"])
        loc.append(data[j]["location"])
        j += 1
    cnxn.close()
    return jsonify([tit, aut, gen, rfid, usr, loc])

# Pending Customers
@totem_methods.route("/totem/Operator/PendingCustomers/<adminID>/<oprID>", methods=["GET", "POST"])
def totem_PendingCustomers(adminID,oprID):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM customers WHERE admin_id = (?) AND opr_id = (?) AND id is null"
    cursor.execute(check_query,adminID,oprID)
    if cursor.rowcount == 0 :
        cnxn.close()
        print("Pending List is Empty")
        return jsonify(["no"])
    print("There are Pending Items")
    j = 0
    fnm = []
    lnm = []
    unm = []
    mil = []
    data = []
    for row in cursor:
        books = {"firstname": row[3], "lastname": row[4], "username": row[5], "mail": row[6]}
        data.append(books)
    for i in data:
        fnm.append(data[j]["firstname"])
        lnm.append(data[j]["lastname"])
        unm.append(data[j]["username"])
        mil.append(data[j]["mail"])
        j += 1
    cnxn.close()
    return jsonify([fnm, lnm, unm, mil])

#############################################################

@totem_methods.route("/get", methods=["GET", "POST"])
def getdata(iiid):
    return "welcome dear : " + str(iiid)
