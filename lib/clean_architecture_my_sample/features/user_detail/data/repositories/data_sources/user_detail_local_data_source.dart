import 'dart:convert';

import 'package:first_flutter/clean_architecture_my_sample/core/error/exception.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserDetailLocalDataSource {
  Future<UserModel> getLastUserDetail();

  Future<void> cacheUserDetail(UserModel userModel);
}

const CACHED_USERS = 'CACHED_USER_DETAIL';

class UserDetailLocalDataSourceImpl implements UserDetailLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserDetailLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getLastUserDetail() {
    final jsonString = sharedPreferences.getString(CACHED_USERS);
    if (jsonString != null) {
      return Future.value(UserModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUserDetail(UserModel userModel) {
    return sharedPreferences.setString(
      CACHED_USERS,
      json.encode(userModel),
    );
  }
}