import 'package:tracking_user/model/client.dart';

class Affectations {
  int? id;
  String? uuid;
  int? clientId;
  int? technicienId;
  int? cityId;
  int? plaqueId;
  String? dateAffectation;
  String? datePlanification;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? validationComplet;
  double? lat;
  double? lng;
  bool? blocage;

  Clients? client;

  Affectations(
      {id,
      uuid,
      clientId,
      technicienId,
      cityId,
      plaqueId,
      dateAffectation,
      datePlanification,
      status,
      createdAt,
      updatedAt,
      validationComplet,
      lat,
      lng,
      client,
      blocage});

  Affectations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    clientId = json['client_id'];
    technicienId = json['technicien_id'];
    cityId = json['city_id'];
    plaqueId = json['plaque_id'];
    dateAffectation = json['date_affectation'];
    validationComplet = json['validation_complet'] == null
        ? json['validation_complet'] == 1
            ? true
            : false
        : false;
    blocage = json['blocage'] == 0 ? false : true;

    status = json['status'];
    createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);

    datePlanification =
        json["planification_date"] == null ? '' : json["planification_date"];
    // lat = double.parse(json['lat'] ?? '0.0') ;
    // lng =double.parse(json['lng'] ?? '0.0');
    client = json['client'] != null ? Clients.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['client_id'] = clientId;
    data['technicien_id'] = technicienId;
    data['city_id'] = cityId;
    data['plaque_id'] = plaqueId;
    // data['date_affectation'] = dateAffectation;
    // data['date_planification'] = datePlanification;
    data['status'] = status;
    data['created_at'] = createdAt!.toIso8601String();
    data['updated_at'] = updatedAt!.toIso8601String();
    data['lat'] = lat;
    data['lng'] = lng;
    data['blocage'] = blocage;

    if (client != null) {
      data['client'] = client;
    }
    return data;
  }
}
