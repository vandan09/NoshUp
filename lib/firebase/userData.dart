class UserModel {
  String? uname;
  String? email;
  String? mobileno;

  UserModel({this.uname, this.email});

  //recieve data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uname: map["uname"],
      email: map["email"],
    );
  }

  //send data to server
  Map<String, dynamic> toMap() {
    return {
      "uname": uname,
      "email": email,
    };
  }
}
