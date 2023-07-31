import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tracking_user/pages/declaration/declaration_page.dart';
import 'package:tracking_user/services/providers/blocage_provider.dart';
import 'package:tracking_user/services/providers/declaration_provider.dart';
import 'package:tracking_user/services/providers/user_provider.dart';
import 'package:tracking_user/widgets/blocage/button_picker_widget.dart';
import 'package:tracking_user/widgets/blocage/button_send_widget.dart';

class ImagePickerWidget extends StatelessWidget {
  final String titel;
  final Uint8List image
;
  final void Function()? onTap;
  const ImagePickerWidget({Key? key, required this.titel, this.onTap, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final declarationProvider = Provider.of<DeclarationProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                titel ,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
            ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          // width: MediaQuery.of(context).size.width,
          height: 180.w,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade200),
          alignment: Alignment.center,
          child: image.isNotEmpty
              ? Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.memory(image),
                        )),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                          width: 35,
                          height: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0XFF6171ba),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )),
                    )
                  ],
                )
              : InkWell(
                  onTap: onTap,
              
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/blocage/Mask group (9).png',color: const Color(0XFF6171ba)),
                      Text(
                        titel,
                        style: const TextStyle(
                          color: Color(0XFF6171ba),
                        ),
                      )
                    ],
                  ),
                ),
        ),

        Visibility(
              visible:! image.isNotEmpty && declarationProvider.check,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "l'image est obligatoire *",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.red),
                ),
              ),
            )
      ],
    );
  }
}
