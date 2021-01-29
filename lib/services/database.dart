import 'dart:developer';

import 'package:mu_dent/models/appointment.dart';
import 'package:mu_dent/models/dentist.dart';
import 'package:mu_dent/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('Patients');
  final CollectionReference appointmentCollection =
      FirebaseFirestore.instance.collection('Appointments');
  final CollectionReference dentistCollection = 
      FirebaseFirestore.instance.collection('Dentists');

  Future updateUserData(String phoneNumber) async {
    return await patientCollection.doc(uid).set({
      'phoneNumber': phoneNumber,
    });
  }

  Future createPatientData(String name, String surName, String gender,
      String phoneNumber, String birthOfDate) async {
    return await patientCollection.doc(uid).set({
      'name': name,
      'surName': surName,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'birthOfDate': birthOfDate,
    });
  }

  // Future createAppointmentData(String ) {

  // }

  // // Brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Brew(
  //       name: doc.data()['name'] ?? '',
  //       strength: doc.data()['strength'] ?? 0,
  //       sugars: doc.data()['sugars'] ?? '0'
  //     );
  //   }).toList();
  // }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        surName: snapshot.data()['surName'],
        gender: snapshot.data()['gender'],
        phoneNumber: snapshot.data()['phoneNumber'],
        birthOfDate: snapshot.data()['birthOfDate']);
  }

  List<String> _dentistNameFromSnapshot(QuerySnapshot snapshot) {
    List<String> dentistNameList = [];
    return snapshot.docs.map((doc) {
      dentistNameList.add(doc.data()['Name']+doc.data()['Surname']);
    }).toList();
    // return snapshot.docs.map((doc) {
    //   return DentistData(
    //     name: doc.data()['Name'],
    //     surName: doc.data()['Surname'],
    //   );
    // }).toList();
  }

  List<AppointmentData> _appointmentFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return AppointmentData(
        patientID: doc.data()['patientID'],
        dentistID: doc.data()['dentistID'],
        type: doc.data()['name'],
        date: doc.data()['date'],
        time: doc.data()['time'],
        status: doc.data()['status'],
        venue: doc.data()['venue'],
        detail: doc.data()['detail'],
        assignedInstructor: doc.data()['assignedInstructors'],
      );
    }).toList();
  }

  List<DocumentSnapshot> filteredDocumentsBy(String key, String query) {
    appointmentCollection.where(key, isEqualTo: query).get().then((val) {
      return val.docs;
    });
  }

  // Get brews Stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots()
  //   .map(_brewListFromSnapshot);
  //   // return brewCollection.snapshots()
  //   // .map((QuerySnapshot snapshot) => _brewListFromSnapshot(snapshot));
  // }

  // Get user doc stream
  Stream<UserData> get patientData {
    return patientCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Stream<List<DentistData>> get dentistData {
  //   return dentistCollection.snapshots()
  //   .map(_dentistNameFromSnapshot);
  // }

  Stream<List<AppointmentData>> get appointmentList {
    return appointmentCollection.snapshots()
    .map(_appointmentFromSnapshot);
  }

  // Stream<List<Appointment>> get filterAppointmentList {
  //   appointmentCollection.where("Name", isEqualTo: "Bond").get();
  //   return appointmentCollection.snapshots()
  //   .map(_appointmentFromSnapshot).where("Name", isEqualR);
  // }

}
