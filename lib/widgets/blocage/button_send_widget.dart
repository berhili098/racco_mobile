import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';

class ButtonSendWidget extends StatelessWidget {
  final double width;

  final String title;
  final void Function()? onPressed;

  const ButtonSendWidget(
      {Key? key, required this.width, required this.title, this.onPressed})
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
        onPressed: 
        onPressed,
        
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
