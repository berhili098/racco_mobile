import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';


import 'package:tracking_user/model/validation.dart';
import 'package:tracking_user/services/deblocage_service.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class DeblocageProvider extends ChangeNotifier {
  final TextEditingController testDebitFo = TextEditingController();

  Uint8List spliterAvantPhoto = Uint8List(0);
  Uint8List spliterApresPhoto = Uint8List(0);
  Uint8List facedePhoto = Uint8List(0);
  Uint8List chambrePhoto = Uint8List(0);
  Uint8List signalPhoto = Uint8List(0);

  int? idValidation;
  bool check = false;
  bool update = false;

  checkImageEmpty() {
    check = true;
    notifyListeners();
  }

  initValue() {
    spliterAvantPhoto = Uint8List(0);
    spliterApresPhoto = Uint8List(0);
    facedePhoto = Uint8List(0);
    chambrePhoto = Uint8List(0);
    signalPhoto = Uint8List(0);

    check = false;
    update = false;
    notifyListeners();
  }

  // void initValueForUpdate(Validation validation) {
  //   idValidation = validation.id;
  //   testDebitFo.text = validation.testDebit ?? '';
  //   testDebitViaCableImg = validation.testDebitViaCableImage ?? Uint8List(0);
  //   etiquetageImg = validation.etiquetageImage ?? Uint8List(0);
  //   pvFicheInstallationImg =
  //       validation.photoTestDebitViaWifiImage ?? Uint8List(0);
  //   photoTestDebitViaWifiImg =
  //       validation.photoTestDebitViaWifiImage ?? Uint8List(0);
  //   routeurTel = validation.routerTelImage ?? Uint8List(0);
  //   pV = validation.pvImage ?? Uint8List(0);

  //   testDebitFo.text = validation.testDebit ?? '';
  //   check = false;
  //   update = true;

  //   notifyListeners();
  // }

  String validationInput(String val) {
    return val;
  }

  DeblocageApi deblocageApi = DeblocageApi();

  Validation validation = Validation();

  final formKey = GlobalKey<FormState>();

  late Response response;
  bool loading = false;

  String bareCode = '';

  setBarCode(String value) {
    bareCode = value;
    notifyListeners();
  }

//   List<FormDeclaration> formDeclaration  =[
// FormDeclaration(title: ,controller: testSignalFoController);

//   ];
  Uint8List image = Uint8List(0);
  changeState() {
    notifyListeners();
  }

  Future<Uint8List> selectGalleryImages(BuildContext context) async {
    final XFile? selectedImages = await ImagePicker().pickImage(
        source: ImageSource.gallery,
    maxHeight: 480,
      maxWidth: 640,
      imageQuality: 100);

    image = File(selectedImages!.path).readAsBytesSync();

    return image;
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

  Future<void> debloquerAffectation(BuildContext context, Object data,
      {bool callNotify = false}) async {
    loading = false;

    try {
    loading = true;
    notifyListeners();
    response = await deblocageApi.deblocageApi(data);

    switch (response.statusCode) {
      case 200:
        // refreshController.loadComplete();

        initValue();

        Future.delayed(Duration.zero, () {
          context.pushReplacement('/home');
          SncakBarWidgdet.snackBarSucces(context, "Client débloquée avec succée");
        });

        break;
      default:
      // showSnackBarError('vérifier votre connection internet', context);
    }
    loading = false;
    notifyListeners();
    } on SocketException {
      context.pushReplacement('/permission');
       loading = false;
    notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    // return;
  }
}

class FormDeclaration {
  String title;
  TextEditingController controller;

  FormDeclaration({required this.title, required this.controller});
}
