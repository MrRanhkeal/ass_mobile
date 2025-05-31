class RegisterRequest {
  RegisterRequest({
    this.name,
    this.username,
    this.password,
    this.roleId = 2,
    this.createBy = 'ranh',
  });

  RegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    username = json['username'];
    password = json['password'];
    roleId = json['role_id'];
    createBy = json['create_by'];
  }

  String? name;
  String? username;
  String? password;
  int? roleId;
  String? createBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['username'] = username;
    map['password'] = password;
    map['role_id'] = roleId;
    map['create_by'] = createBy;
    return map;
  }
}