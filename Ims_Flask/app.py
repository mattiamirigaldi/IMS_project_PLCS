from asyncio.windows_events import NULL
from contextlib import nullcontext
from turtle import title
from flask import Flask, redirect, render_template, Blueprint, request, json, jsonify, url_for, send_from_directory
import pyodbc
import requests

# __name__ means that is referencing this file
app = Flask(__name__)

def connection():
    ## Connection to the database
    # server and database names are given by SQL
    server = 'POUYAN'
    database = 'my_db'
    # Cnxn : is the connection string
    # If trusted connection is 'yes' then we log using our windows authentication
    cnxn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server}; \
         SERVER=' + server + '; \
         DATABASE=' + database + '; \
        Trusted_Connection=yes;')
    return cnxn


FLUTTER_WEB_APP = 'templates'

@app.route('/web/')
def render_page_web():
    return render_template('index.html')

@app.route('/web/<path:name>')
def return_flutter_doc(name):

    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]

    return send_from_directory(DIR_NAME, datalist[-1])

@app.route('/')
def render_page():
    return render_template('/index.html')

#@app.route("/", methods=["GET","POST"])
#def welcomhome():
#    return "welcome!"

@app.route("/register", methods=["GET","POST"])
def register():
    ## 1 SECTION: Connection to the database
    cnxn = connection()
    #create the connection cursor, to do queries in the database
    cursor = cnxn.cursor()

    ## 2 SECTION : API interface
    if request.method == 'POST':
        firstName = request.form["firstName"]
        print("firstname is "+firstName)
        lastName = request.form["lastName"]
        print("lastname is "+lastName)
        userName = request.form["userName"]
        print("username is "+userName)
        mail = request.form["email"]
        print("mail is "+mail)
        password = request.form["password"]
        print("password is "+password)

    ## 3 SECTION : Interaction with database, used the pyodbc library
    # Inserted register credentials in the table
    # insert_query is a variable, is a multiline string
    insert_query = '''INSERT INTO Library_Clients VALUES (?,?,?,?,?);'''    # the '?' are placeholders
    # Then to execute the query is use the method execute(), it can take as argument directly the line of code
    # to execute or a the variable query and the values to be used
    value = (firstName,lastName,userName,mail,password)
    cursor.execute(insert_query, value)
    # Lastly the change is committed
    cnxn.commit()
    # Then the connection can be closed
    cnxn.close()
    return jsonify(["Register success"])

@app.route("/login", methods=["GET","POST"])
def login():
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        userName = request.form["userName"]
        print("Username is "+userName)
        password = request.form["password"]
        print("Password is "+password)
    # check if user is registered
    check_query = '''SELECT CASE WHEN EXISTS (SELECT * FROM [Library_Clients] WHERE userName = (?) AND pwd = (?)) 
                    THEN CAST(1 AS BIT) 
                    ELSE CAST(0 AS BIT) 
                    END'''  # the '?' are placeholders
    value = (userName,password)
    cursor.execute(check_query,value)
    # the returned output is a cursor object
    checked = cursor.fetchone()
    print(checked)
    if checked[0]:
        # Then the connection can be closed
        check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
        value = (userName)
        cursor.execute(check_query,value)
        row = cursor.fetchone() 
        cnxn.close()
        print("Access to Login url : Successful")
        return jsonify(row.firstName,row.mail)
        #return jsonify(["valid user"])
    else:
        # Then the connection can be closed
        cnxn.close()
        return jsonify(["user not registered"])

@app.route("/settings/<usr>", methods=["GET","POST"])
def settings(usr):
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        userName = request.form["userName"]
    check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
    value = (usr)
    cursor.execute(check_query,value)
    row = cursor.fetchone() 
    print("SETTINGS : FIRSTNAME is "+row.firstName)
    print("Access to Settings url : Successful")
    cnxn.close()
    return jsonify(row.firstName,row.lastName,row.userName,row.mail,row.pwd)

@app.route("/settings_ch/<usr>", methods=["GET","POST"])
def settings_ch(usr):
    cnxn = connection()
    cursor = cnxn.cursor()

    if request.method == 'POST':
        firstName = request.form["firstName"]
        lastName = request.form["lastName"]
        userName = request.form["userName"]
        mail = request.form["email"]
        password = request.form["password"]

    print("SETTINGS : FIRSTNAME is "+firstName)
    print("Access to Settings_ch url : Successful_1")

    insert_query = "UPDATE Library_Clients SET firstName = (?), lastName = (?), userName = (?), mail= (?), pwd= (?) WHERE userName = (?)"
    value = (firstName,lastName,userName,mail,password,usr)
    cursor.execute(insert_query, value)
    cnxn.commit()
    
    print("Access to Settings_ch url : Successful_2")
    
    check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
    value = (userName)
    cursor.execute(check_query,value)
    row = cursor.fetchone()
    
    cnxn.close()

    print("Access to Settings_ch url : Successful_3")
    
    return jsonify(firstName,mail)


@app.route("/items/<id>", methods=["GET","POST"])
def items(id):
    cnxn = connection()
    cursor = cnxn.cursor()

    if request.method == 'POST':
        bkid = request.form["bkid"]

    print("SETTINGS : ID is "+bkid)
    print("Access to items url : Successful_1")
    
    check_query = 'SELECT * FROM [Items]'
    cursor.execute(check_query)
    j = 0
    id = []
    tit = []
    aut = []
    gen = []
    rfid = []
    data = []
    for row in cursor :
        print("Access to items url : Successful_3") 
        books = {"id":row[0], "Title":row[1], "Author":row[2], "Genre":row[3],"RFID":row[4],}
        data.append(books)
    for i in data :
        id.append(data[j]["id"])
        tit.append(data[j]["Title"])
        aut.append(data[j]["Author"])
        gen.append(data[j]["Genre"])
        rfid.append(data[j]["RFID"])
        j+=1
    cnxn.close()
    return jsonify (id,tit,aut,gen,rfid)
        #row = cursor.fetchone()
    

#@app.route("/test/<string:id>")
#def test(id):
#    cnxn = connection()
#    cursor = cnxn.cursor()
#    check_query = "SELECT * FROM [Library_Clients] WHERE userName = (?) "
#    value = (id)
#    cursor.execute(check_query,value)
#    row = cursor.fetchone() 
#    #return('id = '+id+'|| Firstname: '+row.firstName
#    #+'|| Lastname: '+row.lastName
#    #+'|| Username: '+row.userName
#    #+'|| Email: '+row.mail)
#
#    return jsonify(
#            firstName=row.firstName, mail=row.mail,
#        )
#       

@app.route("/test", methods=["GET","POST"])
def test():
    global rfid
    if request.method == 'POST':
        rfid = request.form['rfid']
        print(rfid)
        return redirect(url_for('totem'))
    return "welcome dear : "+str(rfid)


#Totem RFID read

rfid = 1    
opr_found_flag = 0

@app.route("/totem", methods=["GET","POST"])
def totem():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    if request.method == 'POST':
        rfid = request.form['rfid']
        print(rfid)
    return ("nunn")


#Operator login

@app.route("/totem/login", methods=["GET","POST"])
def totem_op_login():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    global role
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = (rfid)
    cursor.execute(check_query,value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        print (row.role_i)
        opr_found_flag = "found"
        print("Operator Found : Email is "+row.mail)
        return jsonify([opr_found_flag],row.firstName,row.lastName,row.userName,row.mail,row.pwd,row.RFID_i)
    else :
        opr_found_flag = "not_found"
        print("Operator Not found")
        return jsonify([opr_found_flag])


#User login

@app.route("/totem/user/login", methods=["GET","POST"])
def totem_usr_login():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    check_query = "SELECT * FROM [Library_Clients] WHERE RFID_i = (?) "
    value = (rfid)
    cursor.execute(check_query,value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None:
        global role
        global user_rfid
        role = row.role_i
        user_rfid = row.RFID_i
        usr_found_flag = "found"
        print("User Found : Email is "+row.mail)
        return jsonify([usr_found_flag],row.firstName,row.lastName,row.userName,row.mail,row.pwd,row.RFID_i)
    else :
        usr_found_flag = "not_found"
        print("User Not found")
        return jsonify([usr_found_flag])


#book check

@app.route("/totem/BookCheck", methods=["GET","POST"])
def totem_op_bc():
    cnxn = connection()
    cursor = cnxn.cursor()
    global rfid
    global book_rfid
    check_query = "SELECT * FROM [Items] WHERE RFID = (?) "
    value = (rfid)
    cursor.execute(check_query,value)
    row = cursor.fetchone()
    cnxn.close()
    print (row)
    if row != None :
        book_rfid = row.RFID
        book_found_flag = "found"
        print("Book Found : TITLE is "+row.Title)
        return jsonify([book_found_flag],row.id,row.Title,row.Author,row.Genre,row.RFID,row.RFID_i)
    else :
        book_found_flag = "not_found"
        print("Book Not found")
        return jsonify([book_found_flag])


#add customer check
@app.route("/totem/Operator/AddCustomerCheck", methods=["GET","POST"])
def totem_op_add_customer_check():
    cnxn = connection()
    cursor = cnxn.cursor()
    if request.method == 'POST':
        username = request.form["username"]
    check_query = "SELECT * FROM [Library_Clients] WHERE username = (?) "
    value = (username)
    cursor.execute(check_query,value)
    row = cursor.fetchone()
    cnxn.close()
    if row != None :
        return jsonify(["the entered username is used before"])
    else :
        return jsonify(["username is valid"])

#add customer
@app.route("/totem/Operator/AddCustomer", methods=["GET","POST"])
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
    cursor.execute(check_query,value)
    row = cursor.fetchone()

    if row == None :
        insert_query = '''INSERT INTO Library_Clients VALUES (?,?,?,?,?,?,'usr');'''    # the '?' are placeholders
        value = (firstName,lastName,username,mail,password,rfid)
        cursor.execute(insert_query,value)
        cnxn.commit()
        cnxn.close()
        user_add_flag = "new User added to the database successfully"
        print(user_add_flag)
        return jsonify([user_add_flag])
    else :
        user_add_flag = "RFID is already in the db"
        print(user_add_flag)
        return jsonify([user_add_flag])

#Remove Customer 
@app.route("/totem/Operator/RemoveCustomer", methods=["GET","POST"]) 
def RemoveCustomer(): 
   cnxn = connection() 
   cursor = cnxn.cursor() 
   global rfid 
   cnxn = connection() 
   cursor = cnxn.cursor() 
   check_query = "DELETE FROM [Library_Clients] WHERE rfid_i = (?) " 
   value = (rfid) 
   cursor.execute(check_query,value) 
   cnxn.commit() 
   cnxn.close() 
   remove_flag = "Customer removed successfully" 
   print("Customer removed successfully") 
   return jsonify([remove_flag])


#Remove Book 
@app.route("/totem/Operator/RemoveBook", methods=["GET","POST"]) 
def RemoveBook(): 
   cnxn = connection() 
   cursor = cnxn.cursor() 
   global rfid 
   cnxn = connection() 
   cursor = cnxn.cursor() 
   print(rfid)
   check_query = "DELETE FROM [Items] WHERE RFID = (?) " 
   value = (rfid) 
   cursor.execute(check_query,value) 
   cnxn.commit() 
   cnxn.close() 
   remove_flag = "Book removed successfully" 
   print("Book removed successfully") 
   return jsonify([remove_flag])


   #Rent book

@app.route("/totem/User/RentBook", methods=["GET","POST"])
def totem_book_rent():
   cnxn = connection() 
   cursor = cnxn.cursor() 
   global rfid 
   global user_rfid
   cnxn = connection() 
   cursor = cnxn.cursor() 
   print(rfid)
   check_query = "UPDATE [Items] SET RFID_i = (?) WHERE RFID = (?) " 
   value = (user_rfid,rfid) 
   cursor.execute(check_query,value) 
   cnxn.commit() 
   cnxn.close() 
   rent_flag = "Book rented successfully" 
   print("Book rented successfully") 
   return jsonify([rent_flag])


#Return book

@app.route("/totem/User/ReturnBook", methods=["GET","POST"])
def totem_book_return():
   cnxn = connection() 
   cursor = cnxn.cursor() 
   global rfid 
   global user_rfid
   cnxn = connection() 
   cursor = cnxn.cursor() 
   print(rfid)
   check_query = "UPDATE [Items] SET RFID_i = (?) WHERE RFID = (?) " 
   value = ('-1',rfid) 
   cursor.execute(check_query,value) 
   cnxn.commit() 
   cnxn.close() 
   return_flag = "Book returned successfully" 
   print("Book returned successfully") 
   return jsonify([return_flag])


@app.route("/get", methods=["GET","POST"])
def getdata(iiid):
    return "welcome dear : "+str(iiid)

if __name__=="__main__":
    app.run(host='0.0.0.0')
    #app.run(host='192.168.137.1')