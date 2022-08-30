class User {

  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String imagePath;
  final String news;
  final String pwd;
  final int role;     // if customer role = 0, if operator role =1, if admin role = 2

  const User ({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.imagePath,
    required this.news,
    required this.pwd,
    required this.role,
  });

  Map<String,dynamic> toJson() => {
    'firstName' : firstName,
    'lastName' : lastName,
    'userName' : userName,
    'email' : email,
    'imagePath' : imagePath,
    'news' : news,
    'pwd' : pwd,
  };

  // Create a copy of the user, parameters given as input are different
  User copy({
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? imagePath,
    String? news,
    String? pwd, 
    int? role,
  }) => User (
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    userName: userName ?? this.userName,
    email: email ?? this.email,
    imagePath: imagePath ?? this.imagePath,
    news: news ?? this.news,
    pwd: pwd ?? this.pwd,
    role: role ?? this.role
  );

  // method to translate json object into customer
  static User fromJson(Map<String,dynamic> json) => User(
    firstName: json['firstName'],
    lastName: json['lastName'],
    userName: json['userName'],
    email: json['email'],
    imagePath: json['imagePath'],
    news: json['news'],
    pwd: json['pwd'],
    role: json['role'],
  );
}