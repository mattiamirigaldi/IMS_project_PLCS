class Customer {

  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String imagePath;
  final String news;
  final String pwd;

  const Customer ({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.imagePath,
    required this.news,
    required this.pwd
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
  Customer copy({
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? imagePath,
    String? news,
    String? pwd, 
  }) => Customer (
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    userName: userName ?? this.userName,
    email: email ?? this.email,
    imagePath: imagePath ?? this.imagePath,
    news: news ?? this.news,
    pwd: pwd ?? this.pwd
  );

  // method to translate json object into customer
  static Customer fromJson(Map<String,dynamic> json) => Customer(
    firstName: json['firstName'],
    lastName: json['lastName'],
    userName: json['userName'],
    email: json['email'],
    imagePath: json['imagePath'],
    news: json['news'],
    pwd: json['pwd'],
  );
}