class Technicien {
  int? id;
  int? soustraitantId;
  int? userId;
  int? status;
  String? planificationCount;
  String? createdAt;
  String? updatedAt;
  int? typeTech;
  int? cityId;
  int? counter;

  Technicien(
      {id,
      soustraitantId,
      userId,
      status,
      planificationCount,
      createdAt,
      updatedAt,
      deletedAt,
      typeTech,
      cityId,
      counter});

  Technicien.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soustraitantId = json['soustraitant_id'];
    userId = json['user_id'];
    status = json['status'];
    planificationCount = json['planification_count'];
    typeTech = json['type_tech'];

    cityId = json['city_id'];
    counter = json['counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['soustraitant_id'] = soustraitantId;
    data['user_id'] = userId;
    data['status'] = status;
    data['planification_count'] = planificationCount;
    data['type_tech'] = typeTech;
    data['city_id'] = cityId;
    data['counter'] = counter;
    return data;
  }
}
