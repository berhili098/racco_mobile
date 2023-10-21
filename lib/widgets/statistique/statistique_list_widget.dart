import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/pages/clients_sav/client_plan_sav_page.dart';
import 'package:tracking_user/pages/clients_sav/clients_sav_page.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/client_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/declaration_sav_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';
import 'package:tracking_user/widgets/statistique/captcha_widget.dart';
import 'package:tracking_user/widgets/statistique/card_planification_widget.dart';
import 'package:tracking_user/widgets/statistique/card_statistique_widget.dart';
import 'package:tracking_user/widgets/statistique/demande_client_widget.dart';
import 'package:tracking_user/widgets/statistique/historique_card_widget.dart';

class StatistiqueListWidget extends StatelessWidget {
  const StatistiqueListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final clientProvider = Provider.of<ClientProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);
    final validationProvider =
        Provider.of<ValidationProvider>(context, listen: false);
    final declarationSavProvier =
        Provider.of<DeclarationSavProvider>(context, listen: false);
    final declarationProvider =
        Provider.of<DeclarationProvider>(context, listen: false);

    return LoadingOverlay(
      isLoading: clientProvider.isLoading,
      // progressIndicator: const SizedBox(),
      child: Stack(
        children: [
          ClipPath(
            clipper: BottomWaveClipper(),
            child: Container(
                height: 358.w,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 80.w),
                child: SizedBox(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: SvgPicture.asset('assets/icons/home/Sort-1.svg'),
                    ),
                    InkWell(
                      onTap: () => context.push(routeNotificationPage),
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                              'assets/icons/home/Notification.svg'),
                          userProvider.notificationsList.isEmpty
                              ? const SizedBox()
                              : Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    userProvider.notificationsList.length
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 11),
                                  ))
                        ],
                      ),
                    ),
                  ],
                )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 15.w, top: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bonjour",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 39.sp,
                              color: Colors.white),
                        ),
                        Text(
                          userProvider.userData!.firstName ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          affectationProvider.getAffectationTechnicien(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationPlanifier(context,
                              userProvider.userData!.technicienId.toString());

                          affectationProvider.getAffectationValider(context,
                              userProvider.userData!.technicienId.toString());

                          // affectationProvider.getAffectationDeclarer(
                          //     context, userProvider.userData!.technicienId.toString());
                          affectationProvider.getTicketTechnicien(context,
                              userProvider.userData!.technicienId.toString());
                          affectationProvider.getAffectationBlocage(context,
                              userProvider.userData!.technicienId.toString());
                          affectationProvider.getSavTicketPlanifier(context,
                              userProvider.userData!.technicienId.toString());
                          affectationProvider
                              .getAffectationBeforValidationBlocage(
                                  context,
                                  userProvider.userData!.technicienId
                                      .toString());

                          userProvider.getNotifications(
                              context, userProvider.userData!.id.toString());
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                          size: 35.r,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 15.w, top: 15.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DemandeClientWidget(
                          title: "Demander des clients",
                          onTap: () async {
                            if (userProvider.userData!.technicien!.typeTech ==
                                2) {
                              SncakBarWidgdet.snackBarSucces(context,
                                  "Vous ne pouvez pas demander un client .");
                            } else {
                              if (affectationProvider.conterCheckCaptcha ==
                                  affectationProvider.conterCheckCaptchaShow) {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    isDismissible: true,
                                    enableDrag: false,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0))),
                                    context: context,
                                    builder: (context) {
                                      return const CaptchaWidget();
                                    });
                              } else {
                                affectationProvider.incrementConter();

                                userProvider
                                    .checkPermission(context)
                                    .whenComplete(() async {
                                  if (affectationProvider.affectations.length <
                                      3) {
                                    await clientProvider.getClients(
                                        context,
                                        userProvider.latLngUser,
                                        userProvider.userData!.technicienId
                                            .toString(),
                                        affectationProvider.affectations.length,
                                        userProvider
                                            .userData!.technicien!.cityId!,
                                        userProvider.nbBuild);

                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      affectationProvider
                                          .getAffectationTechnicien(
                                              context,
                                              userProvider
                                                  .userData!.technicienId
                                                  .toString())
                                          .whenComplete(() =>
                                              clientProvider.stopLoading());
                                    });
                                  } else {
                                    SncakBarWidgdet.snackBarSucces(context,
                                        "Vous ne pouvez pas ajouter plus d'un client.");
                                  }
                                });
                              }
                            }
                          },
                        ),
                        20.verticalSpace,
                        CardStatistiqueWidget(
                          icon: const Icon(Icons.abc),
                          nbItem: affectationProvider.affectations.length,
                          percent: 1.0,
                          title: "Vos clients ",
                          useProgress: true,
                          onTap: () {
                            validationProvider.initValue();
                            declarationProvider.initValue();
                            context.push(routeAffectations);
                          },
                        ),
                        20.verticalSpace,
                        CardStatistiqueWidget(
                          icon: const Icon(Icons.abc),
                          nbItem: affectationProvider.savTicket.length,
                          percent: 1.0,
                          title: "Vos clients Sav",
                          isSav: true,
                          useProgress: true,
                          onTap: () {
                            affectationProvider.getTicketTechnicien(context,
                                userProvider.userData!.technicienId.toString());

                            declarationSavProvier.initValue();
                            // context.push(routeAffectations);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ClientSavPage()),
                            );
                          },
                        ),
                        20.verticalSpace,
                        CardPlanificationWidget(
                          icon: const Icon(Icons.abc),
                          nbItem: affectationProvider
                              .affectationsPlanifier.length
                              .toString(),
                          percent: 1.0,
                          title: "Clients planifiés",
                          useProgress: false,
                          onTap: () => context.push(routeFormTechniqueBlocage),
                        ),
                        20.verticalSpace,
                        CardPlanificationWidget(
                            icon: const Icon(Icons.abc),
                            nbItem: affectationProvider
                                .savTicketPlanifier.length
                                .toString(),
                            percent: 1.0,
                            title: "Clients Sav planifiés",
                            useProgress: false,
                            onTap: () {
                              affectationProvider.getSavTicketPlanifier(
                                  context,
                                  userProvider.userData!.technicienId
                                      .toString());

                              declarationSavProvier.initValue();
                              // context.push(routeAffectations);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ClientSavPlanPage()),
                              );
                            }),
                        HomerdWidget(
                          title: "Demandes PPI",
                          onTap: () {
                            validationProvider.initValue();
                            declarationProvider.initValue();

                            context.push(routePromoteur);
                          },
                          showNumber: true,
                          icon: IconlyBold.user_2,
                        ),
                        HomerdWidget(
                          title: "Historique",
                          onTap: () => context.push(routeHistoriquePage),
                          icon: Icons.history_outlined,
                        ),
                        55.verticalSpace,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
