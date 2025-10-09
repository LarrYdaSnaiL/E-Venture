/// A data model class for user information.
/// This class includes methods to convert to/from the JSON format
/// used by Firebase Realtime Database.
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String studentIdCardUrl; // URL to the uploaded KTM image in Firebase Storage
  final String role; // e.g., 'peserta' or 'panitia'

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.studentIdCardUrl,
    this.role = 'peserta', // Default role is participant
  });

  /// Converts a UserModel instance into a Map (JSON format) for Firebase.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'studentIdCardUrl': studentIdCardUrl,
      'role': role,
    };
  }

  /// Creates a UserModel instance from a map (JSON data from Firebase).
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      studentIdCardUrl: json['studentIdCardUrl'] ?? '',
      role: json['role'] ?? 'peserta',
    );
  }
}

