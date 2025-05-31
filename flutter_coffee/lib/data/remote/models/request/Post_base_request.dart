class PostBaseRequest {
  PostBaseRequest({
    this.limit = 10,
    this.page = 1,
    this.userId = 1,
    this.status = "ACT",
    this.id = 0,
    this.data,
  });

  PostBaseRequest.fromJson(dynamic json) {
    limit = json['limit'];
    page = json['page'];
    userId = json['userId'];
    status = json['status'];
    id = json['id'];
    data = json['data'];
  }

  int? limit;
  int? page;
  int? userId;
  String? status;
  int? id;
  Map<String, dynamic>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['limit'] = limit;
    map['page'] = page;
    map['userId'] = userId;
    map['status'] = status;
    map['id'] = id;
    if (data != null) {
      map['data'] = data;
    }
    return map;
  }
}