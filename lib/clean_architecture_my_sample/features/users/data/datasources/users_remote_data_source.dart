import 'dart:convert';
import 'package:first_flutter/clean_architecture_my_sample/core/error/exception.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UsersRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UsersRemoteDataSourceImpl extends UsersRemoteDataSource {
  final http.Client client;

  UsersRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    if (response.statusCode == 200) {
      return UserModel.fromJsonList(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
