update Items

set Items.RFID_i=Library_Clients.RFID_i
from Items, Library_Clients
where Items.Title = 'Harry Potter';