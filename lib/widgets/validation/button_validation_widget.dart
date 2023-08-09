import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/services/providers/validation_provider.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class ButtonValidationWidget extends StatelessWidget {
  final double width;

  final String title;
  final String idAffectation;
  final void Function()? onPressed;

  const ButtonValidationWidget(
      {Key? key,
      required this.width,
      required this.title,
      this.onPressed,
      required this.idAffectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validationProvider = Provider.of<ValidationProvider>(context);

    final userProvider = Provider.of<UserProvider>(context);
    final affectationProvider = Provider.of<AffectationProvider>(context);

    return SizedBox(
      width: width,
      height: 53.h,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(8),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0), // radius you want
            side: const BorderSide(
              color: Colors.transparent,
            ),
          )),
        ),
        onPressed: () {
          userProvider.checkPermission(context).whenComplete(() {
            if (!validationProvider.formKey.currentState!.validate() ||
                // validationProvider.testDebitViaCableImg.isEmpty ||
                validationProvider.photoTestDebitViaWifiImg.isEmpty ||
                validationProvider.etiquetageImg.isEmpty ||
      

              
                validationProvider.pV.isEmpty ||
                validationProvider.routeurTel.isEmpty) {
              validationProvider.formKey.currentState!.reset();

              validationProvider.checkImageEmpty();

              SncakBarWidgdet.snackBarSucces(
                  context, "Tous les champs sont obligatoire *");
            }else if((validationProvider.cinValueSelected == 1|| validationProvider.cinValueSelected == 1)
            && validationProvider.cinImage.isEmpty
            )

            {
  SncakBarWidgdet.snackBarSucces(
                  context, "Photo CIN est obligatoire *");
            } 
            
            else {






              // validationProvider.formKey.currentState!.reset();
              if (validationProvider.update) {
                validationProvider.updateValidtion(context, {
                  'id': validationProvider.idValidation!.toString(),
                  'test_debit': validationProvider.testDebitFo.text,
                  'affectation_id': idAffectation,
                  'test_debit_via_cable_image':
                      base64Encode(validationProvider.testDebitViaCableImg),
                  'photo_test_debit_via_wifi_image':
                      base64Encode(validationProvider.photoTestDebitViaWifiImg),
                  'etiquetage_image':
                      base64Encode(validationProvider.etiquetageImg),
                  'fiche_installation_image':
                      base64Encode(validationProvider.ficheInstallation),
                  'pv_image': base64Encode(validationProvider.pV),
                  'image_cin': base64Encode(validationProvider.cinImage),
                  'cin_justification':
                      validationProvider.justificationCinController.text,
                  'cin_description': validationProvider.cinDescription,


                  'router_tel_image':
                      base64Encode(validationProvider.routeurTel),
                  'lat': userProvider.latLngUser.latitude.toString(),
                  'lng': userProvider.latLngUser.longitude.toString()
                }).whenComplete(() => {
                      affectationProvider.getAffectationTechnicien(context,
                          userProvider.userData!.technicienId.toString()),
                      affectationProvider.getAffectationPlanifier(context,
                          userProvider.userData!.technicienId.toString()),
                    });
              } else {
                validationProvider.validationAffectation(context, {
                  'test_debit': validationProvider.testDebitFo.text,
                  'affectation_id': idAffectation,
                  'test_debit_via_cable_image':
                      base64Encode(validationProvider.testDebitViaCableImg),
                  'photo_test_debit_via_wifi_image':
                      base64Encode(validationProvider.photoTestDebitViaWifiImg),
                  'etiquetage_image':
                      base64Encode(validationProvider.etiquetageImg),
                  'fiche_installation_image':
                      base64Encode(validationProvider.ficheInstallation),
                  'pv_image': base64Encode(validationProvider.pV),
                  'router_tel_image':
                      base64Encode(validationProvider.routeurTel),
                  'image_cin': base64Encode(validationProvider.cinImage),
                  'cin_justification':
                      validationProvider.justificationCinController.text,
                  'cin_description': validationProvider.cinDescription,
                  'lat': userProvider.latLngUser.latitude.toString(),
                  'lng': userProvider.latLngUser.longitude.toString()
                }).whenComplete(() => {
                      affectationProvider.getAffectationTechnicien(context,
                          userProvider.userData!.technicienId.toString()),
                      affectationProvider.getAffectationPlanifier(context,
                          userProvider.userData!.technicienId.toString()),
                    });
              }
            }
          });
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
}
