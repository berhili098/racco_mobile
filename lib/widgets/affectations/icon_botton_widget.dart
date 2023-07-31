import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tracking_user/widgets/affectations/icon_cercle_widget.dart';

class IconBottonWidget extends StatelessWidget {
  final String text ; 
    final IconData icon;
   final void Function()? onTap;
  const IconBottonWidget({super.key, required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
                  padding:  EdgeInsets.symmetric(vertical: 12, horizontal: 20.w),
                  margin:const  EdgeInsets.symmetric( horizontal: 3),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15000000596046448),
                          offset: Offset(0, 0),
                          blurRadius: 15)
                    ],
                    color: Color.fromRGBO(251, 251, 251, 1),
                  ),
                  child: Column(
                    children: [
                      IconCercleWidgt(icon: icon, size: 65.w),
                      Text(
                        text,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
    );
  }
}