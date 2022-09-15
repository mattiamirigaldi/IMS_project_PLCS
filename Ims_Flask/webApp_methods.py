from asyncio.windows_events import NULL
from tkinter.messagebox import NO
from flask import Flask, Blueprint, render_template, redirect, json, jsonify, url_for, request
import pyodbc
import connectionToDb as db
webApp_methods = Blueprint('webApp_methods', __name__)
rfid_counter = 0


@webApp_methods.route("/web", methods=["GET", "POST"])
def webApp():
    if request.method == 'GET':
        return render_template('index.html')

@webApp_methods.route("/web/register", methods=["GET", "POST"])
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


@webApp_methods.route("/web/login", methods=["GET", "POST"])
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
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print (data[0]['firstname'])
    cnxn.close()
    return jsonify(data)

@webApp_methods.route("/web/admins/branch/<admin_id>", methods=["GET", "POST"])
def admin_branches(admin_id):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT DISTINCT branch FROM operators WHERE admin_id = (?)"
    cursor.execute(check_query,admin_id)
    if cursor.rowcount == 0:
        print("Branhces Not found")
        return jsonify(["not_found"])
    #column_names = [col[0] for col in cursor.description]
    #data = [dict(zip(column_names, row))  
    #    for row in cursor.fetchall()]
    data = [item[0] for item in cursor.fetchall()]
    print (data)
    cnxn.close()
    return jsonify(data)

@webApp_methods.route("/web/admins/<admin_id>", methods=["GET", "POST"])
def admin_operators(admin_id):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM operators WHERE admin_id = (?)"
    cursor.execute(check_query,admin_id)
    if cursor.rowcount == 0:
        print("Operators Not found")
        return jsonify(["not_found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print (data[0]['firstname'])
    cnxn.close()
    return jsonify(data)
#############################################################
# Customer and Operator Settings
@webApp_methods.route("/web/usrcheck/<role>/<admin_id>/<usr>/<newusr>", methods=["GET", "POST"])
def UsernameCheck(role,admin_id,usr,newusr):
    print('hellllllllllooooooooo')
    print(role)
    cnxn = db.connection()
    cursor = cnxn.cursor()    
    if role == ("operators" or "customers")  :
        check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?)" %role
        cursor.execute(check_query,newusr,admin_id)
        if cursor.rowcount == 0 or usr == newusr:
            cnxn.close()
            print('Username is fine')
            return jsonify("ok")
        cnxn.close()
        print('Username is in the database')
        return jsonify("The Entered Username is Already Used! Choose a new one please.")
    else:
        check_query = "SELECT * FROM %s WHERE username = (?) " %role
        cursor.execute(check_query,newusr)
        if cursor.rowcount == 0 or usr == newusr:
            cnxn.close()
            print('Username is fine')
            return jsonify("ok")
        cnxn.close()
        print('Username is in the database')
        return jsonify("The Entered Username is Already Used! Choose a new one please.")
    
    

@webApp_methods.route("/web/settings/<usr>/<role>", methods=["GET", "POST"])
def settings(usr,role):
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
    insert_query = "UPDATE %s SET firstname = (?), lastname = (?), username = (?), mail= (?), pwd= (?) WHERE username = (?)" %role
    value = (firstname, lastname, username, mail, password, usr)
    cursor.execute(insert_query, value)
    cnxn.commit()
    cnxn.close()
    return jsonify("done")
#############################################################


@webApp_methods.route("/web/user_edit/<usr>/<role>", methods=["GET", "POST"])
def user_edit(usr,role):
    cnxn = db.connection()
    cursor = cnxn.cursor()   
    if request.method == 'POST':
        firstname = request.form["firstname"]
        lastname = request.form["lastname"]
        username = request.form["username"]
        oldUsername = request.form["oldUsername"]
        mail = request.form["mail"]
        password = request.form["password"]
        rfid = request.form["rfid"]
        userRole = request.form["userRole"]
    print("SETTINGS : FIRSTNAME is " + firstname)
    print("SETTINGS : username is " + username)
    print("user role is"+ userRole)
    print("************************************")
    insert_query = "UPDATE %s SET firstname = (?), lastname = (?), username = (?), mail= (?), pwd= (?), rfid=(?),id = (?) WHERE username = (?)"%userRole
    value = (firstname, lastname, username, mail, password,rfid,rfid, oldUsername)
    cursor.execute(insert_query, value)
    cnxn.commit()
    cnxn.close()
    return jsonify("done")


@webApp_methods.route("/web/items/<role>/<id>/<branch>", methods=["GET", "POST"])
def ListItems(role,id,branch):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("Access to List Items url")
    if role == "admins" :
        if branch == 'ALL':
            check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE admin_id = (?)"
            value = (id)
        else:
            check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE admin_id = (?) AND branch = (?)"
            value = (id,branch)
        cursor.execute(check_query,value)
    if role == "operators" :
        check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE branch = (?)"
        cursor.execute(check_query,branch)
    if role == "customers" :
        check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id WHERE branch = (?)"
        cursor.execute(check_query,branch)
    if cursor.rowcount == 0:
        cnxn.close()
        print("There are no Items")
        return jsonify(["not_found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    cnxn.close()
    return jsonify(data)

@webApp_methods.route("/web/item_edit/<oldid>", methods=["GET", "POST"])
def item_edit(oldid):
    cnxn = db.connection()
    cursor = cnxn.cursor()   
    if request.method == 'POST':
        newTitle = request.form["newTitle"]
        newAuthor = request.form["newAuthor"]
        newDescription = request.form["newDescription"]
        newLocation = request.form["newLocation"]
        newCategory = request.form["newCategory"]
        newRfid = request.form["newRfid"]
    print("SETTINGS : newTitle is " + newTitle)
    print("************************************")
    insert_query = "UPDATE books SET title = (?), author = (?), genre = (?), rfid= (?), loc= (?), description = (?) WHERE id = (?)"
    value = (newTitle, newAuthor, newCategory, newRfid, newLocation, newDescription, oldid)
    cursor.execute(insert_query, value)
    cnxn.commit()
    cnxn.close()
    return jsonify("done")

@webApp_methods.route("/web/item_remove/<role_type>/<usr>/<id>", methods=["GET", "POST"])
def item_remove(role_type,usr,id):
    cnxn = db.connection()
    cursor = cnxn.cursor()   
    if role_type == "admins":
        delete_query = '''  DELETE FROM items WHERE id = (?) AND admin_id = (?);
                            DELETE FROM books WHERE id = (?); '''
    if role_type == "operators":
        delete_query = '''  DELETE FROM items WHERE id = (?) AND opr_id = (?);
                            DELETE FROM books WHERE id = (?); '''
    print("111111111")
    cursor.execute(delete_query,id,usr,id)
    cnxn.commit()
    cnxn.close()
    return jsonify(["done"])

@webApp_methods.route("/web/item_rent/<role_type>/<id>/<username>/<bookid>", methods=["GET", "POST"])
def item_rent(role_type,id,username,bookid):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("111111111")
    if role_type == "admins":
        check_query = "SELECT * FROM customers WHERE username = (?) AND admin_id = (?) "
        insert_query = "UPDATE items SET cus_id = (?) WHERE id = (?) AND admin_id = (?) "
    if role_type == "operators":
        check_query = "SELECT * FROM customers WHERE username = (?) AND opr_id = (?) "
        insert_query = "UPDATE items SET cus_id = (?) WHERE id = (?) AND opr_id = (?) "
    cursor.execute(check_query,username,id)
    if cursor.rowcount == 0 :
        cnxn.close()
        return jsonify(["User not found"])
    row = cursor.fetchone()
    cursor.execute(insert_query,row[2],bookid,id)
    cnxn.commit()
    cnxn.close()
    return jsonify(["done"])

@webApp_methods.route("/web/item_return/<role_type>/<id>/<bookid>", methods=["GET", "POST"])
def item_return(role_type,id,bookid):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("111111111")
    if role_type == "admins":
        insert_query = "UPDATE items SET cus_id = (?) WHERE id = (?) AND admin_id = (?) "
    if role_type == "operators":
        insert_query = "UPDATE items SET cus_id = (?) WHERE id = (?) AND opr_id = (?) "
    cursor.execute(insert_query,None,bookid,id)
    cnxn.commit()
    cnxn.close()
    return jsonify(["done"])

#@webApp_methods.route("/web/items", methods=["GET", "POST"])
#def items():
#    cnxn = db.connection()
#    cursor = cnxn.cursor()
#    if request.method == 'GET':
#        print("GET request")
#    print("Access to items url : Successful_1")
#    check_query = 'SELECT * FROM [Items]'
#    cursor.execute(check_query)
#    j = 0
#    tit = []
#    aut = []
#    gen = []
#    rfid = []
#    usr = []
#    loc = []
#    data = []
#    for row in cursor:
#        print("Access to items url : Successful_3")
#        books = {"Title": row[0], "Author": row[1], "Genre": row[2], "RFID": row[3], "userName": row[4], "Location": row[5]}
#        data.append(books)
#    for i in data:
#        tit.append(data[j]["Title"])
#        aut.append(data[j]["Author"])
#        gen.append(data[j]["Genre"])
#        rfid.append(data[j]["RFID"])
#        usr.append(data[j]["userName"])
#        loc.append(data[j]["Location"])
#        j += 1
#    cnxn.close()
#    return jsonify(tit, aut, gen, rfid, usr, loc)


# List Users
@webApp_methods.route("/web/ListUsers/<role>/<id>/<table_adminID>/<branch>", methods=["GET", "POST"])
def mobile_ListUsers(role,id,table_adminID,branch):
    print(role,id,table_adminID,branch)
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if role == 'operators': # we need admin_id + branch + ID + role
        cursor.execute("SELECT * FROM customers where admin_id = (?) AND branch = (?)",table_adminID,branch)
    if role == 'admins':    # we need table + branch + ID + role
        if branch == 'ALL':
            cursor.execute("SELECT * FROM %s where admin_id = (?)"%table_adminID,id)
        else : 
            cursor.execute("SELECT * FROM %s where admin_id = (?) AND branch = (?)"%table_adminID,id,branch)
    if cursor.rowcount == 0:
        cnxn.close()
        print("There are no user for you")
        return jsonify(["not_found"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    cnxn.close()
    return jsonify(data)

# add user check
@webApp_methods.route("/web/AddCustomerCheck/<adminID>/<rfid>/<role_type>", methods=["GET", "POST"])
def web_op_add_customer_check(adminID,rfid,role_type):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["username"]
        role = request.form["role"]
    if role_type == "admins":
        print(username)
        print(adminID)
        check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) " %role
        check_value =(username,rfid)
        value = check_value
    if role_type == "operators":
        print(username)
        print(adminID)
        print(rfid)
        check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) AND opr_id = (?) "%role
        check_value = (username,adminID,rfid)
        value = check_value
    cursor.execute(check_query,value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print("user used")
        return jsonify(["the entered username is used before"])
    else:
        print("user available")
        return jsonify(["username is valid"])


# add user
@webApp_methods.route("/web/AddCustomer/<adminID>/<rfid>/<role_type>", methods=["GET", "POST"])
def web_op_add_customer(adminID,rfid,role_type):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    global user_add_flag
    if request.method == 'POST':
        firstname = request.form["firstName"]
        lastname = request.form["lastName"]
        username = request.form["username"]
        mail = request.form["email"]
        pwd = request.form["password"]
        branch = request.form["branch"]
        rfid_flag = request.form["rfid_flag"]
        role = request.form["role"]
    print("11111111111")
    #####this IF is useless in web####
    if rfid_flag == "yes" :
        check_query = "SELECT * FROM customers WHERE rfid = (?) AND admin_id = (?) AND opr_id = (?)"
        cursor.execute(check_query, rfid, adminID, rfid)
        rfiddd = rfid
        row = cursor.fetchone()
    ##################################
    else :
        rfiddd = None
        row = None
    print("22222222222")
    if row == None:
        if role_type == "admins":
            if role == 'operators':
                insert_query = '''INSERT INTO %s VALUES (?,?,?,?,?,?,?,?,?);''' %role
                value = (rfid, rfiddd, firstname, lastname, username, mail, pwd, rfiddd, branch)
            if role == 'customers':
                insert_query = '''INSERT INTO %s VALUES (?,?,?,?,?,?,?,?,?,?);''' %role
                value = (rfid,rfiddd, rfiddd, firstname, lastname, username, mail, pwd, rfiddd, branch)
        if role_type == "operators":
            insert_query = '''INSERT INTO %s VALUES (?,?,?,?,?,?,?,?,?,?);''' %role
            value = (adminID, rfid, rfiddd, firstname, lastname, username, mail, pwd, rfiddd, branch)
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
@webApp_methods.route("/web/RemoveCustomer/<adminID>/<rfid>/<role_type>", methods=["GET", "POST"])
def web_RemoveCustomer(adminID,rfid,role_type):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("33333333")
    if request.method == 'POST':
        cst_username = request.form["cst_username"]
        role = request.form["role"]
        print("role is " + role)
        if role_type == "operators":
            print("user is operator")
            check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) AND opr_id =(?) "%role
            value = (cst_username,adminID,rfid)
            delete_query = "DELETE FROM %s WHERE username = (?) AND admin_id = (?) AND opr_id =(?)"%role
            delete_value = (cst_username,adminID,rfid)
        if role_type == "admins":
            print("user is admin")
            check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) "%role
            value = (cst_username,rfid)
            delete_query = "DELETE FROM %s WHERE username = (?) AND admin_id = (?)"%role
            delete_value = (cst_username,rfid)           
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



# Remove User
@webApp_methods.route("/web/RemoveUser/<adminID>/<rfid>/<role_type>", methods=["GET", "POST"])
def web_RemoveUser(adminID,rfid,role_type):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("33333333")
    if request.method == 'POST':
        username = request.form["username"]
        role = request.form["role"]
        print("role is " + role)
        if role_type == "operators":
            print("user is operator")
            check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) AND opr_id =(?) "%role
            value = (username,adminID,rfid)
            delete_query = "DELETE FROM %s WHERE username = (?) AND admin_id = (?) AND opr_id =(?)"%role
            delete_value = (username,adminID,rfid)
        if role_type == "admins":
            print("user is admin")
            check_query = "SELECT * FROM %s WHERE username = (?) AND admin_id = (?) "%role
            value = (username,rfid)
            delete_query = "DELETE FROM %s WHERE username = (?) AND admin_id = (?)"%role
            delete_value = (username,rfid)           
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

        ######################################################################

# Add Book
@webApp_methods.route("/web/AddBook/<adminID>/<rfid>/<role_type>", methods=["GET", "POST"])
def totem_AddBook(adminID,rfid,role_type):
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
    if role_type == "operators":
        check_query1 = " SELECT * FROM books WHERE title = (?) AND author = (?)"
        cursor.execute(check_query1,Title,Author)
        print("check1: " + str(cursor.rowcount))
        if cursor.rowcount == 0 or rfid_flag == "no": 
            rfiddd = rfid
            print("4444444 :  " + str(rfiddd))
            if rfiddd == -1 : 
                cnxn.close()
                return jsonify(["Please Scan the RFID"])
            insert_query = '''INSERT INTO books VALUES (?,?,?,?,?,?,?,?,?,?); INSERT INTO items VALUES (?,?,?,?,?,?,?,?);'''
            insert_value = (rfiddd,rfiddd,Title,Author,Genre,Publisher,Date,0,Loc,Description,adminID,rfid,None,rfiddd,Title,"Book","Turin",0)
            cursor.execute(insert_query, insert_value)
            cnxn.commit()
            return jsonify(["done"])
        else :
            cnxn.close()
            return jsonify(["The book is already in the Database"])
    if role_type == "admins":
        check_query1 = " SELECT * FROM books WHERE title = (?) AND author = (?)"
        cursor.execute(check_query1,Title,Author)
        print("check1: " + str(cursor.rowcount))
        if cursor.rowcount == 0 or rfid_flag == "no": 
            rfiddd = rfid
            print("4444444 :  " + str(rfiddd))
            if rfiddd == -1 : 
                cnxn.close()
                return jsonify(["Please Scan the RFID"])
            insert_query = '''INSERT INTO books VALUES (?,?,?,?,?,?,?,?,?,?); INSERT INTO items VALUES (?,?,?,?,?,?,?,?);'''
            insert_value = (rfiddd,rfiddd,Title,Author,Genre,Publisher,Date,0,Loc,Description,rfid,None,None,rfiddd,Title,"Book","Turin",0)
            cursor.execute(insert_query, insert_value)
            cnxn.commit()
            return jsonify(["done"])
        else :
            cnxn.close()
            return jsonify(["The book is already in the Database"])
        



# Remove Book
@webApp_methods.route("/web/RemoveBook/<adminID>/<rfid>/<role_type>", methods=["GET", "POST"])
def totem_RemoveBook(adminID,rfid,role_type):
    cnxn = db.connection()
    cursor = cnxn.cursor()
    print("000000000")
    if request.method == 'POST':
        title = request.form["title"]
        author = request.form["author"]
        rfid_flag = request.form["rfid_flag"]
    if role_type == "operators":
        check_query = "SELECT * FROM books WHERE author = (?) AND title = (?)"
        delete_query1 = "DELETE FROM items WHERE name = (?) AND admin_id = (?) AND opr_id = (?)"
        delete_query2 = "DELETE FROM books WHERE title = (?) AND author = (?)"
        value = (title,adminID,rfid)
        value2 = (title,author)
        cursor.execute(check_query,author,title)
    if role_type == "admins":
        check_query = "SELECT * FROM books WHERE author = (?) AND title = (?)"
        delete_query1 = "DELETE FROM items WHERE name = (?) AND admin_id = (?)"
        delete_query2 = "DELETE FROM books WHERE title = (?) AND author = (?)"
        value = (title,rfid)
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
# List the User Items
@webApp_methods.route("/web/UserItems/<adminID>/<opr>/<usr>", methods=["GET", "POST"])
def mobile_ListUserItems(adminID,opr,usr):
    print(adminID,opr,usr)
    cnxn = db.connection()
    cursor = cnxn.cursor()
    check_query = "SELECT * FROM books INNER JOIN items ON books.item_id = items.id where admin_id = (?) AND opr_id = (?) AND items.cus_id = (?)"
    cursor.execute(check_query,adminID,opr,usr)
    if cursor.rowcount == 0:
        cnxn.close()
        print("User does not have any Item")
        return jsonify(["You don't have any Items"])
    column_names = [col[0] for col in cursor.description]
    data = [dict(zip(column_names, row))  
        for row in cursor.fetchall()]
    print("There are some Items")
    cnxn.close()
    return jsonify(data)
