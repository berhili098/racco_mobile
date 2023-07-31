import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardDescreptionWidget extends StatelessWidget {

    final String text;
  final Icon icon;
  final Function()? onTap;
  const CardDescreptionWidget({Key? key, required this.text, required this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return      Material(
      elevation: 10,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 240.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: icon,
                     ),
                  Text(
                   text ,
                   textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0.sp),
                    ),
            
    const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.arrow_forward_outlined),
              )
            ],
          ),
        ),
      ),
    );
  
  }
}