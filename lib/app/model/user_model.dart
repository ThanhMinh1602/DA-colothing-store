class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? phone;
  final String? address;
  final String? role;
  final String? deviceToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.phone,
    this.address,
    this.role,
    this.deviceToken,
  });

  // From Firestore
  factory UserModel.fromJson(Map<String, dynamic> json, String docId) {
    return UserModel(
      id: docId,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatarUrl: json['avatarUrl'],
      phone: json['phone'],
      address: json['address'],
      role: json['role'],
      deviceToken: json['deviceToken'],
    );
  }

  // To Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'phone': phone,
      'address': address,
      'role': role,
    };
  }
}
