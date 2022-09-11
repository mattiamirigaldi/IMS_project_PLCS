import pyodbc

def connection():
    ## Connection to the database
    # server and database names are given by SQL
    ######## POUYAN DB ##################
    # server = 'POUYAN'
    # database = 'mydb'
    ######## REZA DB ####################
    server = 'DESKTOP-CK2AQQI'
    database = 'ims_db'
    ######## MATTIA DB ####################
    #server = 'DESKTOP-I7POIMI\SQLEXPRESS'
    #database = 'SQLTest'
    # Cnxn : is the connection string
    # If trusted connection is 'yes' then we log using our windows authentication
    cnxn = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server}; \
         SERVER=' + server + '; \
         DATABASE=' + database + '; \
        Trusted_Connection=yes;')
    return cnxn
