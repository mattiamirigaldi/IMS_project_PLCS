import 'package:flutter/material.dart';
import './../services/http_services.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  //NOTE : in a dart if an identifier start with '_' then it is private to its library
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

// _RegisterPageState inherits the state of RegisterPage
class _RegisterPageState extends State<RegisterPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  // Register form data
  late String email;
  late String firstName;
  late String lastName;
  late String username;
  late String password;
  late String key;
  late bool _obscureText = true;
  late bool _obscureTextVal = true;
  @override
  Widget build(BuildContext context) {
    double width_screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: (
            Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const Image(
                  image: AssetImage("images/ims.jpg"),
                  width: 45,
                  height: 45,
                ),
              ),
              const SizedBox(width: 30,),
              const Text("Register page")
            ])
          ),
        ),
        body: Center(
          child: Container(
            width: width_screen*0.7,
            child: Form(
              key: _formKey,
              child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Center(
                        child: Text(
                          "Register your  account".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent.withOpacity(0.8)),
                          textAlign: TextAlign.center,
                          textScaleFactor: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter your first name",
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter your last name",
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter your username",
                            labelText: 'Username',
                            border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            username = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter your email address",
                            labelText: 'Email',
                            border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap:(){
                              setState(() {
                                 _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off)
                          ),
                        ),
                        hintText: "Enter your password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: _obscureText,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap:(){
                              setState(() {
                                 _obscureTextVal = !_obscureTextVal;
                              });
                            },
                            child: Icon(_obscureTextVal ? Icons.visibility : Icons.visibility_off)
                          ),
                        ),
                        hintText: "Confirm your password",
                        labelText: "Password validation",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: _obscureTextVal,
                      validator: (String? value) {
                        if (value != password) {
                          return 'Password is not correct';
                        }
                        return null;
                      },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter your admin key",
                            labelText: 'Admin key',
                            border: OutlineInputBorder()),
                        onChanged: (value) {
                          setState(() {
                            key = value;
                          });
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  const SizedBox(height: 30),
                    InkWell(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: const Center(
                              child: Text("SUBMIT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepOrangeAccent),
                        ),
                        onTap: () async {
                          if (_formKey.currentState != null) {
                            if (_formKey.currentState!.validate()) {
                              await Httpservices.register(firstName, lastName,
                                  username, email, password, context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Register Success")));
                            }
                          } else {}
                        })
                  ]),
            ),
          ),
        ));
  }
}
