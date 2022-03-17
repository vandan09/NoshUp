class AdminModel {
  String? uname;
  String? email;
  String? mobileno;

  AdminModel({this.uname, this.email});

  //recieve data from server
  factory AdminModel.fromMap(map) {
    return AdminModel(
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
