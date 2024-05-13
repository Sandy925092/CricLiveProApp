class PrivacyPolicyResponse {
  final bool? success;
  final String? message;
  final List<Data>? data;

  PrivacyPolicyResponse({
    this.success,
    this.message,
    this.data,
  });

  PrivacyPolicyResponse.fromJson(Map<String, dynamic> json)
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
  final String? policyText;

  Data({
    this.id,
    this.policyText,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        policyText = json['policyText'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'policyText' : policyText
  };
}