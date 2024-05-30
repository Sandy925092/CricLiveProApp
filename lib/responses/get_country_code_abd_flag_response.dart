class GetCountryCodeAndFlagResponse {
  final bool? success;
  final String? message;
  final List<Data>? data;

  GetCountryCodeAndFlagResponse({
    this.success,
    this.message,
    this.data,
  });

  GetCountryCodeAndFlagResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? id;
  final String? flag;
  final String? country;
  final String? code;

  Data({
    this.id,
    this.flag,
    this.country,
    this.code,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        flag = json['flag'] as String?,
        country = json['country'] as String?,
        code = json['code'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'flag' : flag,
    'country' : country,
    'code' : code
  };
}