from asyncio.windows_events import NULL
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
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid))
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
    #global useruser
    if row != None:
        print("User Found : FIRSTNAME is " + row.firstname)
        print("User Found : RFID is " + str(row.rfid))
        #useruser = row.userName
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, str(row.rfid))
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
    j = 0
    fname = []
    lname = []
    uname = []
    email = []
    rfid = []
    data = []
    for row in cursor:
        customers = {"fname": row[3], "lname": row[4], "uname": row[5], "email": row[6], "rfid": row[8]}
        data.append(customers)
    if cursor.rowcount == 0:
        cnxn.close()
        print("There are no Customer for you")
        return jsonify(["not_found"])
    else:      
        print("------Customer Found ------")
        print("------ 111111 ------")
        for i in data:
            fname.append(data[j]["fname"])
            lname.append(data[j]["lname"])
            uname.append(data[j]["uname"])
            email.append(data[j]["email"])
            rfid.append(data[j]["rfid"])
            j += 1
        cnxn.close()
        print("------ 222222 ------")
        return jsonify([fname, lname, uname, email, rfid]) 

#############################################################
# List the User Items
@mobile_methods.route("/mobile/UserItems/<usr>", methods=["GET", "POST"])
def mobile_ListUserItems(usr):
    print(usr)
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where items.cus_id = (?) "
    cursor.execute(check_query, usr)
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
    if cursor.rowcount == 0:
        cnxn.close()
        print("User does not have any Item")
        return jsonify(["You don't have any Item"])
    else:      
        print("------ Book Found ------")
        print("------ 111111 ------")
        for i in data:
            tit.append(data[j]["title"])
            aut.append(data[j]["author"])
            gen.append(data[j]["genre"])
            rfid.append(data[j]["rfid"])
            usr.append(data[j]["cus_id"])
            loc.append(data[j]["location"])
            j += 1
        cnxn.close()
        print("------ 222222 ------")
        return jsonify([tit, aut, gen, rfid, usr, loc]) 
        

# List All the Items
@mobile_methods.route("/mobile/AllItems", methods=["GET", "POST"])
def mobile_ListAllItems():
    cnxn = connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id"
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
        books = {"title": row[2], "author": row[3], "genre": row[4], "rfid": row[7], "cus_id": row[10], "location": row[14]}
        data.append(books)
    if cursor.rowcount == 0:
        cnxn.close()
        print("No book in the library")
        return jsonify(["No book in the library"])
    else:      
        print("------ Book Found ------")
        print("------ 111111 ------")
        for i in data:
            tit.append(data[j]["title"])
            aut.append(data[j]["author"])
            gen.append(data[j]["genre"])
            rfid.append(data[j]["rfid"])
            usr.append(data[j]["cus_id"])
            loc.append(data[j]["location"])
            j += 1
        cnxn.close()
        print("------ 222222 ------")
        return jsonify([tit, aut, gen, rfid, usr, loc])


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
@mobile_methods.route("/mobile/Operator/AddBook", methods=["GET", "POST"])
def totem_AddBook():
    cnxn = connection()
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
@mobile_methods.route("/mobile/Operator/RemoveBook", methods=["GET", "POST"])
def totem_RemoveBook():
    cnxn = connection()
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

@mobile_methods.route("/get", methods=["GET", "POST"])
def getdata(iiid):
    return "welcome dear : " + str(iiid)
