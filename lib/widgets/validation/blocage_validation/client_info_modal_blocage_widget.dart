import 'dart:convert';

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
import 'package:intl/intl.dart';

class ClientInfoModalBlocageWidget extends StatelessWidget {
  final Affectations affectation;

  final bool withPlanification;

  const ClientInfoModalBlocageWidget(
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
                          vertical: 15.0, horizontal: 10.0),
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
                        Visibility(
                          visible: !withPlanification &&
                              affectation.status != 'Bloqué' &&
                              affectation.status != 'Terminé',
                          child: Column(
                            children: [
                              Text(
                                "Date de planification",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 21.sp),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  affectation.datePlanification!.isNotEmpty
                                      ? DateFormat('dd/MM/yyyy hh:mm').format(
                                          DateTime.parse(
                                              affectation.datePlanification!))
                                      : '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sp,
                                      color: Colors.red)),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
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
                          height: 15.w,
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
                                        text: affectation.client!.phoneNo))
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
                          child: Text(affectation.client!.address ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16.sp,
                              )),
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
                    Visibility(
                      visible:
                          affectation.client!.blocage!.first.resolue ?? false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
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
                                                  'affectation': json.encode(
                                                      affectation.toJson())
                                                }));

                                    // context.pop();
                                  },
                                ),
                              ),
                              Expanded(
                                child: IconBottonWidget(
                                  icon: IconlyLight.tick_square,
                                  text: " Valider ",
                                  onTap: () {
                                    context.pop();

                                    context.pushNamed(routeValidationPage,
                                        params: {
                                          'idAffectation':
                                              affectation.id.toString()
                                        });
                                  },
                                ),
                              ),
                            ]),
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
