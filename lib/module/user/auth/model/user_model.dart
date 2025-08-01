class AuthResponse {
  final String status;
  final String message;
  final UserModel user;
  final String accessToken;
  final String refreshToken;

  AuthResponse({
    required this.status,
    required this.message,
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AuthResponse(
      status: json['status'],
      message: json['message'],
      user: UserModel.fromJson(data['user']),
      accessToken: data['accessToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': {
          'user': user.toJson(),
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        },
      };
}

class UserModel {
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

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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
