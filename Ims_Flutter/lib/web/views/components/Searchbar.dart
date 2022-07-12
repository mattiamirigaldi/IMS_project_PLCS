import 'package:flutter/material.dart';
import 'package:ims/web/data/book_data.dart';
import 'package:ims/web/model/book.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);
   
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // Global key that uniquely identifies the form widget and is used for validation
  final _formKey = GlobalKey<FormState>();
  // Found books in database
  late List<Book> books;
   // Typed in the text field
  late String typed = '';
  // Initial filter
  String filter = 'All';
  // list of possibile filters
  var filters = ['All', 'Title', 'Author', 'Subject'];
  //to get to offset of where to place the menu
  @override
  void initState() {
    super.initState();
    books = allBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(8),
              color: Colors.grey.withOpacity(0.1),
              border: Border.all(color: Colors.black.withOpacity(0.1))),
          width: 400,
          height: 45,
          child: Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              //button to change type of reaserch
              child: DropdownButton(
                  underline: Container(), //remove underline
                  //isExpanded: true,
                  dropdownColor: Colors.white,
                  alignment: Alignment.center,
                  icon: Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: filters.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  value: filter,
                  onChanged: (String? newValue) {
                    setState(() {
                      filter = newValue!;
                    });
                  }),
            ),
           
            Expanded(
                child: PopupMenuButton<Book>(
                  offset: Offset(0.0, 44),
                  child: TextFormField(             
                    
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                      icon:  IconButton(
                        splashColor: Colors.grey,
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      hintText: "Search ... ",
                    ),
                      onChanged: (value) {
                        setState(() {
                          //final List<String> FoundItems = ShowResults;
                          typed = value;
                          print(typed);
                          //here called each 300 ms the http service that results the top 5 correspondence
                        });
                      }),
                      onSelected: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('selected ' + value.title)));
                      },
                      itemBuilder: (BuildContext context) => books.map((e) =>
                        PopupMenuItem<Book>(
                          value: e, 
                          child: SizedBox(width:200, child: buildBook(e)) 
                        )
                      ).toList())
            ),
            
          ]),
        ),
      ),
    );
  }
}


Widget buildBook(Book book) => ListTile(
      leading: Image.network(
        book.urlImage,
        fit: BoxFit.cover,
        width: 40,
        height: 40,
      ),
      title: Text(book.title),
      subtitle: Text(book.author),
    );
