class TermsAndConditionsResponse {
  final bool? success;
  final String? message;
  final List<Data>? data;

  TermsAndConditionsResponse({
    this.success,
    this.message,
    this.data,
  });

  TermsAndConditionsResponse.fromJson(Map<String, dynamic> json)
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
  final String? termsText;

  Data({
    this.id,
    this.termsText,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        termsText = json['termsText'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'termsText' : termsText
  };
}