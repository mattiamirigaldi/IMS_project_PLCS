# IMS_project_PLCS
Implementation of an Inventory Management System (IMS), exam of course "Project and Laboratories on Communication Systems (PLCS)" done at Polito
## SQL DATABASE
Follow the tutorial to set SQL environment : \
https://www.youtube.com/watch?v=RSlqWnP-Dy8&t=281s&ab_channel=AlexTheAnalyst \
To create the table run the following code : \
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
\
*CREATE TABLE Library_Clients* \
*( firstName varchar (50)*, \
  *lastName  varchar (50)*, \
  *userName varchar(50)*, \
  *mail  varchar(100)*, \
  *pwd  varchar(50)* \
*)* 
\
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
Then to get servers info needed to connect to it, just click on "connect" button and this window pops up: \

![image](https://user-images.githubusercontent.com/63643172/167146440-8d7e4908-b535-49e9-96f9-52c515e14175.png)
## FLASK
Simply replace the database info used with your own. \ 
Then run it. 
## FLUTTER 
Before of running the flutter application :
# step 1 
In the user settings search for "Flutter run additional args", there add "--no-sound-null-safety" \
Needed since used http package that is not null safe 
# step 2 
in the cmd prompt > flutter run \
This will install the needed packages \
Then you are ready to debug the app :) 
