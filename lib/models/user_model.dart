// class UserModel {
//   String id;
//   String fullName;
//   String email;
//   String phone;
//   String password;
//   String role; // owner or customer
//   String? businessName; // for owner
//   String? university; // for customer
//   String? ownerId; // for customer (references owner)
//   String? generatedOwnerId; // auto-generated for owner
//
//   UserModel({
//     required this.id,
//     required this.fullName,
//     required this.email,
//     required this.phone,
//     required this.password,
//     required this.role,
//     this.businessName,
//     this.university,
//     this.ownerId,
//     this.generatedOwnerId,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'fullName': fullName,
//       'email': email,
//       'phone': phone,
//       'password': password,
//       'role': role,
//       'businessName': businessName,
//       'university': university,
//       'ownerId': ownerId,
//       'generatedOwnerId': generatedOwnerId,
//     };
//   }
//
//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       id: map['id'] ?? '',
//       fullName: map['fullName'] ?? '',
//       email: map['email'] ?? '',
//       phone: map['phone'] ?? '',
//       password: map['password'] ?? '',
//       role: map['role'] ?? '',
//       businessName: map['businessName'],
//       university: map['university'],
//       ownerId: map['ownerId'],
//       generatedOwnerId: map['generatedOwnerId'],
//     );
//   }
// }






class UserModel {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String role;

  final String? businessName;
  final String? university;
  final String? ownerId;
  final String? generatedOwnerId;

  final String? address;
  final String? phone2;
  final String? jazzCashNumber;
  final String? bankAccount;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    this.businessName,
    this.university,
    this.ownerId,
    this.generatedOwnerId,
    this.address,
    this.phone2,
    this.jazzCashNumber,
    this.bankAccount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'customer',
      businessName: json['businessName'],
      university: json['university'],
      ownerId: json['ownerId'],
      generatedOwnerId: json['generatedOwnerId'],
      address: json['address'],
      phone2: json['phone2'],
      jazzCashNumber: json['jazzCashNumber'],
      bankAccount: json['bankAccount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'businessName': businessName,
      'university': university,
      'ownerId': ownerId,
      'generatedOwnerId': generatedOwnerId,
      'address': address,
      'phone2': phone2,
      'jazzCashNumber': jazzCashNumber,
      'bankAccount': bankAccount,
    };
  }
}