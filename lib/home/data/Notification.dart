class NotificationModel {
   String? message;
  DateTime? timestamp;

  NotificationModel({required this.message, required this.timestamp});
//fromJson
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
//toJson
  Map<String, dynamic> toJson() {
    return {
      'message': message,
        'timestamp': timestamp.toString(),
    };
  }
  //toMap
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'timestamp': timestamp,
    };
  }

}