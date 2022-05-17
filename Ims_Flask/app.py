from asyncio.windows_events import NULL
from contextlib import nullcontext
from turtle import title
from flask import Flask, render_template, Blueprint, request, json, jsonify
import pyodbc
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
    #print(tit)
    #print(aut)
    #print(gen)
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
@app.route("/")
def welcomhome():
    return "welcome"

if __name__=="__main__":
    app.run(host='0.0.0.0')
