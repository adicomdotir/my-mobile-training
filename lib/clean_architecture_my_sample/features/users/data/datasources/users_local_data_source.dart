import 'dart:convert';

import 'package:first_flutter/clean_architecture_my_sample/core/error/exception.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UsersLocalDataSource {
  Future<List<UserModel>> getLastUsers();

  Future<void> cacheUsers(List<UserModel> listUserModel);
}

const CACHED_USERS = 'CACHED_USERS';

class UsersLocalDataSourceImpl implements UsersLocalDataSource {
  final SharedPreferences sharedPreferences;

  UsersLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<UserModel>> getLastUsers() {
    final jsonString = sharedPreferences.getString(CACHED_USERS);
    if (jsonString != null) {
      return Future.value(UserModel.fromJsonList(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUsers(List<UserModel> listUserModel) {
    return sharedPreferences.setString(
      CACHED_USERS,
      json.encode(listUserModel),
    );
  }
}