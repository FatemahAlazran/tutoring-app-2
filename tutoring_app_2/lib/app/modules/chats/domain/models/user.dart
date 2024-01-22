import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String id;
  final String photo;
  final String userLocation;
  UserModel({
    required this.username,
    required this.email,
    required this.id,
    required this.photo,
    required this.userLocation,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? id,
    String? photo,
    String? userLocation,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      id: id ?? this.id,
      photo: photo ?? this.photo,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'id': id,
      'photo': photo,
      'userLocation': userLocation,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        username: map['username'] as String,
        email: map['email'] as String,
        id: map['id'] as String,
        photo: map['photo'] ?? "",
        userLocation: map['userLocation'] ?? "",
      );
    } catch (e) {
      throw e.toString();
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, id: $id, photo: $photo, userLocation: $userLocation)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.id == id &&
        other.photo == photo &&
        other.userLocation == userLocation;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        id.hashCode ^
        photo.hashCode ^
        userLocation.hashCode;
  }
}
