class NotificationResponse {
  final bool? success;
  final String? message;
  final List<NotificationData>? data;

  NotificationResponse({
    this.success,
    this.message,
    this.data,
  });

  NotificationResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] as bool?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => NotificationData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class NotificationData {
  final String? id;
  final String? userId;
  final String? title;
  final String? message;
  final String? createdAt;

  NotificationData({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.createdAt,
  });

  NotificationData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        userId = json['userId'] as String?,
        title = json['title'] as String?,
        message = json['message'] as String?,
        createdAt = json['createdAt'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'userId' : userId,
    'title' : title,
    'message' : message,
    'createdAt' : createdAt
  };
}