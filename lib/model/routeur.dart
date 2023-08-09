class Routeur {
  int? id;
  String? uuid;
  String? snGpon;
  String? snMac;
  int? status;
  int? clientId;
  int? technicienId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Routeur(
      {id,
      uuid,
      snGpon,
      snMac,
      status,
      clientId,
      technicienId,
      createdAt,
      updatedAt,
      deletedAt});

  Routeur.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    snGpon = json['sn_gpon'];
    snMac = json['sn_mac'];
    status = json['status'];
    // clientId = json['client_id'];
    // technicienId = json['technicien_id'];
    // createdAt = DateTime.parse(json["created_at"]);
    // updatedAt = DateTime.parse(json["updated_at"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['sn_gpon'] = snGpon;
    data['sn_mac'] = snMac;
    data['status'] = status;
    data['client_id'] = clientId;
    data['technicien_id'] = technicienId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}
