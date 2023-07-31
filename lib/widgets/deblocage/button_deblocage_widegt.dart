import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/model/affectation.dart';
import 'package:tracking_user/routes.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/services/providers/deblocage_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class ButtonDeblocageWidget extends StatelessWidget {
  final double width;
  final Affectations affectation;
  final String title;
  final void Function()? onPressed;

  const ButtonDeblocageWidget({
    Key? key,
    required this.width,
    required this.title,
    this.onPressed, 
    required this.affectation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deblocageProvider = Provider.of<DeblocageProvider>(context);
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
          if (deblocageProvider.spliterAvantPhoto.isEmpty ||
              deblocageProvider.spliterApresPhoto.isEmpty ||
              deblocageProvider.facedePhoto.isEmpty ||
              deblocageProvider.signalPhoto.isEmpty) {
            deblocageProvider.checkImageEmpty();

            SncakBarWidgdet.snackBarSucces(
                context, "Veuillez inclure les images obligatoires. *");
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
            deblocageProvider.debloquerAffectation(
              context,
              {

                'affectation_id':affectation.id.toString(),
                'photo_spliter_before':
                    base64Encode(deblocageProvider.spliterAvantPhoto),
                'photo_spliter_after': base64Encode(
                  deblocageProvider.spliterApresPhoto,
                ),
                'photo_facade': base64Encode(deblocageProvider.facedePhoto),
                'photo_signal': base64Encode(deblocageProvider.signalPhoto),
                'photo_chambre': base64Encode(deblocageProvider.chambrePhoto),
                'lat': userProvider.latLngUser.latitude.toString(),
                'lng': userProvider.latLngUser.longitude.toString()
              },
            ).whenComplete(() => {
                  affectationProvider.getAffectationTechnicien(
                      context, userProvider.userData!.technicienId.toString()),
                  affectationProvider.getAffectationPlanifier(
                      context, userProvider.userData!.technicienId.toString()),
                  affectationProvider.getAffectationDeclarer(
                      context, userProvider.userData!.technicienId.toString()),
                  affectationProvider.getAffectationBlocage(
                      context, userProvider.userData!.technicienId.toString()),
                });
          }
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
