from asyncio.windows_events import NULL
import itertools
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc

mobile_methods = Blueprint('mobile_methods', __name__)

#Totem RFID read

global opr_found_flag
global user_username
global user_found_flag
global role
global book_rfid
global rfid
rfid = -1
rfid_counter = 0

def connection():
    ## Connection to the database
    # server and database names are given by SQL
    server = 'POUYAN'
    database = 'mydb'
    # Cnxn : is the connection string
    # If trusted connection is 'yes' then we log using our windows authentication
    cnxn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server}; \
         SERVER=' + server + '; \
         DATABASE=' + database + '; \
        Trusted_Connection=yes;')
    return cnxn

# Connection Check
@mobile_methods.route("/mobileurlcheck", methods=["GET", "POST"])
def mobile_urlcheck():
    print("---------")
    if request.method == 'GET':
        print("access to the server success")
        return jsonify(["111"])
    else : 
        print("problem in accessing to the server")
        return jsonify(["222"])

# RFID reader with POST method
@mobile_methods.route("/mobile", methods=["GET", "POST"])
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
@mobile_methods.route('/mobile/UsrLoginRFID', methods=["GET", "POST"])
def UsrLoginRFID():
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [customers] WHERE rfid = (?) "
    #if 'rfid' in globals() :
    #    value = rfid
    #else:
    #    value = -1
    cursor.execute(check_query, rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print("User Found : FIRSTNAME is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id), str(row.opr_id))
    else:
        print("User Not found")
        return jsonify(["not_found"])

# User login Credentials
@mobile_methods.route('/mobile/UsrLoginCredential', methods=["GET", "POST"])
def UsrLoginCredential():
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM [customers] WHERE username = (?) and pwd = (?)"
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
@mobile_methods.route("/mobile/OprLoginRFID", methods=["GET", "POST"])
def OprLoginRFID():
    cnxn = connection()
    cursor = cnxn.cursor()  
    check_query = "SELECT * FROM [operators] WHERE rfid = (?) "
    #if 'rfid' in globals() :
    #    value = rfid
    #else:
    #    value = -1
    cursor.execute(check_query, rfid)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print("Operator Found : Firstname is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id))
    else:
        print("Operator_not_found")
        return jsonify(["Operator not found"])

# Operator login Credentials
@mobile_methods.route('/mobile/OprLoginCredential', methods=["GET", "POST"])
def OprLoginCredential():
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM [operators] WHERE username = (?) and pwd = (?)"
    cursor.execute(check_query,username,password)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print("operator Found : firstname is " + row.firstname)
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid), str(row.admin_id))
    else:
        print("operator Not found")
        return jsonify(["not_found"])

#############################################################
# List Customers
@mobile_methods.route("/mobile/ListCustomers/<adminID>/<oprRFID>", methods=["GET", "POST"])
def mobile_ListCustomers(adminID,oprRFID):
    print(adminID,oprRFID)
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM customers where admin_id = (?) AND opr_id = (?)"
    cursor.execute(check_query,adminID,oprRFID)
    if cursor.rowcount == 0:
        cnxn.close()
        print("There are no Customer for you")
        return jsonify(["not_found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    cnxn.close()
    return jsonify(data)

#############################################################
# List the User Items
@mobile_methods.route("/mobile/UserItems/<adminID>/<opr>/<usr>", methods=["GET", "POST"])
def mobile_ListUserItems(adminID,opr,usr):
    print(adminID,opr,usr)
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where admin_id = (?) AND opr_id = (?) AND items.cus_id = (?)"
    cursor.execute(check_query,adminID,opr,usr)
    if cursor.rowcount == 0:
        cnxn.close()
        print("User does not have any Item")
        return jsonify(["You don't have any Item"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("There are some Items")
    cnxn.close()
    return jsonify(data)

# List All the Items
@mobile_methods.route("/mobile/AllItems/<adminID>/<oprID>", methods=["GET", "POST"])
def mobile_ListAllItems(adminID,oprID):
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE admin_id = (?) AND opr_id = (?)"
    cursor.execute(check_query,adminID,oprID)
    if cursor.rowcount == 0:
        cnxn.close()
        print("The are No items")
        return jsonify(["The are No items"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("There are some Items")
    cnxn.close()
    return jsonify(data)

#############################################################
# add customer check
@mobile_methods.route("/mobile/AddCustomerCheck/<adminID>/<opr>", methods=["GET", "POST"])
def mobile_op_add_customer_check(adminID,opr):
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["username"]
    check_query = "SELECT * FROM customers WHERE username = (?) AND admin_id = (?) AND opr_id = (?) "
    cursor.execute(check_query,username,adminID,opr)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        return jsonify(["the entered username is used before"])
    else:
        return jsonify(["username is valid"])


# add customer
@mobile_methods.route("/mobile/AddCustomer/<adminID>/<opr>", methods=["GET", "POST"])
def mobile_op_add_customer(adminID,opr):
    cnxn = connection()
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
        cursor.execute(check_query, rfid, adminID, opr)
        rfiddd = rfid
        row = cursor.fetchone()
    else :
        rfiddd = None
        row = None
    print("22222222222")
    if row == None:
        insert_query = '''INSERT INTO customers VALUES (?,?,?,?,?,?,?,?,?);'''  # the '?' are placeholders
        value = (adminID, opr, rfiddd, firstname, lastname, username, mail, pwd, rfiddd)
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
@mobile_methods.route("/mobile/RemoveCustomer/<adminID>/<opr>", methods=["GET", "POST"])
def mobile_RemoveCustomer(adminID,opr):
    cnxn = connection()
    cursor = cnxn.cursor()
    print("33333333")
    if request.method == 'POST':
        cst_username = request.form["cst_username"]
        usrn_rfid = request.form["usrn_rfid"]
    if usrn_rfid == "usrn" :
        check_query = "SELECT * FROM customers WHERE username = (?) AND admin_id = (?) AND opr_id = (?)"
        value = (cst_username,adminID,opr)
        delete_query = "DELETE FROM customers WHERE username = (?) AND admin_id = (?) AND opr_id = (?)"
        delete_value = (cst_username,adminID,opr)
    else :
        check_query = "SELECT * FROM customers WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"        
        value = (rfid,adminID,opr)
        delete_query = "DELETE FROM customers WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
        delete_value = (rfid,adminID,opr)
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

#############################################################

# Add Book
@mobile_methods.route("/mobile/AddBook/<adminID>/<opr>", methods=["GET", "POST"])
def totem_AddBook(adminID,opr):
    global rfid_counter
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        Title = request.form["Title"]
        Author = request.form["Author"]
        Genre = request.form["Genre"]
        Publisher = request.form["Publisher"]
        Date = request.form["Date"]
        rfid_flag = request.form["rfid_flag"]
    check_query1 = " SELECT * FROM books WHERE rfid = (?)"
    cursor.execute(check_query1,rfid)
    print("check1: " + str(cursor.rowcount))
    if cursor.rowcount == 0 or rfid_flag == "no":
        check_query2 = " SELECT * FROM operators WHERE rfid = (?)"
        cursor.execute(check_query2,rfid)
        print("check2: " + str(cursor.rowcount))
        if cursor.rowcount == 0 or rfid_flag == "no":
            check_query3 = " SELECT * FROM customers WHERE rfid = (?)"
            cursor.execute(check_query3,rfid)
            print("check3: " + str(cursor.rowcount))
            if cursor.rowcount == 0 or rfid_flag == "no":
                print("33333333333")
                if rfid_flag == "no" :
                    rfid_counter += 1
                    rfiddd = rfid_counter
                else : 
                    rfiddd = rfid
                    print("4444444 :  " + str(rfiddd))
                    if rfiddd == -1 : 
                        cnxn.close()
                        return jsonify(["Please Scan the RFID"])
                insert_query = '''INSERT INTO books VALUES (?,?,?,?,?,?,?,?); INSERT INTO items VALUES (?,?,?,?,?,?,?,?);'''
                insert_value = (rfiddd,rfiddd,Title,Author,Genre,Publisher,Date,0,adminID,opr,None,rfiddd,Title,"Book","Turin",0)
                cursor.execute(insert_query, insert_value)
                cnxn.commit()
                #insert_query = '''INSERT INTO items VALUES (?,?,?,?,?,?,?,?);'''
                #insert_value = (adminID,opr,None,rfiddd,Title,"Book","Turin",0)
                #cursor.execute(insert_query, insert_value)
                #cnxn.commit()
                return jsonify(["done"])
            else :
                cnxn.close()
                return jsonify(["The RFID is for a User"])
        else :
            cnxn.close()
            return jsonify(["The RFID is for an Operator"])
    else :
        cnxn.close()
        return jsonify(["The book is already in the Database"])



# Remove Book
@mobile_methods.route("/mobile/RemoveBook/<adminID>/<opr>", methods=["GET", "POST"])
def totem_RemoveBook(adminID,opr):
    cnxn = connection()
    cursor = cnxn.cursor()
    print("000000000")
    if request.method == 'POST':
        title = request.form["title"]
        author = request.form["author"]
        rfid_flag = request.form["rfid_flag"]
    if rfid_flag == "yes" :
        check_query = "SELECT * FROM items WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
        delete_query1 = "DELETE FROM items WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
        delete_query2 = "DELETE FROM books WHERE rfid = (?)"
        value = (rfid,adminID,opr)
        value2 = (rfid)
        cursor.execute(check_query,value)
    else :
        check_query = "SELECT * FROM books WHERE author = (?) AND title = (?)"
        delete_query1 = "DELETE FROM items WHERE name = (?) AND admin_id = (?) AND opr_id = (?)"
        delete_query2 = "DELETE FROM books WHERE title = (?) AND author = (?)"
        value = (title,adminID,opr)
        value2 = (title,author)
        cursor.execute(check_query,author,title)
    print("111111111")
    if cursor.rowcount == 0 :
        cnxn.close()
        print("2222222")
        return jsonify(["no"])
    else :
        print("33333333")
        cursor.execute(delete_query1,value)
        cnxn.commit()
        cursor.execute(delete_query2,value2)
        cnxn.commit()
        cnxn.close()
        return jsonify(["done"])

#############################################################

@mobile_methods.route("/get", methods=["GET", "POST"])
def getdata(iiid):
    return "welcome dear : " + str(iiid)
