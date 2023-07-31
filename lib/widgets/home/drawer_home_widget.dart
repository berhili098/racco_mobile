import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/user.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

class DrawerHomeWidget extends StatelessWidget {
  final User user;
  const DrawerHomeWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(1, 1.5),
                        end: Alignment(-0.94597145915031433, -0.8),
                        colors: [
                          Color.fromRGBO(89, 185, 255, 1),
                          Color.fromRGBO(97, 113, 186, 1)
                        ]),
                  ),
                  accountName: Text('${user.firstName} ${user.lastName}'),
                  accountEmail: Text(user.email!),
                  currentAccountPicture:
                      // backgroundColor: Colors.orange,
                      Image.network(
                          "https://cdn-icons-png.flaticon.com/512/1995/1995545.png",
                          width: 150,
                          height: 150)),
              ListTile(
                leading: const Icon(IconlyLight.profile),
                title: const Text("Client Affecter"),
                onTap: () {
                  context.push(routeAffectations);
                },
              ),
              ListTile(
                leading: const Icon(IconlyLight.calendar),
                title: const Text("Client planifier"),
                onTap: () {
                  context.push(routeFormTechniqueBlocage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text("Historique"),
                onTap: () {
                  context.push(routeHistoriquePage);
                },
              ),
              ListTile(
                leading: const Icon(IconlyLight.logout, color: Colors.red),
                title: const Text("Déconnecter",
                    style: TextStyle(color: Colors.red)),
                onTap: () async {
                  await userProvider
                      .logOut(user.id.toString(), context)
                  ;
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text(
              'version ${userProvider.version}',
              style: const TextStyle(color: Colors.black38),
            ),
          )
        ],
      ),
    );
  }
}
