import 'package:first_flutter/clean_architecture_app/app/app_prefs.dart';
import 'package:first_flutter/clean_architecture_app/data/data_source/remote_data_source.dart';
import 'package:first_flutter/clean_architecture_app/data/network/app_api.dart';
import 'package:first_flutter/clean_architecture_app/data/network/dio_factory.dart';
import 'package:first_flutter/clean_architecture_app/data/network/network_info.dart';
import 'package:first_flutter/clean_architecture_app/data/repository/repository_impl.dart';
import 'package:first_flutter/clean_architecture_app/domain/repository/repository.dart';
import 'package:first_flutter/clean_architecture_app/domain/usecase/login_usecase.dart';
import 'package:first_flutter/clean_architecture_app/presentation/login/login_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferances>(() => instance());

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (GetIt.I.isRegistered<LoginUseCase>()) {
    instance
        .registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerLazySingleton<LoginViewModel>(
        () => LoginViewModel(instance()));
  }
}
