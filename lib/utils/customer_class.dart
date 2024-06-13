class Customer {
  final String id;
  final String name;
  final String lastName;
  final String phone;
  final String address;
  final String ci;
  final String expedition;
  final String birthDate;
  final String nationality;
  final String gender;
  final String preference;

  Customer({
    required this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.address,
    required this.ci,
    required this.expedition,
    required this.birthDate,
    required this.nationality,
    required this.gender,
    required this.preference,
  });

  // Factory constructor to create a Customer from JSON
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      phone: json['phone'],
      address: json['address'],
      ci: json['ci'],
      expedition: json['expedition'],
      birthDate: json['birthDate'],
      nationality: json['nationality'],
      gender: json['gender'],
      preference: json['preference'],
    );
  }

  // Method to convert a Customer to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'address': address,
      'ci': ci,
      'expedition': expedition,
      'birthDate': birthDate,
      'nationality': nationality,
      'gender': gender,
      'preference': preference,
    };
  }
}
