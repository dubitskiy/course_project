import 'address.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json)
  {return User(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    address: Address.fromJson(json["address"]),
    phone: json['phone'],
  );
  }
}

