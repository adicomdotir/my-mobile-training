import 'package:first_flutter/clean_architecture_app/data/network/app_api.dart';
import 'package:first_flutter/clean_architecture_app/data/request/request.dart';
import 'package:first_flutter/clean_architecture_app/data/responses/respnses.dart';
import 'package:first_flutter/clean_architecture_app/domain/model/model.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType
    );
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

}