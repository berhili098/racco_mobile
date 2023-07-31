import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class PermissionPage extends StatefulWidget {
  @override
  _PermissionPageState createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  LocationPermission? _locationPermission;

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    super.initState();

// Stop/ cancel receiving position updates

    userProvider.checkInternetPermission();
    userProvider.checkLocationPermission();
    userProvider.checkImagePermission();
    userProvider.checkCameraPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text("Permission"),
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
              // width: 428.w,
              decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(1, 1.5),
                end: Alignment(-0.94597145915031433, -0.8),
                colors: [
                              Color.fromRGBO(89, 185, 255, 1),
                            Color.fromRGBO(97, 113, 186, 1)
                ]),
          )),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              userProvider.serviceEnabledSetting == false
                  ? Icons.signal_wifi_off
                  : IconlyBroken.home,
              size: 260.r,
              color: Colors.black38,
            ),

            if (userProvider.internetPermission == false)
              Column(
                children: [
                  Text(
                    "Activer la connection internet",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => userProvider.checkInternetPermission(),
                    child: const Text("Résseyer"),
                  ),
                ],
              )
            else if (userProvider.serviceEnabledSetting == false)
              Column(
                children: [
                  Text(
                    "Accepter l'autorisation de localisation ",
                    style: TextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => userProvider.checkLocationPermission(),
                    child: const Text("Résseyer"),
                  ),
                ],
              )
            else if (userProvider.imagePermission == false)
              Column(
                children: [
                  Text(
                    "Accepter l'autorisation de stockage",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => userProvider.checkImagePermission(),
                    child: Text(
                      "Résseyer",
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              )
            else if (userProvider.cameraPermission == false)
              Column(
                children: [
                  const Text("Accepter l'autorisation de la caméra"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => userProvider.checkCameraPermission(),
                    child: const Text("Résseyer"),
                  ),
                ],
              )
            else
              TextButton(
                onPressed: () async {
                  // Navigate to the next page

                  userProvider.checkAllPermission().whenComplete(() {


             
                    if (userProvider.internetPermission == true &&
                        userProvider.imagePermission == true &&
                        userProvider.cameraPermission == true &&
                        userProvider.serviceEnabledSetting == true) {



                      context.go('/home');
                      userProvider.stopLoading();
                    }
                  });
                },
                child: userProvider.loading == true
                    ? const CupertinoActivityIndicator()
                    : const Text('Continue'),
              ),

            const SizedBox(height: 20),
            // if (!_imagePermission)
            //   ElevatedButton(
            //     onPressed: _checkImagePermission,
            //     child: Text('Accept Image Permission'),
            //   ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('You have accepted all permissions.'),
      ),
    );
  }
}
