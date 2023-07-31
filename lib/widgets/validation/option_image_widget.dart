import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/widgets/affectations/icon_botton_widget.dart';

class OptionImage extends StatelessWidget {
  final void Function()? onCameraTap;
  final void Function()? onGaleryTap;

  const OptionImage({super.key, this.onCameraTap,this.onGaleryTap});

  @override
  Widget build(BuildContext context) {


    return     
    Container(
      // height: MediaQuery.of(context).size.height * .8,

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
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 15),
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Choisir une option",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23.sp),
            ),
          ),
     
       
     Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            child: Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                Expanded(
                  child: IconBottonWidget(
                    icon: IconlyLight.camera,
                    text: "Camera",
                    onTap: onCameraTap,
                  ),
                ),
                Expanded(
                  child: IconBottonWidget(
                    icon: IconlyLight.image,
                    text: "Gallery",
                    onTap:onGaleryTap
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  
  
  
  }
}