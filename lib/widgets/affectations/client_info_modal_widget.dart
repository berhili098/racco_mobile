import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/affectations/affectation_item_widget.dart';
import 'package:tracking_user/widgets/affectations/icon_botton_widget.dart';
import 'package:tracking_user/widgets/affectations/icon_cercle_widget.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';
import 'package:tracking_user/widgets/planification/showCupertinoDatePicker.dart';

class ClientInfoModalWidget extends StatelessWidget {
  final Affectations affectation;

  final bool withPlanification;

  const ClientInfoModalWidget(
      {super.key, required this.affectation, required this.withPlanification});

  @override
  Widget build(BuildContext context) {
    final validationProvider = Provider.of<ValidationProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final declarationProvider = Provider.of<DeclarationProvider>(context);

    DateTime time = DateTime.now();
    DateTime date = DateTime.now();
    return LoadingOverlay(
      isLoading: declarationProvider.loading || validationProvider.loading,
      child: Container(
        height: MediaQuery.of(context).size.height * .95,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                offset: Offset(0, 0),
                blurRadius: 15)
          ],
          color: Color.fromRGBO(240, 240, 240, 1),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Client",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 23.sp),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 10.0),
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AffectationItemWidget(
                        affectation: affectation,
                        showInfoIcon: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Column(
                      children: [
                        affectation.client!.blocage!.isEmpty
                            ? const SizedBox()
                            : Visibility(
                                visible: affectation.status == 'Bloqué',
                                child: Column(
                                  children: [
                                    Text(
                                      "Type de blocage",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 21.sp),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        affectation.client!.blocage!.first.cause
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            color: Colors.red)),
                                    const SizedBox(
                                      height: 25,
                                    )
                                  ],
                                ),
                              ),
                        // Visibility(
                        //   visible: !withPlanification &&
                        //       affectation.status != 'Bloqué' &&
                        //       affectation.status != 'Terminé',
                        //   child: Column(
                        //     children: [
                        //       Text(
                        //         "Date de planification",
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w400,
                        //             fontSize: 21.sp),
                        //       ),
                        //       const SizedBox(
                        //         height: 10,
                        //       ),
                        //       Text(
                        //           affectation.datePlanification!.isNotEmpty
                        //               ? DateFormat('dd/MM/yyyy hh:mm').format(
                        //                   DateTime.parse(
                        //                       affectation.datePlanification!))
                        //               : '',
                        //           style: TextStyle(
                        //               fontWeight: FontWeight.w500,
                        //               fontSize: 16.sp,
                        //               color: Colors.red)),
                        //       const SizedBox(
                        //         height: 25,
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Type d'installation",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21.sp),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${affectation.client!.offre}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.sp,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 25.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Type de routeur",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 21.sp),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${affectation.client!.routeurType}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 16.sp,
                                        )),
                                    Text(
                                      ' ( ${affectation.client!.debit} MB )',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.red,
                                          fontSize: 16.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 20.w,
                        ),
                        Text(
                          "Numéro de télephone",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.sp),
                        ),
                        SizedBox(
                          height: 7.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(affectation.client!.phoneNo ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.sp,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const IconCercleWidgt(
                                icon: Icons.copy_all_outlined,
                                size: 50,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text: affectation.client!.phoneNo!))
                                    .then((_) {
                                  SncakBarWidgdet.snackBarSucces(
                                      context, "Copier avec succès");
                                });

                                // final Uri telLaunchUri = Uri(
                                //   scheme: 'tel',
                                //   path: affectation.client!.phoneNo ?? '',
                                // );

                                // launchUrl(telLaunchUri);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Adresse",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.sp),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: SelectableText(
                                    affectation.client!.address ?? '',
                                    textAlign: TextAlign.center,
                                    toolbarOptions: const ToolbarOptions(
                                      copy: true,
                                      selectAll: true,
                                    ),
                                    showCursor: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp,
                                    )),
                              ),
                              // IconButton(
                              //   padding: EdgeInsets.zero,
                              //   icon: const IconCercleWidgt(
                              //     icon: Icons.copy_all_outlined,
                              //     size: 50,
                              //   ),
                              //   onPressed: () {
                              //     Clipboard.setData(ClipboardData(
                              //             text: affectation.client!.address))
                              //         .then((_) {
                              //       SncakBarWidgdet.snackBarSucces(
                              //           context, "Copier avec succès");
                              //     });

                              //     // final Uri telLaunchUri = Uri(
                              //     //   scheme: 'tel',
                              //     //   path: affectation.client!.phoneNo ?? '',
                              //     // );

                              //     // launchUrl(telLaunchUri);
                              //   },
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.w,
                        ),
                        Text(
                          "Position GPS",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 21.sp),
                        ),
                        SizedBox(
                          height: 7.w,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${affectation.client!.lat ?? ''},${affectation.client!.lng ?? ''}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.sp,
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: const IconCercleWidgt(
                                icon: Icons.copy_all_outlined,
                                size: 50,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text:
                                            '${affectation.client!.lat ?? ''},${affectation.client!.lng ?? ''}'))
                                    .then((_) {
                                  SncakBarWidgdet.snackBarSucces(
                                      context, "Copier avec succès");
                                });

                                // final Uri telLaunchUri = Uri(
                                //   scheme: 'tel',
                                //   path: affectation.client!.phoneNo ?? '',
                                // );

                                // launchUrl(telLaunchUri);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0.w, horizontal: 10.0),
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: affectation.status == "Terminé"
                            ? [
                                Expanded(
                                  child: Visibility(
                                    visible: affectation.status == "Terminé",
                                    child: IconBottonWidget(
                                      icon: IconlyLight.edit,
                                      text: "Modifier la déclaration",
                                      onTap: () {
                                        declarationProvider
                                            .getDeclaration(
                                                affectation.id.toString())
                                            .then((value) => context.pushNamed(
                                                    routeDeclarationPage,
                                                    params: {
                                                      'affectation': json
                                                          .encode(affectation
                                                              .toJson())
                                                    }));

                                        // context.pop();
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Visibility(
                                    visible: affectation.status == "Terminé",
                                    child: IconBottonWidget(
                                      icon: IconlyLight.edit,
                                      text: "Modifier la Validation",
                                      onTap: () {
                                        validationProvider.getValidation(
                                            affectation.id.toString(), context);
                                      },
                                    ),
                                  ),
                                ),
                              ]
                            : [
                                Visibility(
                                  visible: (affectation.status == "En cours" ||
                                      affectation.status == "Planifié"),
                                  child: IconBottonWidget(
                                    icon: IconlyLight.paper_plus,
                                    text: "Déclarer",
                                    onTap: () {
                                      context.pop();
                                      context.pushNamed(routeDeclarationPage,
                                          params: {
                                            'affectation': json
                                                .encode(affectation.toJson())
                                          });
                                      // ignore: use_build_context_synchronously
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: (affectation.status == "En cours" ||
                                          affectation.status != "Terminé") &&
                                      // affectation.status != "Planifié" &&
                                      affectation.status != "Bloqué" &&
                                      affectation.status != "Déclaré" &&
                                      affectationProvider.timeAgo(
                                              affectation.createdAt!) ==
                                          true,
                                  child: IconBottonWidget(
                                      icon: IconlyLight.calendar,
                                      text: "Planifier",
                                      onTap: () {
                                        showCupertinoDatePicker(context,
                                            mode: CupertinoDatePickerMode
                                                .dateAndTime,
                                            initialDateTime: time,
                                            leftHanded: false,
                                            backgroundColor: Colors.white,
                                            action: () {
                                              userProvider
                                                  .checkPermission(context)
                                                  .whenComplete(() {
                                                affectationProvider
                                                    .planificationAffectation(
                                                        context,
                                                        affectation.id
                                                            .toString(),
                                                        affectationProvider
                                                            .result
                                                            .toIso8601String(),
                                                        userProvider.userData!
                                                            .technicien!.id
                                                            .toString())
                                                    .then((value) =>
                                                        context.pop())
                                                    .whenComplete(() => {
                                                          affectationProvider
                                                              .getAffectationPlanifier(
                                                                  context,
                                                                  userProvider
                                                                      .userData!
                                                                      .technicienId
                                                                      .toString()),
                                                          affectationProvider
                                                              .getDate(DateTime
                                                                  .now())
                                                        });
                                              });
                                            },
                                            use24hFormat: true,
                                            onDateTimeChanged: (DateTime time) {
                                              if (time.hour > 0 ||
                                                  time.minute > 0) {
                                                affectationProvider.getDate(
                                                    DateTime(
                                                        time.year,
                                                        time.month,
                                                        time.day,
                                                        time.hour,
                                                        time.minute));
                                              } else {
                                                // The user has hit the cancel button.
                                                affectationProvider.getDate(
                                                    DateTime(
                                                        time.year,
                                                        time.month,
                                                        time.day,
                                                        time.hour,
                                                        time.minute));
                                                // affectationProvider.getDate(  DateTime(date.year, date.month, date.day,
                                                // time.hour, time.minute));
                                              }
                                              // onChanged(result);
                                            });
                                      }),
                                ),
                                Visibility(
                                  visible: (affectation.status == "En cours" ||
                                      affectation.status == "Planifié"),
                                  child: IconBottonWidget(
                                    icon: IconlyLight.shield_fail,
                                    text: "Blocage",
                                    onTap: () {
                                      context.pop();
                                      context.pushNamed(routeTypeBlocage,
                                          params: {
                                            'idAffectation':
                                                affectation.id.toString()
                                          });
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: (affectation.status != "En cours" ||
                                          affectation.status == "Déclaré") &&
                                      affectation.status != "Planifié" &&
                                      affectation.status != "Terminé" &&
                                      affectation.status != "Bloqué",
                                  child: IconBottonWidget(
                                    icon: IconlyLight.tick_square,
                                    text: " Valider ",
                                    onTap: () {
                                      context.pop();

                                      context.pushNamed(
                                          routeOptionValidationPage,
                                          params: {
                                            'idAffectation':
                                                affectation.id.toString()
                                          });
                                    },
                                  ),
                                ),
                              ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
