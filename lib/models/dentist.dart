class Dentist {
  final String uid;

  Dentist({ this.uid });
  
}

class DentistData {
  final String uid;
  final String name;
  final String surName;
  final String gender;
  final String phoneNumber;
  final String operationPeriod;

  DentistData({
    this.uid, this.name, this.surName, this.gender, 
    this.phoneNumber, this.operationPeriod});
}