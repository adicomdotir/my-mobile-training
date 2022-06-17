class LoginRequest {
  String email;
  String password;
  String imei;
  String deviceType;

  LoginRequest(this.email, this.password, this.imei, this.deviceType);
}

class RegisterRequest {
  String countryMobileCode;
  String username;
  String password;
  String email;
  String mobileNumber;
  String profilePicture;

  RegisterRequest(this.countryMobileCode, this.username, this.password,
      this.email, this.mobileNumber, this.profilePicture);
}
