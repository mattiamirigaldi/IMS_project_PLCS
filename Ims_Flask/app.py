from flask import Flask, render_template, Blueprint, request, json, jsonify
import pyodbc
# __name__ means that is referencing this file
app = Flask(__name__)

@app.route("/register", methods=["GET","POST"])
def register():

    ## 1 SECTION : Connection to the database
    # server and database names are given by SQL
    server = 'DESKTOP-I7POIMI\SQLEXPRESS'
    database = 'SQLTest'
    # Cnxn : is the connection string
    #If trusted connection is 'yes' then we log using our windows authentication
    cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';Trusted_Connection=yes;')
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
    insert_query = '''INSERT INTO LibraryClients VALUES (?,?,?,?,?);'''    # the '?' are placeholders
    # Then to execute the query is use the method execute(), it can take as argument directly the line of code
    # to execute or a the variable query and the values to be used
    value = (firstName,lastName,userName,mail,password)
    cursor.execute(insert_query, value)
    # Lastly the change is committed
    cnxn.commit()
    # Then the connection can be closed
    cnxn.close()
    return jsonify(["Register success"])
@app.route("/")
def welcomhome():
    return "welcome"

if __name__=="__main__":
    app.run(host='0.0.0.0')
