import 'dart:convert';

import 'package:flutter/services.dart';

class Declaration {
  int? id;
  String? uuid;
  int? affectationId;
  int? routeurId;
  String? testSignal;
  Uint8List? imageTestSignal;
  Uint8List? imagePboBefore;
  Uint8List? imagePboAfter;
  Uint8List? imagePbiAfter;
  Uint8List? imagePbiBefore;
  Uint8List? imageSplitter;
  String? typePassage;
  Uint8List? imagePassage1;
  Uint8List? imagePassage2;
  Uint8List? imagePassage3;
  String? snTelephone;
  String? nbrJarretieres;
  String? cableMetre;
  String? pto;

  String? feedbackBO;


  Null? lat;
  Null? lng;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Declaration(
      {id,
      uuid,
      affectationId,
      routeurId,
      testSignal,
      imageTestSignal,
      imagePboBefore,
      imagePboAfter,
      imagePbiAfter,
      imagePbiBefore,
      imageSplitter,
      typePassage,
      imagePassage1,
      imagePassage2,
      imagePassage3,
      snTelephone,
      nbrJarretieres,
      cableMetre,
      pto,
      lat,
      lng,
      imageCin,
      cinJustification,
      cinDescription,
      feedbackBO,
      createdAt,
      updatedAt,
      deletedAt});

  Declaration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    affectationId = json['affectation_id'];
    routeurId = json['routeur_id'];
    testSignal = json['test_signal'];
    imageTestSignal =
        Uint8List.fromList(base64.decode(json['image_test_signal']));
    imagePboBefore =
        Uint8List.fromList(base64.decode(json['image_pbo_before']));
    imagePboAfter = Uint8List.fromList(base64.decode(json['image_pbo_after']));
    imagePbiAfter = Uint8List.fromList(base64.decode(json['image_pbi_after']));
    imagePbiBefore =
        Uint8List.fromList(base64.decode(json['image_pbi_before']));
    imageSplitter = Uint8List.fromList(base64.decode(json['image_splitter']));
    typePassage = json['type_passage'];
    imagePassage1 =
        Uint8List.fromList(base64.decode(json['image_passage_1'] ?? ''));
    imagePassage2 =
        Uint8List.fromList(base64.decode(json['image_passage_2'] ?? ''));
    imagePassage3 =
        Uint8List.fromList(base64.decode(json['image_passage_3'] ?? ''));

    snTelephone = json['sn_telephone'];
    nbrJarretieres = json['nbr_jarretieres'];
    cableMetre = json['cable_metre'];
    feedbackBO = json['feedback_bo'];
    pto = json['pto'];
    // lat = json['lat']?? '';
    // lng = json['lng']??'';
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    // deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uuid'] = uuid;
    data['affectation_id'] = affectationId;
    data['routeur_id'] = routeurId;
    data['test_signal'] = testSignal;
    data['image_test_signal'] = imageTestSignal;
    data['image_pbo_before'] = imagePboBefore;
    data['image_pbo_after'] = imagePboAfter;
    data['image_pbi_after'] = imagePbiAfter;
    data['image_pbi_before'] = imagePbiBefore;
    data['image_splitter'] = imageSplitter;
    data['type_passage'] = typePassage;
    data['image_passage_1'] = imagePassage1;
    data['image_passage_2'] = imagePassage2;
    data['image_passage_3'] = imagePassage3;
    data['sn_telephone'] = snTelephone;
    data['nbr_jarretieres'] = nbrJarretieres;
    data['cable_metre'] = cableMetre;
    data['cin_justification'] = cableMetre;
    data['feedback_bo'] = feedbackBO;
    data['pto'] = pto;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
