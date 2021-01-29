class Users {
  final String uid;

  Users({ this.uid });
}

class UserData {
  final String uid;
  final String name;
  final String surName;
  final String gender;
  final String phoneNumber;
  final String birthOfDate;

  UserData({
    this.uid, this.name, this.surName, this.gender, 
    this.phoneNumber, this.birthOfDate});
}