class PatientModel {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String age;
  final String patientId;
  final String bloodGroup;
  final String address;
  final String height;
  final String weight;
  final String bp;
  final String image;
  final String spo2;
  // final String problem;
  // final String surgery;
  final String pulse;
  final String temperature;
  final String allergies;
  final String emergencyContact;

  PatientModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.age,
    required this.patientId,
    required this.bloodGroup,
    required this.address,
    required this.height,
    required this.weight,
    required this.spo2,
    // required this.problem,
    // required this.surgery,
    required this.emergencyContact,
    required this.bp,
    required this.image,
    required this.pulse,
    required this.temperature,
    required this.allergies,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      gender: json["gender"] ?? "",
      age: json["age"] ?? "",
      patientId: json["patient_id"] ?? "",
      bloodGroup: json["blood_group"] ?? "",
      address: json["address"] ?? "",
      height: json["height"] ?? "",
      weight: json["weight"] ?? "",
      bp: json["BP"] ?? "",
      spo2:json["respiration"] ?? "",
      // problem: json["problem"] ?? "",
      // surgery: json["surgery"] ?? "",
      emergencyContact: json["emergency_contact"] ?? "",
      image: json["image"] ?? "",
      pulse: json["pulse"] ?? "",
      temperature: json["temperature"] ?? "",
      allergies: json["allergies"] ?? "",
    );
  }
}