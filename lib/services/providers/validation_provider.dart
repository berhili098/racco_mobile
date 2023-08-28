import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';


import 'package:tracking_user/model/validation.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/affectations_services.dart';
import 'package:tracking_user/services/validation_service.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class ValidationProvider extends ChangeNotifier {
  final TextEditingController testDebitFo = TextEditingController();
  final TextEditingController justificationCinController =
      TextEditingController();

  Uint8List testDebitViaCableImg = Uint8List(0);
  Uint8List imageTestDebitFo = Uint8List(0);
  Uint8List etiquetageImg = Uint8List(0);
  Uint8List pvFicheInstallationImg = Uint8List(0);
  Uint8List photoTestDebitViaWifiImg = Uint8List(0);
  Uint8List routeurTel = Uint8List(0);
  Uint8List pV = Uint8List(0);
  Uint8List ficheInstallation = Uint8List(0);
  Uint8List screenOgif = Uint8List(0);
  Uint8List cinImage = Uint8List(0);
  int? idValidation;
  bool check = false;
  bool update = false;
  int cinValueSelected = -1;
  String cinDescription = "";

  String feedbackBO = "";

  void getClientCinAccepte(int value, String description) {
    cinValueSelected = value;
    cinDescription = description;
    notifyListeners();
  }

  checkImageEmpty() {
    check = true;
    notifyListeners();
  }

  List<Map> listCinOptionClient = [
    {"value": 0, 'description': "le client n'accepte pas"},
    {"value": 1, "description": "Le client a accepté"},
    {"value": 2, 'description': 'CIN presenté hors celle du client'},
  ];

  initValue() {
    testDebitViaCableImg = Uint8List(0);
    ficheInstallation = Uint8List(0);
    etiquetageImg = Uint8List(0);
    pvFicheInstallationImg = Uint8List(0);
    photoTestDebitViaWifiImg = Uint8List(0);
    imageTestDebitFo = Uint8List(0);
    routeurTel = Uint8List(0);
    pV = Uint8List(0);

    cinValueSelected = -1;
    cinDescription = "";

    feedbackBO = "";

    testDebitFo.text = "";
    check = false;
    update = false;
    notifyListeners();
  }

  void initValueForUpdate(Validation validation) {
    idValidation = validation.id;
    testDebitFo.text = validation.testDebit ?? '';
    testDebitViaCableImg = validation.testDebitViaCableImage ?? Uint8List(0);
    etiquetageImg = validation.etiquetageImage ?? Uint8List(0);

    cinImage = validation.imageCin ?? Uint8List(0);

    pvFicheInstallationImg =
        validation.photoTestDebitViaWifiImage ?? Uint8List(0);
    photoTestDebitViaWifiImg =
        validation.photoTestDebitViaWifiImage ?? Uint8List(0);
    routeurTel = validation.routerTelImage ?? Uint8List(0);
    pV = validation.pvImage ?? Uint8List(0);
    pV = validation.pvImage ?? Uint8List(0);
    feedbackBO = validation.feedbackBO ?? '';

    testDebitFo.text = validation.testDebit ?? '';

justificationCinController.text =  (validation.cinDescription ??'').isEmpty
    ? listCinOptionClient  .first["description"]

    :
    validation.cinDescription ?? '';

    cinDescription = 
    (validation.cinDescription ??'').isEmpty
    ? listCinOptionClient  .first["description"]

    :
    validation.cinDescription ?? '';

    cinValueSelected = 
    (validation.cinDescription ??'').isEmpty

    ?
    -1
    :
    
    listCinOptionClient
        .where((element) => element["description"] == validation.cinDescription)
        .first["value"];
    check = false;
    update = true;

    notifyListeners();
  }

  String validationInput(String val) {
    return val;
  }

  AffectationsApi affectationsApi = AffectationsApi();
  ValidationApi validationApi = ValidationApi();

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
    final XFile? selectedImages = await ImagePicker()
        .pickImage(source: ImageSource.gallery);

    image = File(selectedImages!.path).readAsBytesSync();
        final f = File(selectedImages.path);

    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (700 * 700);

    if (sizeInMb > 2.0) {
      final imageComressed =
        comporessImage(File(selectedImages.path).readAsBytesSync());
        // image = File(selectedImages.path).readAsBytesSync()
      return imageComressed ; 
    } else {
      image = File(selectedImages.path).readAsBytesSync();
    }
    return image;
  }

  Future<Uint8List> selectCameraImages(BuildContext context) async {
    final XFile? selectedImages = await ImagePicker()
        .pickImage(source: ImageSource.camera);


    final f = File(selectedImages!.path);
    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (700 * 700);

    if (sizeInMb > 2.0) {
      final imageComressed =
        comporessImage(File(selectedImages.path).readAsBytesSync());
        // image = File(selectedImages.path).readAsBytesSync()
      return imageComressed ; 
    } else {
      image = File(selectedImages.path).readAsBytesSync();
    }
    return image;
  }

    Future<Uint8List> comporessImage(Uint8List list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 800,
      minWidth: 800,
      quality: 85,
      rotate: 0,
    );

    return result;
  }

  Future<void> validationAffectation(BuildContext context, Object data,
      {bool callNotify = false}) async {
    loading = false;

    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.validationAffectation(data);

      switch (response.statusCode) {
        case 200:
          // refreshController.loadComplete();

          initValue();

          Future.delayed(Duration.zero, () {
            context.pushReplacement('/home');
            SncakBarWidgdet.snackBarSucces(
                context, "Client valider avec succée");
          });

          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
      loading = false;
      notifyListeners();
    } on SocketException {
      context.pushReplacement("/permission");
      loading = false;
      notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    // return;
  }

  Future<void> updateValidtion(BuildContext context, Object data,
      {bool callNotify = false}) async {
    try {
      loading = true;
      notifyListeners();

      response = await validationApi.updateValidation(data);

      log(response.body);

      switch (response.statusCode) {
        case 200:
          // refreshController.loadComplete();

          initValue();
          context.pop();

          Future.delayed(Duration.zero, () {
            SncakBarWidgdet.snackBarSucces(
                context, "Client modifier avec succée");
          });
          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
      loading = false;
      notifyListeners();
    } on SocketException {
      // errorInternet = true;
      context.pushReplacement("/permission");
      loading = false;
      notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    // return;
  }

  Future<void> getValidation(String id, BuildContext context) async {
    try {
      loading = true;
      notifyListeners();
      response = await validationApi.getValidation(id);

      log(response.body);

      switch (response.statusCode) {
        case 200:
          var result = json.decode(response.body)["Validation"];

          if (result == null) {
            Future.delayed(Duration.zero, () {
              SncakBarWidgdet.snackBarError(
                  context, "Aucune validation trouvée");
            });
          } else {
            validation = Validation.fromJson(result);
            // refreshController.loadComplete();
            initValueForUpdate(validation);

            Future.delayed(Duration.zero, () {
              context.pushNamed(routeValidationPage,
                  params: {'idAffectation': id});
            });

            notifyListeners();
          }

          break;
        default:
      }
      loading = false;
      notifyListeners();
    } on SocketException {
      // errorInternet = true;
      notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }
    return;
  }
}

class FormDeclaration {
  String title;
  TextEditingController controller;

  FormDeclaration({required this.title, required this.controller});
}
