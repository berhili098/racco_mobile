import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/sav_ticket.dart';
import 'package:tracking_user/pages/blocage/blocage_sav.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/affectations/icon_botton_widget.dart';
import 'package:tracking_user/widgets/affectations/icon_cercle_widget.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';
import 'package:tracking_user/widgets/planification/showCupertinoDatePicker.dart';
import 'package:tracking_user/widgets/sav/sav_ticket_item.dart';

import '../../pages/clients_sav/declaration_sav_page.dart';

class ClientSavInfoModalWidget extends StatelessWidget {
  final SavTicket affectation;

  final bool withPlanification;

  const ClientSavInfoModalWidget(
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
                      child: SavTicketItem(
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
                        Text(
                          "Description",
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
                                    affectation.description == null
                                        ? affectation.description!
                                            .replaceAll("Description", "")
                                            .replaceAll(":", "")
                                        : "",
                                    textAlign: TextAlign.center,
                                    toolbarOptions: const ToolbarOptions(
                                      copy: true,
                                      selectAll: true,
                                    ),
                                    maxLines: 2,
                                    showCursor: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16.sp,
                                    )),
                              ),
                            ],
                          ),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeclarationSavPage(
                                                  affectation: affectation,
                                                )),
                                      );

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
                                              context.pop();
                                              userProvider
                                                  .checkPermission(context)
                                                  .whenComplete(() {
                                                affectationProvider.submit(
                                                    context, affectation);
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OptionBlocageSavPage(
                                                  isSav: true,
                                                  idAffectation:
                                                      affectation.id.toString(),
                                                )),
                                      );
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
