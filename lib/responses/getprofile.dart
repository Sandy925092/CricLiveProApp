class GetProfileResponse {
  final bool? success;
  final String? message;
  final Data? data;

  GetProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  GetProfileResponse.fromJson(Map<String, dynamic> json)
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
  final String? fullName;
  final String? email;
  final String? country;
  final String? role;
  final String? profile;
  final String? deviceToken;
  final bool? otpVerified;

  Data({
    this.id,
    this.fullName,
    this.email,
    this.country,
    this.role,
    this.profile,
    this.deviceToken,
    this.otpVerified,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        fullName = json['fullName'] as String?,
        email = json['email'] as String?,
        country = json['country'] as String?,
        role = json['role'] as String?,
        profile = json['profile'] as String?,
        deviceToken = json['deviceToken'] as String?,
        otpVerified = json['otpVerified'] as bool?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'fullName' : fullName,
    'email' : email,
    'country' : country,
    'role' : role,
    'profile' : profile,
    'deviceToken' : deviceToken,
    'otpVerified' : otpVerified
  };
}