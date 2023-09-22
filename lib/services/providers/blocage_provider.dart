import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tracking_user/model/blocage.dart';
import 'package:tracking_user/model/blocage_image.dart';
import 'package:http/http.dart';
import 'package:tracking_user/services/blocage_service.dart';
import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';
import 'package:tracking_user/storage/shared_preferences.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

import 'package:http/http.dart' as http;

class BlocageProvider extends ChangeNotifier {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController adresseLinkController = TextEditingController();
  TextEditingController typeBlocageController = TextEditingController();
  TextEditingController typeBlocageValidationController =
      TextEditingController();

  String savUrl = dotenv.get('SAV_URL', fallback: '');
  // =============== function ===================
  String checkValueBlocageClient = '';
  String checkValueBlocageValidatinClient = '';
  String checkValueBlocageTechnicien = '';

  BlocageValidationClient? typeBlocage;

  Uint8List screenOgif = Uint8List(0);

  // List<Uint8List> imagelist = <Uint8List>[];
  Uint8List image = Uint8List(0);

  Location location = Location();
  late bool _serviceEnabled;
  PermissionStatus? _permissionGranted;
  late LocationData locationData;
  LatLng markerPoint = LatLng(0.0, 0.0);
  List<BlocageImage> imageList = [];

  String idAffectation = '';

  getIdAffectation(String affectation) {
    idAffectation = affectation;
  }

  Future<LocationData> getLocation(BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    locationData = await location.getLocation();

    return locationData;

    // await userProvider.getAffectation(context);

    // lines[0] =[LatLng(locationData.latitude!.toDouble(), locationData.longitude!.toDouble())];
  }

  clearList() {
    imageList.clear();

    descriptionController.text = "";
  }

  clearImage() {
    if (screenOgif.isNotEmpty) {
      screenOgif.clear();
    }

    descriptionController.text = "";

    notifyListeners();
  }

  String groupValue = '';
  String groupValidationValue = '';

  validate(context) async {
    if (typeBlocageController.text.isEmpty) {
      SncakBarWidgdet.snackBarSucces(
          context, "Veuillez Selectionner un type de blockage.");
      return false;
    } else {
      return true;
    }
  }

  Future updateDeclarantionSav(Object data) async {
    var headers = {'Accept': 'application/json'};
    Uri uri = Uri.parse('$savUrl/addFeedbackBlockage');
    try {
      await http.post(uri, headers: headers, body: data);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  setValueTypeBlocage(BlocageClient value) {
    typeBlocageController.text = getStringFromSwitch(value);
    groupValue = getStringFromSwitch(value);

    notifyListeners();
  }

  checlValueTypeBlocage(BlocageClient value) {
    checkValueBlocageClient = value.name;

    print(checkValueBlocageClient);

    notifyListeners();
  }

  setValueTypeValidationBlocage(BlocageValidationClient value) {
    typeBlocageValidationController.text =
        getStringFromTypeValidationSwitch(value);
    groupValidationValue = getStringFromTypeValidationSwitch(value);
    checkValueBlocageValidatinClient = getStringFromTypeValidationSwitch(value);

    notifyListeners();
  }

  Future<void> selectGaleryImages(
      BuildContext context, String imageName) async {
    final XFile? selectedImages = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100);

    if (selectedImages != null) {
      image = File(selectedImages.path).readAsBytesSync();
      BlocageImage newBlocageImage =
          BlocageImage(nameImage: imageName, image: image);
      if (!imageList
          .any((element) => element.nameImage == newBlocageImage.nameImage)) {
        imageList.add(newBlocageImage);
      } else {
        imageList[imageList.indexOf(imageList
            .where((element) => element.nameImage == newBlocageImage.nameImage)
            .first)] = newBlocageImage;
      }
    }
  }

  Future<void> selectCameraImages(
      BuildContext context, String imageName) async {
    final XFile? selectedImages = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 100);

    if (selectedImages != null) {
      image = File(selectedImages.path).readAsBytesSync();

      BlocageImage newBlocageImage =
          BlocageImage(nameImage: imageName, image: image);

      if (!imageList
          .any((element) => element.nameImage == newBlocageImage.nameImage)) {
        imageList.add(newBlocageImage);
      } else {
        imageList[imageList.indexOf(imageList
            .where((element) => element.nameImage == newBlocageImage.nameImage)
            .first)] = newBlocageImage;
      }
    }
  }

  deleteImageFromList(String imageName) {
    imageList.removeAt(0);
  }

  changeState() {
    notifyListeners();
  }

  void getValueBlocageClient(String value) {
    checkValueBlocageClient = value;

    notifyListeners();
  }

  void getValueBlocageTechnicien(String value) {
    checkValueBlocageTechnicien = value;

    notifyListeners();
  }

  bool isLink(String text) {
    // Regular expression pattern to match a valid URL
    RegExp urlPattern = RegExp(
      r'^(https?|ftp|file):\/\/[\-A-Za-z0-9+&@#\/%?=~_|!:,.;]*[\-A-Za-z0-9+&@#\/%=~_|]',
      caseSensitive: false,
      multiLine: false,
    );

    return urlPattern.hasMatch(text);
  }

  bool isLinkGoogle(String text) {
    // Regular expression pattern to match a valid URL
    Uri uri = Uri.parse(text);
    String hostName = uri.host;

    return hostName == "maps.app.goo.gl" || hostName == "www.google.com";
  }

  void showDialog(Widget child, BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.only(top: 6.0),

              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  String getStringFromSwitch(BlocageClient value) {
    String result;

    switch (value) {
      case BlocageClient.adresseErroneDeploye:
        result = "Adresse erronée déployée";
        break;
      case BlocageClient.adresseErroneNonDeploye:
        result = "Adresse erronée non déployée";
        break;
      case BlocageClient.blocageFacadeCoteApparetemment:
        result = "Blocage de passage coté appartement";
        break;
      case BlocageClient.blocageFacadeCoteMagasin:
        result = "Blocage de passage coté magasin";
        break;
      case BlocageClient.blocageFacadeCoteVilla:
        result = "Blocage de passage coté villa";
        break;
      case BlocageClient.blocagePassageCoteSyndic:
        result = "Blocage coté Syndic";
        break;
      case BlocageClient.clientAnnuleSaDemande:
        result = "Client a annulé sa demande";
        break;
      case BlocageClient.contactErronee:
        result = "Contact Erronee";
        break;
      case BlocageClient.demandeEnDouble:
        result = "Demande en double";
        break;
      case BlocageClient.horsPlaque:
        result = "Hors Plaque";
        break;
      case BlocageClient.indisponible:
        result = "Indisponible";
        break;
      case BlocageClient.injoignableSMS:
        result = "Injoignable/SMS";
        break;
      case BlocageClient.manqueID:
        result = "Manque ID";
        break;
      case BlocageClient.caleTransportDgrades:
        result = "Câble transport dégradés";
        break;
      case BlocageClient.manqueCableTransport:
        result = "Manque Cable transport";
        break;
      case BlocageClient.gponSature:
        result = "Gpon saturé";
        break;
      case BlocageClient.nonEligible:
        result = "Non Eligible";
        break;
      case BlocageClient.cabelTransportSature:
        result = "Cabel transport saturé";
        break;
      case BlocageClient.splitterSature:
        result = "Splitter saturé";
        break;
      case BlocageClient.pasSignal:
        result = "Pas Signal";
        break;

      case BlocageClient.blocageBdc:
        result = "Besoin BDC";
        break;
      case BlocageClient.blocageSwan:
        result = "Besoin Swan";
        break;
      case BlocageClient.blocageBesoinJartterier:
        result = "Besoin jarretière";
        break;
      case BlocageClient.problemeVerticalite:
        result = "Probléme de verticalité";
        break;
      case BlocageClient.blocageManqueCarteNationel:
        result = "Manque carte nationale";
        break;
      case BlocageClient.signalDegrade:
        result = "Signal Dégrade";
        break;

      default:
        result = "";
        break;
    }

    return result;
  }

  String getStringFromTypeValidationSwitch(BlocageValidationClient value) {
    String result;

    switch (value) {
      case BlocageValidationClient.idErronee:
        result = "Id Erronée";
        break;
      case BlocageValidationClient.activationBloque:
        result = "Activation Bloque";
        break;
      case BlocageValidationClient.demenagement:
        result = "Demenagement";
        break;
      case BlocageValidationClient.retardDactivation:
        result = "Retard D'activation";
        break;
      case BlocageValidationClient.pasDeticket:
        result = "Pas de ticket";
        break;
      case BlocageValidationClient.porta:
        result = "Porta";
        break;

      default:
        result = "";
        break;
    }

    return result;
  }

  //====================== API ==========================
  late Response response;

  bool loading = false;
  bool isLoading = false;
  BlocageApi blocageApi = BlocageApi();

  Future<void> declarationBlocage(
      BuildContext context,
      String affectationId,
      String cause,
      String justification,
      LatLng positionTechnicien,
      bool blocageValidation) async {
    Response response;

    isLoading = true;
    notifyListeners();

    // try {

    response = await blocageApi.declarationBlocage(
        affectationId,
        cause,
        justification,
        positionTechnicien.longitude.toString(),
        positionTechnicien.latitude.toString());

    switch (response.statusCode) {
      case 200:
        Blocage blocage =
            Blocage.fromJson(jsonDecode(response.body)["Blocage"]);

        if (imageList.isNotEmpty) {
          for (BlocageImage element in imageList) {
            insertImageBlocage(element.nameImage, base64Encode(element.image),
                blocage.id.toString());
          }
        }

        descriptionController.text = '';
        typeBlocageController.text = '';

        groupValue = '';
        checkValueBlocageClient = '';

        // if (context.canPop()) {
        //   context.pop();
        // } else {
        context.pushReplacement('/home');
        // }

        SncakBarWidgdet.snackBarSucces(
            context, "Client est déclaré en blocage");

        isLoading = false;

        notifyListeners();
        if (blocageValidation == false) {
          increaseConteurUser();
        }

        break;

      case 401:
        // SncakBarWidgdet.snackBarError(context, "");
        isLoading = false;
        notifyListeners();
        break;
      case 500:
        // SncakBarWidgdet.snackBarError(context, "");
        isLoading = false;
        notifyListeners();
        break;
      default:
        // SncakBarWidgdet.snackBarError(context, "");
        isLoading = false;
        notifyListeners();
    }
    // } on SocketException {
    //   context.pushReplacement("/permission");
    //   isLoading = false;
    //   notifyListeners();
    //   notifyListeners();

    //   // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    // } catch (e) {
    //   // SncakBarWidgdet.snackBarError(context, e.toString());
    // }
    notifyListeners();
    return;
  }

  insertImageBlocage(String image, String imageData, String blocageId) async {
    Response response;

    response = await blocageApi.insertImageBlocage(image, imageData, blocageId);

    isLoading = true;
    notifyListeners();

    switch (response.statusCode) {
      case 200:
        // A user = User.fromJson(jsonDecode(response.body)["User"]);
        imageList.clear();
        isLoading = false;
        notifyListeners();

        break;
      case 401:
        // SncakBarWidgdet.snackBarError(context, "");
        isLoading = false;
        notifyListeners();
        break;
      default:
        // SncakBarWidgdet.snackBarError(context, "");
        isLoading = false;
        notifyListeners();
    }
  }
}

enum BlocageClient {
  adresseErroneDeploye,
  adresseErroneNonDeploye,
  blocageFacadeCoteApparetemment,
  blocageFacadeCoteMagasin,
  blocageFacadeCoteVilla,
  blocagePassageCoteSyndic,
  clientAnnuleSaDemande,
  contactErronee,
  demandeEnDouble,
  horsPlaque,
  indisponible,
  injoignableSMS,
  manqueID,
  caleTransportDgrades,
  manqueCableTransport,
  gponSature,
  nonEligible,
  cabelTransportSature,
  splitterSature,
  pasSignal,
  problemeVerticalite,
  blocageBdc,
  blocageSwan,
  blocageBesoinJartterier,
  blocageManqueCarteNationel,
  signalDegrade
}

enum BlocageValidationClient {
  idErronee,
  activationBloque,
  demenagement,
  retardDactivation,
  pasDeticket,
  porta
}
