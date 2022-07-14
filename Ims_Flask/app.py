from asyncio.windows_events import NULL
from contextlib import nullcontext
from turtle import title
from flask import Flask, redirect, render_template, Blueprint, request, json, jsonify, url_for, send_from_directory
import pyodbc
from totem_methods import totem_methods
from webApp_methods import webApp_methods

# __name__ means that is referencing this file
app = Flask(__name__)

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


FLUTTER_WEB_APP = 'templates'

@app.route('/')
def render_page_web():
    return render_template('index.html')

@app.route('/<path:name>')
def return_flutter_doc(name):
    # the path to the requested files in the templates directory is embedded in the URL of the request.
    # Hence, the return_flutter_doc function extracts the path to the requested files from the request URL
    #  and serves the files from the templates folder over HTTP.
    datalist = str(name).split('/')
    DIR_NAME = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            DIR_NAME += '/' + datalist[i]

    return send_from_directory(DIR_NAME, datalist[-1])


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

@app.route("/test", methods=["GET", "POST"])
def test():
    global rfid
    if request.method == 'POST':
        rfid = request.form['rfid']
        print(rfid)
        return redirect(url_for('totem'))
    return "welcome dear : "+str(rfid)

#imported applications in webApp methods into app
app.register_blueprint(webApp_methods)
# imported applications in totem_methods into app
app.register_blueprint(totem_methods)

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
