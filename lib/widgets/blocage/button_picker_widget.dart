import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

class ButtonPickerWidget extends StatelessWidget {
  final double width;
final String idAffectation ; 
  final String title;
  final void Function()? onPressed;

  const ButtonPickerWidget(
      {Key? key, required this.width, required this.title, this.onPressed, required this.idAffectation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocageProvider = Provider.of<BlocageProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

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
          blocageProvider.getLocation(context).then((value) {
            blocageProvider.declarationBlocage(
              context,
               idAffectation,
                 blocageProvider.descriptionController.text,
                blocageProvider.descriptionController.text,
                userProvider.latLngUser,
                false
            );
          });
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const 
SizedBox(width: 5,),
             SvgPicture.asset('assets/icons/blocage/Plus.svg', color: Colors.white,)
              ],
            )),
      ),
    );
  }
}
