import 'dart:developer';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import 'package:location/location.dart' as loc;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:image/image.dart' as IMG;
import 'package:geolocator_platform_interface/src/enums/location_accuracy.dart'
    as te;
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:tracking_user/model/client.dart' as client;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tracking_user/services/client_service.dart';
import 'package:tracking_user/storage/shared_preferences.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class ClientProvider extends ChangeNotifier {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ClientApi clientsApi = ClientApi();

  void onRefresh(BuildContext context, String id) async {
    // monitor network fetch

    await getClientAffectation(context, id: id);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void onLoading(BuildContext context, String id) async {
    // monitor network fetch
    // await getClientAffectation(context, id: id);

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    refreshController.loadComplete();
  }

  bool loadingTest = false;
  Future testLoading(BuildContext context) {
    loadingTest = true;
    notifyListeners();

    return Future.delayed(Duration(seconds: 2), () {
      loadingTest = false;
      SncakBarWidgdet.snackBarSucces(context, "avec succes");
      notifyListeners();
    });
  }

  Future decreasseCounter() {
    return decreaseConteurUser();
  }

  Future<int> conteurUser() {
    return getCounterUser();
  }

  Future increaseConteur() {
    return increaseConteurUser();
  }

  Location location = new Location();
  late bool _serviceEnabled;
  PermissionStatus? _permissionGranted;
  late LocationData locationData;
  LatLng markerPoint = LatLng(0.0, 0.0);

//=========================  API ==========================

  List<double> distances = [];

  int couteur = 0;

  Future<void> createAffectationPlusProche(
      String idTechnicien,
      int cnt,
      LatLng positionTechnicien,
      BuildContext context,
      String nbBuild,
      int nbAffectation) async {
    // clients = clients.sublist(0, 3);
    // if (clients.isEmpty) {
    //   isLoading = false;
    //   notifyListeners();
    //   return;
    // }
    int counterTechnicien = nbAffectation - cnt;

    if (clients.isNotEmpty) {
      if (counterTechnicien == 0) {
        Future.delayed(Duration.zero, () {
          SncakBarWidgdet.snackBarSucces(context,
              "Vous ne pouvez pas ajouter plus de $counterTechnicien clients.");
        });
        createLogTechnicien({
          "technicien_id": idTechnicien,
          "nb_affectation": "0",
          "lat": positionTechnicien.latitude.toString(),
          "lng": positionTechnicien.longitude.toString(),
          "build": nbBuild
        });
      } else if (clients.length > counterTechnicien) {
        for (int i = 0; i < counterTechnicien; i++) {
          await createAffectation(clients[i].id.toString(), idTechnicien,
              positionTechnicien, context);
        }
        Future.delayed(Duration.zero, () {
          SncakBarWidgdet.snackBarSucces(
              context, "$counterTechnicien clients ont été affectés à vous.");
        });

        createLogTechnicien({
          "technicien_id": idTechnicien,
          "nb_affectation": counterTechnicien.toString(),
          "lat": positionTechnicien.latitude.toString(),
          "lng": positionTechnicien.longitude.toString(),
          "build": nbBuild
        });
      } else {
        for (int i = 0; i < clients.take(counterTechnicien).length; i++) {
          await createAffectation(clients[i].id.toString(), idTechnicien,
              positionTechnicien, context);
        }
        Future.delayed(Duration.zero, () {
          SncakBarWidgdet.snackBarSucces(
              context, "$counterTechnicien clients ont été affectés à vous.");
        });

        createLogTechnicien({
          "technicien_id": idTechnicien,
          "nb_affectation": counterTechnicien.toString(),
          "lat": positionTechnicien.latitude.toString(),
          "lng": positionTechnicien.longitude.toString(),
          "build": nbBuild
        });
      }
    } else {
      Future.delayed(Duration.zero, () {
        SncakBarWidgdet.snackBarSucces(context, "Aucun client disponible.");
      });

      createLogTechnicien({
        "technicien_id": idTechnicien,
        "nb_affectation": "0",
        "lat": positionTechnicien.latitude.toString(),
        "lng": positionTechnicien.longitude.toString(),
        "build": nbBuild
      });
    }

    // Future.delayed(Duration(seconds: 1), () {
    //   isLoadifals
    //   notifyListeners();
    // });
  }

  late Response response;

  bool isLoading = false;

  List<client.Clients> clients = [];
  List<client.Clients> clientsAffecter = [];

  Future<void> getClients(BuildContext context, LatLng postionTechnicien,
      String idTechnicien, int cnt, int cityId, String build,
      {bool callNotify = false}) async {
    try {
      clients = [];
      isLoading = true;
      notifyListeners();
      response = await clientsApi.getClients(idTechnicien, build);
      switch (response.statusCode) {
        case 200:
          var result = json.decode(response.body)["Clients"];
          for (int i = 0; i < result.length; i++) {
            clients.add(client.Clients.fromJson(result[i]));
          }
          Map<int, double> distancesAffectation = {};

          for (var location in clients) {
            double distanceInMeters = Geolocator.distanceBetween(
              postionTechnicien.latitude,
              postionTechnicien.longitude,
              location.lat!,
              location.lng!,
            );

            distancesAffectation[location.id!] = distanceInMeters;
          }

          clients.sort((a, b) => distancesAffectation[a.id]!
              .compareTo(distancesAffectation[b.id]!));

          await createAffectationPlusProche(
              idTechnicien,
              cnt,
              postionTechnicien,
              context,
              build,
              json.decode(response.body)["Compteur"]);

          notifyListeners();
          break;

        case 409:
          Future.delayed(Duration.zero).then((value) {
            isLoading = true;
            notifyListeners();
            SncakBarWidgdet.snackBarError(
                context, json.decode(response.body)["Message"]);
          });

          createLogTechnicien({
            "technicien_id": idTechnicien,
            "nb_affectation": '0',
            "lat": postionTechnicien.latitude.toString(),
            "lng": postionTechnicien.longitude.toString(),
            "build": build
          });

          // refreshController.loadComplete();

          break;

        case 410:
          Future.delayed(Duration.zero).then((value) {
            isLoading = true;
            notifyListeners();
            SncakBarWidgdet.snackBarError(
                context, json.decode(response.body)["Message"]);
          });

          createLogTechnicien({
            "technicien_id": idTechnicien,
            "nb_affectation": '0',
            "lat": postionTechnicien.latitude.toString(),
            "lng": postionTechnicien.longitude.toString(),
            "build": build
          });
          // refreshController.loadComplete();

          break;

        case 411:
          Future.delayed(Duration.zero).then((value) {
            isLoading = true;
            notifyListeners();
            SncakBarWidgdet.snackBarError(
                context, json.decode(response.body)["Message"]);
          });

          createLogTechnicien({
            "technicien_id": idTechnicien,
            "nb_affectation": '0',
            "lat": postionTechnicien.latitude.toString(),
            "lng": postionTechnicien.longitude.toString(),
            "build": build
          });
          // refreshController.loadComplete();

          break;
        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }

      // }
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

  stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> getClientAffectation(BuildContext context,
      {bool callNotify = false, required String id}) async {
    isLoading = false;
    notifyListeners();

    try {
      clientsAffecter = [];
      isLoading = true;
      notifyListeners();

      response = await clientsApi.getAffectationTechnicien(id);

      switch (response.statusCode) {
        case 200:
          var result = json.decode(response.body)["Clients"];

          for (int i = 0; i < result.length; i++) {
            clientsAffecter.add(client.Clients.fromJson(result[i]));
          }
          // refreshController.loadComplete();
          notifyListeners();
          break;

        default:
        // showSnackBarError('vérifier votre connection internet', context);
      }
      isLoading = false;
      notifyListeners();
      // }
    } on SocketException {
      context.pushReplacement("/permission");
      isLoading = false;
      notifyListeners();
      // SncakBarWidgdet.snackBarError(context, S.of(context)!.probleme_error);
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }
    notifyListeners();
    return;
  }

  Future<void> createAffectation(String clientId, String thecnicieId,
      LatLng positionTechnicien, BuildContext context) async {
    Response response;

    try {
      response = await clientsApi.createAffectation(
          clientId,
          thecnicieId,
          positionTechnicien.latitude.toString(),
          positionTechnicien.longitude.toString());

      // isLoading = true;
      // notifyListeners();


      switch (response.statusCode) {
        case 200:
          // A user = User.fromJson(jsonDecode(response.body)["User"]);

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
    } on SocketException {
      // errorInternet = true;
      isLoading = false;
      notifyListeners();
      context.pushReplacement("/permission");

      notifyListeners();

      // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    } catch (e) {
      // SncakBarWidgdet.snackBarError(context, e.toString());
    }
  }

  Future<void> createLogTechnicien(body) async {
    Response response;

    // try {
    response = await clientsApi.createLogTechnicien(body);

    // isLoading = true;
    // notifyListeners();


    switch (response.statusCode) {
      case 200:
        break;

      case 401:
        break;
      default:
      // SncakBarWidgdet.snackBarError(context, "");

    }
    // } on SocketException {
    //   // errorInternet = true;

    //   notifyListeners();

    //   // SncakBarWidgdet.snackBarError(context, "client est déclaré en blocage");
    // } catch (e) {
    //   // SncakBarWidgdet.snackBarError(context, e.toString());
    // }
  }
}
