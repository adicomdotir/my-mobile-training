import 'package:equatable/equatable.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/entities/user.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.website});
  
  @override
  List<Object?> get props => [id, name, username, email, phone, website];

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    username: json['username'],
    email: json['email'],
    phone: json['phone'],
    website: json['website']);

  static List<UserModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['website'] = this.website;
    return data;
  }

  User toEntity() => User(
    id: id,
    name: name,
    username: username,
    email: email,
    phone: phone,
    website: website
  );
}

