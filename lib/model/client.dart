import 'package:tracking_user/model/blocage.dart';

class ClientsData {
  List<Clients>? clients;

  ClientsData({clients, counter});

  ClientsData.fromJson(Map<String, dynamic> json) {
    if (json['Clients'] != null) {
      clients = <Clients>[];
      json['Clients'].forEach((v) {
        clients!.add(new Clients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (clients != null) {
      data['Clients'] = clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Clients {
  int? id;
  String? uuid;
  String? type;
  String? name;
  String? address;
  int? cityId;
  int? plaqueId;
  String? phoneNo;
  String? debit;
  String? sip;
  String? status;
  String? offre;

  // Null? createdAt;
  // Null? updatedAt;
  // Null? deletedAt;
  String? profilePicture;
  String? deviceKey;
  String? routeurType;
  String? clientId;
  double? lat;
  double? lng;
  List<Blocage>? blocage;

  Clients(
      {id,
      uuid,
      type,
      name,
      address,
      cityId,
      plaqueId,
      phoneNo,
      debit,
      sip,
      status,
      routeurType,
      clientId,
      createdAt,
      updatedAt,
      deletedAt,
      profilePicture,
      deviceKey,
      lat,
      lng,
      blocage});

  Clients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    type = json['type'];
    name = json['name'];
    address = json['address'];
    cityId = json['city_id'];
    plaqueId = json['plaque_id'];
    phoneNo = json['phone_no'];
    debit = json['debit'];
    sip = json['sip'];
    status = json['status'];
    offre = json['offre'] ?? '';
    routeurType = json['routeur_type'] ?? "";
    clientId = json['client_id'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
    profilePicture = json['profile_picture'];
    deviceKey = json['device_key'];
    lat = double.parse(json['lat']);
    lng = double.parse(json['lng']);
    blocage = json.containsKey('blocages')
        ? List<Blocage>.from(json["blocages"].map((x) => Blocage.fromJson(x)))
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['type'] = type;
    data['name'] = name;
    data['address'] = address;
    data['city_id'] = cityId;
    data['plaque_id'] = plaqueId;
    data['phone_no'] = phoneNo;
    data['debit'] = debit;
    data['sip'] = sip;
    data['status'] = status;
    // data['created_at'] = createdAt;
    // data['updated_at'] = updatedAt;
    // data['deleted_at'] = deletedAt;
    data['profile_picture'] = profilePicture;
    data['device_key'] = deviceKey;
    data['lat'] = lat.toString();
    data['lng'] = lng.toString();
    return data;
  }
}
