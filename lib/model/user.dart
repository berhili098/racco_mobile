import 'package:tracking_user/model/technicien.dart';

class User {
  int? id;

  String? uuid;
  String? technicienId;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? emailVerifiedAt;
  String? phoneNo;
  String? profilePicture;
  String? deviceKey;
  int? status;
  int? counter;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  Technicien? technicien;

  User(
      {id,
      uuid,
      technicienId,
      firstName,
      lastName,
      email,
      emailVerifiedAt,
      phoneNo,
      profilePicture,
      deviceKey,
      status,
      createdAt,
      updatedAt,
      deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    // emailVerifiedAt = json['email_verified_at'];
    phoneNo = json['phone_no'];
    profilePicture = json['profile_picture'];
    deviceKey = json['device_key'];
    status = json['status'];
    technicienId = json['technicien_id'].toString();
    counter = json['counter'];
    technicien = json['technicien'] != null
        ?  Technicien.fromJson(json['technicien'])
        : null;
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    // data['email_verified_at'] = emailVerifiedAt;
    data['phone_no'] = phoneNo;
    data['profile_picture'] = profilePicture;
    data['device_key'] = deviceKey;
    data['technicien_id'] = technicienId;
    data['status'] = status;
    data['counter'] = counter;

    if (technicien != null) {
      data['technicien'] = technicien!.toJson();
    }
    // data['Counter'] = counter;
    // data['created_at'] = createdAt;
    // data['updated_at'] = updatedAt;
    // data['deleted_at'] = deletedAt;

    return data;
  }
}
