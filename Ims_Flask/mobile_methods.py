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
    #cursor.execute(check_query, rfid)
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
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, row.rfid)
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
        return jsonify(["found"], row.firstname, row.lastname, row.username, row.mail, row.rfid)
    else:
        print("operator Not found")
        return jsonify(["not_found"])

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
@mobile_methods.route("/mobile/Operator/AddCustomerCheck", methods=["GET", "POST"])
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
@mobile_methods.route("/mobile/Operator/AddCustomer", methods=["GET", "POST"])
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

#############################################################

# Remove Customer
@mobile_methods.route("/mobile/Operator/RemoveCustomer", methods=["GET", "POST"])
def RemoveCustomer():
    cnxn = connection()
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
