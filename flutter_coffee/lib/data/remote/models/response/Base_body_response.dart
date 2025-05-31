class BaseBodyResponse {
  const BaseBodyResponse({
    this.message,
    this.messageKh,
    this.messageCh,
    required this.code,
    this.body,
  });

  factory BaseBodyResponse.fromJson(dynamic json) {
    return BaseBodyResponse(
      message: json['message'] as String?,
      messageKh: json['messageKh'] as String?,
      messageCh: json['messageCh'] as String?,
      code: json['code'] is String
          ? int.tryParse(json['code'] as String) ?? 0
          : (json['code'] as int? ?? 0),
      body: json['data'],
    );
  }

  final String? message;
  final String? messageKh;
  final String? messageCh;
  final int code;
  final dynamic body;

  bool get isSuccess => code == 200;

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'messageKh': messageKh,
      'messageCh': messageCh,
      'code': code,
      'data': body,
    };
  }
}