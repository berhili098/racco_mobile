import 'package:tracking_user/model/affectation.dart';

class Blocage {
  String? uuid;
  String? affectationId;
  String? cause;
  bool? resolue;
  String? updatedAt;
  String? createdAt;
  int? id;
  Affectations? affectation;

  Blocage(
      {uuid,
      affectationId,
      resolue,
      updatedAt,
      createdAt,
      id,
      required affectation});

  Blocage.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    // affectationId = json['affectation_id'] ??'';
    cause = json['cause'];
    resolue = json['resolue'] == 0 ? false : true;
    id = json['id'];
    // affectation = json['affectation'];
  }

  Blocage.fromJsonBeforValidation(Map<String, dynamic> json) {
    uuid = json['uuid'];
    // affectationId = json['affectation_id'] ??'';
    cause = json['cause'];
    resolue = json['resolue'] == 0 ? false : true;

    id = json['id'];
    affectation = Affectations.fromJson(json['affectation']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['affectation_id'] = affectationId;
    data['resolue'] = resolue;
    data['cause'] = cause;

    data['id'] = id;
    return data;
  }
}
