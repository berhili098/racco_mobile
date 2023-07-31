import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/affectation_provider.dart';
import 'package:tracking_user/widgets/declaration/field_declaration_widget.dart';
import 'dart:math';

import 'package:tracking_user/widgets/notification/snack_bar_widget.dart';

class CaptchaWidget extends StatefulWidget {

  const CaptchaWidget({super.key});

  @override
  State<CaptchaWidget> createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  int numberConfirm = 0;


  TextEditingController confirmNumberCnt = TextEditingController();
  void generateRandomNumber() {
    Random random = Random();

    numberConfirm =
        random.nextInt(10); // Change 100 to the desired range of random numbers
  }

  @override
  void initState() {
    generateRandomNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

        final affectationProvider = Provider.of<AffectationProvider>(context);

    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus(); 

      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 60.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Captcha",
              style: TextStyle(
                fontSize: 25.sp,
              ),
            ),
            Column(
              children: [
                Text(
                  "Entrer ce nombre pour continuer",
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                    width: 65,
                    height: 65,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(97, 113, 186, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      numberConfirm.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25.sp),
                    )),
                 Padding(
                  padding: const  EdgeInsets.all(13.0),
                  child: FieldDeclarationWidget(

                         inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],

        
                    // controller: declarationProvider.sNController,
                 controller :   confirmNumberCnt,
                    readOnly: false,

                    title: 'Confirmer le nombre ',
                 keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed :true

                 ),

         
                  ),
                ),
              ],
            ),
            CupertinoButton.filled(
              onPressed: () {


                if(confirmNumberCnt.text != numberConfirm.toString() )
                {
       SncakBarWidgdet.snackBarSucces(context,
                "Réessayer en cours");
                }else
                {

                          affectationProvider.generateRandomNumber();
                                    affectationProvider.initialConterCheckCaptcha();
context.pop();
                }
              },
              child: const Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }
}
