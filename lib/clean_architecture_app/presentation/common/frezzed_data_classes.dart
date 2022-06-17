import 'package:freezed_annotation/freezed_annotation.dart';
part 'frezzed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _LoginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
      String countryMobileCode,
      String username,
      String password,
      String email,
      String mobileNumber,
      String profilePicture) = _RegisterObject;
}
