class ProfileModel {
  final String id;
  final String username;
  final String email;
  final String name;
  final String role;
  final String phone;
  final String address;
  final String profileImage;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.name,
    required this.role,
    required this.phone,
    required this.address,
    required this.profileImage,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      phone: json['phone'],
      address: json['address'],
      profileImage: json['profileImage'] ?? '',
      isVerified: json['isVerified'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'name': name,
        'role': role,
        'phone': phone,
        'address': address,
        'profileImage': profileImage,
        'isVerified': isVerified,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
