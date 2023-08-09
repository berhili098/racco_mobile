import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/home/drawer_home_widget.dart';
import 'package:tracking_user/widgets/statistique/statistique_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getDataAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      drawer: DrawerHomeWidget(user: userProvider.userData!),
      body: const StatistiqueListWidget(),
    );
  }

  Future getDataAsync() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final affectationProvider =
          Provider.of<AffectationProvider>(context, listen: false);
      final clientProvider =
          Provider.of<ClientProvider>(context, listen: false);

      userProvider.sendRepairTechnicien();
      affectationProvider.generateRandomNumber();

      userProvider.getUserFromStorage().then((value) => {
            affectationProvider.getAffectationTechnicien(
                context, userProvider.userData!.technicienId.toString()),
            affectationProvider.getAffectationPromoteurTechnicien(
                context, userProvider.userData!.technicienId.toString()),
            affectationProvider.getAffectationPlanifier(
                context, userProvider.userData!.technicienId.toString()),
            userProvider.getNotifications(
                context, userProvider.userData!.id.toString()),
          });

      userProvider.getInfoApp();

      OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
        userProvider.getUserFromStorage().then((value) => {
              userProvider.checkTechnicienIsBlocked(
                  context, userProvider.userData!.id.toString())
            });

        
        

        if (event.notification.subtitle == "test") {}

        clientProvider.createLogTechnicien({
          "technicien_id": userProvider.userData!.technicien!.id.toString(),
          "nb_affectation": "500",
          "lat": userProvider.latLngUser.latitude.toString(),
          "lng": userProvider.latLngUser.longitude.toString(),
          "build": userProvider.nbBuild
        });

        userProvider.getNotifications(
            context, userProvider.userData!.id.toString());
      });
    });
  }
}
