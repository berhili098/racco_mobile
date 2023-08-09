import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart'
    as te;
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/model/blocage.dart';
import 'package:tracking_user/services/affectations_services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tracking_user/storage/shared_preferences.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class AffectationProvider extends ChangeNotifier {
  int indexTab = 0;

  int conterCheckCaptcha = 0;
  int conterCheckCaptchaShow = 0;

  void generateRandomNumber() {
    Random random = Random();

    conterCheckCaptcha = random.nextInt(4) + 2;

    notifyListeners();
  }

  void initialConterCheckCaptcha() {
    conterCheckCaptchaShow = 0;

    notifyListeners();
  }

  void incrementConter() {
    conterCheckCaptchaShow++;


    notifyListeners();
  }

  getIndexTab(int index) {
    indexTab = index;

  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  AffectationsApi affectationsApi = AffectationsApi();

  removeAffectation(String id) {
    if (affectations
        .where((element) => element.id.toString() == id)
        .isNotEmpty) {
      affectations.remove(
          affectations.where((element) => element.id.toString() == id).first);
    }
    notifyListeners();
  }

  removeAffectationBlocage(String id) {
    if (affectationsBlocage
        .where((element) => element.id.toString() == id)
        .isNotEmpty) {
      affectationsBlocage.remove(affectationsBlocage
          .where((element) => element.id.toString() == id)
          .first);
    }

    notifyListeners();
  }

  void onRefresh(BuildContext context, String id) async {
    // monitor network fetch

    await getAffectationTechnicien(context, id);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onRefreshPromoteur(BuildContext context, String id) async {
    // monitor network fetch

    await getAffectationPromoteurTechnicien(context, id);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onRefreshPlanification(BuildContext context, String id) async {
    // monitor network fetch

    await getAffectationPlanifier(context, id);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading(BuildContext context, String id) async {
    // monitor network fetch
    // await getClientAffectation(context, id: id);

    // await getAffectationTechnicien(context, id);

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    refreshController.loadComplete();
  }

  DateTime result = DateTime.now();

  getDate(DateTime date) {
    result = date;
    notifyListeners();
  }

//=========================  API ==========================

  List<double> distances = [];
  calculateDistance() async {
    Position currentPosition = await Geolocator.getCurrentPosition();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: te.LocationAccuracy.high,
    );
    Map<LatLng, double> distances = {};
    Map<int, double> distancesAffectation = {};

    for (var location in affectations) {
      double distanceInMeters = Geolocator.distanceBetween(
        33.593,
        -7.6179,
        location.lat!,
        location.lng!,
      );

      distancesAffectation[location.id!] = distanceInMeters;
    }

    affectations.sort((a, b) =>
        distancesAffectation[a.id]!.compareTo(distancesAffectation[b.id]!));

    // affectations =   affectations.sublist(0, 3);

    notifyListeners();
  }

  late Response response;
  bool loading = false;

  List<Affectations> affectations = [];
  List<Affectations> affectationsPromoteur = [];
  List<Affectations> affectationsPlanifier = [];
  List<Affectations> affectationsPlanifierFiltre = [];
  List<Affectations> affectationsValider = [];
  List<Affectations> affectationsValiderFiltre = [];
  List<Affectations> affectationsDeclarer = [];
  List<Blocage> affectationsBlocage = [];
  List<Blocage> affectationsBlocageFiltre = [];
  List<Blocage> affectationsBeforValidationBlocage = [];
  List<Blocage> affectationsBeforValidationBlocageFiltre = [];

  filtreaffectationsValider(String id) {
    List<Affectations> results = [];
    if (id.isEmpty) {
      results = affectationsValiderFiltre;
    } else {
      results = affectationsValiderFiltre
          .where((user) =>
              user.client!.sip!.toLowerCase().contains(id.toLowerCase()) ||
              user.client!.name!.toLowerCase().contains(id.toLowerCase()))
          .toList();
    }

    affectationsValider = results;

    notifyListeners();
  }

  filtreaffectationsBloquee(String id) {
    List<Blocage> results = [];
    if (id.isEmpty) {
      results = affectationsBlocageFiltre;
    } else {
      results = affectationsBlocageFiltre
          .where((user) =>
              user.affectation!.client!.sip!
                  .toLowerCase()
                  .contains(id.toLowerCase()) ||
              user.affectation!.client!.name!
                  .toLowerCase()
                  .contains(id.toLowerCase()))
          .toList();
    }
    affectationsBlocage = results;
    notifyListeners();
  }

  filtreaffectationsBloqueeValidation(String id) {
    List<Blocage> results = [];
    if (id.isEmpty) {
      results = affectationsBeforValidationBlocageFiltre;
    } else {
      results = affectationsBeforValidationBlocageFiltre
          .where((user) =>
              user.affectation!.client!.sip!
                  .toLowerCase()
                  .contains(id.toLowerCase()) ||
              user.affectation!.client!.name!
                  .toLowerCase()
                  .contains(id.toLowerCase()))
          .toList();
    }
    affectationsBeforValidationBlocage = results;
    notifyListeners();
  }

  filtreaffectationsPLafie(String id) {
    List<Affectations> results = [];
    if (id.isEmpty) {
      results = affectationsPlanifierFiltre;
    } else {
      results = affectationsPlanifierFiltre
          .where((user) =>
              user.client!.sip!.toLowerCase().contains(id.toLowerCase()) ||
              user.client!.name!.toLowerCase().contains(id.toLowerCase()))
          .toList();
    }

    affectationsPlanifier = results;
    notifyListeners();
  }

  bool timeAgo(DateTime fatchedDate) {
    DateTime currentDate = DateTime.now();
    Duration different = currentDate.difference(fatchedDate);
    if (different.inMinutes > 0) {
      return true;
    }
    return false;
  }

  Future<void> getAffectation(BuildContext context,
      {bool callNotify = false}) async {
    loading = false;

    try {
      affectations = [];
      loading = true;

      response = await affectationsApi.getAffectation();

      switch (response.statusCode) {
        case 200:
          var result = json.decode(response.body)["Affectations"];

          for (int i = 0; i < result.length; i++) {
            affectations.add(Affectations.fromJson(result[i]));
          }

          // refreshController.loadComplete();
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

      // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }
    notifyListeners();
    return;
  }

  Future<void> getAffectationTechnicien(BuildContext context, String id,
      {bool callNotify = false}) async {
    loading = false;

    try {
      // loading = true;
      // notifyListeners();
      response = await affectationsApi.getAffectationTechnicien(id);

      switch (response.statusCode) {
        case 200:
          affectations.clear();

          var result = json.decode(response.body)["Affectations"];

          for (int i = 0; i < result.length; i++) {
            affectations.add(Affectations.fromJson(result[i]));
          }

          // refreshController.loadComplete();

          loading = false;
          notifyListeners();

          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
    } on SocketException {
      // errorInternet = true;
      notifyListeners();

      // showSnackBarError('vérifier votre connection internet', context);

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    return;
  }

  Future<void> getAffectationPromoteurTechnicien(
      BuildContext context, String id,
      {bool callNotify = false}) async {
    loading = false;

    try {
      // loading = true;
      // notifyListeners();
      response = await affectationsApi.getAffectationPromoteurTechnicien(id);


      switch (response.statusCode) {
        case 200:
          affectationsPromoteur.clear();

          var result = json.decode(response.body)["Affectations"];

          for (int i = 0; i < result.length; i++) {
            affectationsPromoteur.add(Affectations.fromJson(result[i]));
          }

          // refreshController.loadComplete();

          loading = false;
          notifyListeners();

          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
    } on SocketException {
      // errorInternet = true;
      notifyListeners();

      // showSnackBarError('vérifier votre connection internet', context);

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }

    return;
  }

  Future<void> getAffectationPlanifier(BuildContext context, String id,
      {bool callNotify = false}) async {
    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.getAffectationPlanifier(id);
      switch (response.statusCode) {
        case 200:
          affectationsPlanifier.clear();
          affectationsPlanifierFiltre.clear();
          var result = json.decode(response.body)["Affectations"];

          for (int i = 0; i < result.length; i++) {
            affectationsPlanifier.add(Affectations.fromJson(result[i]));
            affectationsPlanifierFiltre.add(Affectations.fromJson(result[i]));
          }
          // refreshController.loadComplete();
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

    return;
  }

  Future<void> getAffectationValider(BuildContext context, String id,
      {bool callNotify = false}) async {
    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.getAffectationValider(id);

      switch (response.statusCode) {
        case 200:
          affectationsValider.clear();
          affectationsValiderFiltre.clear();
          var result = json.decode(response.body)["Affectations"];

          for (int i = 0; i < result.length; i++) {
            affectationsValider.add(Affectations.fromJson(result[i]));
            affectationsValiderFiltre.add(Affectations.fromJson(result[i]));
          }
          // refreshController.loadComplete();
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

    return;
  }

  Future<void> getAffectationDeclarer(BuildContext context, String id,
      {bool callNotify = false}) async {
    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.getAffectationDeclarer(id);

      switch (response.statusCode) {
        case 200:
          affectationsDeclarer.clear();
          var result = json.decode(response.body)["Affectations"];

          for (int i = 0; i < result.length; i++) {
            affectationsDeclarer.add(Affectations.fromJson(result[i]));
          }
          // refreshController.loadComplete();
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

    return;
  }

  Future<void> getAffectationBlocage(BuildContext context, String id,
      {bool callNotify = false}) async {
    // try {
    loading = true;
    notifyListeners();

    response = await affectationsApi.getAffectationBlocage(id);

    switch (response.statusCode) {
      case 200:
        affectationsBlocage.clear();
        var result = json.decode(response.body)["Affectations"];

        for (int i = 0; i < result.length; i++) {
          affectationsBlocage.add(Blocage.fromJsonBeforValidation(result[i]));
        }

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

    // return;
  }

  Future<void> getAffectationBeforValidationBlocage(
      BuildContext context, String id,
      {bool callNotify = false}) async {
    // try {
    loading = true;
    notifyListeners();

    response = await affectationsApi.getAffectationBlocageBeforeValidation(id);

    switch (response.statusCode) {
      case 200:
        affectationsBeforValidationBlocage.clear();
        var result = json.decode(response.body)["Affectations"];

        for (int i = 0; i < result.length; i++) {
          affectationsBeforValidationBlocage
              .add(Blocage.fromJsonBeforValidation(result[i]));
        }

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

    // return;
  }

  Future<void> planificationAffectation(BuildContext context, String id,
      String planifierAffectation, String technicienId,
      {bool callNotify = false}) async {
    loading = false;

    try {
      loading = true;
      notifyListeners();
      response = await affectationsApi.planifierAffectation(
          id, planifierAffectation, technicienId);

      switch (response.statusCode) {
        case 200:

          // refreshController.loadComplete();

          Future.delayed(Duration.zero).then((value) {
            removeAffectation(id);
            increaseConteurUser();

            loading = false;
            notifyListeners();
            SncakBarWidgdet.snackBarSucces(
                context, "Client planifier avec succée ");
          });
          break;
        case 409:

          // refreshController.loadComplete();

          Future.delayed(Duration.zero).then((value) {
            loading = false;
            notifyListeners();
            SncakBarWidgdet.snackBarSucces(
                context, "Vous avez dépassé la limite de planification.");
          });
          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
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
