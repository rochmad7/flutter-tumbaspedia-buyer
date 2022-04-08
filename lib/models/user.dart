part of 'models.dart';

enum UserRole { admin, user, ukm, pengurus }

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phoneNumber;
  final String profilePicture;

  User(
      {this.id,
      this.name,
      this.email,
      this.address,
      this.phoneNumber,
      this.profilePicture});

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data["id"],
        name: data["name"],
        email: data["email"],
        address: data["address"],
        phoneNumber: data["phone_number"].toString(),
        profilePicture: data["profile_picture"],
      );

  User copyWith({
    int id,
    String name,
    String email,
    String address,
    String phoneNumber,
    String picturePath,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profilePicture: picturePath ?? this.profilePicture,
      );

  @override
  List<Object> get props => [
        id,
        name,
        email,
        address,
        phoneNumber,
        profilePicture,
      ];
}