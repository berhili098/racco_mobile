import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart' as loc;
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as IMG;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart'
    as te;
import 'package:flutter_map/flutter_map.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_user/model/notification.dart';
import 'package:tracking_user/model/ticket_orange.dart';
import 'package:tracking_user/model/user.dart';
import 'package:tracking_user/services/auth_service.dart';
import 'package:tracking_user/storage/shared_preferences.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class UserProvider extends ChangeNotifier {
  String version = '';
  String nbBuild = '';
  //====================== Dclaration varibles =============

  bool internetPermission = false;
  bool imagePermission = false;
  bool cameraPermission = false;
  bool serviceEnabledSetting = false;
  bool serviceEnabledlocation = false;

  List<Notifications> notificationsList = [];

  FocusNode myFocusNode = FocusNode();
  User? userData = User();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String deviseKey = "";
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>(debugLabel: 'login');

  MapController mapController = MapController();

  bool loading = false;

  bool show = false;

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@neweracom.ma',
  );

  checkedInternetPermission(bool value) {
    internetPermission = value;
    notifyListeners();
  }

  checkedImagePermission(bool value) {
    imagePermission = value;

    notifyListeners();
  }

  checkedCameraPermission(bool value) {
    cameraPermission = value;
    notifyListeners();
  }

  checkedServiceEnabledSetting(bool value) {
    serviceEnabledSetting = value;
    notifyListeners();
  }

  checkedServiceEnabledLocation(bool value) {
    serviceEnabledlocation = value;
    notifyListeners();
  }

  showPassword() {
    show = !show;
    notifyListeners();
  }

  bool testRoute = false;
  goToHome() {
    testRoute = true;
    notifyListeners();
  }

  goToLogin() {
    testRoute = false;
    notifyListeners();
  }

  getDeviseKey(String deviseKeyValue) {
    deviseKey = deviseKeyValue;

    notifyListeners();
  }

  checkErrorEmail(String value) {
    errorEmailTxtField = value;
    notifyListeners();
  }

  checkErrorPassword(String value) {
    errorPasswordTxtField = value;
    notifyListeners();
  }

  loc.Location location = loc.Location();
  late bool _serviceEnabled;
  loc.PermissionStatus? _permissionGranted;
  late loc.LocationData locationData;

  Future<loc.LocationData> getLocation(BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    locationData = await location.getLocation();

    return locationData;
  }

  Future<String> getDeviceIdentifier() async {
    String deviceIdentifier = "unknown";
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.id;
      getDeviseKey(androidInfo.id);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor ?? '';
      getDeviseKey(deviceIdentifier);
    }
    return deviceIdentifier;
  }
  // CollectionReference notifications =
  //     FirebaseFirestore.instance.collection('notifications');

  changeIndexListFormsChangePassword() {
    indexPage = 2;

    notifyListeners();
  }

  password(String? txt, BuildContext context) {
    if (txt == null || txt.isEmpty) {
      return "Mots de passe obligatoire";
    }
    if (txt.length < 8) {
      return "Le mot de passe doit comporter 8 caractères";
    }
    // if (!txt.contains(RegExp(r'[A-Z]'))) {
    //   return "Password must has uppercase";
    // }
    // if (!txt.contains(RegExp(r'[0-9]'))) {
    //   return "Password must has digits";
    // }
    // if (!txt.contains(RegExp(r'[a-z]'))) {
    //   return "Password must has lowercase";
    // }
    // if (!txt.contains(RegExp(r'[#?!@$%^&*-]'))) {
    //   return "Password must has special characters";
    // } else {
    return "";
    // }
  }

  late LatLng latLngUser;
  String errorEmailTxtField = "";
  String errorPasswordTxtField = "";
  String errorFullNameTxtField = "";
  String errorFullPhoneNumber = "";
  int indexPage = 0;

  List<Placemark> placemarks = [];
  List<int> dist = [];

  List<LatLng> locations = [
    LatLng(31.791702, -7.092620), // Location maroc
    LatLng(26.2540493, 29.2675469), // Location Egypt
    LatLng(33.8439408, 9.400138), // Location Tunis
    LatLng(64.6863136, 97.7453061), // Location Russ

    // Add more locations as needed
  ];

// Get the current location

  calculateDistance2() async {
    Position currentPosition = await Geolocator.getCurrentPosition();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: te.LocationAccuracy.high,
    );
    Map<LatLng, double> distances = {};

    for (var location in locations) {
      double distanceInMeters = await Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        location.latitude,
        location.longitude,
      );

      distances[location] = distanceInMeters;
    }

    locations.sort((a, b) => distances[b]!.compareTo(distances[a]!));

    List<LatLng> nearbyLocations = locations.sublist(0, 3);

    for (int i = 0; i <= nearbyLocations.length; i++) {}
    notifyListeners();
  }

  sendRepairTechnicien() {
    loc.Location location = loc.Location();

    location.onLocationChanged.listen((event) {
      latLngUser =
          LatLng(event.latitude!.toDouble(), event.longitude!.toDouble());
    });
  }

  Future<void> checkPermission(BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    final permissionStatus = await Permission.storage.status;
    final permissionStatusCamera = await Permission.camera.status;

    if (!_serviceEnabled) _serviceEnabled = await location.requestService();

    final serviceStatusStream =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();

    serviceEnabledSetting = await location.serviceEnabled();

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      context.pushReplacement("/permission");

      // await openAppSettings();
    } else if (_permissionGranted == loc.PermissionStatus.deniedForever) {
      context.pushReplacement("/permission");
    } else if (!serviceStatusStream) {
      await location.requestService().then((value) {
        if (value == false) {
          context.pushReplacement("/permission");
        }
      });
    } else if (permissionStatus.isDenied) {
      context.pushReplacement("/permission");

      if (permissionStatus.isDenied) {}
    } else if (permissionStatus.isPermanentlyDenied) {
      context.pushReplacement("/permission");
    } else if (permissionStatusCamera.isDenied) {
      await Permission.storage.request();

      if (permissionStatusCamera.isDenied) {}
    } else if (permissionStatus.isPermanentlyDenied) {
      context.pushReplacement("/permission");
    }

    // await userProvider.getAffectation(context);

    // lines[0] =[LatLng(locationData.latitude!.toDouble(), locationData.longitude!.toDouble())];
  }

  Stream<List<TicketOrange>> getTickes() {
    return FirebaseFirestore.instance
        .collection('ticket_orange')
        // .where("user_receiver", isEqualTo:id)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => TicketOrange.fromJson(document.data()))
            .toList());
  }

  startTicket(String lat, String lang) async {
    loc.Location location = loc.Location();

    FirebaseFirestore.instance.collection('ticket_orange').add({
      'nom_ticket': "test",
      'lat': lat,
      'lang': lang,
      'created_at': Timestamp.fromDate(DateTime.now()),
    }).then((value) async {
      // await sendNotification(
      //     deviseToken: deviseToken,
      //     bodyMessage: 'prix proposée  : $message',
      //     titleMessage: 'négociation');
    }).catchError((error) => print("Failed to add user: $error"));
  }

  List<Uint8List> imagelist = <Uint8List>[];
  Uint8List? image;

  void selectImages(BuildContext context) async {
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      if (imagelist.length < 5 &&
          selectedImages.length <= 5 - imagelist.length) {
        for (int i = 0; i < selectedImages.take(5).length; i++) {
          final f = File(selectedImages[i].path);
          int sizeInBytes = f.lengthSync();
          double sizeInMb = sizeInBytes / (1024 * 1024);

          // if (sizeInMb >= 2.0) {
          //   // SncakBarWidgdet.snackBarError(context, S.of(context)!.check_size_image);
          //   return;
          // } else {
          IMG.Image? img =
              IMG.decodeImage(File(selectedImages[i].path).readAsBytesSync());
          IMG.Image resized = IMG.copyResize(img!, width: 200, height: 200);

          image = File(selectedImages[i].path).readAsBytesSync();

          // imagelist.add(Uint8List.fromList(IMG.encodePng(resized)));

          imagelist = [Uint8List.fromList(IMG.encodePng(resized))];
          // }
        }

        // imagelist.addAll(
        //     );
        // Navigator.pop(context);
      }
    }

    notifyListeners();
  }

  Future<void> getNotifications(BuildContext context, String id,
      {bool callNotify = false}) async {
    try {
      loading = true;
      notifyListeners();

      response = await userApi.getNotificationApi(id);

      switch (response.statusCode) {
        case 200:
          notificationsList.clear();
          var result = json.decode(response.body)["notifications"];

          for (int i = 0; i < result.length; i++) {
            notificationsList.add(Notifications.fromJson(result[i]));
          }

          notifyListeners();

          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
      loading = false;
      notifyListeners();
    } on SocketException {
      context.pushReplacement("/permission");

      notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    // return;
  }

  User? user;
  bool logged = false;
  Future<bool> checkUserAuth() async {
    User? user = await getUser('user');

    if (user == null) {
      // notifyListeners();
      return false;
    }

    return true;
  }

  Future getUserFromStorage() async {
    userData = await getUser('user');

    notifyListeners();
  }

  //======================================  Api  ===============================

  late Response response;

  bool isLoading = false;

  UserApi userApi = UserApi();

  Future<void> updatePlayerId(String userId, String playeriId) async {
    Response response;

    response = await userApi.updatePlayerIdService(userId, playeriId);

    // try {
    print(response.body);

    switch (response.statusCode) {
      case 200:
        break;

      case 401:
        // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);

        break;
      default:
      // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    }
    //   loading = false;
    //   notifyListeners();
    // } on SocketException {
    //   // errorInternet = true;
    //   notifyListeners();

    //   // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    // } catch (e) {
    //   // SncakBarWidgdet.snackBarError(context, e.toString());
    // }
  }

  Future<void> deconnectUser(String userId) async {
    Response response;

    response = await userApi.deconnectUserService(userId);

    // try {

    switch (response.statusCode) {
      case 200:
        break;

      case 401:
        // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);

        break;
      default:
      // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    }
    //   loading = false;
    //   notifyListeners();
    // } on SocketException {
    //   // errorInternet = true;
    //   notifyListeners();

    //   // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    // } catch (e) {
    //   // SncakBarWidgdet.snackBarError(context, e.toString());
    // }
  }

  Future<void> checkTechnicienIsBlocked(
      BuildContext context, String userId) async {
    Response response;

    response = await userApi.checkTechnicienIsBlockedApi(userId);

    switch (response.statusCode) {
      case 200:
        log("userId : ${userId}");

        log(response.body);
        log(response.statusCode.toString());

        break;

      case 409:
        log(response.body);
        log(response.statusCode.toString());

        Future.delayed(Duration.zero, () {
          logOut(userId, context);
        });
        break;
      default:
    }
  }

  login(String email, String password, BuildContext context) async {
    Response response;
    loading = true;
    notifyListeners();

    response = await userApi.loginService(email, password);

    switch (response.statusCode) {
      case 200:
        User user = User.fromJson(jsonDecode(response.body)["User"]);

        await OneSignal.shared.getDeviceState().then((value) {
          updatePlayerId(
              user.technicien!.id.toString(), value!.userId.toString());
        });

        if (user.status != 1) {
          SncakBarWidgdet.snackBarSucces(context, "Ce compte est bloqué.");
          loading = false;
          notifyListeners();
        } else if (user.deviceKey == null) {
          await userApi.updateDeviseKeyService(user.id.toString(), deviseKey);
          // context.go('/home'),
          await saveUser(user);
          await createConteurUser(user.counter!);

          emailController.clear();
          passwordController.clear();
          context.go('/home');
          loading = false;
          notifyListeners();

          return;
        } else if (user.deviceKey == deviseKey) {
          await saveUser(user);
          await createConteurUser(user.counter!);
          context.go('/home');
          loading = false;
          notifyListeners();

          return;
        }

        // else
        // if (user.deviceKey!.isEmpty) {
        //   await saveUser(user);
        //   await createConteurUser(user.counter!);
        //   context.go('/home');
        //   loading = false;
        //   notifyListeners();

        //   loading = false;
        //   notifyListeners();

        //   return;
        // }
        else {
          SncakBarWidgdet.snackBarSucces(
              context, "Ce compte est déjà connecté sur un autre appareil.");
          loading = false;
          notifyListeners();
        }

        break;

      case 401:
        Future.delayed(Duration.zero).then((value) {
          SncakBarWidgdet.snackBarError(
              context, "Email ou mot de passe incorrect.");
          loading = false;
          notifyListeners();
        });

        break;
      default:
        SncakBarWidgdet.snackBarError(context, "");
        isLoading = false;
        notifyListeners();
    }
  }

  Future<void> logOut(String userId, BuildContext context) async {
    await dropSessionUser();
    await checkUserAuth();
    logged = false;
    deconnectUser(userId);
    notifyListeners();
  }

  Future<void> getInfoApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = '${packageInfo.version} + ${packageInfo.buildNumber}';

    nbBuild = packageInfo.buildNumber.toString();

    notifyListeners();
  }
  ////////////////////check permission/////////////////////////

  Future<void> checkInternetPermission() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      checkedInternetPermission(true);
      print(" mobil echeckedInternetPermission${true}");
    } else {
      checkedInternetPermission(false);

      print("checkedInternetPermission${false}");
    }
  }

  Future<void> checkServiceEnabledLocation() async {
    final serviceStatusStream =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();
  }

  Future<void> checkLocationPermission() async {
    serviceEnabledSetting = await location.serviceEnabled();
    final serviceStatusStream =
        await GeolocatorPlatform.instance.isLocationServiceEnabled();

    _permissionGranted = await location.hasPermission();

    serviceEnabledSetting = await location.requestService();

    print("$_permissionGranted    location ");

    if (_permissionGranted == loc.PermissionStatus.denied) {
      checkedServiceEnabledSetting(false);
      serviceEnabledSetting = await location.requestService();

      _permissionGranted = await location.requestPermission();
      // await openAppSettings();
    } else if (_permissionGranted == loc.PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
      checkedServiceEnabledSetting(false);

      await openAppSettings();
    } else if (!serviceStatusStream) {
      serviceEnabledSetting = await location.requestService();

      checkedServiceEnabledSetting(false);
    } else {
      checkedServiceEnabledSetting(true);
    }
  }

  Future<void> checkImagePermission() async {
    final permissionStatus = await Permission.storage.status;

    print("isDenied${permissionStatus.toString()}");

    if (permissionStatus.isDenied) {
      await Permission.storage.request();

      checkedImagePermission(false);
    } else if (permissionStatus.isPermanentlyDenied) {
      checkedImagePermission(false);

      await openAppSettings();
    } else {
      print("isDenied${permissionStatus.toString()}");

      checkedImagePermission(true);
    }
  }

  Future<void> checkCameraPermission() async {
    final permissionStatus = await Permission.camera.status;
    if (permissionStatus.isDenied) {
      await Permission.camera.request();

      if (permissionStatus.isDenied) {
        // await openAppSettings();
        checkedCameraPermission(false);
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      checkedCameraPermission(false);

      await openAppSettings();
    } else {
      checkedCameraPermission(true);
    }
  }

  Future<void> checkAllPermission() async {
    loading = true;
    notifyListeners();

    await checkInternetPermission();
    await checkLocationPermission();
    await checkImagePermission();
    await checkCameraPermission();
  }

  void stopLoading() {
    loading = false;
    notifyListeners();
  }
}
