import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonNavigationWidget extends StatelessWidget {

 final  void Function()? onTap ; 
 final  String   title ; 

  const ButtonNavigationWidget({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return           InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130.w,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(251, 251, 251, 0.75),
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/home/card.svg'),
                    SvgPicture.asset('assets/icons/home/Document.svg'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                  title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 19.sp,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
                'assets/icons/home/Arrow - Right Square.svg'),
          ],
        ),
      ),
    );
     
  }
}