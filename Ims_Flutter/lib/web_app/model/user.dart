// ignore_for_file: non_constant_identifier_names

class User {
  String firstname;
  String lastname;
  String username;
  String mail;
  String rfid;
  String admin_id;
  String opr_id;
  String imagePath;
  String news;
  String pwd;
  String
      role; // if customer role = cus, if operator role = opr, if admin role = adm

  User({
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.mail,
    required this.rfid,
    required this.admin_id,
    required this.opr_id,
    required this.imagePath,
    required this.news,
    required this.pwd,
    required this.role,
  });
}
//  Map<String,dynamic> toJson() => {
//    'firstName' : firstName,
//    'lastName' : lastName,
//    'userName' : userName,
//    'email' : email,
//    'imagePath' : imagePath,
//    'news' : news,
//    'pwd' : pwd,
//  };
//
//  // Create a copy of the user, parameters given as input are different
//  User copy({
//    String? firstName,
//    String? lastName,
//    String? userName,
//    String? email,
//    String? imagePath,
//    String? news,
//    String? pwd,
//    int? role,
//  }) => User (
//    firstName: firstName ?? this.firstName,
//    lastName: lastName ?? this.lastName,
//    userName: userName ?? this.userName,
//    email: email ?? this.email,
//    imagePath: imagePath ?? this.imagePath,
//    news: news ?? this.news,
//    pwd: pwd ?? this.pwd,
//    role: role ?? this.role
//  );
//
//  // method to translate json object into customer
//  static User fromJson(Map<String,dynamic> json) => User(
//    firstName: json['firstName'],
//    lastName: json['lastName'],
//    userName: json['userName'],
//    email: json['email'],
//    imagePath: json['imagePath'],
//    news: json['news'],
//    pwd: json['pwd'],
//    role: json['role'],
//  );

