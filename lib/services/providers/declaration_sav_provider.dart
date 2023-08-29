import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tracking_user/pages/home/home_page.dart';

import '../../widgets/notification/snack_bar_widget.dart';

class DeclarationSavProvider extends ChangeNotifier {
  bool loading = false;
  TextEditingController descriptionController = TextEditingController();
  Uint8List image = Uint8List(0); 
  Uint8List imageTestSignal = Uint8List(0);
  Uint8List imageBlockage = Uint8List(0);

  String savUrl = dotenv.get('SAV_URL', fallback: '');
  Uint8List imageFacultatif = Uint8List(0);
  Future<Uint8List> selectGalleryImages(BuildContext context) async {
    final XFile? selectedImages = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100);

    image = File(selectedImages!.path).readAsBytesSync();

    return image;
  }

  initValue() {
    descriptionController.text = '';
    image = Uint8List(0);
    imageTestSignal = Uint8List(0);
    imageFacultatif = Uint8List(0);
    notifyListeners();
  }

  Future<Uint8List> selectCameraImages(BuildContext context) async {
    final XFile? selectedImages = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100);

    image = File(selectedImages!.path).readAsBytesSync();

    return image;
  }

  String validationInput(String val) {
    return val;
  }

  changeState() {
    notifyListeners();
  }

  validate(context) async {
    if (imageTestSignal.isEmpty) {
      SncakBarWidgdet.snackBarSucces(
          context, "Veuillez Remplir l'image Test Signal.");
      return false;
    } else {
      return true;
    }
  }

  Future updateDeclarationSav(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.parse('$savUrl/addFeedback');
    try {
      http.post(uri, headers: headers, body: data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  submit(context, String affectation) {
    validate(context).then((val) async {
      if (val) {
        loading = true;
        notifyListeners();
        String finalImage = base64Encode(imageTestSignal);
        String imageFacFinal = base64Encode(imageFacultatif);

        updateDeclarationSav({
          "description": descriptionController.text,
          "test_signal": finalImage,
          "sav_ticket_id": affectation,
          "image_facultatif": imageFacFinal
        }).then((value) {
          loading = false;
          notifyListeners();
          if (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {}
        });
      } else {}
    });
  }

  validate2(context) async {
    if (imageBlockage.isEmpty) {
      SncakBarWidgdet.snackBarSucces(context, "Veuillez Remplir l'image.");
      return false;
    } else {
      return true;
    }
  }

  Future updateBlockageSav(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.parse('$savUrl/addFeedbackBlockage');
    try {
      http.post(uri, headers: headers, body: data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  submitBlockage(context, String affectationId, String type) {
    validate2(context).then((val) async {
      if (val) {
        loading = true;
        notifyListeners();

        updateBlockageSav({
          "sav_ticket_id": affectationId,
          "image_facultatif": base64Encode(imageBlockage),
          "type_blockage": type
        }).then((value) {
          loading = false;
          notifyListeners();
          if (value) {
            imageBlockage = Uint8List(0);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else {}
        });
      } else {}
    });
  }
}
