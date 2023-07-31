import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class ButtonDeclarationWidget extends StatelessWidget {
  final double width;

  final String title;
  final Affectations affectation;
  final void Function()? onPressed;

  const ButtonDeclarationWidget(
      {Key? key,
      required this.width,
      required this.title,
      this.onPressed,
      required this.affectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final declarationProvider = Provider.of<DeclarationProvider>(context);

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
           if (!declarationProvider.formKey.currentState!.validate() ||
                declarationProvider.imageTestSignalFo.isEmpty ||
                declarationProvider.photoPboAvant.isEmpty ||
                declarationProvider.photoPboApres.isEmpty ||
                declarationProvider.photoPbIAvant.isEmpty ||
                declarationProvider.photoPbIApres.isEmpty ||
                declarationProvider.photoSpliter.isEmpty) {
              declarationProvider.checkImageEmpty();

              SncakBarWidgdet.snackBarSucces(
                  context, "Tous les champs sont obligatoire *");

              declarationProvider.checkGponValidation();
              declarationProvider.checkMacValidation();
            } else if (declarationProvider.routeueGponController.text.isEmpty) {
              SncakBarWidgdet.snackBarSucces(
                  context, "Veuillez saisir le GPON et le MAC du routeur *");

              declarationProvider.checkMacValidation();
            }
            // else

            // if (
            //         declarationProvider.routeueMacController.text.isEmpty ||
            //     !RegExp(r'^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$')
            //         .hasMatch(declarationProvider.routeueMacController.text)) {
            //   SncakBarWidgdet.snackBarSucces(
            //       context, "Veuillez saisir le GPON et le MAC du routeur *");

            //   declarationProvider.checkMacValidation();

            //   return;
            // }

            else {
              declarationProvider.addRouteur({
                'sn_gpon': declarationProvider.routeueGponController.text,
                'sn_mac': declarationProvider.routeueMacController.text,
                'client_id': affectation.client?.id.toString(),
                'technicien_id': userProvider.userData!.technicienId.toString()
              }).then((value) {
                if (declarationProvider.update) {
                  declarationProvider
                      .updateDeclaration(
                          context,
                          {
                            'id': declarationProvider.idDeclaration.toString(),
                            'affectation_id': affectation.id.toString(),
                            'test_signal':
                                declarationProvider.testSignalFoController.text,
                            'image_test_signal': base64Encode(
                                declarationProvider.imageTestSignalFo),
                            'image_pbo_before':
                                base64Encode(declarationProvider.photoPboAvant),
                            'image_pbo_after':
                                base64Encode(declarationProvider.photoPboApres),
                            'image_pbi_after':
                                base64Encode(declarationProvider.photoPbIApres),
                            'image_pbi_before':
                                base64Encode(declarationProvider.photoPbIAvant),
                            'image_splitter':
                                base64Encode(declarationProvider.photoSpliter),
                            'type_passage': declarationProvider
                                .typeDePassageDeCableController.text,
                            'image_passage_1':
                                base64Encode(declarationProvider.photoFacade1),
                            'image_passage_2':
                                base64Encode(declarationProvider.photoFacade2),
                            'image_passage_3':
                                base64Encode(declarationProvider.photoFacade3),
                            'sn_telephone':
                                declarationProvider.sNController.text,
                            'nbr_jarretieres': declarationProvider
                                .nbrJarretieresController.text,
                            'cable_metre':
                                declarationProvider.cableMetreController.text,
                            'pto': declarationProvider.ptoController.text,
                            'routeur_id': value,
                            'routeur_type': declarationProvider.typeDeRoteurController.text,
                    
                            'lat': userProvider.latLngUser.latitude.toString(),
                            'lng': userProvider.latLngUser.longitude.toString()
                          },
                          affectation.id.toString())
                      .whenComplete(() => {
                            affectationProvider.getAffectationTechnicien(
                                context,
                                userProvider.userData!.technicienId.toString()),
                            affectationProvider.getAffectationPlanifier(context,
                                userProvider.userData!.technicienId.toString()),
                            affectationProvider.getAffectationDeclarer(context,
                                userProvider.userData!.technicienId.toString()),
                            affectationProvider.getAffectationBlocage(context,
                                userProvider.userData!.technicienId.toString()),
                          });
                } else {
                  declarationProvider
                      .declarationAffectation(
                          context,
                          {
                            'affectation_id': affectation.id.toString(),
                            'test_signal':
                                declarationProvider.testSignalFoController.text,
                            'image_test_signal': base64Encode(declarationProvider.imageTestSignalFo),
                            'image_pbo_before':
                                base64Encode(declarationProvider.photoPboAvant),
                            'image_pbo_after':
                                base64Encode(declarationProvider.photoPboApres),
                            'image_pbi_after':
                                base64Encode(declarationProvider.photoPbIApres),
                            'image_pbi_before':
                                base64Encode(declarationProvider.photoPbIAvant),
                            'image_splitter':
                                base64Encode(declarationProvider.photoSpliter),
                            'type_passage': declarationProvider
                                .typeDePassageDeCableController.text,
                            'image_passage_1':
                                base64Encode(declarationProvider.photoFacade1),
                            'image_passage_2':
                                base64Encode(declarationProvider.photoFacade2),
                            'image_passage_3':
                                base64Encode(declarationProvider.photoFacade3),
                            'sn_telephone':
                                declarationProvider.sNController.text,
                            'nbr_jarretieres': declarationProvider
                                .nbrJarretieresController.text,
                            'cable_metre':declarationProvider.cableMetreController.text,
                            'pto': declarationProvider.ptoController.text,
                            'image_cin':
                                base64Encode(declarationProvider.imageCin),
                            'cin_justification': declarationProvider
                                .justificationCinController.text,
                            'cin_description':
                                declarationProvider.groupValueCinClientOption,
                            'routeur_type': declarationProvider.typeDeRoteurController.text,
                            'routeur_id': value,
                            'lat': userProvider.latLngUser.latitude.toString(),
                            'lng': userProvider.latLngUser.longitude.toString()
                          },
                          affectation.id.toString())
                      .whenComplete(() => {
                            affectationProvider.getAffectationTechnicien(
                                context,
                                userProvider.userData!.technicienId.toString()),
                            affectationProvider.getAffectationPlanifier(context,
                                userProvider.userData!.technicienId.toString()),
                            affectationProvider.getAffectationDeclarer(context,
                                userProvider.userData!.technicienId.toString()),
                            affectationProvider.getAffectationBlocage(context,
                                userProvider.userData!.technicienId.toString()),
                          });
                }
              });
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
