from asyncio.windows_events import NULL
import itertools
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc
import connectionToDb as db

mobile_methods = Blueprint('mobile_methods', __name__)

global rfid
rfid = -1
rfid_counter = 0

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

# Customer login RFID
@mobile_methods.route('/mobile/UsrLoginRFID', methods=["GET", "POST"])
def UsrLoginRFID():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM [customers] WHERE rfid = (?) "
    cursor.execute(check_query, rfid)
    if cursor.rowcount == 0:
        cnxn.close()
        print("not found")
        return jsonify(["not found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("User found")
    cnxn.close()
    return jsonify(data)

# Customer login Credentials
@mobile_methods.route('/mobile/UsrLoginCredential', methods=["GET", "POST"])
def UsrLoginCredential():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM [customers] WHERE username = (?) and pwd = (?)"
    value = (username,password)
    cursor.execute(check_query, value)
    if cursor.rowcount == 0:
        cnxn.close()
        print("not found")
        return jsonify(["not found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("User found")
    cnxn.close()
    return jsonify(data)

# Operator login RFID
@mobile_methods.route("/mobile/OprLoginRFID", methods=["GET", "POST"])
def OprLoginRFID():
    cnxn = db.connection()
    cursor = cnxn.cursor()  
    check_query = "SELECT * FROM [operators] WHERE rfid = (?) "
    cursor.execute(check_query, rfid)
    if cursor.rowcount == 0:
        cnxn.close()
        print("not found")
        return jsonify(["not found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("Operator found")
    cnxn.close()
    return jsonify(data)

# Operator login Credentials
@mobile_methods.route('/mobile/OprLoginCredential', methods=["GET", "POST"])
def OprLoginCredential():
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["userName"]
        password = request.form["password"]
    check_query = "SELECT * FROM [operators] WHERE username = (?) and pwd = (?)"
    cursor.execute(check_query,username,password)
    if cursor.rowcount == 0:
        cnxn.close()
        print("not found")
        return jsonify(["not found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("Operator found")
    cnxn.close()
    return jsonify(data)

#############################################################
# List Customers
@mobile_methods.route("/mobile/ListCustomers/<admin_id>/<branch>", methods=["GET", "POST"])
def mobile_ListCustomers(admin_id,branch):
    print(admin_id,branch)
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM customers where admin_id = (?) AND branch = (?)"
    cursor.execute(check_query,admin_id,branch)
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
    cnxn = db.connection()
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
@mobile_methods.route("/mobile/AllItems/<adminID>/<branch>", methods=["GET", "POST"])
def mobile_ListAllItems(adminID,branch):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE admin_id = (?) AND branch = (?) "
    cursor.execute(check_query,adminID,branch)
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
# Customer and Operator Settings
@mobile_methods.route("/mobile/usrcheck/<role>/<admin_id>/<usr>/<newusr>", methods=["GET", "POST"])
def UsernameCheck(role,admin_id,usr,newusr):
    print('hellllllllllooooooooo')
    cnxn = db.connection()
    cursor = cnxn.cursor()    
    check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?)" %role
    cursor.execute(check_query,newusr,admin_id)
    if cursor.rowcount == 0 or usr == newusr:
        cnxn.close()
        print('Username is fine')
        return jsonify("ok")
    cnxn.close()
    print('Username is in the database')
    return jsonify("The Entered Username is Already Used! Choose a new one please.")
#############################################################
@mobile_methods.route("/mobile/settings/<role>/<usr>", methods=["GET", "POST"])
def settings(role,usr):
    cnxn = db.connection()
    cursor = cnxn.cursor()    
    if request.method == 'POST':
        firstname = request.form["firstname"]
        lastname = request.form["lastname"]
        username = request.form["username"]
        mail = request.form["mail"]
        password = request.form["password"] 
    insert_query = "UPDATE %s SET firstname = (?), lastname = (?), username = (?), mail= (?), pwd= (?) WHERE username = (?)" %role
    value = (firstname, lastname, username, mail, password, usr)
    cursor.execute(insert_query, value)
    cnxn.commit()
    cnxn.close()
    print('Settings Changed for user: '+usr+', from table %s.'%role)
    return jsonify("done")
    
#############################################################
# add customer check
@mobile_methods.route("/mobile/AddCustomerCheck/<adminID>/<opr>/<branch>", methods=["GET", "POST"])
def mobile_op_add_customer_check(adminID,opr,branch):
    cnxn = db.connection()
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
@mobile_methods.route("/mobile/AddCustomer/<adminID>/<opr>/<branch>", methods=["GET", "POST"])
def mobile_op_add_customer(adminID,opr,branch):
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
    rfiddd = None
    if rfid_flag == "yes" :
        check_query = "SELECT * FROM customers WHERE rfid = (?) AND admin_id = (?) AND and branch = (?)"
        cursor.execute(check_query, rfid, adminID, branch)
        rfiddd = rfid
    print("22222222222")
    if cursor.rowcount == 0 or rfid_flag == "no":
        insert_query = '''INSERT INTO customers VALUES (?,?,?,?,?,?,?,?,?,?);'''  # the '?' are placeholders
        value = (adminID, opr, rfiddd, firstname, lastname, username, mail, pwd, rfiddd, branch)
        cursor.execute(insert_query, value)
        cnxn.commit()
        cnxn.close()
        user_add_flag = "new User added to the database successfully"
        print(user_add_flag)
        return jsonify([user_add_flag])
    cnxn.close()
    user_add_flag = "RFID is already in the db"
    print(user_add_flag)
    return jsonify([user_add_flag])

#############################################################

# Remove Customer
@mobile_methods.route("/mobile/RemoveCustomer/<admin_id>/<branch>", methods=["GET", "POST"])
def mobile_RemoveCustomer(admin_id,branch):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("33333333")
    if request.method == 'POST':
        cst_username = request.form["cst_username"]
        usrn_rfid = request.form["usrn_rfid"]
    if usrn_rfid == "usrn" :
        print("4444444")
        check_query = "SELECT * FROM customers WHERE username = (?) AND admin_id = (?) AND branch = (?)"
        value = (cst_username,admin_id,branch)
        delete_query = "DELETE FROM customers WHERE username = (?) AND admin_id = (?) AND branch = (?)"
        delete_value = (cst_username,admin_id,branch)
    else :
        check_query = "SELECT * FROM customers WHERE rfid = (?) AND admin_id = (?) AND branch = (?)"        
        value = (rfid,admin_id,branch)
        delete_query = "DELETE FROM customers WHERE rfid = (?) AND admin_id = (?) AND branch = (?)"
        delete_value = (rfid,admin_id,branch)
    cursor.execute(check_query, value)
    print("66666666")
    if cursor.rowcount == 0 :
        cnxn.close()
        print("user not found")
        return jsonify(["no"])
    cursor.execute(delete_query, delete_value)
    cnxn.commit()
    cnxn.close()
    print("Operator removed a User successfully")
    return jsonify(["Done"])
    
        

#############################################################

# Add Book
@mobile_methods.route("/mobile/AddBook/<adminID>/<opr>/<branch>", methods=["GET", "POST"])
def totem_AddBook(adminID,opr,branch):
    global rfid_counter
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
                insert_query = '''INSERT INTO books VALUES (?,?,?,?,?,?,?,?,?,?); INSERT INTO items VALUES (?,?,?,?,?,?,?,?,?);'''
                insert_value = (rfiddd,rfiddd,Title,Author,Genre,Publisher,Date,0,Loc,Description,adminID,opr,None,rfiddd,Title,"Book",branch,0,"https://smallimg.pngkey.com/png/small/12-122439_book-icon-book-flat-icon-png.png")
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
@mobile_methods.route("/mobile/RemoveBook/<adminID>/<branch>", methods=["GET", "POST"])
def totem_RemoveBook(adminID,branch):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("000000000")
    if request.method == 'POST':
        title = request.form["title"]
        author = request.form["author"]
        rfid_flag = request.form["rfid_flag"]
    if rfid_flag == "yes" :
        check_query = "SELECT * FROM items WHERE rfid = (?) AND admin_id = (?) AND branch = (?)"
        delete_query1 = "DELETE FROM items WHERE rfid = (?) AND admin_id = (?) AND branch = (?)"
        delete_query2 = "DELETE FROM books WHERE rfid = (?)"
        value = (rfid,adminID,branch)
        value2 = (rfid)
        cursor.execute(check_query,value)
    else :
        check_query = "SELECT * FROM books WHERE author = (?) AND title = (?)"
        delete_query1 = "DELETE FROM items WHERE name = (?) AND admin_id = (?) AND branch = (?)"
        delete_query2 = "DELETE FROM books WHERE title = (?) AND author = (?)"
        value = (title,adminID,branch)
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
