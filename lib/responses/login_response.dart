class LoginResponse {
  final bool? success;
  final String? message;
  final Data? data;

  LoginResponse({
    this.success,
    this.message,
    this.data,
  });

  LoginResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final String? id;
  final String? name;
  final String? email;
  final String? token;
  final String? country;
  final String? password;
  final dynamic confirmPassword;
  final List<int>? otpCreatedAt;
  final dynamic otp;
  final bool? otpVerified;

  Data({
    this.id,
    this.name,
    this.email,
    this.token,
    this.country,
    this.password,
    this.confirmPassword,
    this.otpCreatedAt,
    this.otp,
    this.otpVerified,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['fullName'] as String?,
        email = json['email'] as String?,
        token = json['token'] as String?,
        country = json['country'] as String?,
        password = json['password'] as String?,
        confirmPassword = json['confirmPassword'],
        otpCreatedAt = (json['otpCreatedAt'] as List?)?.map((dynamic e) => e as int).toList(),
        otp = json['otp'],
        otpVerified = json['otpVerified'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'token' : token,
    'country' : country,
    'password' : password,
    'confirmPassword' : confirmPassword,
    'otpCreatedAt' : otpCreatedAt,
    'otp' : otp,
    'otpVerified' : otpVerified
  };
}