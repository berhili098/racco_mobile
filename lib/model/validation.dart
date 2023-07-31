import 'dart:convert';

import 'package:flutter/services.dart';

class Autogenerated {
  Validation? validation;

  Autogenerated({validation});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    validation = json['Validation'] != null
        ? new Validation.fromJson(json['Validation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (validation != null) {
      data['Validation'] = validation!.toJson();
    }
    return data;
  }
}

class Validation {
  int? id;
  String? uuid;
  String? testDebit;
  int? affectationId;
  Uint8List? testDebitImage;
  Uint8List? testDebitViaCableImage;
  Uint8List? photoTestDebitViaWifiImage;
  Uint8List? etiquetageImage;

  Uint8List? routerTelImage;
  Uint8List? pvImage;
  String? feedbackBO;
  Uint8List? imageCin;
    String? cinJustification;
  String? cinDescription;
  String? createdAt;
  String? updatedAt;

  Validation(
      {id,
      uuid,
      affectationId,
      testDebit,
      testDebitViaCableImage,
      photoTestDebitViaWifiImage,
      etiquetageImage,
      ficheInstallationImage,
      routerTelImage,
      pvImage,
      lat,
      lng,

            feedbackBO,
                imageCin,
      cinJustification,
      cinDescription,

      createdAt,
      updatedAt,
      deletedAt});

  Validation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    testDebit = json['test_debit'];
    affectationId = json['affectation_id'];
    // testDebitImage =
    //     Uint8List.fromList(base64.decode(json['test_debit_image']));
    testDebitViaCableImage =
        Uint8List.fromList(base64.decode(json['test_debit_via_cable_image']));
    photoTestDebitViaWifiImage = Uint8List.fromList(
        base64.decode(json['photo_test_debit_via_wifi_image']));

    etiquetageImage =
        Uint8List.fromList(base64.decode(json['etiquetage_image']));

    routerTelImage =
        Uint8List.fromList(base64.decode(json['router_tel_image']));
    feedbackBO = json['feedback_bo'];


    cinJustification = json['cin_justification'];
    cinDescription = json['cin_description'];
        imageCin = Uint8List.fromList(base64.decode(json['image_cin'] ?? ''));
    pvImage = Uint8List.fromList(base64.decode(json['pv_image']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['affectation_id'] = affectationId;
    data['test_debit_image'] = testDebitImage;
    data['test_debit_via_cable_image'] = testDebitViaCableImage;
    data['photo_test_debit_via_wifi_image'] = photoTestDebitViaWifiImage;
    data['etiquetage_image'] = etiquetageImage;
    // data['fiche_installation_image'] = ficheInstallationImage;
    data['router_tel_image'] = routerTelImage;
    data['pv_image'] = pvImage;
    // data['lat'] = lat;
    // data['lng'] = lng;
        data['feedback_bo'] = feedbackBO;


            data['image_cin'] = imageCin;
            data['cin_description'] = cinDescription;
            data['cin_description'] = cinJustification;


    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // data['deleted_at'] = deletedAt;
    return data;
  }
}