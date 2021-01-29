class AppointmentData {
  // final String appointmentID;
  final String patientID;
  final String patientName;
  final String patientSurName;
  final String dentistID;
  final String dentistName;
  final String dentistSurName;
  final status;
  String type;
  final String date;
  final String time;
  final String detail;
  final String venue;
  final String assignedInstructor;

  AppointmentData(
      {this.patientID,
      this.dentistID,
      this.dentistName,
      this.dentistSurName,
      this.patientName,
      this.patientSurName,
      this.status,
      this.type,
      this.date,
      this.time,
      this.detail,
      this.venue,
      this.assignedInstructor});
}

enum status {
  Pending,
  Approved,
  Confirmed,
  Declined,
  Absent,
  PleaseContact
}

class AppointmentList {
  List<String> appointmentType = [
    'Bond',
    'Band',
    'Bond/Band',
    'Debond/Deband',
    'Insert RTN',
    'Insert instrument',
    'New',
    'Obsever',
    'Recheck RTN',
    'Instrument removal + install RTN'
  ];
}
