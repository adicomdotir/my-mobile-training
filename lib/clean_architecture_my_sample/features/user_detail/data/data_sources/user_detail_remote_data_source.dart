import 'dart:convert';

import 'package:first_flutter/clean_architecture_my_sample/core/error/exception.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserDetailRemoteDataSource {
  Future<UserModel> getUserDetail(int userId);
}

class UserDetailRemoteDataSourceImpl extends UserDetailRemoteDataSource {
  final http.Client client;

  UserDetailRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUserDetail(int userId) async {
    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'), headers: {
      'Content-Type': 'application/json'
    });
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}