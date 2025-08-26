class CommonResponse {
  final bool? success;
  final String? message;
  final dynamic data;

  CommonResponse({
    this.success,
    this.message,
    this.data,
  });

  CommonResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = json['data'];

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data
  };
}