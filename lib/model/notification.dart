
class Notifications {
  int? id;
  String? uuid;
  String? title;
  String? data;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Notifications(
      {id,
      uuid,
      title,
      data,
      userId,
      createdAt,
      updatedAt});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    data = json['data'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['title'] = title;
    data['data'] = data;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
