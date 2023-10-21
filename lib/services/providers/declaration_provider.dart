import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:tracking_user/model/declaration.dart';
import 'package:tracking_user/model/routeur.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/affectations_services.dart';
import 'package:tracking_user/services/declaration_services.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class DeclarationProvider extends ChangeNotifier {
  final TextEditingController testSignalFoController = TextEditingController();
  final TextEditingController typeDePassageDeCableController =
      TextEditingController();
  final TextEditingController typeDeRoteurController = TextEditingController();
  final TextEditingController snTelephoneController = TextEditingController();
  final TextEditingController nbrJarretieresController =
      TextEditingController();
  final TextEditingController cableMetreController = TextEditingController();
  final TextEditingController ptoController = TextEditingController();
  final TextEditingController sNController = TextEditingController();
  final TextEditingController routeueGponController = TextEditingController();
  final TextEditingController routeueMacController = TextEditingController();
  final TextEditingController justificationCinController =
      TextEditingController();

  Uint8List imageTestSignalFo = Uint8List(0);
  Uint8List imageCin = Uint8List(0);
  Uint8List photoPboAvant = Uint8List(0);
  Uint8List photoPboApres = Uint8List(0);
  Uint8List photoPbIAvant = Uint8List(0);
  Uint8List photoPbIApres = Uint8List(0);
  Uint8List photoSpliter = Uint8List(0);
  Uint8List typDePassageCable = Uint8List(0);
  Uint8List photoFacade1 = Uint8List(0);
  Uint8List photoFacade2 = Uint8List(0);
  Uint8List photoFacade3 = Uint8List(0);

  Declaration declaration = Declaration();

  String groupValueTypeRoteur = "";
  String groupValueTypePassage = "";
  String groupValueCinClientOption = "le client n'accepte pas";
  String cinDescription = "le client n'accepte pas";
  bool check = false;
  bool update = false;

  int? idDeclaration;
  String feedbackBO = "";

  List<Routeur> routeurList = [];
  String checkGponValidationText = '';
  String checkMacValidationText = '';

  checkMacValidation() {
    if (routeueMacController.text.isEmpty) {
      checkMacValidationText = 'Champ obligatoire *';
    } else if (!RegExp(r'^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$')
        .hasMatch(routeueMacController.text)) {
      checkMacValidationText = 'Entrer une format valide 00:00:5E:00:01:XX ';
    }

    notifyListeners();
  }

  checkGponValidation() {
    if (routeueGponController.text.isEmpty) {
      checkGponValidationText = 'Champ obligatoire *';
    }

    notifyListeners();
  }

  getValueTypePassge(String value) {
    typeDePassageDeCableController.text = value;
    groupValueTypePassage = value;
    notifyListeners();
  }

  getValueTypeRoteur(String value) {
    typeDeRoteurController.text = value;
    groupValueTypeRoteur = value;
    notifyListeners();
  }

  checkImageEmpty() {
    check = true;
    notifyListeners();
  }

  setRouteturGponController(String text) {
    routeueGponController.text = text;
    routeueMacController.text =
        routeurList.where((element) => element.snGpon == text).first.snMac ??
            '';
    notifyListeners();
  }

  setRouteturMacController(String text) {
    routeueMacController.text = text;
    routeueGponController.text =
        routeurList.where((element) => element.snMac == text).first.snGpon ??
            '';
    notifyListeners();
  }

  void initValue() {
    imageTestSignalFo = Uint8List(0);
    imageCin = Uint8List(0);
    photoPboAvant = Uint8List(0);
    photoPboApres = Uint8List(0);
    photoPbIAvant = Uint8List(0);
    photoPbIApres = Uint8List(0);
    photoSpliter = Uint8List(0);
    typDePassageCable = Uint8List(0);
    photoFacade1 = Uint8List(0);
    photoFacade2 = Uint8List(0);
    photoFacade3 = Uint8List(0);
    testSignalFoController.text = "";
    typeDePassageDeCableController.text = "";
    snTelephoneController.text = "";
    nbrJarretieresController.text = "";
    cableMetreController.text = "";
    ptoController.text = "";
    sNController.text = "";
    routeueGponController.text = "";
    routeueMacController.text = "";
    checkMacValidationText = "";
    checkGponValidationText = "";
    groupValueTypePassage = "";
    groupValueCinClientOption = "";
    feedbackBO = "";

    update = false;
    check = false;

    notifyListeners();
  }

  initValueForUpdate(Declaration declaration) {
    imageTestSignalFo = declaration.imageTestSignal ?? Uint8List(0);
    photoPboAvant = declaration.imagePboBefore ?? Uint8List(0);
    photoPboApres = declaration.imagePboAfter ?? Uint8List(0);
    photoPbIAvant = declaration.imagePbiBefore ?? Uint8List(0);
    photoPbIApres = declaration.imagePbiAfter ?? Uint8List(0);
    photoSpliter = declaration.imageSplitter ?? Uint8List(0);
    typDePassageCable = Uint8List(0);
    photoFacade1 = declaration.imagePassage1 ?? Uint8List(0);
    photoFacade2 = declaration.imagePassage2 ?? Uint8List(0);
    photoFacade3 = declaration.imagePassage3 ?? Uint8List(0);
    idDeclaration = declaration.id;
    feedbackBO = declaration.feedbackBO ?? '';
    testSignalFoController.text = declaration.testSignal ?? '';
    typeDePassageDeCableController.text = declaration.typePassage ?? '';
    snTelephoneController.text = declaration.snTelephone ?? '';
    nbrJarretieresController.text = declaration.nbrJarretieres ?? '';
    cableMetreController.text = declaration.cableMetre ?? '';
    ptoController.text = declaration.pto ?? '';
    sNController.text = declaration.snTelephone ?? '';
    routeueGponController.text = routeurList
            .where((element) => element.id == declaration.routeurId)
            .first
            .snGpon ??
        '';
    routeueMacController.text = routeurList
            .where((element) => element.id == declaration.routeurId)
            .first
            .snMac ??
        '';

    check = false;
    update = true;
    notifyListeners();
  }

  String validationInput(String val) {
    return val;
  }

  getValueGponFromScan(String val) {
    routeueGponController.text = val;

    routeueMacController.text =
        routeurList.where((element) => element.snGpon == val).first.snMac ?? '';

    notifyListeners();
  }

  getValueMacFromScan(String val) {
    routeueMacController.text = val.replaceAllMapped(
        RegExp(r'^(.{2})(.{2})(.{2})(.{2})(.{2})(.{2})'),
        (match) =>
            '${match.group(1)}:${match.group(2)}:${match.group(3)}:${match.group(4)}:${match.group(5)}:${match.group(6)}');
    routeueGponController.text =
        routeurList.where((element) => element.snMac == val).first.snGpon ?? '';
    notifyListeners();
  }

  AffectationsApi affectationsApi = AffectationsApi();
  DeclarationApi declarationApi = DeclarationApi();

  final formKey = GlobalKey<FormState>();

  late Response response;
  bool loading = false;
  String bareCode = '';
  String routeurId = '';

  setBarCode(String value) {
    bareCode = value;
    notifyListeners();
  }

  Uint8List image = Uint8List(0);
  changeState() {
    notifyListeners();
  }

  Future<Uint8List> selectCameraImages(BuildContext context) async {
    final XFile? selectedImages =
        await ImagePicker().pickImage(source: ImageSource.camera);

    final image = comporessImage(File(selectedImages!.path).readAsBytesSync());

    return image;
  }

  Future<Uint8List> selectGalleryImages(BuildContext context) async {
    final XFile? selectedImages =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    final image = comporessImage(File(selectedImages!.path).readAsBytesSync());

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

  Future<void> declarationAffectation(
      BuildContext context, Object data, String idAffectation,
      {bool callNotify = false}) async {
    loading = false;

    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.declarerAffectation(data);

      switch (response.statusCode) {
        case 200:
          // refreshController.loadComplete();

          initValue();
          SncakBarWidgdet.snackBarSucces(
              context, "Client déclarer avec succée");

          context.pushReplacementNamed(routeOptionValidationPage,
              params: {'idAffectation': idAffectation});

          break;
        case 500:
          Future.delayed(Duration.zero, () {
            SncakBarWidgdet.snackBarSucces(context, response.body);
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
    } catch (e) {
      SncakBarWidgdet.snackBarError(context, e.toString());
      loading = false;
      notifyListeners();
    }

    // return;
  }

  Future<void> updateDeclaration(
      BuildContext context, Object data, String idAffectation,
      {bool callNotify = false}) async {
    loading = false;

    try {
      loading = true;
      notifyListeners();
      response = await declarationApi.updateDeclaration(data);

      log(response.body);

      switch (response.statusCode) {
        case 200:
          // refreshController.loadComplete();

          initValue();

          // ignore: use_build_context_synchronously

          //  context.pushReplacementNamed(routeOptionValidationPage,
          //           params: {'idAffectation': idAffectation});

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
      context.pushReplacement("/permission");
      loading = false;
      notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());

      loading = false;
      notifyListeners();
    }

    // return;
  }

  Future<String> addRouteur(Object data) async {
    loading = false;

    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.addRouteur(data);

      log(response.body);
      switch (response.statusCode) {
        case 200:
          // refreshController.loadComplete();

          routeurId = Routeur.fromJson(jsonDecode(response.body)["Routeur"])
              .id
              .toString();
          // ignore: use_build_context_synchronously

          //  context.pushReplacementNamed(routeOptionValidationPage,
          //           params: {'idAffectation': idAffectation});

          notifyListeners();

          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
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
    return routeurId;
  }

  Future<void> getRouteurs() async {
    // try {
    loading = true;
    notifyListeners();
    response = await affectationsApi.getRouteurs();

    switch (response.statusCode) {
      case 200:
        routeurList.clear();
        var result = json.decode(response.body)["Routeurs"];

        for (int i = 0; i < result.length; i++) {
          routeurList.add(Routeur.fromJson(result[i]));
        }
        // refreshController.loadComplete();

        notifyListeners();

        break;
      default:
      // showSnackBarError('vérifier votre connection internet', context);
    }
    loading = false;
    notifyListeners();
    // } on SocketException {
    //   // errorInternet = true;
    //   notifyListeners();

    //   // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    // } catch (e) {
    //   // SncakBarWidgdet.snackBarError(context, e.toString());
    // }

    return;
  }

  Future<void> getDeclaration(String id) async {
    // try {
    loading = true;
    notifyListeners();
    print('hello');
    response = await declarationApi.getDeclaration(id);

    log(response.body);
    switch (response.statusCode) {
      case 200:
        var result = json.decode(response.body)["Declaration"];
        declaration = Declaration.fromJson(result);
        // refreshController.loadComplete();

        await getRouteurs();
        initValueForUpdate(declaration);
        notifyListeners();

        break;
      default:
      // showSnackBarError('vérifier votre connection internet', context);
    }
    loading = false;
    notifyListeners();
    // } on SocketException {
    //   // errorInternet = true;
    //   notifyListeners();

    //   // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    // } catch (e) {
    //   // SncakBarWidgdet.snackBarError(context, e.toString());
    // }

    return;
  }
}

class FormDeclaration {
  String title;
  TextEditingController controller;

  FormDeclaration({required this.title, required this.controller});
}
