
import 'package:first_flutter/clean_architecture_my_sample/core/network/network_info.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/data/data_sources/user_detail_local_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/data/data_sources/user_detail_remote_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/data/repositories/user_detail_repository_impl.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/domain/repositories/user_detail_repository.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/domain/use_cases/get_user_detail.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/user_detail/presentation/bloc/user_detail_bloc.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/datasources/users_local_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/datasources/users_remote_data_source.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/repositories/users_repository.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/domain/usecases/get_users.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/presentation/bloc/bloc.dart';
import 'package:first_flutter/clean_architecture_my_sample/features/users/data/repositories/users_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // bloc
  sl.registerFactory(() => UsersBloc(getUsers: sl()));
  sl.registerFactory(() => UserDetailBloc(getUserDetail: sl()));

  // use cases
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerLazySingleton(() => GetUserDetail(userDetailRepository:  sl()));

  // repository
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<UserDetailRepository>(() => UserDetailRepositoryImpl(userDetailRemoteDataSource: sl(), userDetailLocalDataSource: sl(), networkInfo: sl()));

  // data sources
  sl.registerLazySingleton<UsersRemoteDataSource>(() => UsersRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UsersLocalDataSource>(() => UsersLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<UserDetailRemoteDataSource>(() => UserDetailRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserDetailLocalDataSource>(() => UserDetailLocalDataSourceImpl(sharedPreferences: sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  final dataCoccectionChecker = DataConnectionChecker();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => dataCoccectionChecker);
}
